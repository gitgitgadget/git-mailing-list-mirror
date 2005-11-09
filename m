From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH 2/4] Add documentation for git-pack-intersect
Date: Wed, 09 Nov 2005 02:23:55 +0100
Organization: Chalmers
Message-ID: <43714FAB.2050501@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 09 02:24:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZegb-0008Ox-9D
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVKIBXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Nov 2005 20:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVKIBXf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:23:35 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:42424 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030499AbVKIBXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:23:34 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4368D4B9001B0D64; Wed, 9 Nov 2005 02:23:33 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43714EFB.5070705@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11380>

Add documentation for git-pack-intersect

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

 Documentation/git-pack-intersect.txt |   47 ++++++++++++++++++++++++++=
++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-pack-intersect.txt

applies-to: 2746df1385345537edc41746b191c67ee98eea20
a1b6ab6c15c3b782478a524a7fd7791ba92960e6
diff --git a/Documentation/git-pack-intersect.txt b/Documentation/git-p=
ack-intersect.txt
new file mode 100644
index 0000000..a73d9e3
--- /dev/null
+++ b/Documentation/git-pack-intersect.txt
@@ -0,0 +1,47 @@
+git-pack-intersect(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-pack-intersect - Program used to find redundant pack files.
+
+
+SYNOPSIS
+--------
+'git-pack-intersect [ -v ] < -a | .pack filename ... >'
+
+DESCRIPTION
+-----------
+This program computes which packs in your repository
+are redundant. The output is suitable for piping to
+'xargs rm' if you are in the root of the repository.
+
+OPTIONS
+-------
+
+-v::
+	Verbose. Outputs some statistics to stderr.
+	Has a small performance penalty.
+
+-a::
+	All. Processes all the local packs. Any filenames on
+	the commandline are ignored.
+
+Author
+------
+Written by Lukas Sandstr=F6m <lukass@etek.chalmers.se>
+
+Documentation
+--------------
+Documentation by Lukas Sandstr=F6m <lukass@etek.chalmers.se>
+
+See-Also
+--------
+gitlink:git-pack-objects[1]
+gitlink:git-repack[1]
+gitlink:git-prune-packed[1]
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
---
0.99.9.GIT
