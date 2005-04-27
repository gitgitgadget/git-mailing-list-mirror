From: Andrew Morton <akpm@osdl.org>
Subject: I'm missing isofs.h
Date: Tue, 26 Apr 2005 21:43:38 -0700
Message-ID: <20050426214338.32e9ac27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 06:39:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQeKk-0001VZ-Kr
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 06:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVD0EoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 00:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVD0EoV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 00:44:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:44246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261919AbVD0EoE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 00:44:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3R4hxs4027772
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 21:44:00 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3R4hx20029806;
	Tue, 26 Apr 2005 21:43:59 -0700
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


In a current tree, using git-pasky-0.7:

bix:/usr/src/git26> cat .git/tags/v2.6.12-rc3 
a2755a80f40e5794ddc20e00f781af9d6320fafb
bix:/usr/src/git26> git diff -r v2.6.12-rc3|grep isofs.h
+#include "isofs.h"
 #include "zisofs.h"
+#include "isofs.h"
+#include "isofs.h"
+#include "isofs.h"
 #include "zisofs.h"
+#include "isofs.h"
+#include "isofs.h"
+#include "isofs.h"
+#include "isofs.h"


That diff should have included the addition of the new isofs.h, but it
isn't there.

