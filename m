From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 0/4]
Date: Mon,  4 Jun 2012 19:20:51 +0200
Message-ID: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbayI-0003FD-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab2FDRV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:21:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51121 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab2FDRVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:21:25 -0400
Received: by bkcji2 with SMTP id ji2so3818493bkc.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=rXzPLTBbHKSfgb6+ZF2tEGqnVfIhz4w1c4jHgk2FW0Y=;
        b=kq53pNCye+hayiSfSmotGDUbo3/jmcFqtMbFsfeoaTinyI8x2RkHZwPbuwi77GQo9h
         eVZ9MZCW4QC3AD4QUHZp/7WCp0TgEMkeEztE3R/lnihAoOp7AyQgj4V/iWN9Eg/yTWAk
         +xVD5nym83v+GkORAhFMLNFQQFG2Eq7AnbA06ybX+9rF7GuYUnH8vuK77aUQmOJ87JcM
         OmUL6+0Nuc7Cus2fjFp8VFkjTL8svj7f73lFs4+O6AmtzxSVym8MEtlO0j5lMPJHfGiP
         buDVex6gr8hfVn4ymkF2VzHFNnV25/lZ9t6jzaZGyKeexSDMABVp8E3A7gERKF9rHGt/
         htsA==
Received: by 10.204.151.204 with SMTP id d12mr7114068bkw.72.1338830482479;
        Mon, 04 Jun 2012 10:21:22 -0700 (PDT)
Received: from flobuntu.lan (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m2sm11224637bkm.2.2012.06.04.10.21.21
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 10:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199159>

Series of patches creating a very basic remote helper in C.

[RFC 1/4] Implement a basic remote helper vor svn in C.
[RFC 2/4] Integrate remote-svn into svn-fe/Makefile.
[RFC 3/4] Add svndump_init_fd to allow reading dumps from arbitrary
[RFC 4/4] Add cat-blob report pipe from fast-import to
