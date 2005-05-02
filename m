From: Frank Sorenson <frank@tuxrocks.com>
Subject: Colorize "Acked-by:" like "Signed-off-by:" in cg-log
Date: Mon, 02 May 2005 00:01:09 -0600
Message-ID: <4275C225.6090908@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 02 07:55:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSTtz-00011A-Cm
	for gcvg-git@gmane.org; Mon, 02 May 2005 07:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVEBGB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 02:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVEBGB3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 02:01:29 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:7431 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261762AbVEBGBS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 02:01:18 -0400
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4261BPt029150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 00:01:13 -0600
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch adds color to "Acked-by:" lines in cg-log


Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Colorize "Acked-by:" in cg-log

- ---
commit 3da886f11c286089586596e01e03aec1df5eab7f
tree afec725c306afc453ef4cbfd4a3e657016a745f2
parent f9be53a0dd1594f39b2e166ca064b781546f4c46
author sorenson <sorenson@moebius.cs.byu.edu> 1115013121 -0600
committer sorenson <sorenson@moebius.cs.byu.edu> 1115013121 -0600

Index: cg-log
===================================================================
- --- 320ae30b42c144f8970bf8e9fae3ef6b91cab5b9/cg-log  (mode:100755 sha1:b0e109f36609878ad91020811ea0aa5cde9c1138)
+++ afec725c306afc453ef4cbfd4a3e657016a745f2/cg-log  (mode:100755 sha1:b10bc72715319e536ec591a7bfd788f2de4c7017)
@@ -74,6 +74,7 @@
~ 			"")
~ 				echo; sed -re '
~ 					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
+					/ *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
~ 					s/./    &/
~ 				'
~ 				;;


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCdcIlaI0dwg4A47wRAgZYAJ94qxTw9ttKKY0YYYK6w0gElIp39wCfXg1S
qidz2hXjOvcjpLjaDMoQ7J0=
=r6sB
-----END PGP SIGNATURE-----
