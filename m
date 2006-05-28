From: Paul Jakma <paul@clubi.ie>
Subject: [gitweb/patch] commit log bodies should be pre-format tagged
Date: Sun, 28 May 2006 11:28:39 +0100 (IST)
Message-ID: <Pine.LNX.4.64.0605281118060.22571@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="299119927-1061507229-1148812119=:22571"
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 28 12:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkIW3-00015g-4S
	for gcvg-git@gmane.org; Sun, 28 May 2006 12:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWE1K24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 06:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWE1K24
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 06:28:56 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:46220 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1750707AbWE1K2z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 06:28:55 -0400
Received: from sheen.jakma.org (IDENT:U2FsdGVkX19nbLuylK9k4WYchCBM6v2PF6Gfq1JlyMU@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.6/8.13.1) with ESMTP id k4SASdIb004509;
	Sun, 28 May 2006 11:28:52 +0100
X-X-Sender: paul@sheen.jakma.org
To: kay.sievers@vrfy.org
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20878>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--299119927-1061507229-1148812119=:22571
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Kay,

I don't know about you, but when I write commit messages, I don't 
HTML format them. ;)

Attached patch wraps commit log messages in HTML pre tags. Without 
this patch, any commits with any kind of ASCII-formatted structure 
look strange at best (e.g. traditional GNUish ChangeLog style which 
use indentation), and unintelligble at worst (ASCII art or 
diagrammes).

The log, commit and commitdiff pages all still validate, and the RSS 
feed looks /much/ better in Liferea. Probably it could be done in 
some smarter way with divs and CSS though, but hey.

Please apply. :)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Fiber optics caused gas main leak
--299119927-1061507229-1148812119=:22571
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=gitweb.log-pre.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0605281128390.22571@sheen.jakma.org>
Content-Description: 
Content-Disposition: attachment; filename=gitweb.log-pre.diff

LS0tIGdpdHdlYi5jZ2kub3JpZwkyMDA2LTA1LTI4IDEwOjMwOjM4LjAwMDAw
MDAwMCArMDEwMA0KKysrIGdpdHdlYi5jZ2kJMjAwNi0wNS0yOCAxMToxMjo1
Mi4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMjE4LDEyICsxMjE4LDEyIEBADQog
CX0NCiAJcHJpbnQgIjwvdGFibGU+XG5cbiIgLg0KIAkgICAgICAiPC9kaXY+
XG4iOw0KLQlwcmludCAiPGRpdiBjbGFzcz1cInBhZ2VfYm9keVwiPiI7DQor
CXByaW50ICI8ZGl2IGNsYXNzPVwicGFnZV9ib2R5XCI+PHByZT4iOw0KIAlt
eSAkY29tbWVudCA9ICR0YWd7J2NvbW1lbnQnfTsNCiAJZm9yZWFjaCBteSAk
bGluZSAoQCRjb21tZW50KSB7DQotCQlwcmludCBlc2NfaHRtbCgkbGluZSkg
LiAiPGJyLz5cbiI7DQorCQlwcmludCBlc2NfaHRtbCgkbGluZSkgLiAiXG4i
Ow0KIAl9DQotCXByaW50ICI8L2Rpdj5cbiI7DQorCXByaW50ICI8L3ByZT48
L2Rpdj5cbiI7DQogCWdpdF9mb290ZXJfaHRtbCgpOw0KIH0NCiANCkBAIC0x
NTQ3LDIyICsxNTQ3LDIyIEBADQogCQkgICAgICAiPGxpbms+IiAuIGVzY19o
dG1sKCIkbXlfdXJsP3A9JHByb2plY3Q7YT1jb21taXQ7aD0kY29tbWl0Iikg
LiAiPC9saW5rPlxuIiAuDQogCQkgICAgICAiPGRlc2NyaXB0aW9uPiIgLiBl
c2NfaHRtbCgkY297J3RpdGxlJ30pIC4gIjwvZGVzY3JpcHRpb24+XG4iIC4N
CiAJCSAgICAgICI8Y29udGVudDplbmNvZGVkPiIgLg0KLQkJICAgICAgIjwh
W0NEQVRBW1xuIjsNCisJCSAgICAgICI8IVtDREFUQVs8cHJlPlxuIjsNCiAJ
CW15ICRjb21tZW50ID0gJGNveydjb21tZW50J307DQogCQlmb3JlYWNoIG15
ICRsaW5lIChAJGNvbW1lbnQpIHsNCiAJCQkkbGluZSA9IGRlY29kZSgidXRm
OCIsICRsaW5lLCBFbmNvZGU6OkZCX0RFRkFVTFQpOw0KLQkJCXByaW50ICIk
bGluZTxici8+XG4iOw0KKwkJCXByaW50ICIkbGluZVxuIjsNCiAJCX0NCi0J
CXByaW50ICI8YnIvPlxuIjsNCisJCXByaW50ICJcbiI7DQogCQlmb3JlYWNo
IG15ICRsaW5lIChAZGlmZnRyZWUpIHsNCiAJCQlpZiAoISgkbGluZSA9fiBt
L146KFswLTddezZ9KSAoWzAtN117Nn0pIChbMC05YS1mQS1GXXs0MH0pIChb
MC05YS1mQS1GXXs0MH0pICguKShbMC05XXswLDN9KVx0KC4qKSQvKSkgew0K
IAkJCQluZXh0Ow0KIAkJCX0NCiAJCQlteSAkZmlsZSA9IHZhbGlkYXRlX2lu
cHV0KHVucXVvdGUoJDcpKTsNCiAJCQkkZmlsZSA9IGRlY29kZSgidXRmOCIs
ICRmaWxlLCBFbmNvZGU6OkZCX0RFRkFVTFQpOw0KLQkJCXByaW50ICIkZmls
ZTxici8+XG4iOw0KKwkJCXByaW50ICIkZmlsZVxuIjsNCiAJCX0NCi0JCXBy
aW50ICJdXT5cbiIgLg0KKwkJcHJpbnQgIjwvcHJlPl1dPlxuIiAuDQogCQkg
ICAgICAiPC9jb250ZW50OmVuY29kZWQ+XG4iIC4NCiAJCSAgICAgICI8L2l0
ZW0+XG4iOw0KIAl9DQpAQCAtMTY3Myw3ICsxNjczLDcgQEANCiAJCSAgICAg
ICI8L2Rpdj5cbiIgLg0KIAkJICAgICAgIjxpPiIgLiBlc2NfaHRtbCgkY297
J2F1dGhvcl9uYW1lJ30pIC4gICIgWyRhZHsncmZjMjgyMid9XTwvaT48YnIv
PlxuIiAuDQogCQkgICAgICAiPC9kaXY+XG4iIC4NCi0JCSAgICAgICI8ZGl2
IGNsYXNzPVwibG9nX2JvZHlcIj5cbiI7DQorCQkgICAgICAiPGRpdiBjbGFz
cz1cImxvZ19ib2R5XCI+PHByZT5cbiI7DQogCQlteSAkY29tbWVudCA9ICRj
b3snY29tbWVudCd9Ow0KIAkJbXkgJGVtcHR5ID0gMDsNCiAJCWZvcmVhY2gg
bXkgJGxpbmUgKEAkY29tbWVudCkgew0KQEAgLTE2ODgsMTIgKzE2ODgsMTIg
QEANCiAJCQl9IGVsc2Ugew0KIAkJCQkkZW1wdHkgPSAwOw0KIAkJCX0NCi0J
CQlwcmludCBmb3JtYXRfbG9nX2xpbmVfaHRtbCgkbGluZSkgLiAiPGJyLz5c
biI7DQorCQkJcHJpbnQgZm9ybWF0X2xvZ19saW5lX2h0bWwoJGxpbmUpIC4g
IlxuIjsNCiAJCX0NCiAJCWlmICghJGVtcHR5KSB7DQotCQkJcHJpbnQgIjxi
ci8+XG4iOw0KKwkJCXByaW50ICJcbiI7DQogCQl9DQotCQlwcmludCAiPC9k
aXY+XG4iOw0KKwkJcHJpbnQgIjwvcHJlPjwvZGl2PlxuIjsNCiAJfQ0KIAln
aXRfZm9vdGVyX2h0bWwoKTsNCiB9DQpAQCAtMTc4Myw3ICsxNzgzLDcgQEAN
CiAJfQ0KIAlwcmludCAiPC90YWJsZT4iLiANCiAJICAgICAgIjwvZGl2Plxu
IjsNCi0JcHJpbnQgIjxkaXYgY2xhc3M9XCJwYWdlX2JvZHlcIj5cbiI7DQor
CXByaW50ICI8ZGl2IGNsYXNzPVwicGFnZV9ib2R5XCI+PHByZT5cbiI7DQog
CW15ICRjb21tZW50ID0gJGNveydjb21tZW50J307DQogCW15ICRlbXB0eSA9
IDA7DQogCW15ICRzaWduZWQgPSAwOw0KQEAgLTE3OTksMTMgKzE3OTksMTMg
QEANCiAJCX0NCiAJCWlmICgkbGluZSA9fiBtL14gKihzaWduZWRbIFwtXW9m
ZlsgXC1dYnlbIDpdfGFja2VkWyBcLV1ieVsgOl18Y2NbIDpdKS9pKSB7DQog
CQkJJHNpZ25lZCA9IDE7DQotCQkJcHJpbnQgIjxzcGFuIHN0eWxlPVwiY29s
b3I6ICM4ODg4ODhcIj4iIC4gZXNjX2h0bWwoJGxpbmUpIC4gIjwvc3Bhbj48
YnIvPlxuIjsNCisJCQlwcmludCAiPC9wcmU+PHNwYW4gc3R5bGU9XCJjb2xv
cjogIzg4ODg4OFwiPiIgLiBlc2NfaHRtbCgkbGluZSkgLiAiPC9zcGFuPjxi
ci8+PHByZT5cbiI7DQogCQl9IGVsc2Ugew0KIAkJCSRzaWduZWQgPSAwOw0K
LQkJCXByaW50IGZvcm1hdF9sb2dfbGluZV9odG1sKCRsaW5lKSAuICI8YnIv
PlxuIjsNCisJCQlwcmludCBmb3JtYXRfbG9nX2xpbmVfaHRtbCgkbGluZSkg
LiAiXG4iOw0KIAkJfQ0KIAl9DQotCXByaW50ICI8L2Rpdj5cbiI7DQorCXBy
aW50ICI8L3ByZT48L2Rpdj5cbiI7DQogCXByaW50ICI8ZGl2IGNsYXNzPVwi
bGlzdF9oZWFkXCI+XG4iOw0KIAlpZiAoJCNkaWZmdHJlZSA+IDEwKSB7DQog
CQlwcmludCgoJCNkaWZmdHJlZSArIDEpIC4gIiBmaWxlcyBjaGFuZ2VkOlxu
Iik7DQpAQCAtMTk4Miw3ICsxOTgyLDcgQEANCiAJcHJpbnQgIjxkaXY+XG4i
IC4NCiAJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVz
Y19wYXJhbSgicD0kcHJvamVjdDthPWNvbW1pdDtoPSRoYXNoIiksIC1jbGFz
cyA9PiAidGl0bGUifSwgZXNjX2h0bWwoJGNveyd0aXRsZSd9KSAuICRyZWYp
IC4gIlxuIiAuDQogCSAgICAgICI8L2Rpdj5cbiI7DQotCXByaW50ICI8ZGl2
IGNsYXNzPVwicGFnZV9ib2R5XCI+XG4iOw0KKwlwcmludCAiPGRpdiBjbGFz
cz1cInBhZ2VfYm9keVwiPjxwcmU+XG4iOw0KIAlteSAkY29tbWVudCA9ICRj
b3snY29tbWVudCd9Ow0KIAlteSAkZW1wdHkgPSAwOw0KIAlteSAkc2lnbmVk
ID0gMDsNCkBAIC0yMDA0LDkgKzIwMDQsOSBAQA0KIAkJfSBlbHNlIHsNCiAJ
CQkkZW1wdHkgPSAwOw0KIAkJfQ0KLQkJcHJpbnQgZm9ybWF0X2xvZ19saW5l
X2h0bWwoJGxpbmUpIC4gIjxici8+XG4iOw0KKwkJcHJpbnQgZm9ybWF0X2xv
Z19saW5lX2h0bWwoJGxpbmUpIC4gIlxuIjsNCiAJfQ0KLQlwcmludCAiPGJy
Lz5cbiI7DQorCXByaW50ICI8L3ByZT48YnIvPlxuIjsNCiAJZm9yZWFjaCBt
eSAkbGluZSAoQGRpZmZ0cmVlKSB7DQogCQkjICc6MTAwNjQ0IDEwMDY0NCAw
M2IyMTgyNjBlOTliNzhjNmRmMGVkMzc4ZTU5ZWQ5MjA1Y2NjOTZkIDNiOTNk
NWU3Y2M3ZjdkZDRlYmVkMTNhNWNjMWE0YWQ5NzZmYzk0ZDggTSAgICAgIGxz
LWZpbGVzLmMnDQogCQkjICc6MTAwNjQ0IDEwMDY0NCA3ZjkyODE5ODUwODY5
NzFkMzg3N2FjYTI3NzA0ZjJhYWY5YzQ0OGNlIGJjMTkwZWJjNzFiYmQ5MjNm
MmI3MjhlNTA1NDA4ZjVlNTRiZDA3M2EgTSAgICAgIHJldi10cmVlLmMnDQo=

--299119927-1061507229-1148812119=:22571--
