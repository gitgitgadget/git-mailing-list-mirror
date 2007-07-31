From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] Mention libiconv as a requirement for git-am
Date: Tue, 31 Jul 2007 11:09:48 -0400
Message-ID: <20070731150948.GA9947@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFtMh-0007bT-PH
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 17:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763404AbXGaPKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 11:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762160AbXGaPKS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 11:10:18 -0400
Received: from ag-out-0708.google.com ([72.14.246.241]:1990 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762279AbXGaPKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 11:10:16 -0400
Received: by ag-out-0708.google.com with SMTP id 35so786822aga
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 08:10:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ebD02AirF8KCm8Ej5UQUXM6dRvwVW7+oAcDnvALevgADfK8JmVdsEBcXI9Uj4sDsCmtBjt4Nqij3eovytKYB7TtvgJn8D4TRXQPM6D1hkSZXry3tSUvSvtIbeY+qgev/8GiB3d/hddbPLo887e5PEJ9v9qPX1e3J1U5kKEuU5uU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hTkd5oXm45vPUHBWpZZKtOMMrZtGl1EuoKXPO+N6VC20NFRj01TOv5Ii9PXsOvLqU7DMU7UvtU25n0JxiTQud8/ZjqqlJsQ27+KaoBelRu7hidYf7Gai8WrVyu74bnWBQCuI4y2GYjRvydRyzaK3/WvPMJ4wk+42hd86EJMECmQ=
Received: by 10.100.13.12 with SMTP id 12mr5312512anm.1185894610798;
        Tue, 31 Jul 2007 08:10:10 -0700 (PDT)
Received: from pclouds@gmail.com ( [66.129.232.2])
        by mx.google.com with ESMTPS id c16sm3993857anc.2007.07.31.08.10.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 08:10:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 31 Jul 2007 11:09:48 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54358>

---
 Han-Wen, any chance to include libiconv to the installer? You may need
 to set NEEDS_ICONV, ICONVDIR and NO_ICONV properly to make git-am work.

 README.MinGW |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/README.MinGW b/README.MinGW
index 89b7065..c0b8f66 100644
--- a/README.MinGW
+++ b/README.MinGW
@@ -28,6 +28,7 @@ In order to compile this code you need:
 	zlib-1.2.3-mingwPORT-1.tar
 	w32api-3.6.tar.gz
 	tcltk-8.4.1-1.exe (for gitk, git-gui)
+	libiconv-1.9.2-1-{lib,bin}.zip (for git-am, from http://gnuwin32.sourceforge.net/packages/libiconv.htm)
 
 
 STATUS
-- 
1.5.0.7
