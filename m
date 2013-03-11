From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 11 Mar 2013 13:30:41 +0100
Message-ID: <vpqd2v686fi.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: manlio.perillo@gmail.com, felipe.contreras@gmail.com
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 13:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1sq-0006vb-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 13:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab3CKMaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 08:30:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53251 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3CKMap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 08:30:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2BCUe06004574
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 13:30:40 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UF1sI-0003ZR-4X; Mon, 11 Mar 2013 13:30:42 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Mar 2013 13:30:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BCUe06004574
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363609841.51674@3zkS6g8+5M7MPu0dnqrTzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217873>

Hi,

Since the recent update to bash completion, I often get a segmentation
fault from ZSH. This is most likely a bug in ZSH, but it would be cool
to avoid triggering it from Git.

Steps to reproduce:

moy@anie:/tmp$$ git init zsh
Initialized empty Git repository in /tmp/zsh/.git/
moy@anie:/tmp$$ cd zsh/
moy@anie:/tmp/zsh$$ mkdir foo
moy@anie:/tmp/zsh$$ touch foo/bar.txt
moy@anie:/tmp/zsh$$ git mv foo/zsh: segmentation fault  zsh
moy@anie:~$ zsh --version
zsh 4.3.10 (i686-pc-linux-gnu)

(this is ZSH packaged with Debian stable)

Any ZSH guru to look into it?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
