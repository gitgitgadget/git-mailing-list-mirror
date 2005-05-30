From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem with cg-update and deleted files
Date: Mon, 30 May 2005 17:23:20 +0200
Message-ID: <1117466600.7072.188.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 17:21:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcm4Y-0005Ot-2F
	for gcvg-git@gmane.org; Mon, 30 May 2005 17:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVE3PXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 11:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVE3PXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 11:23:25 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:63418 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261495AbVE3PXS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 11:23:18 -0400
Received: from pegasus (p5487D5D5.dip.t-dialin.net [84.135.213.213])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4UFP5Ss000671
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 30 May 2005 17:25:06 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/899/Mon May 30 08:57:01 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

with the latest cg-update and pulling the linux-2.6 repository I saw
problems with deleted files:

Applying changes...
Fast-forwarding 37e0915b701281182cea9fc90e894d10addf134a -> 5e485b7975472ba4a408523deb6541e70c451842
        on top of 37e0915b701281182cea9fc90e894d10addf134a...
rm: cannot remove `:100644 000000 057cc3f8ff378c0de881482d55b47255e3c5ea72 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 d1352120acd7ef7853041098bf12ae79a8ac1e0a 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 abdb015a4d71036eb7305e18b606151eb35fb810 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 fc568af468b9482b9e09cc618d726ece226cb9db 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 cb90681e151cd510825dd8f7ca555ad8e0be137f 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 c91976274e7b007b78269e40fd8b354a4e888b86 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 57d03d9178f611f73079d6a83af0302f9c33dc3c 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 a7ffd9c45a2c272594a0be593cdaa467ce7abf5e 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 98fa3f7a9eff4721531ca060cee5961f7fba0100 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 5b2aacdefa6cb7db6d3aa87194f210d5fcb87974 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 D': No such file or directory
rm: cannot remove `:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 D': No such file or directory

Regards

Marcel


