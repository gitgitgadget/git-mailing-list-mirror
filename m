From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 2/3] Add license boiler-plates
Date: Sun, 12 Jul 2009 16:47:00 +0200 (CEST)
Message-ID: <7723165e07318851210a9636cd94d10c23b85167.1247408350u.git.johannes.schindelin@gmx.de>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 16:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ0Ip-0002r3-Lz
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 16:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbZGLOpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZGLOpN
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 10:45:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:38572 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752948AbZGLOpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 10:45:04 -0400
Received: (qmail invoked by alias); 12 Jul 2009 14:45:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 12 Jul 2009 16:45:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18spO85JYYs3COJC/Wo5MPbENv4YD3d2DJjWAuhDl
	wa1GTwuolbuz5Z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1247408350u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123150>

Add some legalese so that sue-happy people get not that happy.  This
patch is separate from the code part to help reviewers in getting
less distracted.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../src/org/spearce/jgit/gui/CommitGraph.java      |   37 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/CommitGrid.java       |   37 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/CommitPainter.java    |   37 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/CommitRow.java        |   37 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/GraphCommit.java      |   37 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/GraphWalk.java        |   37 ++++++++++++++++++++
 6 files changed, 222 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
index 0d94865..7c77c9b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import java.awt.Dimension;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
index 77f56f6..379bdf3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import java.awt.Dimension;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
index 061cd2f..e67e6ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import java.awt.Color;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
index d110e89..e3ec75f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import java.util.ArrayList;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
index 13a5936..6c99a4f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import org.spearce.jgit.lib.AnyObjectId;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
index fe98df3..8297b57 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
@@ -1,3 +1,40 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 package org.spearce.jgit.gui;
 
 import java.io.IOException;
-- 
1.6.3.3.644.g82c56
