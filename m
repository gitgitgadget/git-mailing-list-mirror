From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 20 Feb 2009 19:34:39 +0100
Message-ID: <2c6b72b30902201034r47850c8aq248b673ee96bdf3a@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
	 <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
	 <499EE761.2010902@tedpavlic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5c2dad6f29204635de72a
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 19:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaaEK-00076O-PK
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 19:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZBTSeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 13:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbZBTSen
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 13:34:43 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:62477 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbZBTSem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 13:34:42 -0500
X-Greylist: delayed 14305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2009 13:34:42 EST
Received: by fxm11 with SMTP id 11so400325fxm.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=LoXCR/FzLb6teHPPOuk51hPCeX30GRG9QuBhqAXUsAw=;
        b=aSa5ZL73AlQDL3adjOdx+OyajUzuE9Nd4XHK69YxVWUw6eLQStDym50Nbio6Ope7wg
         b00NWMg4Nie3Sm0JzkSY5DmtfnrobkdJhBB5eQB63zYmjKljME9AFrWlqIkhpysFrYCk
         E5GDe1zKoM6W6cObFU0m0PLYw6lGYFes2p+40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=NhUIT5iHev3wBiLw/mKTTJRD/4mLALw+zu8BtgnfSeigDhUR+H6kNP81cm21XkMpg5
         NBItZhx8HQ9CSa4rUvZyJBgX24zhy9Riqe918/reov5ba+T2xv1LgVAmbfL2NP2Ldzk/
         3KVeijsjknjiLjEP2d0rQ24wW87Lz5wTkEhGA=
Received: by 10.180.214.13 with SMTP id m13mr364109bkg.157.1235154879574; Fri, 
	20 Feb 2009 10:34:39 -0800 (PST)
In-Reply-To: <499EE761.2010902@tedpavlic.com>
X-Google-Sender-Auth: 54b00e7be3dcc4ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110876>

--001636c5c2dad6f29204635de72a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Feb 20, 2009 at 18:24, Ted Pavlic <ted@tedpavlic.com> wrote:
>> Looks like there might be a pattern and I might have an excuse to go
>> knock on the door of one of my "Mac" friends. ;) However, first I
>> would kindly ask if one of you have time to test the attached patch.
>
> Any verdict on this patch (it WFM)? I notice tig is still unpatched to fix
> this problem.

I didn't look more into it. Maybe you can try the attached patch for me.

-- 
Jonas Fonseca

--001636c5c2dad6f29204635de72a
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frf7b3k40

RnJvbSAyNzBlODk0YjU5Y2FjMWJhYTNlZTJjYjRjMTJmMzIwZWZiM2ZlYTMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb25hcyBGb25zZWNhIDxmb25zZWNhQGRpa3UuZGs+CkRhdGU6
IFR1ZSwgMTAgRmViIDIwMDkgMjE6MzM6MTggKzAxMDAKU3ViamVjdDogW1BBVENIXSBGaXggcmVn
cmVzc2lvbiB3aGVyZSBhIGxpbmUgd2FzIG5vdCBjbGVhcmVkIHdoZW4gbm90IHNlbGVjdGVkIGFu
eW1vcmUKCkludHJvZHVjZWQgaW4gMjczYzI4ZGYyYWE1Y2MwZDEyMmIxYTBmM2MwMDE0YTU2YWI4
YzM5MiAoVHJlZSB2aWV3OiBtYWtlCmRyYXdpbmcgbW9yZSBzbW9vdGggYnkgdXNpbmcgdGhlIGRp
cnR5IGZsYWcpLgotLS0KIHRpZy5jIHwgICAgOSArKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RpZy5jIGIvdGln
LmMKaW5kZXggMmEzYWIzYS4uZmJiZDFjYyAxMDA2NDQKLS0tIGEvdGlnLmMKKysrIGIvdGlnLmMK
QEAgLTIwNzMsNiArMjA3Myw3IEBAIGRyYXdfdmlld19saW5lKHN0cnVjdCB2aWV3ICp2aWV3LCB1
bnNpZ25lZCBpbnQgbGluZW5vKQogewogCXN0cnVjdCBsaW5lICpsaW5lOwogCWJvb2wgc2VsZWN0
ZWQgPSAodmlldy0+b2Zmc2V0ICsgbGluZW5vID09IHZpZXctPmxpbmVubyk7CisJYm9vbCBjbGVh
cmVvbDsKIAogCWFzc2VydCh2aWV3X2lzX2Rpc3BsYXllZCh2aWV3KSk7CiAKQEAgLTIwODAsMTAg
KzIwODEsOSBAQCBkcmF3X3ZpZXdfbGluZShzdHJ1Y3QgdmlldyAqdmlldywgdW5zaWduZWQgaW50
IGxpbmVubykKIAkJcmV0dXJuIEZBTFNFOwogCiAJbGluZSA9ICZ2aWV3LT5saW5lW3ZpZXctPm9m
ZnNldCArIGxpbmVub107CisJY2xlYXJlb2wgPSBsaW5lLT5jbGVhcmVvbCB8fCAobGluZS0+c2Vs
ZWN0ZWQgJiYgIXNlbGVjdGVkKTsKIAogCXdtb3ZlKHZpZXctPndpbiwgbGluZW5vLCAwKTsKLQlp
ZiAobGluZS0+Y2xlYXJlb2wpCi0JCXdjbHJ0b2VvbCh2aWV3LT53aW4pOwogCXZpZXctPmNvbCA9
IDA7CiAJdmlldy0+Y3VybGluZSA9IGxpbmU7CiAJdmlldy0+Y3VydHlwZSA9IExJTkVfTk9ORTsK
QEAgLTIwOTQsNiArMjA5NCwxMSBAQCBkcmF3X3ZpZXdfbGluZShzdHJ1Y3QgdmlldyAqdmlldywg
dW5zaWduZWQgaW50IGxpbmVubykKIAkJc2V0X3ZpZXdfYXR0cih2aWV3LCBMSU5FX0NVUlNPUik7
CiAJCWxpbmUtPnNlbGVjdGVkID0gVFJVRTsKIAkJdmlldy0+b3BzLT5zZWxlY3QodmlldywgbGlu
ZSk7CisJfSBlbHNlIGlmIChjbGVhcmVvbCkgeworCQkvKiBGSVhNRTogSXQgaXMgbm90IHN0cmlj
dGx5IGNvcnJlY3QgdG8gb25seSBjbGVhciB0bworCQkgKiB0aGUgbGluZSBlbmQgZm9yIG5vbi1z
ZWxlY3RlZCBsaW5lcy4gSG93ZXZlciwgbm8gdmlldworCQkgKiBjdXJyZW50bHkgcmVxdWlyZXMg
Y2xlYXJpbmcgZm9yIHRoZSBmaXJzdCBsaW5lLiAqLworCQl3Y2xydG9lb2wodmlldy0+d2luKTsK
IAl9CiAKIAlyZXR1cm4gdmlldy0+b3BzLT5kcmF3KHZpZXcsIGxpbmUsIGxpbmVubyk7Ci0tIAox
LjYuMi5yYzEuMjA5LmdmZTYyNC5kaXJ0eQoK
--001636c5c2dad6f29204635de72a--
