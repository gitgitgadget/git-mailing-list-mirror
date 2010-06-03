From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu, 03 Jun 2010 16:47:51 +0200
Message-ID: <vpq1vco41go.fsf@bauges.imag.fr>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 16:51:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBlH-00070t-Ix
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab0FCOvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:51:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:54228 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab0FCOvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 10:51:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o53ElpGG022506
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 Jun 2010 16:47:51 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OKBi3-0002AQ-Jo; Thu, 03 Jun 2010 16:47:51 +0200
In-Reply-To: <cover.1275575236.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\,  3 Jun 2010 16\:35\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 03 Jun 2010 16:47:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148327>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "No newline at end of file" always confuses me when looking at a diff for
> symlinks. "File? Huh? Didn't Git recognize my symlink?"

For interactive use, I do understand. But how do you deal with the
(improbable) case of a user actually adding a newline at the end of
the target of the symlink, and then using format-patch and am to apply
the changes somewhere else?

You probably want to make sure your patch doesn't modify format-patch.

BTW, I disagree that the message is a "warning": it's actually a piece
of information, part of the patch, but that we find annoying in this
case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
