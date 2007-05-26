From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] update diff-delta.c copyright
Date: Fri, 25 May 2007 22:16:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705252202160.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 04:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrlpn-0003hu-II
	for gcvg-git@gmane.org; Sat, 26 May 2007 04:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXEZCQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 22:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXEZCQh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 22:16:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39377 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXEZCQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 22:16:37 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIM0093IMBFYM00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 22:16:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48443>

There is actually nothing left from the original LibXDiff code I used 
over 2 years ago, and even the GIT implementation has diverged quite a 
bit from LibXDiff's at this point.  Let's update the copyright notice
to better reflect that fact.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/diff-delta.c b/diff-delta.c
index 09e6bcd..72b53d8 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -1,21 +1,14 @@
 /*
  * diff-delta.c: generate a delta between two buffers
  *
- *  Many parts of this file have been lifted from LibXDiff version 0.10.
- *  http://www.xmailserver.org/xdiff-lib.html
+ * This code was greatly inspired by parts of LibXDiff from Davide Libenzi
+ * http://www.xmailserver.org/xdiff-lib.html
  *
- *  LibXDiff was written by Davide Libenzi <davidel@xmailserver.org>
- *  Copyright (C) 2003	Davide Libenzi
+ * Rewritten for GIT by Nicolas Pitre <nico@cam.org>, (C) 2005-2007
  *
- *  Many mods for GIT usage by Nicolas Pitre <nico@cam.org>, (C) 2005.
- *
- *  This file is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  Use of this within git automatically means that the LGPL
- *  licensing gets turned into GPLv2 within this project.
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #include "git-compat-util.h"
