From: Bram Schoenmakers <me@bramschoenmakers.nl>
Subject: [PATCH] Mention split command in git-add manpage
Date: Sat, 20 Oct 2007 21:15:08 +0200
Message-ID: <200710202115.10028.me@bramschoenmakers.nl>
Reply-To: me@bramschoenmakers.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 20 21:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjJnJ-0000ZJ-RD
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 21:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701AbXJTTPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 15:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757802AbXJTTPV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 15:15:21 -0400
Received: from viefep18-int.chello.at ([213.46.255.22]:5551 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbXJTTPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 15:15:19 -0400
Received: from IMP ([192.168.13.239]) by viefep18-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20071020191514.WCEU11104.viefep18-int.chello.at@IMP>;
          Sat, 20 Oct 2007 21:15:14 +0200
Received: from [192.168.1.100] ([77.251.93.109])
	by IMP with chello.at
	id 2jFB1Y00b2Mani50000000; Sat, 20 Oct 2007 21:15:14 +0200
User-Agent: KMail/1.9.7
X-Face: &[!|}QvdlkzFIu,|mW.\-Ci1t2d@CEo+#Q14@XM9*@`S,@l*5r-m!\,,kFc:ZlD62]6/>=?utf-8?q?=5B=0A=09Ovg=3BN=5Bqk=3B=60w6=3D5abys2!H+EUYcEDJ?=<R$6{yw]Wn]%kBpfM!H{Z:/MG[=]8"l":u7mOK)=?utf-8?q?bV=0A=09d?=<@pasEk@x{^+[vVtDh0l#Gnr1@L7foyeRl8`ANOb*VekgZ|-\Td<|{:T>=?utf-8?q?=25lo=26d67gO=2E!/=0A=09w?=@YD{YH]Ebe{@|(qtKgoum%{-=qXlf.+/`^E<'!m"?5d<&C(:B+p*KjP'-Knv!6U<=?utf-8?q?1W!=7EZ=0A=09P3ee-=7BfAb-i+MsJHM?=@
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61850>

Hello,

A little patch for the git-add manpage which mentions the 's' option for 
splitting hunks in git-add -i mode.

---
 Documentation/git-add.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 2fe7355..032957a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -210,6 +210,7 @@ patch::
        k - do not decide on this hunk now, and view the previous
            undecided hunk
        K - do not decide on this hunk now, and view the previous hunk
+       s - split large hunks at context lines in the middle
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
-- 
1.5.2.5

Kind regards,

-- 
Bram Schoenmakers

You can contact me directly on ICQ with #153817629
