From: Dan Weber <dan@mirrorlynx.com>
Subject: Git cancel work
Date: Sun, 24 Apr 2005 00:34:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504240033230.1980@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-297472272-1982687346-1114317284=:1980"
X-From: git-owner@vger.kernel.org Sun Apr 24 06:28:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYjb-0006Bo-71
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVDXEdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVDXEdc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:33:32 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:27660 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S262216AbVDXEdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 00:33:25 -0400
Received: from pool-68-238-240-238.phlapa.fios.verizon.net ([68.238.240.238] helo=mirrorlynx.com)
	by outbound.mailhop.org with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.44)
	id 1DPYo8-0002bR-Sn
	for git@vger.kernel.org; Sun, 24 Apr 2005 00:33:24 -0400
Received: from dan (helo=localhost)
	by mirrorlynx.com with local-esmtp (Exim 4.34)
	id 1DPYpQ-0000X0-EN
	for git@vger.kernel.org; Sun, 24 Apr 2005 00:34:44 -0400
To: Git Mailing List <git@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: dan@mirrorlynx.com
X-Spam-Checker-Version: SpamAssassin 3.0.0 (2004-09-13) on mirrorlynx.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=unavailable version=3.0.0
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mirrorlynx.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 68.238.240.238
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: DanWeber1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---297472272-1982687346-1114317284=:1980
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


I noticed that git cancel was always doing a full checkout.  So I figured, 
"what about just checking out the modified files?".  Attached is a patch 
to do so.

Dan
---297472272-1982687346-1114317284=:1980
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-fastcancel
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0504240034440.1980@mirrorlynx.com>
Content-Description: Fast Cancel
Content-Disposition: attachment; filename=patch-fastcancel

TGV0cyBub3QgZG8gYSBmdWxsIGNoZWNrb3V0IG9uIGdpdCBjYW5jZWwNCg0K
LS0tDQpjb21taXQgNDcxOTdkOWFjY2I0MjBlYzU1ZjZkZmQ2M2Q5OTBkNGZi
MjUzNzMzMA0KdHJlZSBlOGYzNjk5ODc3ZGQyMjA0NDA4MDgwODc2MzJlZjg3
Y2NlMjI4OGE3DQpwYXJlbnQgYzgzYjk1Mjk3YzJhNjMzNmMyMDA3NTQ4Zjkw
OTc2OWUwODYyYjUwOQ0KYXV0aG9yIERhbiBXZWJlciA8ZGFuQG1pcnJvcmx5
bnguY29tPiAxMTE0MzE2NTA0IC0wNDAwDQpjb21taXR0ZXIgRGFuIFdlYmVy
IDxkYW5AbWlycm9ybHlueC5jb20+IDExMTQzMTY1MDQgLTA0MDANCg0KSW5k
ZXg6IGdpdGNhbmNlbC5zaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IDJhYWY5NGVhZTIwYWNjNDUxNTUzNzY2ZjNjMDYzYmM0NmNmYTc1YzYvZ2l0
Y2FuY2VsLnNoICAobW9kZToxMDA3NTUgc2hhMToyNmVlY2I1MGJjODEyMjEx
NDU0ZTk4ZDk4ZTg4MTgzODdhZTk3ZGY1KQ0KKysrIGU4ZjM2OTk4NzdkZDIy
MDQ0MDgwODA4NzYzMmVmODdjY2UyMjg4YTcvZ2l0Y2FuY2VsLnNoICAobW9k
ZToxMDA3NTUgc2hhMTpjODM2Yjc1YmI4YTdjNDYxYjJkMGFkNTM2ZDFjM2Jj
MmQyNDQwYWI0KQ0KQEAgLTIsNiArMiw3IEBADQogIw0KICMgQ2FuY2VscyBj
dXJyZW50IGVkaXRzIGluIHRoZSB3b3JraW5nIHRyZWUuDQogIyBDb3B5cmln
aHQgKGMpIFBldHIgQmF1ZGlzLCAyMDA1DQorIyBDb3B5cmlnaHQgKGMpIERh
biBXZWJlciwgMjAwNQ0KICMNCiAjIFRoaXMgc2NyaXB0IHJldmVydHMgdGhl
IHdvcmtpbmcgdHJlZSB0byBhIGNvbnNpc3RlbnQgc3RhdGUgYmVmb3JlDQog
IyBhbnkgY2hhbmdlcyB0byBpdCAoaW5jbHVkaW5nIG1lcmdlcyBldGMpIHdl
cmUgZG9uZS4NCkBAIC0yNiw1ICsyNywyMyBAQA0KIHJtIC1mIC5naXQvYmxv
Y2tlZCAuZ2l0L21lcmdpbmcgLmdpdC9tZXJnaW5nLXN5bSAuZ2l0L21lcmdl
LWJhc2UNCiByZWFkLXRyZWUgLW0gJCh0cmVlLWlkKSB8fCByZWFkLXRyZWUg
JCh0cmVlLWlkKQ0KIA0KLWNoZWNrb3V0LWNhY2hlIC1mIC1hDQotdXBkYXRl
LWNhY2hlIC0tcmVmcmVzaA0KK2dlbmVyYWwoKSB7DQorCWZvciBuYW1lIGlu
ICQoZGlmZi1jYWNoZSAtciAkKHRyZWUtaWQpfGF3ayAne3ByaW50ICQ0fScp
DQorCWRvDQorCQljaGVja291dC1jYWNoZSAtZiAkbmFtZQ0KKwlkb25lDQor
CXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCit9DQorDQorZnVsbCAoKSB7DQor
CWNoZWNrb3V0LWNhY2hlIC1mIC1hDQorCXVwZGF0ZS1jYWNoZSAtLXJlZnJl
c2gNCit9DQorDQorDQoraWYgWyAiJDEiID09ICItYSIgLW8gIiQxIiA9PSAi
LS1mdWxsIiAtbyAiJDEiID09ICItLWFsbCIgXTsgdGhlbg0KKwlmdWxsDQor
ZWxzZQ0KKwlnZW5lcmFsDQorZmkNCisNCg==

---297472272-1982687346-1114317284=:1980--
