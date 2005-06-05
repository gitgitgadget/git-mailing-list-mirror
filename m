From: Chris Wedgwood <cw@f00f.org>
Subject: [PATCH] cogitio: sh != bash
Date: Sun, 5 Jun 2005 00:45:33 -0700
Message-ID: <20050605074533.GA18645@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 09:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DepmE-0007y0-P1
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 09:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFEHpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVFEHpn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 03:45:43 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:47509 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261515AbVFEHpi
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 03:45:38 -0400
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j557jPCg018043
	for <git@vger.kernel.org>; Sun, 5 Jun 2005 03:45:26 -0400
X-ORBL: [63.202.173.158]
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j557jYIJ240492;
	Sun, 5 Jun 2005 03:45:34 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id CFF1A529BBC; Sun,  5 Jun 2005 00:45:33 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Without this users of dash (or similar?) as /bin/sh will get
'substitution' warnings.


diff --git a/cg-patch b/cg-patch
--- a/cg-patch
+++ b/cg-patch
@@ -128,7 +128,7 @@ wait
 touchfiles="$(git-ls-files --deleted | join -v 2 $gonefile -)"
 [ "$touchfiles" ] && touch $touchfiles
 
-cat $todo | xargs -0 sh -c '
+cat $todo | xargs -0 bash -c '
 while [ "$1" ]; do
 	op="$1"; shift;
 	case "$op" in

