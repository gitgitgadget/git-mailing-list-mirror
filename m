From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Sat, 06 Sep 2008 22:27:56 -0700
Message-ID: <7vskscplsz.fsf@gitster.siamese.dyndns.org>
References: <48BBB59F.9080204@statsbiblioteket.dk>
 <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org>
 <48BBC20E.20808@statsbiblioteket.dk> <20080901104222.GA10026@toroid.org>
 <48BBCBEA.8000301@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Abhijit Menon-Sen <ams@toroid.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Sun Sep 07 07:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcCpp-0004b8-RP
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 07:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYIGF2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 01:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYIGF2H
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 01:28:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYIGF2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 01:28:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 145595EC56;
	Sun,  7 Sep 2008 01:28:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4F7F95EC55; Sun,  7 Sep 2008 01:27:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE9DEEF2-7C9D-11DD-804E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95113>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:

> Abhijit Menon-Sen wrote:
>> Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
>> interface introduced in 0.14, as pointed out by Tom G. Christensen.
>>
>> Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
>> ---
>>
>> At 2008-09-01 12:21:02 +0200, tgc@statsbiblioteket.dk wrote:
>>> Wouldn't it be possible to accomplish the same as File::Temp->New with
>>> the old File::Temp?
>>
>> OK, does this one work for you?
>>
> Nope.

Somebody involved in this thread care to report the current status please?
