From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 25 Feb 2009 22:54:38 +0100
Message-ID: <2c6b72b30902251354k25cf97dfh66a3026385f5aa8d@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
	 <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
	 <499EE761.2010902@tedpavlic.com>
	 <2c6b72b30902201034r47850c8aq248b673ee96bdf3a@mail.gmail.com>
	 <499F143B.7080708@tedpavlic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b4223bb6420463c548a6
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRjh-0006Z5-4R
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbZBYVyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZBYVyp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:54:45 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:50484 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZBYVyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:54:44 -0500
Received: by fxm24 with SMTP id 24so210456fxm.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=3a/j3ekNovMNeKFI7UDCTvxJ8PJPWhjqXKSkR/UAzn4=;
        b=srzOFJyIZz/fEk9Lh9LWoqvc1Whp34OPxVOV2ahhTBvSVnFYpOC4x6ME5g8JbQ004L
         AXusoezDgvj3U4UGIZ9y4KZ5Dud/BMgP5QfotQHfu/IUckrjSo5tjlktabIMq9vWkXv7
         wvnKzkY2WbxZz7WFjTUWFlUaPACLOGVcpL6Js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Yjjc4VXITe4MSimYnjosyWbMDQWI1FOwvjJdyyCDMHHdrHZEhIC6+zkJ2DBxXj9FNp
         MUrv1252ueXY2zDVwC8aWUZEYAbBUbroZ0z0RrwhQC7/NtQXHSeJrM/4u++kA4vkuxS5
         sBULZohRVWJ/KoXSdQMA0FiBmlBmN/Wg94tVw=
Received: by 10.181.20.6 with SMTP id x6mr179854bki.167.1235598878422; Wed, 25 
	Feb 2009 13:54:38 -0800 (PST)
In-Reply-To: <499F143B.7080708@tedpavlic.com>
X-Google-Sender-Auth: 0e9dda01f63a6799
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111501>

--001636c5b4223bb6420463c548a6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Feb 20, 2009 at 21:36, Ted Pavlic <ted@tedpavlic.com> wrote:
> Both patches (the new and the old) seem to fix the original problem.
>
> However, I now notice that both patches introduces a new problem.

I finally found a way to reproduce and bisect this today on a linux
box with ncurses-5.5 installed. To double check can you please try
this third version?

-- 
Jonas Fonseca

--001636c5b4223bb6420463c548a6
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frmjjjns0

RnJvbSA1NDU4ODgxNDM5YjM2MmI2ZDcyOTUwMGJjN2Q2N2JkMTAwY2RkOGI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb25hcyBGb25zZWNhIDxmb25zZWNhQGRpa3UuZGs+CkRhdGU6
IFR1ZSwgMTAgRmViIDIwMDkgMjE6MzM6MTggKzAxMDAKU3ViamVjdDogW1BBVENIXSBGaXggcmVn
cmVzc2lvbiB3aGVyZSBhIGxpbmUgd2FzIG5vdCBjbGVhcmVkIHdoZW4gbm90IHNlbGVjdGVkIGFu
eW1vcmUKCkludHJvZHVjZWQgaW4gNzkyZDBlMDkzMWZiODc4NTEzNWE2YjVkMjUwYTU3MGE1OTdj
NzMyNCB3aGljaCB0cmllZCB0bwplbGltaW5hdGVkIHVubmVlZGVkIGNhbGxzIHRvIHJlZHJhd3dp
bigpLiBIb3dldmVyLCBmb3Igb2xkZXIgbmN1cnNlcwp2ZXJzaW9ucyAoNS41KSB0aGlzIGNhdXNl
ZCBwcm9ibGVtcy4gVG8gZml4IHRoaXMgZXhwbGljaXRseSBtYXJrIG5ld2x5CnNlbGVjdGVkIGxp
bmVzIHVzaW5nIHd0b3VjaGxuKCksIHNvIHRoZXkgYXJlIHByb3Blcmx5IHJlZHJhd24uCi0tLQog
dGlnLmMgfCAgIDEwICsrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RpZy5jIGIvdGlnLmMKaW5kZXggMmEzYWIz
YS4uZGYyYjRmNiAxMDA2NDQKLS0tIGEvdGlnLmMKKysrIGIvdGlnLmMKQEAgLTIwNzMsNiArMjA3
Myw3IEBAIGRyYXdfdmlld19saW5lKHN0cnVjdCB2aWV3ICp2aWV3LCB1bnNpZ25lZCBpbnQgbGlu
ZW5vKQogewogCXN0cnVjdCBsaW5lICpsaW5lOwogCWJvb2wgc2VsZWN0ZWQgPSAodmlldy0+b2Zm
c2V0ICsgbGluZW5vID09IHZpZXctPmxpbmVubyk7CisJYm9vbCBjbGVhcmVvbDsKIAogCWFzc2Vy
dCh2aWV3X2lzX2Rpc3BsYXllZCh2aWV3KSk7CiAKQEAgLTIwODAsMTAgKzIwODEsOSBAQCBkcmF3
X3ZpZXdfbGluZShzdHJ1Y3QgdmlldyAqdmlldywgdW5zaWduZWQgaW50IGxpbmVubykKIAkJcmV0
dXJuIEZBTFNFOwogCiAJbGluZSA9ICZ2aWV3LT5saW5lW3ZpZXctPm9mZnNldCArIGxpbmVub107
CisJY2xlYXJlb2wgPSBsaW5lLT5jbGVhcmVvbCB8fCAobGluZS0+c2VsZWN0ZWQgJiYgIXNlbGVj
dGVkKTsKIAogCXdtb3ZlKHZpZXctPndpbiwgbGluZW5vLCAwKTsKLQlpZiAobGluZS0+Y2xlYXJl
b2wpCi0JCXdjbHJ0b2VvbCh2aWV3LT53aW4pOwogCXZpZXctPmNvbCA9IDA7CiAJdmlldy0+Y3Vy
bGluZSA9IGxpbmU7CiAJdmlldy0+Y3VydHlwZSA9IExJTkVfTk9ORTsKQEAgLTIwOTQsNiArMjA5
NCwxMiBAQCBkcmF3X3ZpZXdfbGluZShzdHJ1Y3QgdmlldyAqdmlldywgdW5zaWduZWQgaW50IGxp
bmVubykKIAkJc2V0X3ZpZXdfYXR0cih2aWV3LCBMSU5FX0NVUlNPUik7CiAJCWxpbmUtPnNlbGVj
dGVkID0gVFJVRTsKIAkJdmlldy0+b3BzLT5zZWxlY3QodmlldywgbGluZSk7CisJCXRvdWNobGlu
ZSh2aWV3LT53aW4sIGxpbmVubywgMSk7CisJfSBlbHNlIGlmIChjbGVhcmVvbCkgeworCQkvKiBG
SVhNRTogSXQgaXMgbm90IHN0cmljdGx5IGNvcnJlY3QgdG8gb25seSBjbGVhciB0bworCQkgKiB0
aGUgbGluZSBlbmQgZm9yIG5vbi1zZWxlY3RlZCBsaW5lcy4gSG93ZXZlciwgbm8gdmlldworCQkg
KiBjdXJyZW50bHkgcmVxdWlyZXMgY2xlYXJpbmcgZm9yIHRoZSBmaXJzdCBsaW5lLiAqLworCQl3
Y2xydG9lb2wodmlldy0+d2luKTsKIAl9CiAKIAlyZXR1cm4gdmlldy0+b3BzLT5kcmF3KHZpZXcs
IGxpbmUsIGxpbmVubyk7Ci0tIAoxLjYuMi5yYzEuMjA5LmdmZTYyNC5kaXJ0eQoK
--001636c5b4223bb6420463c548a6--
