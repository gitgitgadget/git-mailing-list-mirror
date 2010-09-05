From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Make commit help text more accurate for --verbose
Date: Sun, 5 Sep 2010 12:06:33 -0300
Message-ID: <AANLkTinEZ92S_XB4zrnb26eVR-MFsDQcSPAZ3RXj6ofH@mail.gmail.com>
References: <1283680383-12495-1-git-send-email-ramana.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 17:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsGnq-0004xM-F1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 17:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab0IEPGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 11:06:35 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40419 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0IEPGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 11:06:34 -0400
Received: by qyk33 with SMTP id 33so3587905qyk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GqX9xxoi7ylkO+uYvYdq8aKlPIdrVWWdPSPRhHx78gk=;
        b=rW/hifIlC5gNDQqRc1sOupeN8Rz6BLx5FRl19CJsgM4vIuftoNz4UD6S5RIy/DwjhH
         gFfa6hTf0nDn23eScKWqLg+hCiss7yWrpszHBKCOGJFFH0c7v56NQR1PEjPQw7E6g+xu
         j07ISLp0Vl6Nkk7HXRFzN2SrAMRQJFE1Vx5bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rar0OculpuPzy30/CWmbBUWQwWF6At2vsU+F+KQo39oRmOBoH2m+MRXdQPCum/Qmi6
         jHlWKerO2PES4pXvI9IX2FMIFy8KF92Us+/7neoOtOZOWUJjNGACsjeBGQtzSAxmDccK
         yd08Di6v7EP6gtD5zD0MVJHOoRLlhEwAGzmYo=
Received: by 10.229.1.161 with SMTP id 33mr2035645qcf.279.1283699193850; Sun,
 05 Sep 2010 08:06:33 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 5 Sep 2010 08:06:33 -0700 (PDT)
In-Reply-To: <1283680383-12495-1-git-send-email-ramana.kumar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155456>

SGkgUmFtYW5hLAoKU29tZSAqc3R5bGUqIGNvbW1lbnRzIGJlbG93LgpPbiBTdW4sIFNlcCA1LCAy
MDEwIGF0IDY6NTMgQU0sIFJhbWFuYSBLdW1hciA8cmFtYW5hLmt1bWFyQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLAo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIlxuIgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIiMgUGxlYXNlIGVudGVyIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgeW91ciBjaGFuZ2Vz
LiIpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNsZWFudXBfbW9kZSA9PSBDTEVBTlVQ
X0FMTCkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjbGVhbnVwX21vZGUgPT0gQ0xFQU5V
UF9BTEwgJiYgIXZlcmJvc2UpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
cHJpbnRmKGZwLAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIiBMaW5lcyBzdGFydGluZ1xuIgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIiMgd2l0aCAnIycgd2lsbCBiZSBpZ25vcmVkLCBhbmQgYW4gZW1wdHki
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAiIG1lc3Nh
Z2UgYWJvcnRzIHRoZSBjb21taXQuXG4iKTsKVGhlIERvY3VtZW50YXRpb24vQ29kaW5nU3R5bGUg
c2F5cyB0byBhdm9pZCB1c2luZyBicmFjZXMgdW5uY2Vzc2FyeS4KQnV0IHNpbmNlIHRoaXMgaXMg
bm90IGEgc2luZ2xlIGxpbmUgc3RhdGVtZW50LCBsaWtlOgppZiAoZm9vKQogIGZvbyA9IHg7CgpD
b3VsZCB5b3Ugd3JhcHAgdGhpcyBpbnRvIHsgfSA/Cgo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZWxzZSAvKiBDTEVBTlVQX1NQQUNFLCB0aGF0IGlzLiAqLwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICIgTGluZXMgc3RhcnRpbmdcbiIKPiAtIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICIjIHdpdGggJyMnIHdpbGwgYmUga2VwdDsg
eW91IG1heSByZW1vdmUgdGhlbSIKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICIgeW91cnNlbGYgaWYgeW91IHdhbnQgdG8uXG4iCj4gLSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAiIyBBbiBlbXB0eSBtZXNzYWdlIGFi
b3J0cyB0aGUgY29tbWl0LlxuIik7Cj4gKyDCoCDCoGVsc2Ugewo+ICsgwqAgwqAgwqBpZiAoY2xl
YW51cF9tb2RlID09IENMRUFOVVBfQUxMKQo+ICsgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLAo+ICsg
wqAgwqAgwqAgwqAgwqAiIExpbmVzIHN0YXJ0aW5nXG4iCj4gKyDCoCDCoCDCoCDCoCDCoCIjIHdp
dGggJyMnIHdpbGwgYmUgaWdub3JlZCwgYXMgd2lsbCIKPiArIMKgIMKgIMKgIMKgIMKgIiB0aGUg
ZGlmZiBhbmQgYW55dGhpbmcgYmVsb3cgaXQuXG4iKTsKClNhbWUgdGhpbmcgaGVyZSAoYW5kIGJl
bG93KSBhcyBwb2ludGVkIGFib3ZlLgoKPiArIMKgIMKgIMKgZWxzZSB7IC8qIENMRUFOVVBfU1BB
Q0UsIHRoYXQgaXMuICovCj4gKyDCoCDCoCDCoCDCoGZwcmludGYoZnAsCj4gKyDCoCDCoCDCoCDC
oCDCoCIgTGluZXMgc3RhcnRpbmdcbiIKPiArIMKgIMKgIMKgIMKgIMKgIiMgd2l0aCAnIycgd2ls
bCBiZSBrZXB0OyB5b3UgbWF5IHJlbW92ZSB0aGVtIgo+ICsgwqAgwqAgwqAgwqAgwqAiIHlvdXJz
ZWxmIGlmIHlvdSB3YW50IHRvLlxuIik7Cj4gKyDCoCDCoCDCoCDCoGlmICh2ZXJib3NlKQo+ICsg
wqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAiIyBUaGUgZGlm
ZiBhbmQgYW55dGhpbmcgYmVsb3cgaXQgd2lsbCBiZSBpZ25vcmVkLlxuIik7Cj4gKyDCoCDCoCDC
oH0KPiArIMKgIMKgIMKgZnByaW50ZihmcCwgIiMgQW4gZW1wdHkgbWVzc2FnZSBhYm9ydHMgdGhl
IGNvbW1pdC5cbiIpOwo+ICsgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAob25s
eV9pbmNsdWRlX2Fzc3VtZWQpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
cHJpbnRmKGZwLCAiIyAlc1xuIiwgb25seV9pbmNsdWRlX2Fzc3VtZWQpOwo+Cg==
