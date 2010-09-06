From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Git-gui and the next Git release
Date: Mon, 06 Sep 2010 17:57:14 +0200
Message-ID: <vpqzkvusw4l.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 18:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ose82-0007Qv-AZ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 18:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab0IFQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 12:00:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:34748 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab0IFQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 12:00:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o86FvEtW009555
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Sep 2010 17:57:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ose4I-0003Nx-9k; Mon, 06 Sep 2010 17:57:14 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Sep 2010 17:57:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155579>

Hi,

There are a few fixes in Git-gui's repository that were not merged in
git:

$ git log --oneline --decorate git-gui/master ^origin/master
aef0b48 (git-gui/master) git-gui: ensure correct application termination in git-gui--askpass
d5257fb (git-gui/pu) git-gui: handle textconv filter on Windows and in development
62f9a63 git-gui: use shell to launch textconv filter in "blame"
7807777 (git-gui/maint) git-gui: display error launching blame as a message box.
ea47503 git-gui: Make usage statement visible on Windows.

Don't we want to have them merged before the next release?

Thanks,

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
