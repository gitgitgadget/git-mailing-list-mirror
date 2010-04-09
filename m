From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] branch: say "Reset to" in reflog entries for 'git branch -f' operations
Date: Fri, 09 Apr 2010 14:03:10 +0200
Message-ID: <vpqk4sgltoh.fsf@bauges.imag.fr>
References: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
	<4BBF159A.1000206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 09 14:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Cvs-0007sK-TU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab0DIMD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:03:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33508 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab0DIMDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:03:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o39BwWI2004925
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Apr 2010 13:58:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O0CvX-0005Sr-4p; Fri, 09 Apr 2010 14:03:11 +0200
In-Reply-To: <4BBF159A.1000206@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 09 Apr 2010 19\:55\:06 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Apr 2010 13:58:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o39BwWI2004925
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271419114.07599@e0zriMIcmLGwyL0+bMm5Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144426>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> But I also have a functional question: Is "start_from" really the ref
> *to* which the branch is reset? I hope reset does it right.

I don't know which is which, but if start_from is the destination of
the ref, then it should be renamed. I don't think we want to have this

		snprintf(msg, sizeof msg, "branch: Reset to %s",
                                                         ^^
 			 start_name);
                         ^^^^^

in the code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
