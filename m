From: Dan Weber <dan@mirrorlynx.com>
Subject: void return diff-cache.c
Date: Wed, 27 Apr 2005 21:22:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504272121230.9460@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-297489934-230926953-1114651369=:9460"
X-From: git-owner@vger.kernel.org Thu Apr 28 03:15:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxcv-0004BS-WC
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVD1BVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVD1BVA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:21:00 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:21769 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S261178AbVD1BUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 21:20:52 -0400
Received: from pool-68-238-242-169.phlapa.fios.verizon.net ([68.238.242.169] helo=mirrorlynx.com)
	by outbound.mailhop.org with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.44)
	id 1DQxi0-0003w7-2K
	for git@vger.kernel.org; Wed, 27 Apr 2005 21:20:52 -0400
Received: from dan (helo=localhost)
	by mirrorlynx.com with local-esmtp (Exim 4.34)
	id 1DQxjt-0002UU-BM
	for git@vger.kernel.org; Wed, 27 Apr 2005 21:22:49 -0400
To: Git Mailing List <git@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: dan@mirrorlynx.com
X-Spam-Checker-Version: SpamAssassin 3.0.0 (2004-09-13) on mirrorlynx.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED 
	autolearn=unavailable version=3.0.0
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mirrorlynx.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 68.238.242.169
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: DanWeber1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---297489934-230926953-1114651369=:9460
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

While compiling cogito, I got a compiler warning about returning -1 in a 
void function.  Attached is the patch.

Dan
---297489934-230926953-1114651369=:9460
Content-Type: TEXT/plain; charset=US-ASCII; name=void-return.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0504272122490.9460@mirrorlynx.com>
Content-Description: 
Content-Disposition: attachment; filename=void-return.diff

Q2FuIG5vdCByZXR1cm4gLTEgaW4gYSB2b2lkIGZ1bmN0aW9uLCBidXQgd2Ug
Y2FuIHJldHVybiB0aGVyZQ0KDQotLS0NCmNvbW1pdCBiMzRmNjRhZGMxOGFl
MDRmZTI5OTI1Nzg3MWExMDIzMDc2ODNkMzZiDQp0cmVlIDI5ZjdiN2QxNDZi
Njg5ZjdhNzI0ZTk0ZjhkYWRkY2VhYjIxOTk0MmQNCnBhcmVudCAxZTAyZWQx
NGRjMDQ2ZGM0N2FhZmU5M2VmMzY1ODdjOTk2NzBhNDk4DQphdXRob3IgRGFu
IFdlYmVyIDxkYW5AbWlycm9ybHlueC5jb20+IDExMTQ2NTExMDUgLTA0MDAN
CmNvbW1pdHRlciBEYW4gV2ViZXIgPGRhbkBtaXJyb3JseW54LmNvbT4gMTEx
NDY1MTEwNSAtMDQwMA0KDQpJbmRleDogZGlmZi1jYWNoZS5jDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQotLS0gMzE0NDIzNWJjM2I2NDk2MWUxMzNiYzhl
M2E2YjljNzU2OTIzOTA3YS9kaWZmLWNhY2hlLmMgIChtb2RlOjEwMDY0NCBz
aGExOjMwODA0ZDI3NzVkNGE2NWE3ODkyYWUyYmYwYjM1NzE1ODEyZTkzOWIp
DQorKysgMjlmN2I3ZDE0NmI2ODlmN2E3MjRlOTRmOGRhZGRjZWFiMjE5OTQy
ZC9kaWZmLWNhY2hlLmMgIChtb2RlOjEwMDY0NCBzaGExOmUzNjVmNzEzZmEy
ODUyNmY4YTg4M2YwM2EwMTczNzU1OTg3ZWFkZWEpDQpAQCAtNDUsNyArNDUs
NyBAQA0KIA0KIAkvKiBOZXcgZmlsZSBpbiB0aGUgaW5kZXg6IGl0IG1pZ2h0
IGFjdHVhbGx5IGJlIGRpZmZlcmVudCBpbiB0aGUgd29ya2luZyBjb3B5ICov
DQogCWlmIChnZXRfc3RhdF9kYXRhKG5ldywgJnNoYTEsICZtb2RlKSA8IDAp
DQotCQlyZXR1cm4gLTE7DQorCQlyZXR1cm47DQogDQogCXNob3dfZmlsZSgi
KyIsIG5ldywgc2hhMSwgbW9kZSk7DQogfQ0K

---297489934-230926953-1114651369=:9460--
