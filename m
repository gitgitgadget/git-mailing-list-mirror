From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] Makefile: add compat/bswap.h to LIB_H
Date: Mon, 2 Nov 2009 02:09:05 +0300
Message-ID: <20091101230905.GA15675@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 00:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4jhb-0006Wf-7k
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 00:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZKAXTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbZKAXTG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 18:19:06 -0500
Received: from vint.altlinux.org ([194.107.17.35]:50567 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbZKAXTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 18:19:05 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2009 18:19:04 EST
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 3636E3F80251;
	Sun,  1 Nov 2009 23:09:05 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 1C4623F48C7C; Mon,  2 Nov 2009 02:09:05 +0300 (MSK)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131885>

Starting with commit 51ea55190b6e72c77c96754c1bf2f149a4714848,
git-compat-util.h includes compat/bswap.h

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 268aede..3bca8d4 100644
--- a/Makefile
+++ b/Makefile
@@ -412,6 +412,7 @@ LIB_H += builtin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
+LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += csum-file.h
-- 
ldv
