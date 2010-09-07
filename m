From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] Documentation: move RelNotes into a directory of their own
Date: Mon, 06 Sep 2010 20:29:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009062026330.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osm4e-0007sv-VS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0IGAaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 20:30:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62679 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab0IGAaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 20:30:01 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8C00EGTPDXMI70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Sep 2010 20:30:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155655>


There are 108 of them already.  That's a bit more than one third of
all the files in the Documentation directory already, and still growing.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 .../{RelNotes-1.5.0.1.txt => RelNotes/1.5.0.1.txt} |    0
 .../{RelNotes-1.5.0.2.txt => RelNotes/1.5.0.2.txt} |    0
 .../{RelNotes-1.5.0.3.txt => RelNotes/1.5.0.3.txt} |    0
 .../{RelNotes-1.5.0.4.txt => RelNotes/1.5.0.4.txt} |    0
 .../{RelNotes-1.5.0.5.txt => RelNotes/1.5.0.5.txt} |    0
 .../{RelNotes-1.5.0.6.txt => RelNotes/1.5.0.6.txt} |    0
 .../{RelNotes-1.5.0.7.txt => RelNotes/1.5.0.7.txt} |    0
 .../{RelNotes-1.5.0.txt => RelNotes/1.5.0.txt}     |    0
 .../{RelNotes-1.5.1.1.txt => RelNotes/1.5.1.1.txt} |    0
 .../{RelNotes-1.5.1.2.txt => RelNotes/1.5.1.2.txt} |    0
 .../{RelNotes-1.5.1.3.txt => RelNotes/1.5.1.3.txt} |    0
 .../{RelNotes-1.5.1.4.txt => RelNotes/1.5.1.4.txt} |    0
 .../{RelNotes-1.5.1.5.txt => RelNotes/1.5.1.5.txt} |    0
 .../{RelNotes-1.5.1.6.txt => RelNotes/1.5.1.6.txt} |    0
 .../{RelNotes-1.5.1.txt => RelNotes/1.5.1.txt}     |    0
 .../{RelNotes-1.5.2.1.txt => RelNotes/1.5.2.1.txt} |    0
 .../{RelNotes-1.5.2.2.txt => RelNotes/1.5.2.2.txt} |    0
 .../{RelNotes-1.5.2.3.txt => RelNotes/1.5.2.3.txt} |    0
 .../{RelNotes-1.5.2.4.txt => RelNotes/1.5.2.4.txt} |    0
 .../{RelNotes-1.5.2.5.txt => RelNotes/1.5.2.5.txt} |    0
 .../{RelNotes-1.5.2.txt => RelNotes/1.5.2.txt}     |    0
 .../{RelNotes-1.5.3.1.txt => RelNotes/1.5.3.1.txt} |    0
 .../{RelNotes-1.5.3.2.txt => RelNotes/1.5.3.2.txt} |    0
 .../{RelNotes-1.5.3.3.txt => RelNotes/1.5.3.3.txt} |    0
 .../{RelNotes-1.5.3.4.txt => RelNotes/1.5.3.4.txt} |    0
 .../{RelNotes-1.5.3.5.txt => RelNotes/1.5.3.5.txt} |    0
 .../{RelNotes-1.5.3.6.txt => RelNotes/1.5.3.6.txt} |    0
 .../{RelNotes-1.5.3.7.txt => RelNotes/1.5.3.7.txt} |    0
 .../{RelNotes-1.5.3.8.txt => RelNotes/1.5.3.8.txt} |    0
 .../{RelNotes-1.5.3.txt => RelNotes/1.5.3.txt}     |    0
 .../{RelNotes-1.5.4.1.txt => RelNotes/1.5.4.1.txt} |    0
 .../{RelNotes-1.5.4.2.txt => RelNotes/1.5.4.2.txt} |    0
 .../{RelNotes-1.5.4.3.txt => RelNotes/1.5.4.3.txt} |    0
 .../{RelNotes-1.5.4.4.txt => RelNotes/1.5.4.4.txt} |    0
 .../{RelNotes-1.5.4.5.txt => RelNotes/1.5.4.5.txt} |    0
 .../{RelNotes-1.5.4.6.txt => RelNotes/1.5.4.6.txt} |    0
 .../{RelNotes-1.5.4.7.txt => RelNotes/1.5.4.7.txt} |    0
 .../{RelNotes-1.5.4.txt => RelNotes/1.5.4.txt}     |    0
 .../{RelNotes-1.5.5.1.txt => RelNotes/1.5.5.1.txt} |    0
 .../{RelNotes-1.5.5.2.txt => RelNotes/1.5.5.2.txt} |    0
 .../{RelNotes-1.5.5.3.txt => RelNotes/1.5.5.3.txt} |    0
 .../{RelNotes-1.5.5.4.txt => RelNotes/1.5.5.4.txt} |    0
 .../{RelNotes-1.5.5.5.txt => RelNotes/1.5.5.5.txt} |    0
 .../{RelNotes-1.5.5.6.txt => RelNotes/1.5.5.6.txt} |    0
 .../{RelNotes-1.5.5.txt => RelNotes/1.5.5.txt}     |    0
 .../{RelNotes-1.5.6.1.txt => RelNotes/1.5.6.1.txt} |    0
 .../{RelNotes-1.5.6.2.txt => RelNotes/1.5.6.2.txt} |    0
 .../{RelNotes-1.5.6.3.txt => RelNotes/1.5.6.3.txt} |    0
 .../{RelNotes-1.5.6.4.txt => RelNotes/1.5.6.4.txt} |    0
 .../{RelNotes-1.5.6.5.txt => RelNotes/1.5.6.5.txt} |    0
 .../{RelNotes-1.5.6.6.txt => RelNotes/1.5.6.6.txt} |    0
 .../{RelNotes-1.5.6.txt => RelNotes/1.5.6.txt}     |    0
 .../{RelNotes-1.6.0.1.txt => RelNotes/1.6.0.1.txt} |    0
 .../{RelNotes-1.6.0.2.txt => RelNotes/1.6.0.2.txt} |    0
 .../{RelNotes-1.6.0.3.txt => RelNotes/1.6.0.3.txt} |    0
 .../{RelNotes-1.6.0.4.txt => RelNotes/1.6.0.4.txt} |    0
 .../{RelNotes-1.6.0.5.txt => RelNotes/1.6.0.5.txt} |    0
 .../{RelNotes-1.6.0.6.txt => RelNotes/1.6.0.6.txt} |    0
 .../{RelNotes-1.6.0.txt => RelNotes/1.6.0.txt}     |    0
 .../{RelNotes-1.6.1.1.txt => RelNotes/1.6.1.1.txt} |    0
 .../{RelNotes-1.6.1.2.txt => RelNotes/1.6.1.2.txt} |    0
 .../{RelNotes-1.6.1.3.txt => RelNotes/1.6.1.3.txt} |    0
 .../{RelNotes-1.6.1.4.txt => RelNotes/1.6.1.4.txt} |    0
 .../{RelNotes-1.6.1.txt => RelNotes/1.6.1.txt}     |    0
 .../{RelNotes-1.6.2.1.txt => RelNotes/1.6.2.1.txt} |    0
 .../{RelNotes-1.6.2.2.txt => RelNotes/1.6.2.2.txt} |    0
 .../{RelNotes-1.6.2.3.txt => RelNotes/1.6.2.3.txt} |    0
 .../{RelNotes-1.6.2.4.txt => RelNotes/1.6.2.4.txt} |    0
 .../{RelNotes-1.6.2.5.txt => RelNotes/1.6.2.5.txt} |    0
 .../{RelNotes-1.6.2.txt => RelNotes/1.6.2.txt}     |    0
 .../{RelNotes-1.6.3.1.txt => RelNotes/1.6.3.1.txt} |    0
 .../{RelNotes-1.6.3.2.txt => RelNotes/1.6.3.2.txt} |    0
 .../{RelNotes-1.6.3.3.txt => RelNotes/1.6.3.3.txt} |    0
 .../{RelNotes-1.6.3.4.txt => RelNotes/1.6.3.4.txt} |    0
 .../{RelNotes-1.6.3.txt => RelNotes/1.6.3.txt}     |    0
 .../{RelNotes-1.6.4.1.txt => RelNotes/1.6.4.1.txt} |    0
 .../{RelNotes-1.6.4.2.txt => RelNotes/1.6.4.2.txt} |    0
 .../{RelNotes-1.6.4.3.txt => RelNotes/1.6.4.3.txt} |    0
 .../{RelNotes-1.6.4.4.txt => RelNotes/1.6.4.4.txt} |    0
 .../{RelNotes-1.6.4.txt => RelNotes/1.6.4.txt}     |    0
 .../{RelNotes-1.6.5.1.txt => RelNotes/1.6.5.1.txt} |    0
 .../{RelNotes-1.6.5.2.txt => RelNotes/1.6.5.2.txt} |    0
 .../{RelNotes-1.6.5.3.txt => RelNotes/1.6.5.3.txt} |    0
 .../{RelNotes-1.6.5.4.txt => RelNotes/1.6.5.4.txt} |    0
 .../{RelNotes-1.6.5.5.txt => RelNotes/1.6.5.5.txt} |    0
 .../{RelNotes-1.6.5.6.txt => RelNotes/1.6.5.6.txt} |    0
 .../{RelNotes-1.6.5.7.txt => RelNotes/1.6.5.7.txt} |    0
 .../{RelNotes-1.6.5.8.txt => RelNotes/1.6.5.8.txt} |    0
 .../{RelNotes-1.6.5.txt => RelNotes/1.6.5.txt}     |    0
 .../{RelNotes-1.6.6.1.txt => RelNotes/1.6.6.1.txt} |    0
 .../{RelNotes-1.6.6.2.txt => RelNotes/1.6.6.2.txt} |    0
 .../{RelNotes-1.6.6.txt => RelNotes/1.6.6.txt}     |    0
 .../{RelNotes-1.7.0.1.txt => RelNotes/1.7.0.1.txt} |    0
 .../{RelNotes-1.7.0.2.txt => RelNotes/1.7.0.2.txt} |    0
 .../{RelNotes-1.7.0.3.txt => RelNotes/1.7.0.3.txt} |    0
 .../{RelNotes-1.7.0.4.txt => RelNotes/1.7.0.4.txt} |    0
 .../{RelNotes-1.7.0.5.txt => RelNotes/1.7.0.5.txt} |    0
 .../{RelNotes-1.7.0.6.txt => RelNotes/1.7.0.6.txt} |    0
 .../{RelNotes-1.7.0.7.txt => RelNotes/1.7.0.7.txt} |    0
 .../{RelNotes-1.7.0.txt => RelNotes/1.7.0.txt}     |    0
 .../{RelNotes-1.7.1.1.txt => RelNotes/1.7.1.1.txt} |    0
 .../{RelNotes-1.7.1.2.txt => RelNotes/1.7.1.2.txt} |    0
 .../{RelNotes-1.7.1.txt => RelNotes/1.7.1.txt}     |    0
 .../{RelNotes-1.7.2.1.txt => RelNotes/1.7.2.1.txt} |    0
 .../{RelNotes-1.7.2.2.txt => RelNotes/1.7.2.2.txt} |    0
 .../{RelNotes-1.7.2.3.txt => RelNotes/1.7.2.3.txt} |    0
 .../{RelNotes-1.7.2.txt => RelNotes/1.7.2.txt}     |    0
 .../{RelNotes-1.7.3.txt => RelNotes/1.7.3.txt}     |    0
 Documentation/git.txt                              |  210 ++++++++++----------
 Documentation/install-webdoc.sh                    |    2 +-
 110 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/Documentation/RelNotes-1.5.0.1.txt b/Documentation/RelNotes/1.5.0.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.1.txt
rename to Documentation/RelNotes/1.5.0.1.txt
diff --git a/Documentation/RelNotes-1.5.0.2.txt b/Documentation/RelNotes/1.5.0.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.2.txt
rename to Documentation/RelNotes/1.5.0.2.txt
diff --git a/Documentation/RelNotes-1.5.0.3.txt b/Documentation/RelNotes/1.5.0.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.3.txt
rename to Documentation/RelNotes/1.5.0.3.txt
diff --git a/Documentation/RelNotes-1.5.0.4.txt b/Documentation/RelNotes/1.5.0.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.4.txt
rename to Documentation/RelNotes/1.5.0.4.txt
diff --git a/Documentation/RelNotes-1.5.0.5.txt b/Documentation/RelNotes/1.5.0.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.5.txt
rename to Documentation/RelNotes/1.5.0.5.txt
diff --git a/Documentation/RelNotes-1.5.0.6.txt b/Documentation/RelNotes/1.5.0.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.6.txt
rename to Documentation/RelNotes/1.5.0.6.txt
diff --git a/Documentation/RelNotes-1.5.0.7.txt b/Documentation/RelNotes/1.5.0.7.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.7.txt
rename to Documentation/RelNotes/1.5.0.7.txt
diff --git a/Documentation/RelNotes-1.5.0.txt b/Documentation/RelNotes/1.5.0.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.0.txt
rename to Documentation/RelNotes/1.5.0.txt
diff --git a/Documentation/RelNotes-1.5.1.1.txt b/Documentation/RelNotes/1.5.1.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.1.txt
rename to Documentation/RelNotes/1.5.1.1.txt
diff --git a/Documentation/RelNotes-1.5.1.2.txt b/Documentation/RelNotes/1.5.1.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.2.txt
rename to Documentation/RelNotes/1.5.1.2.txt
diff --git a/Documentation/RelNotes-1.5.1.3.txt b/Documentation/RelNotes/1.5.1.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.3.txt
rename to Documentation/RelNotes/1.5.1.3.txt
diff --git a/Documentation/RelNotes-1.5.1.4.txt b/Documentation/RelNotes/1.5.1.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.4.txt
rename to Documentation/RelNotes/1.5.1.4.txt
diff --git a/Documentation/RelNotes-1.5.1.5.txt b/Documentation/RelNotes/1.5.1.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.5.txt
rename to Documentation/RelNotes/1.5.1.5.txt
diff --git a/Documentation/RelNotes-1.5.1.6.txt b/Documentation/RelNotes/1.5.1.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.6.txt
rename to Documentation/RelNotes/1.5.1.6.txt
diff --git a/Documentation/RelNotes-1.5.1.txt b/Documentation/RelNotes/1.5.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.1.txt
rename to Documentation/RelNotes/1.5.1.txt
diff --git a/Documentation/RelNotes-1.5.2.1.txt b/Documentation/RelNotes/1.5.2.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.1.txt
rename to Documentation/RelNotes/1.5.2.1.txt
diff --git a/Documentation/RelNotes-1.5.2.2.txt b/Documentation/RelNotes/1.5.2.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.2.txt
rename to Documentation/RelNotes/1.5.2.2.txt
diff --git a/Documentation/RelNotes-1.5.2.3.txt b/Documentation/RelNotes/1.5.2.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.3.txt
rename to Documentation/RelNotes/1.5.2.3.txt
diff --git a/Documentation/RelNotes-1.5.2.4.txt b/Documentation/RelNotes/1.5.2.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.4.txt
rename to Documentation/RelNotes/1.5.2.4.txt
diff --git a/Documentation/RelNotes-1.5.2.5.txt b/Documentation/RelNotes/1.5.2.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.5.txt
rename to Documentation/RelNotes/1.5.2.5.txt
diff --git a/Documentation/RelNotes-1.5.2.txt b/Documentation/RelNotes/1.5.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.2.txt
rename to Documentation/RelNotes/1.5.2.txt
diff --git a/Documentation/RelNotes-1.5.3.1.txt b/Documentation/RelNotes/1.5.3.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.1.txt
rename to Documentation/RelNotes/1.5.3.1.txt
diff --git a/Documentation/RelNotes-1.5.3.2.txt b/Documentation/RelNotes/1.5.3.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.2.txt
rename to Documentation/RelNotes/1.5.3.2.txt
diff --git a/Documentation/RelNotes-1.5.3.3.txt b/Documentation/RelNotes/1.5.3.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.3.txt
rename to Documentation/RelNotes/1.5.3.3.txt
diff --git a/Documentation/RelNotes-1.5.3.4.txt b/Documentation/RelNotes/1.5.3.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.4.txt
rename to Documentation/RelNotes/1.5.3.4.txt
diff --git a/Documentation/RelNotes-1.5.3.5.txt b/Documentation/RelNotes/1.5.3.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.5.txt
rename to Documentation/RelNotes/1.5.3.5.txt
diff --git a/Documentation/RelNotes-1.5.3.6.txt b/Documentation/RelNotes/1.5.3.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.6.txt
rename to Documentation/RelNotes/1.5.3.6.txt
diff --git a/Documentation/RelNotes-1.5.3.7.txt b/Documentation/RelNotes/1.5.3.7.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.7.txt
rename to Documentation/RelNotes/1.5.3.7.txt
diff --git a/Documentation/RelNotes-1.5.3.8.txt b/Documentation/RelNotes/1.5.3.8.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.8.txt
rename to Documentation/RelNotes/1.5.3.8.txt
diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes/1.5.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.3.txt
rename to Documentation/RelNotes/1.5.3.txt
diff --git a/Documentation/RelNotes-1.5.4.1.txt b/Documentation/RelNotes/1.5.4.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.1.txt
rename to Documentation/RelNotes/1.5.4.1.txt
diff --git a/Documentation/RelNotes-1.5.4.2.txt b/Documentation/RelNotes/1.5.4.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.2.txt
rename to Documentation/RelNotes/1.5.4.2.txt
diff --git a/Documentation/RelNotes-1.5.4.3.txt b/Documentation/RelNotes/1.5.4.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.3.txt
rename to Documentation/RelNotes/1.5.4.3.txt
diff --git a/Documentation/RelNotes-1.5.4.4.txt b/Documentation/RelNotes/1.5.4.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.4.txt
rename to Documentation/RelNotes/1.5.4.4.txt
diff --git a/Documentation/RelNotes-1.5.4.5.txt b/Documentation/RelNotes/1.5.4.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.5.txt
rename to Documentation/RelNotes/1.5.4.5.txt
diff --git a/Documentation/RelNotes-1.5.4.6.txt b/Documentation/RelNotes/1.5.4.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.6.txt
rename to Documentation/RelNotes/1.5.4.6.txt
diff --git a/Documentation/RelNotes-1.5.4.7.txt b/Documentation/RelNotes/1.5.4.7.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.7.txt
rename to Documentation/RelNotes/1.5.4.7.txt
diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes/1.5.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.4.txt
rename to Documentation/RelNotes/1.5.4.txt
diff --git a/Documentation/RelNotes-1.5.5.1.txt b/Documentation/RelNotes/1.5.5.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.1.txt
rename to Documentation/RelNotes/1.5.5.1.txt
diff --git a/Documentation/RelNotes-1.5.5.2.txt b/Documentation/RelNotes/1.5.5.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.2.txt
rename to Documentation/RelNotes/1.5.5.2.txt
diff --git a/Documentation/RelNotes-1.5.5.3.txt b/Documentation/RelNotes/1.5.5.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.3.txt
rename to Documentation/RelNotes/1.5.5.3.txt
diff --git a/Documentation/RelNotes-1.5.5.4.txt b/Documentation/RelNotes/1.5.5.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.4.txt
rename to Documentation/RelNotes/1.5.5.4.txt
diff --git a/Documentation/RelNotes-1.5.5.5.txt b/Documentation/RelNotes/1.5.5.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.5.txt
rename to Documentation/RelNotes/1.5.5.5.txt
diff --git a/Documentation/RelNotes-1.5.5.6.txt b/Documentation/RelNotes/1.5.5.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.6.txt
rename to Documentation/RelNotes/1.5.5.6.txt
diff --git a/Documentation/RelNotes-1.5.5.txt b/Documentation/RelNotes/1.5.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.5.txt
rename to Documentation/RelNotes/1.5.5.txt
diff --git a/Documentation/RelNotes-1.5.6.1.txt b/Documentation/RelNotes/1.5.6.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.1.txt
rename to Documentation/RelNotes/1.5.6.1.txt
diff --git a/Documentation/RelNotes-1.5.6.2.txt b/Documentation/RelNotes/1.5.6.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.2.txt
rename to Documentation/RelNotes/1.5.6.2.txt
diff --git a/Documentation/RelNotes-1.5.6.3.txt b/Documentation/RelNotes/1.5.6.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.3.txt
rename to Documentation/RelNotes/1.5.6.3.txt
diff --git a/Documentation/RelNotes-1.5.6.4.txt b/Documentation/RelNotes/1.5.6.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.4.txt
rename to Documentation/RelNotes/1.5.6.4.txt
diff --git a/Documentation/RelNotes-1.5.6.5.txt b/Documentation/RelNotes/1.5.6.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.5.txt
rename to Documentation/RelNotes/1.5.6.5.txt
diff --git a/Documentation/RelNotes-1.5.6.6.txt b/Documentation/RelNotes/1.5.6.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.6.txt
rename to Documentation/RelNotes/1.5.6.6.txt
diff --git a/Documentation/RelNotes-1.5.6.txt b/Documentation/RelNotes/1.5.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.5.6.txt
rename to Documentation/RelNotes/1.5.6.txt
diff --git a/Documentation/RelNotes-1.6.0.1.txt b/Documentation/RelNotes/1.6.0.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.1.txt
rename to Documentation/RelNotes/1.6.0.1.txt
diff --git a/Documentation/RelNotes-1.6.0.2.txt b/Documentation/RelNotes/1.6.0.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.2.txt
rename to Documentation/RelNotes/1.6.0.2.txt
diff --git a/Documentation/RelNotes-1.6.0.3.txt b/Documentation/RelNotes/1.6.0.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.3.txt
rename to Documentation/RelNotes/1.6.0.3.txt
diff --git a/Documentation/RelNotes-1.6.0.4.txt b/Documentation/RelNotes/1.6.0.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.4.txt
rename to Documentation/RelNotes/1.6.0.4.txt
diff --git a/Documentation/RelNotes-1.6.0.5.txt b/Documentation/RelNotes/1.6.0.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.5.txt
rename to Documentation/RelNotes/1.6.0.5.txt
diff --git a/Documentation/RelNotes-1.6.0.6.txt b/Documentation/RelNotes/1.6.0.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.6.txt
rename to Documentation/RelNotes/1.6.0.6.txt
diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes/1.6.0.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.0.txt
rename to Documentation/RelNotes/1.6.0.txt
diff --git a/Documentation/RelNotes-1.6.1.1.txt b/Documentation/RelNotes/1.6.1.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.1.1.txt
rename to Documentation/RelNotes/1.6.1.1.txt
diff --git a/Documentation/RelNotes-1.6.1.2.txt b/Documentation/RelNotes/1.6.1.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.1.2.txt
rename to Documentation/RelNotes/1.6.1.2.txt
diff --git a/Documentation/RelNotes-1.6.1.3.txt b/Documentation/RelNotes/1.6.1.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.1.3.txt
rename to Documentation/RelNotes/1.6.1.3.txt
diff --git a/Documentation/RelNotes-1.6.1.4.txt b/Documentation/RelNotes/1.6.1.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.1.4.txt
rename to Documentation/RelNotes/1.6.1.4.txt
diff --git a/Documentation/RelNotes-1.6.1.txt b/Documentation/RelNotes/1.6.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.1.txt
rename to Documentation/RelNotes/1.6.1.txt
diff --git a/Documentation/RelNotes-1.6.2.1.txt b/Documentation/RelNotes/1.6.2.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.1.txt
rename to Documentation/RelNotes/1.6.2.1.txt
diff --git a/Documentation/RelNotes-1.6.2.2.txt b/Documentation/RelNotes/1.6.2.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.2.txt
rename to Documentation/RelNotes/1.6.2.2.txt
diff --git a/Documentation/RelNotes-1.6.2.3.txt b/Documentation/RelNotes/1.6.2.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.3.txt
rename to Documentation/RelNotes/1.6.2.3.txt
diff --git a/Documentation/RelNotes-1.6.2.4.txt b/Documentation/RelNotes/1.6.2.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.4.txt
rename to Documentation/RelNotes/1.6.2.4.txt
diff --git a/Documentation/RelNotes-1.6.2.5.txt b/Documentation/RelNotes/1.6.2.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.5.txt
rename to Documentation/RelNotes/1.6.2.5.txt
diff --git a/Documentation/RelNotes-1.6.2.txt b/Documentation/RelNotes/1.6.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.2.txt
rename to Documentation/RelNotes/1.6.2.txt
diff --git a/Documentation/RelNotes-1.6.3.1.txt b/Documentation/RelNotes/1.6.3.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.3.1.txt
rename to Documentation/RelNotes/1.6.3.1.txt
diff --git a/Documentation/RelNotes-1.6.3.2.txt b/Documentation/RelNotes/1.6.3.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.3.2.txt
rename to Documentation/RelNotes/1.6.3.2.txt
diff --git a/Documentation/RelNotes-1.6.3.3.txt b/Documentation/RelNotes/1.6.3.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.3.3.txt
rename to Documentation/RelNotes/1.6.3.3.txt
diff --git a/Documentation/RelNotes-1.6.3.4.txt b/Documentation/RelNotes/1.6.3.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.3.4.txt
rename to Documentation/RelNotes/1.6.3.4.txt
diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes/1.6.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.3.txt
rename to Documentation/RelNotes/1.6.3.txt
diff --git a/Documentation/RelNotes-1.6.4.1.txt b/Documentation/RelNotes/1.6.4.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.4.1.txt
rename to Documentation/RelNotes/1.6.4.1.txt
diff --git a/Documentation/RelNotes-1.6.4.2.txt b/Documentation/RelNotes/1.6.4.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.4.2.txt
rename to Documentation/RelNotes/1.6.4.2.txt
diff --git a/Documentation/RelNotes-1.6.4.3.txt b/Documentation/RelNotes/1.6.4.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.4.3.txt
rename to Documentation/RelNotes/1.6.4.3.txt
diff --git a/Documentation/RelNotes-1.6.4.4.txt b/Documentation/RelNotes/1.6.4.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.4.4.txt
rename to Documentation/RelNotes/1.6.4.4.txt
diff --git a/Documentation/RelNotes-1.6.4.txt b/Documentation/RelNotes/1.6.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.4.txt
rename to Documentation/RelNotes/1.6.4.txt
diff --git a/Documentation/RelNotes-1.6.5.1.txt b/Documentation/RelNotes/1.6.5.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.1.txt
rename to Documentation/RelNotes/1.6.5.1.txt
diff --git a/Documentation/RelNotes-1.6.5.2.txt b/Documentation/RelNotes/1.6.5.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.2.txt
rename to Documentation/RelNotes/1.6.5.2.txt
diff --git a/Documentation/RelNotes-1.6.5.3.txt b/Documentation/RelNotes/1.6.5.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.3.txt
rename to Documentation/RelNotes/1.6.5.3.txt
diff --git a/Documentation/RelNotes-1.6.5.4.txt b/Documentation/RelNotes/1.6.5.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.4.txt
rename to Documentation/RelNotes/1.6.5.4.txt
diff --git a/Documentation/RelNotes-1.6.5.5.txt b/Documentation/RelNotes/1.6.5.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.5.txt
rename to Documentation/RelNotes/1.6.5.5.txt
diff --git a/Documentation/RelNotes-1.6.5.6.txt b/Documentation/RelNotes/1.6.5.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.6.txt
rename to Documentation/RelNotes/1.6.5.6.txt
diff --git a/Documentation/RelNotes-1.6.5.7.txt b/Documentation/RelNotes/1.6.5.7.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.7.txt
rename to Documentation/RelNotes/1.6.5.7.txt
diff --git a/Documentation/RelNotes-1.6.5.8.txt b/Documentation/RelNotes/1.6.5.8.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.8.txt
rename to Documentation/RelNotes/1.6.5.8.txt
diff --git a/Documentation/RelNotes-1.6.5.txt b/Documentation/RelNotes/1.6.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.5.txt
rename to Documentation/RelNotes/1.6.5.txt
diff --git a/Documentation/RelNotes-1.6.6.1.txt b/Documentation/RelNotes/1.6.6.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.6.1.txt
rename to Documentation/RelNotes/1.6.6.1.txt
diff --git a/Documentation/RelNotes-1.6.6.2.txt b/Documentation/RelNotes/1.6.6.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.6.2.txt
rename to Documentation/RelNotes/1.6.6.2.txt
diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes/1.6.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.6.6.txt
rename to Documentation/RelNotes/1.6.6.txt
diff --git a/Documentation/RelNotes-1.7.0.1.txt b/Documentation/RelNotes/1.7.0.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.1.txt
rename to Documentation/RelNotes/1.7.0.1.txt
diff --git a/Documentation/RelNotes-1.7.0.2.txt b/Documentation/RelNotes/1.7.0.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.2.txt
rename to Documentation/RelNotes/1.7.0.2.txt
diff --git a/Documentation/RelNotes-1.7.0.3.txt b/Documentation/RelNotes/1.7.0.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.3.txt
rename to Documentation/RelNotes/1.7.0.3.txt
diff --git a/Documentation/RelNotes-1.7.0.4.txt b/Documentation/RelNotes/1.7.0.4.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.4.txt
rename to Documentation/RelNotes/1.7.0.4.txt
diff --git a/Documentation/RelNotes-1.7.0.5.txt b/Documentation/RelNotes/1.7.0.5.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.5.txt
rename to Documentation/RelNotes/1.7.0.5.txt
diff --git a/Documentation/RelNotes-1.7.0.6.txt b/Documentation/RelNotes/1.7.0.6.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.6.txt
rename to Documentation/RelNotes/1.7.0.6.txt
diff --git a/Documentation/RelNotes-1.7.0.7.txt b/Documentation/RelNotes/1.7.0.7.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.7.txt
rename to Documentation/RelNotes/1.7.0.7.txt
diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes/1.7.0.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.0.txt
rename to Documentation/RelNotes/1.7.0.txt
diff --git a/Documentation/RelNotes-1.7.1.1.txt b/Documentation/RelNotes/1.7.1.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.1.1.txt
rename to Documentation/RelNotes/1.7.1.1.txt
diff --git a/Documentation/RelNotes-1.7.1.2.txt b/Documentation/RelNotes/1.7.1.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.1.2.txt
rename to Documentation/RelNotes/1.7.1.2.txt
diff --git a/Documentation/RelNotes-1.7.1.txt b/Documentation/RelNotes/1.7.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.1.txt
rename to Documentation/RelNotes/1.7.1.txt
diff --git a/Documentation/RelNotes-1.7.2.1.txt b/Documentation/RelNotes/1.7.2.1.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.2.1.txt
rename to Documentation/RelNotes/1.7.2.1.txt
diff --git a/Documentation/RelNotes-1.7.2.2.txt b/Documentation/RelNotes/1.7.2.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.2.2.txt
rename to Documentation/RelNotes/1.7.2.2.txt
diff --git a/Documentation/RelNotes-1.7.2.3.txt b/Documentation/RelNotes/1.7.2.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.2.3.txt
rename to Documentation/RelNotes/1.7.2.3.txt
diff --git a/Documentation/RelNotes-1.7.2.txt b/Documentation/RelNotes/1.7.2.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.2.txt
rename to Documentation/RelNotes/1.7.2.txt
diff --git a/Documentation/RelNotes-1.7.3.txt b/Documentation/RelNotes/1.7.3.txt
similarity index 100%
rename from Documentation/RelNotes-1.7.3.txt
rename to Documentation/RelNotes/1.7.3.txt
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 93e3b07..d9988f1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -47,173 +47,173 @@ Documentation for older releases are available here:
 * link:v1.7.2.3/git.html[documentation for release 1.7.2.3]
 
 * release notes for
-  link:RelNotes-1.7.2.3.txt[1.7.2.3],
-  link:RelNotes-1.7.2.2.txt[1.7.2.2],
-  link:RelNotes-1.7.2.1.txt[1.7.2.1],
-  link:RelNotes-1.7.2.txt[1.7.2].
+  link:RelNotes/1.7.2.3.txt[1.7.2.3],
+  link:RelNotes/1.7.2.2.txt[1.7.2.2],
+  link:RelNotes/1.7.2.1.txt[1.7.2.1],
+  link:RelNotes/1.7.2.txt[1.7.2].
 
 * link:v1.7.1.2/git.html[documentation for release 1.7.1.2]
 
 * release notes for
-  link:RelNotes-1.7.1.2.txt[1.7.1.2],
-  link:RelNotes-1.7.1.1.txt[1.7.1.1],
-  link:RelNotes-1.7.1.txt[1.7.1].
+  link:RelNotes/1.7.1.2.txt[1.7.1.2],
+  link:RelNotes/1.7.1.1.txt[1.7.1.1],
+  link:RelNotes/1.7.1.txt[1.7.1].
 
 * link:v1.7.0.7/git.html[documentation for release 1.7.0.7]
 
 * release notes for
-  link:RelNotes-1.7.0.7.txt[1.7.0.7],
-  link:RelNotes-1.7.0.6.txt[1.7.0.6],
-  link:RelNotes-1.7.0.5.txt[1.7.0.5],
-  link:RelNotes-1.7.0.4.txt[1.7.0.4],
-  link:RelNotes-1.7.0.3.txt[1.7.0.3],
-  link:RelNotes-1.7.0.2.txt[1.7.0.2],
-  link:RelNotes-1.7.0.1.txt[1.7.0.1],
-  link:RelNotes-1.7.0.txt[1.7.0].
+  link:RelNotes/1.7.0.7.txt[1.7.0.7],
+  link:RelNotes/1.7.0.6.txt[1.7.0.6],
+  link:RelNotes/1.7.0.5.txt[1.7.0.5],
+  link:RelNotes/1.7.0.4.txt[1.7.0.4],
+  link:RelNotes/1.7.0.3.txt[1.7.0.3],
+  link:RelNotes/1.7.0.2.txt[1.7.0.2],
+  link:RelNotes/1.7.0.1.txt[1.7.0.1],
+  link:RelNotes/1.7.0.txt[1.7.0].
 
 * link:v1.6.6.2/git.html[documentation for release 1.6.6.2]
 
 * release notes for
-  link:RelNotes-1.6.6.2.txt[1.6.6.2],
-  link:RelNotes-1.6.6.1.txt[1.6.6.1],
-  link:RelNotes-1.6.6.txt[1.6.6].
+  link:RelNotes/1.6.6.2.txt[1.6.6.2],
+  link:RelNotes/1.6.6.1.txt[1.6.6.1],
+  link:RelNotes/1.6.6.txt[1.6.6].
 
 * link:v1.6.5.8/git.html[documentation for release 1.6.5.8]
 
 * release notes for
-  link:RelNotes-1.6.5.8.txt[1.6.5.8],
-  link:RelNotes-1.6.5.7.txt[1.6.5.7],
-  link:RelNotes-1.6.5.6.txt[1.6.5.6],
-  link:RelNotes-1.6.5.5.txt[1.6.5.5],
-  link:RelNotes-1.6.5.4.txt[1.6.5.4],
-  link:RelNotes-1.6.5.3.txt[1.6.5.3],
-  link:RelNotes-1.6.5.2.txt[1.6.5.2],
-  link:RelNotes-1.6.5.1.txt[1.6.5.1],
-  link:RelNotes-1.6.5.txt[1.6.5].
+  link:RelNotes/1.6.5.8.txt[1.6.5.8],
+  link:RelNotes/1.6.5.7.txt[1.6.5.7],
+  link:RelNotes/1.6.5.6.txt[1.6.5.6],
+  link:RelNotes/1.6.5.5.txt[1.6.5.5],
+  link:RelNotes/1.6.5.4.txt[1.6.5.4],
+  link:RelNotes/1.6.5.3.txt[1.6.5.3],
+  link:RelNotes/1.6.5.2.txt[1.6.5.2],
+  link:RelNotes/1.6.5.1.txt[1.6.5.1],
+  link:RelNotes/1.6.5.txt[1.6.5].
 
 * link:v1.6.4.4/git.html[documentation for release 1.6.4.4]
 
 * release notes for
-  link:RelNotes-1.6.4.4.txt[1.6.4.4],
-  link:RelNotes-1.6.4.3.txt[1.6.4.3],
-  link:RelNotes-1.6.4.2.txt[1.6.4.2],
-  link:RelNotes-1.6.4.1.txt[1.6.4.1],
-  link:RelNotes-1.6.4.txt[1.6.4].
+  link:RelNotes/1.6.4.4.txt[1.6.4.4],
+  link:RelNotes/1.6.4.3.txt[1.6.4.3],
+  link:RelNotes/1.6.4.2.txt[1.6.4.2],
+  link:RelNotes/1.6.4.1.txt[1.6.4.1],
+  link:RelNotes/1.6.4.txt[1.6.4].
 
 * link:v1.6.3.4/git.html[documentation for release 1.6.3.4]
 
 * release notes for
-  link:RelNotes-1.6.3.4.txt[1.6.3.4],
-  link:RelNotes-1.6.3.3.txt[1.6.3.3],
-  link:RelNotes-1.6.3.2.txt[1.6.3.2],
-  link:RelNotes-1.6.3.1.txt[1.6.3.1],
-  link:RelNotes-1.6.3.txt[1.6.3].
+  link:RelNotes/1.6.3.4.txt[1.6.3.4],
+  link:RelNotes/1.6.3.3.txt[1.6.3.3],
+  link:RelNotes/1.6.3.2.txt[1.6.3.2],
+  link:RelNotes/1.6.3.1.txt[1.6.3.1],
+  link:RelNotes/1.6.3.txt[1.6.3].
 
 * release notes for
-  link:RelNotes-1.6.2.5.txt[1.6.2.5],
-  link:RelNotes-1.6.2.4.txt[1.6.2.4],
-  link:RelNotes-1.6.2.3.txt[1.6.2.3],
-  link:RelNotes-1.6.2.2.txt[1.6.2.2],
-  link:RelNotes-1.6.2.1.txt[1.6.2.1],
-  link:RelNotes-1.6.2.txt[1.6.2].
+  link:RelNotes/1.6.2.5.txt[1.6.2.5],
+  link:RelNotes/1.6.2.4.txt[1.6.2.4],
+  link:RelNotes/1.6.2.3.txt[1.6.2.3],
+  link:RelNotes/1.6.2.2.txt[1.6.2.2],
+  link:RelNotes/1.6.2.1.txt[1.6.2.1],
+  link:RelNotes/1.6.2.txt[1.6.2].
 
 * link:v1.6.1.3/git.html[documentation for release 1.6.1.3]
 
 * release notes for
-  link:RelNotes-1.6.1.3.txt[1.6.1.3],
-  link:RelNotes-1.6.1.2.txt[1.6.1.2],
-  link:RelNotes-1.6.1.1.txt[1.6.1.1],
-  link:RelNotes-1.6.1.txt[1.6.1].
+  link:RelNotes/1.6.1.3.txt[1.6.1.3],
+  link:RelNotes/1.6.1.2.txt[1.6.1.2],
+  link:RelNotes/1.6.1.1.txt[1.6.1.1],
+  link:RelNotes/1.6.1.txt[1.6.1].
 
 * link:v1.6.0.6/git.html[documentation for release 1.6.0.6]
 
 * release notes for
-  link:RelNotes-1.6.0.6.txt[1.6.0.6],
-  link:RelNotes-1.6.0.5.txt[1.6.0.5],
-  link:RelNotes-1.6.0.4.txt[1.6.0.4],
-  link:RelNotes-1.6.0.3.txt[1.6.0.3],
-  link:RelNotes-1.6.0.2.txt[1.6.0.2],
-  link:RelNotes-1.6.0.1.txt[1.6.0.1],
-  link:RelNotes-1.6.0.txt[1.6.0].
+  link:RelNotes/1.6.0.6.txt[1.6.0.6],
+  link:RelNotes/1.6.0.5.txt[1.6.0.5],
+  link:RelNotes/1.6.0.4.txt[1.6.0.4],
+  link:RelNotes/1.6.0.3.txt[1.6.0.3],
+  link:RelNotes/1.6.0.2.txt[1.6.0.2],
+  link:RelNotes/1.6.0.1.txt[1.6.0.1],
+  link:RelNotes/1.6.0.txt[1.6.0].
 
 * link:v1.5.6.6/git.html[documentation for release 1.5.6.6]
 
 * release notes for
-  link:RelNotes-1.5.6.6.txt[1.5.6.6],
-  link:RelNotes-1.5.6.5.txt[1.5.6.5],
-  link:RelNotes-1.5.6.4.txt[1.5.6.4],
-  link:RelNotes-1.5.6.3.txt[1.5.6.3],
-  link:RelNotes-1.5.6.2.txt[1.5.6.2],
-  link:RelNotes-1.5.6.1.txt[1.5.6.1],
-  link:RelNotes-1.5.6.txt[1.5.6].
+  link:RelNotes/1.5.6.6.txt[1.5.6.6],
+  link:RelNotes/1.5.6.5.txt[1.5.6.5],
+  link:RelNotes/1.5.6.4.txt[1.5.6.4],
+  link:RelNotes/1.5.6.3.txt[1.5.6.3],
+  link:RelNotes/1.5.6.2.txt[1.5.6.2],
+  link:RelNotes/1.5.6.1.txt[1.5.6.1],
+  link:RelNotes/1.5.6.txt[1.5.6].
 
 * link:v1.5.5.6/git.html[documentation for release 1.5.5.6]
 
 * release notes for
-  link:RelNotes-1.5.5.6.txt[1.5.5.6],
-  link:RelNotes-1.5.5.5.txt[1.5.5.5],
-  link:RelNotes-1.5.5.4.txt[1.5.5.4],
-  link:RelNotes-1.5.5.3.txt[1.5.5.3],
-  link:RelNotes-1.5.5.2.txt[1.5.5.2],
-  link:RelNotes-1.5.5.1.txt[1.5.5.1],
-  link:RelNotes-1.5.5.txt[1.5.5].
+  link:RelNotes/1.5.5.6.txt[1.5.5.6],
+  link:RelNotes/1.5.5.5.txt[1.5.5.5],
+  link:RelNotes/1.5.5.4.txt[1.5.5.4],
+  link:RelNotes/1.5.5.3.txt[1.5.5.3],
+  link:RelNotes/1.5.5.2.txt[1.5.5.2],
+  link:RelNotes/1.5.5.1.txt[1.5.5.1],
+  link:RelNotes/1.5.5.txt[1.5.5].
 
 * link:v1.5.4.7/git.html[documentation for release 1.5.4.7]
 
 * release notes for
-  link:RelNotes-1.5.4.7.txt[1.5.4.7],
-  link:RelNotes-1.5.4.6.txt[1.5.4.6],
-  link:RelNotes-1.5.4.5.txt[1.5.4.5],
-  link:RelNotes-1.5.4.4.txt[1.5.4.4],
-  link:RelNotes-1.5.4.3.txt[1.5.4.3],
-  link:RelNotes-1.5.4.2.txt[1.5.4.2],
-  link:RelNotes-1.5.4.1.txt[1.5.4.1],
-  link:RelNotes-1.5.4.txt[1.5.4].
+  link:RelNotes/1.5.4.7.txt[1.5.4.7],
+  link:RelNotes/1.5.4.6.txt[1.5.4.6],
+  link:RelNotes/1.5.4.5.txt[1.5.4.5],
+  link:RelNotes/1.5.4.4.txt[1.5.4.4],
+  link:RelNotes/1.5.4.3.txt[1.5.4.3],
+  link:RelNotes/1.5.4.2.txt[1.5.4.2],
+  link:RelNotes/1.5.4.1.txt[1.5.4.1],
+  link:RelNotes/1.5.4.txt[1.5.4].
 
 * link:v1.5.3.8/git.html[documentation for release 1.5.3.8]
 
 * release notes for
-  link:RelNotes-1.5.3.8.txt[1.5.3.8],
-  link:RelNotes-1.5.3.7.txt[1.5.3.7],
-  link:RelNotes-1.5.3.6.txt[1.5.3.6],
-  link:RelNotes-1.5.3.5.txt[1.5.3.5],
-  link:RelNotes-1.5.3.4.txt[1.5.3.4],
-  link:RelNotes-1.5.3.3.txt[1.5.3.3],
-  link:RelNotes-1.5.3.2.txt[1.5.3.2],
-  link:RelNotes-1.5.3.1.txt[1.5.3.1],
-  link:RelNotes-1.5.3.txt[1.5.3].
+  link:RelNotes/1.5.3.8.txt[1.5.3.8],
+  link:RelNotes/1.5.3.7.txt[1.5.3.7],
+  link:RelNotes/1.5.3.6.txt[1.5.3.6],
+  link:RelNotes/1.5.3.5.txt[1.5.3.5],
+  link:RelNotes/1.5.3.4.txt[1.5.3.4],
+  link:RelNotes/1.5.3.3.txt[1.5.3.3],
+  link:RelNotes/1.5.3.2.txt[1.5.3.2],
+  link:RelNotes/1.5.3.1.txt[1.5.3.1],
+  link:RelNotes/1.5.3.txt[1.5.3].
 
 * link:v1.5.2.5/git.html[documentation for release 1.5.2.5]
 
 * release notes for
-  link:RelNotes-1.5.2.5.txt[1.5.2.5],
-  link:RelNotes-1.5.2.4.txt[1.5.2.4],
-  link:RelNotes-1.5.2.3.txt[1.5.2.3],
-  link:RelNotes-1.5.2.2.txt[1.5.2.2],
-  link:RelNotes-1.5.2.1.txt[1.5.2.1],
-  link:RelNotes-1.5.2.txt[1.5.2].
+  link:RelNotes/1.5.2.5.txt[1.5.2.5],
+  link:RelNotes/1.5.2.4.txt[1.5.2.4],
+  link:RelNotes/1.5.2.3.txt[1.5.2.3],
+  link:RelNotes/1.5.2.2.txt[1.5.2.2],
+  link:RelNotes/1.5.2.1.txt[1.5.2.1],
+  link:RelNotes/1.5.2.txt[1.5.2].
 
 * link:v1.5.1.6/git.html[documentation for release 1.5.1.6]
 
 * release notes for
-  link:RelNotes-1.5.1.6.txt[1.5.1.6],
-  link:RelNotes-1.5.1.5.txt[1.5.1.5],
-  link:RelNotes-1.5.1.4.txt[1.5.1.4],
-  link:RelNotes-1.5.1.3.txt[1.5.1.3],
-  link:RelNotes-1.5.1.2.txt[1.5.1.2],
-  link:RelNotes-1.5.1.1.txt[1.5.1.1],
-  link:RelNotes-1.5.1.txt[1.5.1].
+  link:RelNotes/1.5.1.6.txt[1.5.1.6],
+  link:RelNotes/1.5.1.5.txt[1.5.1.5],
+  link:RelNotes/1.5.1.4.txt[1.5.1.4],
+  link:RelNotes/1.5.1.3.txt[1.5.1.3],
+  link:RelNotes/1.5.1.2.txt[1.5.1.2],
+  link:RelNotes/1.5.1.1.txt[1.5.1.1],
+  link:RelNotes/1.5.1.txt[1.5.1].
 
 * link:v1.5.0.7/git.html[documentation for release 1.5.0.7]
 
 * release notes for
-  link:RelNotes-1.5.0.7.txt[1.5.0.7],
-  link:RelNotes-1.5.0.6.txt[1.5.0.6],
-  link:RelNotes-1.5.0.5.txt[1.5.0.5],
-  link:RelNotes-1.5.0.3.txt[1.5.0.3],
-  link:RelNotes-1.5.0.2.txt[1.5.0.2],
-  link:RelNotes-1.5.0.1.txt[1.5.0.1],
-  link:RelNotes-1.5.0.txt[1.5.0].
+  link:RelNotes/1.5.0.7.txt[1.5.0.7],
+  link:RelNotes/1.5.0.6.txt[1.5.0.6],
+  link:RelNotes/1.5.0.5.txt[1.5.0.5],
+  link:RelNotes/1.5.0.3.txt[1.5.0.3],
+  link:RelNotes/1.5.0.2.txt[1.5.0.2],
+  link:RelNotes/1.5.0.1.txt[1.5.0.1],
+  link:RelNotes/1.5.0.txt[1.5.0].
 
 * documentation for release link:v1.4.4.4/git.html[1.4.4.4],
   link:v1.3.3/git.html[1.3.3],
diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index 37e67d1..e5c1cbe 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -6,7 +6,7 @@ for h in \
 	*.txt *.html \
 	howto/*.txt howto/*.html \
 	technical/*.txt technical/*.html \
-	RelNotes-*.txt *.css
+	RelNotes/*.txt *.css
 do
 	if test ! -f "$h"
 	then
