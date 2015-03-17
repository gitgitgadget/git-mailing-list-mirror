From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 16:48:22 -0400
Message-ID: <1426625302.1806008.241713717.52A37086@webmail.messagingengine.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
 <20150317195030.GA18725@peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_142662530218060082";
 charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyPd-0005kj-Al
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbbCQUsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:48:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54374 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997AbbCQUsX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 16:48:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F53B202F4
	for <git@vger.kernel.org>; Tue, 17 Mar 2015 16:48:21 -0400 (EDT)
Received: from web1 ([10.202.2.211])
  by compute5.internal (MEProxy); Tue, 17 Mar 2015 16:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=desrt.ca; h=
	message-id:x-sasl-enc:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=mesmtp; bh=hOHZofRxFHoMJX0MlrU84UIqonM=; b=oThB
	YtctUy84MWVPwS50RwGoDf/9KmK4XxPSE8kM5CyG+wAw8VVcaf3h0weoHZJE6NpX
	yOfoCNpVfADDHe/oINW+ojDwQn93zVBD5lfUAa47r80V722lNJ2YwSLkjI+mm4aW
	YaA2qo3d7MmLF4iCsY5dQaW7BtcaCT/nRRS2Zrg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to:cc
	:mime-version:content-transfer-encoding:content-type:in-reply-to
	:references:subject:date; s=smtpout; bh=hOHZofRxFHoMJX0MlrU84UIq
	onM=; b=qqSH2Zg+pNcsZba4o/JAvx2zzn26rFViXjHeMuXC7IUxk/gYQtUMPSQ4
	Gd1w4MvPeGUWnIlvuAB8QPbxSqBlb4G6X6DO4K2SBt7JoX8zW/03maKKE1W67Wpe
	omLBNCXw6GC0Ey1VevnOfxw0bcJFwsetgtZv4fYw4FHd/PvqMuw=
Received: by web1.nyi.internal (Postfix, from userid 99)
	id F325CAF3502; Tue, 17 Mar 2015 16:48:22 -0400 (EDT)
X-Sasl-Enc: V+QS4W2VGzcqipqMh0oZFl4Trn4D2nyF7jfUiIXBiL9F 1426625302
X-Mailer: MessagingEngine.com Webmail Interface - ajax-15db86eb
In-Reply-To: <20150317195030.GA18725@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265665>

This is a multi-part message in MIME format.

--_----------=_142662530218060082
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

On Tue, Mar 17, 2015, at 15:50, Jeff King wrote:
> Yeah, spelling out the security model more explicitly would be good.

Please see the attached patch.

Cheers

--_----------=_142662530218060082
Content-Disposition: attachment; filename="0001-docs-clarify-command-submodule-update-policy.patch"
Content-Id: <1426625253.1805943.d70af37051bf9d66e0142621c7187f204b835469.5D1C2AD5@content.messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0001-docs-clarify-command-submodule-update-policy.patch"

RnJvbSBhNmQ3MDA1NmYyMWYwMzlkYjg2NzZmNzJhMWRlY2EwMGMzOTEyMWJk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSeWFuIExvcnRpZSA8
ZGVzcnRAZGVzcnQuY2E+CkRhdGU6IFR1ZSwgMTcgTWFyIDIwMTUgMTY6Mjk6
NTEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBkb2NzOiBjbGFyaWZ5ICFjb21t
YW5kIHN1Ym1vZHVsZSB1cGRhdGUgcG9saWN5CgpDbGFyaWZ5IHRoYXQgdGhl
ICFjb21tYW5kIHN1Ym1vZHVsZSB1cGRhdGUgcG9saWN5IGlzIG5vdCBhdmFp
bGFibGUgZnJvbQouZ2l0bW9kdWxlcyBmaWxlcy4KClRoaXMgc2hvdWxkIGhl
bHAgY2FsbSBhbnkgZmVhcnMgcGVvcGxlIGhhdmUgYWJvdXQgdGhlIHNlY3Vy
aXR5CmltcGxpY2F0aW9ucyBvZiB0aGlzIG90aGVyd2lzZSBzY2FyeS1sb29r
aW5nIGZlYXR1cmUuCgpTaWduZWQtb2ZmLWJ5OiBSeWFuIExvcnRpZSA8ZGVz
cnRAZGVzcnQuY2E+Ci0tLQogRG9jdW1lbnRhdGlvbi9naXQtc3VibW9kdWxl
LnR4dCB8IDEwICsrKysrKystLS0KIERvY3VtZW50YXRpb24vZ2l0bW9kdWxl
cy50eHQgICAgfCAxMSArKysrKysrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZ2l0LXN1Ym1vZHVsZS50eHQgYi9Eb2N1bWVudGF0
aW9uL2dpdC1zdWJtb2R1bGUudHh0CmluZGV4IDhlNmFmNjUuLmEwMzNlMjYg
MTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LXN1Ym1vZHVsZS50eHQK
KysrIGIvRG9jdW1lbnRhdGlvbi9naXQtc3VibW9kdWxlLnR4dApAQCAtMTU5
LDkgKzE1OSwxMyBAQCB1cGRhdGU6OgogCVRoaXMgd2lsbCBtYWtlIHRoZSBz
dWJtb2R1bGVzIEhFQUQgYmUgZGV0YWNoZWQgdW5sZXNzIGAtLXJlYmFzZWAg
b3IKIAlgLS1tZXJnZWAgaXMgc3BlY2lmaWVkIG9yIHRoZSBrZXkgYHN1Ym1v
ZHVsZS4kbmFtZS51cGRhdGVgIGlzIHNldCB0bwogCWByZWJhc2VgLCBgbWVy
Z2VgIG9yIGBub25lYC4gYG5vbmVgIGNhbiBiZSBvdmVycmlkZGVuIGJ5IHNw
ZWNpZnlpbmcKLQlgLS1jaGVja291dGAuIFNldHRpbmcgdGhlIGtleSBgc3Vi
bW9kdWxlLiRuYW1lLnVwZGF0ZWAgdG8gYCFjb21tYW5kYAotCXdpbGwgY2F1
c2UgYGNvbW1hbmRgIHRvIGJlIHJ1bi4gYGNvbW1hbmRgIGNhbiBiZSBhbnkg
YXJiaXRyYXJ5IHNoZWxsCi0JY29tbWFuZCB0aGF0IHRha2VzIGEgc2luZ2xl
IGFyZ3VtZW50LCBuYW1lbHkgdGhlIHNoYTEgdG8gdXBkYXRlIHRvLgorCWAt
LWNoZWNrb3V0YC4KKysKK1NldHRpbmcgdGhlIGtleSBgc3VibW9kdWxlLiRu
YW1lLnVwZGF0ZWAgaW4gYC5naXQvY29uZmlnYCB0bworYCFjb21tYW5kYCB3
aWxsIGNhdXNlIGBjb21tYW5kYCB0byBiZSBydW4uIGBjb21tYW5kYCBjYW4g
YmUgYW55CithcmJpdHJhcnkgc2hlbGwgY29tbWFuZCB0aGF0IHRha2VzIGEg
c2luZ2xlIGFyZ3VtZW50LCBuYW1lbHkgdGhlIHNoYTEKK3RvIHVwZGF0ZSB0
by4gIEZvciBzZWN1cml0eSByZWFzb25zLCB0aGlzIGZlYXR1cmUgaXMgbm90
IHN1cHBvcnRlZAorZnJvbSB0aGUgYC5naXRtb2R1bGVzYCBmaWxlLgogKwog
SWYgdGhlIHN1Ym1vZHVsZSBpcyBub3QgeWV0IGluaXRpYWxpemVkLCBhbmQg
eW91IGp1c3Qgd2FudCB0byB1c2UgdGhlCiBzZXR0aW5nIGFzIHN0b3JlZCBp
biAuZ2l0bW9kdWxlcywgeW91IGNhbiBhdXRvbWF0aWNhbGx5IGluaXRpYWxp
emUgdGhlCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdG1vZHVsZXMu
dHh0IGIvRG9jdW1lbnRhdGlvbi9naXRtb2R1bGVzLnR4dAppbmRleCBmNmMw
ZGZkLi5mMTFlODcyIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dpdG1v
ZHVsZXMudHh0CisrKyBiL0RvY3VtZW50YXRpb24vZ2l0bW9kdWxlcy50eHQK
QEAgLTQ3LDkgKzQ3LDE0IEBAIHN1Ym1vZHVsZS48bmFtZT4udXBkYXRlOjoK
IAlpbiB0aGUgc3VibW9kdWxlLgogCUlmICdub25lJywgdGhlIHN1Ym1vZHVs
ZSB3aXRoIG5hbWUgYCRuYW1lYCB3aWxsIG5vdCBiZSB1cGRhdGVkCiAJYnkg
ZGVmYXVsdC4KLQotCVRoaXMgY29uZmlnIG9wdGlvbiBpcyBvdmVycmlkZGVu
IGlmICdnaXQgc3VibW9kdWxlIHVwZGF0ZScgaXMgZ2l2ZW4KLQl0aGUgJy0t
bWVyZ2UnLCAnLS1yZWJhc2UnIG9yICctLWNoZWNrb3V0JyBvcHRpb25zLgor
KworVGhpcyBjb25maWcgb3B0aW9uIGlzIG92ZXJyaWRkZW4gaWYgJ2dpdCBz
dWJtb2R1bGUgdXBkYXRlJyBpcyBnaXZlbgordGhlICctLW1lcmdlJywgJy0t
cmViYXNlJyBvciAnLS1jaGVja291dCcgb3B0aW9ucy4KKysKK09ubHkgdGhl
IHZhbHVlcyAnY2hlY2tvdXQnLCAncmViYXNlJywgJ21lcmdlJyBhbmQgJ25v
bmUnIGFyZQorcmVjb2duaXplZCB3aGVuIHRoaXMga2V5IGFwcGVhcnMgaW4g
dGhlIGAuZ2l0bW9kdWxlc2AgZmlsZS4gIEluCitwYXJ0aWN1bGFyLCAnIWNv
bW1hbmQnIGlzIG5vdCByZWNvZ25pc2VkLCBhbmQgd2lsbCBiZSByZXdyaXR0
ZW4gdG8KKydub25lJyBieSAiZ2l0IHN1Ym1vZHVsZSBpbml0Ii4KIAogc3Vi
bW9kdWxlLjxuYW1lPi5icmFuY2g6OgogCUEgcmVtb3RlIGJyYW5jaCBuYW1l
IGZvciB0cmFja2luZyB1cGRhdGVzIGluIHRoZSB1cHN0cmVhbSBzdWJtb2R1
bGUuCi0tIAoyLjEuNAoK

--_----------=_142662530218060082--
