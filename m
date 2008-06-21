From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: MinGW port pull request
Date: Sat, 21 Jun 2008 14:47:05 -0700
Message-ID: <7vve028nqe.fsf@gitster.siamese.dyndns.org>
References: <485B6510.3080201@viscovery.net>
 <7vskv79l37.fsf@gitster.siamese.dyndns.org>
 <200806212318.47745.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAwO-0006PE-5p
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbYFUVrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYFUVrR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:47:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbYFUVrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:47:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D06B2D4CB;
	Sat, 21 Jun 2008 17:47:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 29E90D4C5; Sat, 21 Jun 2008 17:47:11 -0400 (EDT)
In-Reply-To: <200806212318.47745.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Sat, 21 Jun 2008 23:18:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C956406-3FDB-11DD-993B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85731>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> * The #ifdef in setup.c, prefix_filename() could easily be removed by using 
> the MINGW32 arm everywhere. This would penalize non-Windows, however, 
> prefix_filename() is not performance critical.
>
>>  * There is an interaction with dr/ceiling topic that is already in 'next'
>>    that needs to be resolved before we merge this in 'next'.
>
> How do you want me to proceed? Rebase on top of dr/ceiling? Wait until 
> dr/ceiling is in master and rebase again? Merge it into my series? (I would 
> make the merge the last commit in my series.) I'm asking because support of 
> dr/ceiling was not overwhelming.

I personally feel MinGW branch is more important than ceiling work, not
just because it targets far wider audience but because it affects a lot
wider area.  j6t/mingw _will_ eventually graduate to master in some form
(possibly after fixups that is needed to keep things working on non
Windows environment), and dr/ceil may or may not.

So my preference would be to merge j6t/mingw into dr/ceil branch soon,
resolve conflicts there, and merge the result to 'next' when j6t/mingw is
merged to 'next' at the same time.  And you can help with that merge when
it happens.
