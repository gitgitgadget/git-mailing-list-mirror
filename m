From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [COGITO PATCH] fix "cg-Xnormid: command not found" error
Date: Sun, 29 May 2005 11:57:57 +0200
Message-ID: <1117360678.7072.53.camel@pegasus>
References: <20050529.121545.77345008.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 11:56:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcKWS-0006BT-1w
	for gcvg-git@gmane.org; Sun, 29 May 2005 11:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVE2J6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 05:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVE2J6L
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 05:58:11 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:11194 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261300AbVE2J6H
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 05:58:07 -0400
Received: from pegasus (p5487DF90.dip.t-dialin.net [84.135.223.144])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4T9xgSs018459
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 29 May 2005 11:59:43 +0200
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
In-Reply-To: <20050529.121545.77345008.yoshfuji@linux-ipv6.org>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

> Call cg-Xnormid with ${COGITO_LIB} to fix "cg-Xnormid: command not found"
> error.

I made the same patch, but when I used cg-diff to create the patch, I
got two extra annoying lines at the top.

commit-id: needs update
tree-id: needs update
Index: commit-id
===================================================================
--- c8e987e5e4608c1144293cd3f852210d70b572cb/commit-id  (mode:100755)
+++ uncommitted/commit-id  (mode:100755)

I think the "needs update" lines came from "git-update-cache --refresh"
and we don't really want them there. Should we simply direct the output
to /dev/null or what?

Regards

Marcel


