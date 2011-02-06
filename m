From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Sun, 06 Feb 2011 21:48:48 +0100
Message-ID: <vpq1v3kopn3.fsf@bauges.imag.fr>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBXc-0006KY-Ne
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1BFUs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:48:57 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54775 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab1BFUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:48:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p16KmkWb012931
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Feb 2011 21:48:46 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmBXM-0000U4-PM; Sun, 06 Feb 2011 21:48:48 +0100
In-Reply-To: <4D4EF7E4.7050303@hartwork.org> (Sebastian Pipping's message of "Sun\, 06 Feb 2011 20\:35\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Feb 2011 21:48:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p16KmkWb012931
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297630128.65056@tjmuZkYc7f+Q3SER8v3xvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166203>

Sebastian Pipping <webmaster@hartwork.org> writes:

> I was and I can confirm the different behaviour with 1.7.4 over here: it
> does work on the root directory of the repo as you supposed.

What do you mean by "it does not work"?

"git add -u" adds files under the current directory, and it always
did.

> Is that behavior needed to be as is or could you change it to work from
> everywhere?

I consider it as a design bug that "add -u" is not tree-wide, but it's
not easy to change the existing behavior without breaking expectations
of people used to the current behavior.

> Could it be it has been working from anywhere before?

Can you post an example where Git 1.7.4 and a previous version behave
differently? Up to now, I see difference between your expectations and
what Git does, but not between new and old versions.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
