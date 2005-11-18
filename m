From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Document the "ignore objects" feature of git-pack-redundant
Date: Fri, 18 Nov 2005 23:20:15 +0100
Organization: Chalmers
Message-ID: <437E539F.6080304@etek.chalmers.se>
References: <437E530E.1020803@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 23:43:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdEaC-0003Jl-Tt
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVKRWTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 17:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVKRWTq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:19:46 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:36540 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751044AbVKRWTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:19:45 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 437DDE8100018AEE; Fri, 18 Nov 2005 23:19:45 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437E530E.1020803@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12277>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---

 Documentation/git-pack-redundant.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

applies-to: 5053091ee7d1f4b32b18a21f4b255cf1141cf72c
e417344dab21aca41fbc1f99d935ef033e53e3a8
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-p=
ack-redundant.txt
index 2e23cbc..9fe86ae 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -16,6 +16,14 @@ This program computes which packs in you
 are redundant. The output is suitable for piping to
 'xargs rm' if you are in the root of the repository.
=20
+git-pack-redundant accepts a list of objects on standard input. Any ob=
jects
+given will be ignored when checking which packs are required. This mak=
es the=20
+following command useful when wanting to remove packs which contain un=
reachable
+objects.
+
+git-fsck-objects --full --unreachable | cut -d ' ' -f3 | \
+git-pack-redundant --all | xargs rm
+
 OPTIONS
 -------
=20
---
0.99.9.GIT
