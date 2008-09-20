From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to
 non-GNU extended regex syntax
Date: Sat, 20 Sep 2008 15:29:15 -0700
Message-ID: <7vmyi21mf8.fsf@gitster.siamese.dyndns.org>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
 <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vy71n482x.fsf@gitster.siamese.dyndns.org> <loom.20080920T200157-713@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAyD-0005xV-E9
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYITW3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYITW3X
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:29:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYITW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:29:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E492665C7F;
	Sat, 20 Sep 2008 18:29:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2CE5065C7E; Sat, 20 Sep 2008 18:29:17 -0400 (EDT)
In-Reply-To: <loom.20080920T200157-713@post.gmane.org> (Brandon Casey's
 message of "Sat, 20 Sep 2008 21:03:24 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91D66CF2-8763-11DD-9E70-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96375>

Brandon Casey <drafnel@gmail.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> Here is [1/2] to be applied on top of 45d9414 (diff.*.xfuncname which uses
>> "extended" regex's for hunk header selection, 2008-09-18).
>> 
>> Testing appreciated.
>
>> +	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>> +	  REG_EXTENDED },
>> +	{ "tex",
>> +	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\{.*)$",
>
> I think you need double backslash '\\' before '{' in the two places in these
> patterns where you only have a single backslash.

Thanks.  Any other nits?
