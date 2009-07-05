From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Verbose output of git commands
Date: Sun, 05 Jul 2009 16:06:33 +0200
Message-ID: <vpqocrz5imu.fsf@bauges.imag.fr>
References: <20090705105856.GC5689@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Trstenjak <Daniel.Trstenjak@online.de>
X-From: git-owner@vger.kernel.org Sun Jul 05 16:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNSPm-0003Og-W7
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 16:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZGEOJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 10:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZGEOJq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 10:09:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49016 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbZGEOJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 10:09:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n65E8wdg021991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 5 Jul 2009 16:08:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MNSMT-0000ld-N6; Sun, 05 Jul 2009 16:06:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MNSMT-0007yV-Lj; Sun, 05 Jul 2009 16:06:33 +0200
In-Reply-To: <20090705105856.GC5689@laptop> (Daniel Trstenjak's message of "Sun\, 5 Jul 2009 12\:58\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 05 Jul 2009 16:08:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n65E8wdg021991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1247407738.98285@HZ1lnSYgja07J8/3dH18tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122740>

Daniel Trstenjak <Daniel.Trstenjak@online.de> writes:

> E.g:
> git status
>
> file: needs merge
> # Not currently on any branch.
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       unmerged:   file
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       init
>
>
> The core information is just:
>
> unmerged : file
> untracked: init

The

# Not currently on any branch.

also contains some relevant information.

> It would be nice to be able to configure an expert mode, in which only
> the core information of the git commands is printed out.

Agreed, but even without that, I find 'ui.color = true' to solve most
of the issue: the relevant text is shown colored, and the color tells
me whether the change is staged or not. So, I can still concentrate on
the important.

Other than that, "git diff --name-status" can help, too.

-- 
Matthieu
