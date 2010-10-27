From: Jeff Carr <basilarchia@gmail.com>
Subject: add UTC option for pretty-formats
Date: Tue, 26 Oct 2010 18:32:21 -0700
Message-ID: <AANLkTikN_B-bUTyy5440AVwTD=KkUWdkf_ukRszTuhYG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485eba7082a670704938f349a
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 03:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAust-0002GY-4m
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 03:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0J0Bcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 21:32:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62617 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0J0Bcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 21:32:52 -0400
Received: by qwk3 with SMTP id 3so141396qwk.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 18:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=wNOX2ipJUSnu7xvmQF471Oeu6iZziTmZ7ypWO+FuDtA=;
        b=GdMtRNj1sobJU5RJOPKtH2ZMfN2JolEsciZhUQmykoQMZCXSUvVHCVG5xrDLviKEFs
         18xr2xLwTGJkKNY/TorwSH6pgCDNHoBatQ2mW+1UywoobyFYGy+78quxpL6pYSKOGG2Z
         OSq1+GUFaPUTGm+ukx2+/W8adRNhjrDs8mbb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=PcOBDz1NgfX3qKAIfCx1WLFuhcsrzEWyG2nIF3LJ0J9HpS+t7+ZMlEB40r1Kz1/tpS
         lNVZ/9e+S7GKCn9IbV81WrFPtWDCPTS/cWF1m344AQGADdVV3nH5vRg6UAETbzzXwb6L
         gJBtG5/uQ5KRXz92trJQGK4RlE9AnBVompbj4=
Received: by 10.224.119.198 with SMTP id a6mr2001679qar.41.1288143171641; Tue,
 26 Oct 2010 18:32:51 -0700 (PDT)
Received: by 10.224.37.132 with HTTP; Tue, 26 Oct 2010 18:32:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160016>

--001485eba7082a670704938f349a
Content-Type: text/plain; charset=UTF-8

Adds displaying author and commit times in UTC using %au and %cu.

--001485eba7082a670704938f349a
Content-Type: text/x-patch; charset=US-ASCII; name="git_format_utc.diff"
Content-Disposition: attachment; filename="git_format_utc.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfrj2uc10

Y29tbWl0IDk5YTQyOWMzZTM2OWNhNzYxMTNhODY0MmY4MDI0NWQ3NjQ0YjlhMmYKQXV0aG9yOiBK
ZWZmIENhcnIgPGpjYXJyQGJhc2lsYXJjaGlhQGdtYWlsLmNvbT4KRGF0ZTogICBUdWUgT2N0IDI2
IDE4OjI1OjA2IDIwMTAgLTA3MDAKCiAgICBBZGRzIGEgVVRDIG9wdGlvbiB0byB0aGUgcHJldHR5
IGZvcm1hdHMKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ByZXR0eS1mb3JtYXRzLnR4dCBi
L0RvY3VtZW50YXRpb24vcHJldHR5LWZvcm1hdHMudHh0CmluZGV4IDU2MWNjOWYuLmRmNTYxNDcg
MTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vcHJldHR5LWZvcm1hdHMudHh0CisrKyBiL0RvY3Vt
ZW50YXRpb24vcHJldHR5LWZvcm1hdHMudHh0CkBAIC0xMTQsNiArMTE0LDcgQEAgVGhlIHBsYWNl
aG9sZGVycyBhcmU6CiAtICclYXInOiBhdXRob3IgZGF0ZSwgcmVsYXRpdmUKIC0gJyVhdCc6IGF1
dGhvciBkYXRlLCBVTklYIHRpbWVzdGFtcAogLSAnJWFpJzogYXV0aG9yIGRhdGUsIElTTyA4NjAx
IGZvcm1hdAorLSAnJWF1JzogYXV0aG9yIGRhdGUsIFVUQwogLSAnJWNuJzogY29tbWl0dGVyIG5h
bWUKIC0gJyVjTic6IGNvbW1pdHRlciBuYW1lIChyZXNwZWN0aW5nIC5tYWlsbWFwLCBzZWUgbGlu
a2dpdDpnaXQtc2hvcnRsb2dbMV0gb3IgbGlua2dpdDpnaXQtYmxhbWVbMV0pCiAtICclY2UnOiBj
b21taXR0ZXIgZW1haWwKQEAgLTEyMyw2ICsxMjQsNyBAQCBUaGUgcGxhY2Vob2xkZXJzIGFyZToK
IC0gJyVjcic6IGNvbW1pdHRlciBkYXRlLCByZWxhdGl2ZQogLSAnJWN0JzogY29tbWl0dGVyIGRh
dGUsIFVOSVggdGltZXN0YW1wCiAtICclY2knOiBjb21taXR0ZXIgZGF0ZSwgSVNPIDg2MDEgZm9y
bWF0CistICclY3UnOiBjb21taXR0ZXIgZGF0ZSwgVVRDCiAtICclZCc6IHJlZiBuYW1lcywgbGlr
ZSB0aGUgLS1kZWNvcmF0ZSBvcHRpb24gb2YgbGlua2dpdDpnaXQtbG9nWzFdCiAtICclZSc6IGVu
Y29kaW5nCiAtICclcyc6IHN1YmplY3QKZGlmZiAtLWdpdCBhL2J1aWx0aW4vYmxhbWUuYyBiL2J1
aWx0aW4vYmxhbWUuYwppbmRleCAxMDE1MzU0Li4zM2IwNGU2IDEwMDY0NAotLS0gYS9idWlsdGlu
L2JsYW1lLmMKKysrIGIvYnVpbHRpbi9ibGFtZS5jCkBAIC0yMzQzLDYgKzIzNDMsOSBAQCBwYXJz
ZV9kb25lOgogCWNhc2UgREFURV9TSE9SVDoKIAkJYmxhbWVfZGF0ZV93aWR0aCA9IHNpemVvZigi
MjAwNi0xMC0xOSIpOwogCQlicmVhazsKKwljYXNlIERBVEVfVVRDOgorCQlibGFtZV9kYXRlX3dp
ZHRoID0gc2l6ZW9mKCJGcmkgTWFyIDEyIDIwOjE4OjUzIFVUQyAyMDEwIik7CisJCWJyZWFrOwog
CWNhc2UgREFURV9SRUxBVElWRToKIAkJLyogIm5vcm1hbCIgaXMgdXNlZCBhcyB0aGUgZmFsbGJh
Y2sgZm9yICJyZWxhdGl2ZSIgKi8KIAljYXNlIERBVEVfTE9DQUw6CmRpZmYgLS1naXQgYS9jYWNo
ZS5oIGIvY2FjaGUuaAppbmRleCAzM2RlY2Q5Li5hNDY5NjVkIDEwMDY0NAotLS0gYS9jYWNoZS5o
CisrKyBiL2NhY2hlLmgKQEAgLTgxMiw2ICs4MTIsNyBAQCBlbnVtIGRhdGVfbW9kZSB7CiAJREFU
RV9MT0NBTCwKIAlEQVRFX0lTTzg2MDEsCiAJREFURV9SRkMyODIyLAorCURBVEVfVVRDLAogCURB
VEVfUkFXCiB9OwogCmRpZmYgLS1naXQgYS9kYXRlLmMgYi9kYXRlLmMKaW5kZXggMDBmOWViNS4u
NjRiYmNlMCAxMDA2NDQKLS0tIGEvZGF0ZS5jCisrKyBiL2RhdGUuYwpAQCAtMTU3LDYgKzE1Nywx
NyBAQCBjb25zdCBjaGFyICpzaG93X2RhdGUodW5zaWduZWQgbG9uZyB0aW1lLCBpbnQgdHosIGVu
dW0gZGF0ZV9tb2RlIG1vZGUpCiAJCXJldHVybiB0aW1lYnVmOwogCX0KIAorCWlmIChtb2RlID09
IERBVEVfVVRDKSB7CisJCXRtID0gdGltZV90b190bSh0aW1lLCAwKTsKKwkJc3ByaW50Zih0aW1l
YnVmLCAiJS4zcyAlLjNzICUyZCAlMDJkOiUwMmQ6JTAyZCBVVEMgJWQiLAorCQkJd2Vla2RheV9u
YW1lc1t0bS0+dG1fd2RheV0sCisJCQltb250aF9uYW1lc1t0bS0+dG1fbW9uXSwKKwkJCXRtLT50
bV9tZGF5LAorCQkJdG0tPnRtX2hvdXIsIHRtLT50bV9taW4sIHRtLT50bV9zZWMsCisJCQl0bS0+
dG1feWVhciArIDE5MDApOworCQlyZXR1cm4gdGltZWJ1ZjsKKwl9CisKIAlpZiAobW9kZSA9PSBE
QVRFX1JFTEFUSVZFKSB7CiAJCXN0cnVjdCB0aW1ldmFsIG5vdzsKIAkJZ2V0dGltZW9mZGF5KCZu
b3csIE5VTEwpOwpkaWZmIC0tZ2l0IGEvcHJldHR5LmMgYi9wcmV0dHkuYwppbmRleCBmODU0NDRi
Li45OTAzYTEyIDEwMDY0NAotLS0gYS9wcmV0dHkuYworKysgYi9wcmV0dHkuYwpAQCAtNTMxLDYg
KzUzMSw5IEBAIHN0YXRpYyBzaXplX3QgZm9ybWF0X3BlcnNvbl9wYXJ0KHN0cnVjdCBzdHJidWYg
KnNiLCBjaGFyIHBhcnQsCiAJY2FzZSAnaSc6CS8qIGRhdGUsIElTTyA4NjAxICovCiAJCXN0cmJ1
Zl9hZGRzdHIoc2IsIHNob3dfZGF0ZShkYXRlLCB0eiwgREFURV9JU084NjAxKSk7CiAJCXJldHVy
biBwbGFjZWhvbGRlcl9sZW47CisJY2FzZSAndSc6CS8qIGRhdGUsIFVUQyAqLworCQlzdHJidWZf
YWRkc3RyKHNiLCBzaG93X2RhdGUoZGF0ZSwgdHosIERBVEVfVVRDKSk7CisJCXJldHVybiBwbGFj
ZWhvbGRlcl9sZW47CiAJfQogCiBza2lwOgo=
--001485eba7082a670704938f349a--
