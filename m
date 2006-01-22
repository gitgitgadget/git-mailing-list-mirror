From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: git cherry unkillable
Date: Sun, 22 Jan 2006 13:23:26 +0300
Message-ID: <200601221323.33377.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 22 11:23:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0cNz-0005PT-JB
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 11:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWAVKXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWAVKXt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 05:23:49 -0500
Received: from mx3.mail.ru ([194.67.23.149]:38425 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751152AbWAVKXs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 05:23:48 -0500
Received: from [83.237.195.229] (port=15184 helo=cooker.home.net)
	by mx3.mail.ru with asmtp 
	id 1F0cNk-0006AJ-00
	for git@vger.kernel.org; Sun, 22 Jan 2006 13:23:36 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15047>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I mistakenly run git cherry on linus tree which was a bit too much for my poor 
old system. Trying to kill (^C) it I got

{pts/0}% git cherry ali1535 linus
external diff died, stopping at include/linux/sysctl.h.
external diff died, stopping at drivers/serial/suncore.c.
diff: /home/bor/tmp/.diff_Y6CvCw: No such file or directory
diff: /home/bor/tmp/.diff_tBqCCk: No such file or directory
external diff died, stopping at include/asm-arm/arch-pxa/pxa-regs.h.
external diff died, stopping at fs/cifs/file.c.
external diff died, stopping at MAINTAINERS.
diff: /home/bor/tmp/.diff_P12uX9: No such file or directory
diff: /home/bor/tmp/.diff_R4v0g0: No such file or directory
external diff died, stopping at net/ipv4/route.c.
....

and it jut goes on. This takes really some time here so ability to stop it 
would be really nice. It still runs with CPU temp rocketing.

Regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD010lR6LMutpd94wRArDIAKC4yNPpwZ2AEKpXwjeZREMRCL3VyACeJaYu
UMZUpX3D3UfHSm0m44pvAmY=
=0Cxg
-----END PGP SIGNATURE-----
