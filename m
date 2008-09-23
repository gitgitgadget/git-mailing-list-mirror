From: Abdelrazak Younes <younes@lyx.org>
Subject: [QGit] Can't compile under windows (MSVC2008)
Date: Tue, 23 Sep 2008 13:31:29 +0200
Message-ID: <gbak2u$v9b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080406060301080409080301"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 13:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki69C-0008HW-Gz
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbYIWLbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYIWLbz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:31:55 -0400
Received: from main.gmane.org ([80.91.229.2]:37488 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbYIWLbx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:31:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ki67S-0000Vv-2Z
	for git@vger.kernel.org; Tue, 23 Sep 2008 11:31:50 +0000
Received: from gre92-10-88-181-30-42.fbx.proxad.net ([88.181.30.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 11:31:50 +0000
Received: from younes by gre92-10-88-181-30-42.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 11:31:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-10-88-181-30-42.fbx.proxad.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96550>

This is a multi-part message in MIME format.
--------------080406060301080409080301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I tried to follow README_WIN.txt:

C:\devel\qgit\qgit4>qmake qgit.pro

The Makefile (attached to this mail) seems to be correctly generated in 
the same directory (C:\devel\qgit\qgit4).

Then, under MSVC2008 Express, I get this error:

1>------ Début de la génération : Projet : qgit, Configuration : Debug 
Win32 ------
1>Actions de projet Makefile en cours
1>Microsoft (R) Program Maintenance Utility Version 9.00.21022.08
1>Copyright (C) Microsoft Corporation. Tous droits rÚservÚs.
1> cd src\ && "C:\Program Files\Microsoft Visual Studio 
9.0\VC\bin\nmake.exe" debug
1>Microsoft (R) Program Maintenance Utility Version 9.00.21022.08
1>Copyright (C) Microsoft Corporation. Tous droits rÚservÚs.
1>NMAKE : fatal error U1073: incapable d'obtenir 'src\\Makefile'
1>Stop.
1>NMAKE : fatal error U1077: 'cd'á: code retour '0x2'
1>Stop.
1>Project : error PRJ0019: Un outil a retourné un code d'erreur à partir 
de "Actions de projet Makefile en cours"
1>Le journal de génération a été enregistré à l'emplacement 
"file://c:\devel\qgit\qgit4\Debug\BuildLog.htm"
1>qgit - 3 erreur(s), 0 avertissement(s)
========== Génération : 0 a réussi, 1 a échoué, 0 mis à jour, 0 a été 
ignoré ==========

Idea someone?

Wouldn't it be nice to use CMake instead of qmake so that the MSVC 
solution is generated directly?

Abdel.

--------------080406060301080409080301
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Makefile"

IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiMgTWFrZWZpbGUgZm9yIGJ1aWxkaW5nOiBxZ2l0
DQojIEdlbmVyYXRlZCBieSBxbWFrZSAoMi4wMWEpIChRdCA0LjQuMi1zbmFwc2hvdC0yMDA4
MDczMCkgb246IG1hci4gMjMuIHNlcHQuIDEzOjI2OjM1IDIwMDgNCiMgUHJvamVjdDogIHFn
aXQucHJvDQojIFRlbXBsYXRlOiBzdWJkaXJzDQojIENvbW1hbmQ6IGM6XGRldmVsXHF0XDQu
NFxiaW5ccW1ha2UuZXhlIC13aW4zMiAtbyBNYWtlZmlsZSBxZ2l0LnBybw0KIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMNCg0KZmlyc3Q6IG1ha2VfZGVmYXVsdA0KTUFLRUZJTEUgICAgICA9
IE1ha2VmaWxlDQpRTUFLRSAgICAgICAgID0gYzpcZGV2ZWxccXRcNC40XGJpblxxbWFrZS5l
eGUNCkRFTF9GSUxFICAgICAgPSBkZWwNCkNIS19ESVJfRVhJU1RTPSBpZiBub3QgZXhpc3QN
Ck1LRElSICAgICAgICAgPSBta2Rpcg0KQ09QWSAgICAgICAgICA9IGNvcHkgL3kNCkNPUFlf
RklMRSAgICAgPSAkKENPUFkpDQpDT1BZX0RJUiAgICAgID0geGNvcHkgL3MgL3EgL3kgL2kN
CklOU1RBTExfRklMRSAgPSAkKENPUFlfRklMRSkNCklOU1RBTExfUFJPR1JBTSA9ICQoQ09Q
WV9GSUxFKQ0KSU5TVEFMTF9ESVIgICA9ICQoQ09QWV9ESVIpDQpERUxfRklMRSAgICAgID0g
ZGVsDQpTWU1MSU5LICAgICAgID0gDQpERUxfRElSICAgICAgID0gcm1kaXINCk1PVkUgICAg
ICAgICAgPSBtb3ZlDQpDSEtfRElSX0VYSVNUUz0gaWYgbm90IGV4aXN0DQpNS0RJUiAgICAg
ICAgID0gbWtkaXINClNVQlRBUkdFVFMgICAgPSAgXA0KCQlzdWItc3JjDQoNCnNyY1wkKE1B
S0VGSUxFKTogDQoJQCQoQ0hLX0RJUl9FWElTVFMpIHNyY1wgJChNS0RJUikgc3JjXCANCglj
ZCBzcmNcICYmICQoUU1BS0UpIHNyYy5wcm8gLXdpbjMyIC1vICQoTUFLRUZJTEUpDQpzdWIt
c3JjLXFtYWtlX2FsbDogIEZPUkNFDQoJQCQoQ0hLX0RJUl9FWElTVFMpIHNyY1wgJChNS0RJ
Uikgc3JjXCANCgljZCBzcmNcICYmICQoUU1BS0UpIHNyYy5wcm8gLXdpbjMyIC1vICQoTUFL
RUZJTEUpDQpzdWItc3JjOiBzcmNcJChNQUtFRklMRSkgRk9SQ0UNCgljZCBzcmNcICYmICQo
TUFLRSkgLWYgJChNQUtFRklMRSkNCnN1Yi1zcmMtbWFrZV9kZWZhdWx0OiBzcmNcJChNQUtF
RklMRSkgRk9SQ0UNCgljZCBzcmNcICYmICQoTUFLRSkgLWYgJChNQUtFRklMRSkgDQpzdWIt
c3JjLW1ha2VfZmlyc3Q6IHNyY1wkKE1BS0VGSUxFKSBGT1JDRQ0KCWNkIHNyY1wgJiYgJChN
QUtFKSAtZiAkKE1BS0VGSUxFKSBmaXJzdA0Kc3ViLXNyYy1hbGw6IHNyY1wkKE1BS0VGSUxF
KSBGT1JDRQ0KCWNkIHNyY1wgJiYgJChNQUtFKSAtZiAkKE1BS0VGSUxFKSBhbGwNCnN1Yi1z
cmMtY2xlYW46IHNyY1wkKE1BS0VGSUxFKSBGT1JDRQ0KCWNkIHNyY1wgJiYgJChNQUtFKSAt
ZiAkKE1BS0VGSUxFKSBjbGVhbg0Kc3ViLXNyYy1kaXN0Y2xlYW46IHNyY1wkKE1BS0VGSUxF
KSBGT1JDRQ0KCWNkIHNyY1wgJiYgJChNQUtFKSAtZiAkKE1BS0VGSUxFKSBkaXN0Y2xlYW4N
CnN1Yi1zcmMtaW5zdGFsbF9zdWJ0YXJnZXRzOiBzcmNcJChNQUtFRklMRSkgRk9SQ0UNCglj
ZCBzcmNcICYmICQoTUFLRSkgLWYgJChNQUtFRklMRSkgaW5zdGFsbA0Kc3ViLXNyYy11bmlu
c3RhbGxfc3VidGFyZ2V0czogc3JjXCQoTUFLRUZJTEUpIEZPUkNFDQoJY2Qgc3JjXCAmJiAk
KE1BS0UpIC1mICQoTUFLRUZJTEUpIHVuaW5zdGFsbA0KDQpNYWtlZmlsZTogcWdpdC5wcm8g
IC4uXC4uXHF0XDQuNFxta3NwZWNzXGRlZmF1bHRccW1ha2UuY29uZiAuLlwuLlxxdFw0LjRc
bWtzcGVjc1xxY29uZmlnLnByaSBcDQoJCS4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVz
XHF0X2Z1bmN0aW9ucy5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xx
dF9jb25maWcucHJmIFwNCgkJLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcZXhjbHVz
aXZlX2J1aWxkcy5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xkZWZh
dWx0X3ByZS5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1x3aW4zMlxk
ZWZhdWx0X3ByZS5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xkZWJ1
Zy5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xkZWJ1Z19hbmRfcmVs
ZWFzZS5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xkZWZhdWx0X3Bv
c3QucHJmIFwNCgkJLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcd2luMzJccnR0aS5w
cmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1x3aW4zMlxleGNlcHRpb25z
LnByZiBcDQoJCS4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHNoYXJlZC5wcmYgXA0K
CQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1x3aW4zMlxlbWJlZF9tYW5pZmVzdF9l
eGUucHJmIFwNCgkJLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcd2luMzJcZW1iZWRf
bWFuaWZlc3RfZGxsLnByZiBcDQoJCS4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHdh
cm5fb24ucHJmIFwNCgkJLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNccXQucHJmIFwN
CgkJLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcd2luMzJcdGhyZWFkLnByZiBcDQoJ
CS4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXG1vYy5wcmYgXA0KCQkuLlwuLlxxdFw0
LjRcbWtzcGVjc1xmZWF0dXJlc1x3aW4zMlx3aW5kb3dzLnByZiBcDQoJCS4uXC4uXHF0XDQu
NFxta3NwZWNzXGZlYXR1cmVzXHdpbjMyXHN0bF9vZmYucHJmIFwNCgkJLi5cLi5ccXRcNC40
XG1rc3BlY3NcZmVhdHVyZXNccmVzb3VyY2VzLnByZiBcDQoJCS4uXC4uXHF0XDQuNFxta3Nw
ZWNzXGZlYXR1cmVzXHVpYy5wcmYgXA0KCQkuLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJl
c1x5YWNjLnByZiBcDQoJCS4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXGxleC5wcmYN
CgkkKFFNQUtFKSAtd2luMzIgLW8gTWFrZWZpbGUgcWdpdC5wcm8NCi4uXC4uXHF0XDQuNFxt
a3NwZWNzXHFjb25maWcucHJpOg0KLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNccXRf
ZnVuY3Rpb25zLnByZjoNCi4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHF0X2NvbmZp
Zy5wcmY6DQouLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xleGNsdXNpdmVfYnVpbGRz
LnByZjoNCi4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXGRlZmF1bHRfcHJlLnByZjoN
Ci4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHdpbjMyXGRlZmF1bHRfcHJlLnByZjoN
Ci4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXGRlYnVnLnByZjoNCi4uXC4uXHF0XDQu
NFxta3NwZWNzXGZlYXR1cmVzXGRlYnVnX2FuZF9yZWxlYXNlLnByZjoNCi4uXC4uXHF0XDQu
NFxta3NwZWNzXGZlYXR1cmVzXGRlZmF1bHRfcG9zdC5wcmY6DQouLlwuLlxxdFw0LjRcbWtz
cGVjc1xmZWF0dXJlc1x3aW4zMlxydHRpLnByZjoNCi4uXC4uXHF0XDQuNFxta3NwZWNzXGZl
YXR1cmVzXHdpbjMyXGV4Y2VwdGlvbnMucHJmOg0KLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVh
dHVyZXNcc2hhcmVkLnByZjoNCi4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHdpbjMy
XGVtYmVkX21hbmlmZXN0X2V4ZS5wcmY6DQouLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJl
c1x3aW4zMlxlbWJlZF9tYW5pZmVzdF9kbGwucHJmOg0KLi5cLi5ccXRcNC40XG1rc3BlY3Nc
ZmVhdHVyZXNcd2Fybl9vbi5wcmY6DQouLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1xx
dC5wcmY6DQouLlwuLlxxdFw0LjRcbWtzcGVjc1xmZWF0dXJlc1x3aW4zMlx0aHJlYWQucHJm
Og0KLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcbW9jLnByZjoNCi4uXC4uXHF0XDQu
NFxta3NwZWNzXGZlYXR1cmVzXHdpbjMyXHdpbmRvd3MucHJmOg0KLi5cLi5ccXRcNC40XG1r
c3BlY3NcZmVhdHVyZXNcd2luMzJcc3RsX29mZi5wcmY6DQouLlwuLlxxdFw0LjRcbWtzcGVj
c1xmZWF0dXJlc1xyZXNvdXJjZXMucHJmOg0KLi5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVy
ZXNcdWljLnByZjoNCi4uXC4uXHF0XDQuNFxta3NwZWNzXGZlYXR1cmVzXHlhY2MucHJmOg0K
Li5cLi5ccXRcNC40XG1rc3BlY3NcZmVhdHVyZXNcbGV4LnByZjoNCnFtYWtlOiBxbWFrZV9h
bGwgRk9SQ0UNCglAJChRTUFLRSkgLXdpbjMyIC1vIE1ha2VmaWxlIHFnaXQucHJvDQoNCnFt
YWtlX2FsbDogc3ViLXNyYy1xbWFrZV9hbGwgRk9SQ0UNCg0KbWFrZV9kZWZhdWx0OiBzdWIt
c3JjLW1ha2VfZGVmYXVsdCBGT1JDRQ0KbWFrZV9maXJzdDogc3ViLXNyYy1tYWtlX2ZpcnN0
IEZPUkNFDQphbGw6IHN1Yi1zcmMtYWxsIEZPUkNFDQpjbGVhbjogc3ViLXNyYy1jbGVhbiBG
T1JDRQ0KZGlzdGNsZWFuOiBzdWItc3JjLWRpc3RjbGVhbiBGT1JDRQ0KCS0kKERFTF9GSUxF
KSBNYWtlZmlsZQ0KaW5zdGFsbF9zdWJ0YXJnZXRzOiBzdWItc3JjLWluc3RhbGxfc3VidGFy
Z2V0cyBGT1JDRQ0KdW5pbnN0YWxsX3N1YnRhcmdldHM6IHN1Yi1zcmMtdW5pbnN0YWxsX3N1
YnRhcmdldHMgRk9SQ0UNCg0Kc3ViLXNyYy1zdWJfRGVidWc6IHNyY1xcJChNQUtFRklMRSkN
CgljZCBzcmNcICYmICQoTUFLRSkgZGVidWcNCmRlYnVnOiBzdWItc3JjLXN1Yl9EZWJ1Zw0K
DQpzdWItc3JjLXN1Yl9SZWxlYXNlOiBzcmNcXCQoTUFLRUZJTEUpDQoJY2Qgc3JjXCAmJiAk
KE1BS0UpIHJlbGVhc2UNCnJlbGVhc2U6IHN1Yi1zcmMtc3ViX1JlbGVhc2UNCg0KbW9jY2xl
YW46IGNvbXBpbGVyX21vY19oZWFkZXJfY2xlYW4gY29tcGlsZXJfbW9jX3NvdXJjZV9jbGVh
bg0KDQptb2NhYmxlczogY29tcGlsZXJfbW9jX2hlYWRlcl9tYWtlX2FsbCBjb21waWxlcl9t
b2Nfc291cmNlX21ha2VfYWxsDQppbnN0YWxsOiBpbnN0YWxsX3N1YnRhcmdldHMgIEZPUkNF
DQoNCnVuaW5zdGFsbDogIHVuaW5zdGFsbF9zdWJ0YXJnZXRzIEZPUkNFDQoNCkZPUkNFOg0K
DQo=
--------------080406060301080409080301--
