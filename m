From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem with cg-merge
Date: Sun, 29 May 2005 17:04:52 +0200
Message-ID: <1117379092.7072.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 17:03:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcPJS-0006Bh-9O
	for gcvg-git@gmane.org; Sun, 29 May 2005 17:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVE2PFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 11:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVE2PFG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 11:05:06 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:19898 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261331AbVE2PE6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 11:04:58 -0400
Received: from pegasus (p5487DF90.dip.t-dialin.net [84.135.223.144])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4TF6aSs020560
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 29 May 2005 17:06:37 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

I saw that earlier, but I don't have any idea what's wrong here. If I do
a simple cg-update, I see something like this:

Tree change: cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
:100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38 fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
:100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help

Applying changes...
Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 -> 89a14a5bd2c880095d5c618a102319bb3dc03da9
        on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
patching file cg-diff
patching file cg-help
cg-diff: needs update
cg-help: needs update

This is a little bit odd, because if I call "git-diff-cache HEAD" after
it, I will see that cg-diff and cg-help are modified. After calling
cg-cancel everything looks fine again.

Regards

Marcel


