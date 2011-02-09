From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/7] Add column layout
Date: Wed, 9 Feb 2011 18:24:23 +0700
Message-ID: <AANLkTimuae1rDn2+UH3mg1zBS5LsS5++8z1-yY0cBmhB@mail.gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-3-git-send-email-pclouds@gmail.com> <20110209073655.GA2135@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 12:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn8AO-0005Rt-GM
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 12:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab1BILYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 06:24:55 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33176 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1BILYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 06:24:54 -0500
Received: by wwa36 with SMTP id 36so58778wwa.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 03:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Fapzw5q1T78SMNEQ7v5GkwuTjTuy7Y4H1LCTmgihI/o=;
        b=hjv4nfKofuQGQ/hn3j3oxo+6KmrHIdazQw3BrO728p+6uIUOmpbT10QuHQIQOEwni9
         oYpBp9V4oe00muvWpZ2ldZdm7nKn/hsDGrfiAeq1xIcg9o+fm2rlyYLa92lwbLg8AuzI
         oocWriGBYFnTAlK57NGlsth5AMLgPKmbVvvy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cPH56BMgUNezYb+nMfA+xWFLm+3q/GisJFvppX6YFCs1121cjfIiOoZLSGLsqHs2IA
         RE9qBZuuaPA8kYdUNP6/AfXN/daGHbTCdPIea/ekkatdfDMk4GLrisuxyZXJF42GbFDg
         U7jPDfXwJWgMjhc+44/TJrifIPEG8mC8KKaIs=
Received: by 10.216.89.71 with SMTP id b49mr17011595wef.28.1297250693470; Wed,
 09 Feb 2011 03:24:53 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 9 Feb 2011 03:24:23 -0800 (PST)
In-Reply-To: <20110209073655.GA2135@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166404>

MjAxMS8yLzkgSm9uYXRoYW4gTmllZGVyIDxqcm5pZWRlckBnbWFpbC5jb20+Ogo+IE5ndXnhu4Vu
IFRow6FpIE5n4buNYyBEdXkgd3JvdGU6Cj4KPj4gKysrIGIvY29sdW1uLmMKPj4gQEAgLTAsMCAr
MSwxNzcgQEAKPiBbLi4uXQo+PiArc3RhdGljIGludCBpdGVtX2xlbmd0aChjb25zdCBzdHJ1Y3Qg
Y29sdW1uX2xheW91dCAqYywgY29uc3QgY2hhciAqcykKPj4gK3sKPj4gKyDCoCDCoCBpbnQgYV9s
ZW4gPSAwOwo+PiArCj4+ICsgwqAgwqAgaWYgKCEoYy0+bW9kZSAmIENPTF9BTlNJKSkKPj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gc3RybGVuKHMpOwo+PiArCj4+ICsgwqAgwqAgd2hpbGUg
KChzID0gc3Ryc3RyKHMsICJcMDMzWyIpKSAhPSBOVUxMKSB7Cj4+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgaW50IGxlbiA9IHN0cnNwbihzKzIsICIwMTIzNDU2Nzg5OyIpOwo+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIHMgKz0gbGVuKzM7IC8qIFwwMzNbPGxlbj48ZnVuYyBjaGFyPiAqLwo+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIGFfbGVuICs9IGxlbiszOwo+PiArIMKgIMKgIH0KPj4gKyDCoCDCoCByZXR1
cm4gYV9sZW47Cj4+ICt9Cj4KPiBJIHRoaW5rIHlvdSBtZWFuICJyZXR1cm4gc3RybGVuKG9yaWdf
cykgLSBhX2xlbiIuCj4KPiBTb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIGNvdWxkIGJlIG1v
cmUgb2J2aW91cywgdGhvdWdoCj4gaXQgaXMgdW5mb3J0dW5hdGVseSB2ZXJib3NlLgo+Cj4gwqAg
wqAgwqAgwqBpbnQgbGVuID0gMDsKPiDCoCDCoCDCoCDCoHdoaWxlICgqcykgewo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqbmV4dDsKPgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLyogXDAzM1s8bGVuPjxmdW5jIGNoYXI+ICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoIXByZWZpeGNtcChzLCAiXDAzM1siKSkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcyArPSBzdHJsZW4oIlwwMzNbIik7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzICs9IHN0cnNwbihzLCAiMDEyMzQ1Njc4OTsiKTsKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghKnMpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuLi4gaGFuZGxlIHNvbWVob3cgLi4uCj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzKys7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5leHQgPSBzdHJjaHJudWwocywgJ1wwMzMnKTsK
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxlbiArPSBuZXh0IC0gczsKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHMgPSBuZXh0Owo+IMKgIMKgIMKgIMKgfQo+Cj4gQm90aCBtaXNjb21wdXRlIHRo
ZSB3aWR0aCBvZiAiRMOpcMO0dCIuIMKgU29tZXRoaW5nIGxpa2UgdGhpcyBjYW4gZG8gb2sKPiBp
ZiB0aGUgc3RyaW5nIGlzIG1vZGlmaWFibGUgYW5kIHdlIGtub3cgaXQgaXMgVVRGLTg6Cj4KPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNoYXIgc2F2ZTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC4uLgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmV4dCA9IHN0cmNocm51bChzLCAnXDAzMycp
Owo+Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICogTkVFRFNXT1JLOiBhIHV0Zjhfc3Ryd2lkdGggdmFyaWFudCB0aGF0Cj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKiBhY2NlcHRzIGEgbWVtb3J5IGFyZWEgbm90IHRlcm1pbmF0ZWQgYnkgXDAK
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIHdvdWxkIGF2b2lkIHRoaXMgdWdsaW5lc3MuCj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi8KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNhdmUg
PSAqbmV4dDsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpuZXh0ID0gJ1wwJzsKPiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGxlbiArPSB1dGY4X3N0cndpZHRoKHMpOwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKm5leHQgPSBzYXZlOwo+Cj4gUE9TSVggZG9lcyBub3QgcHJvdmlkZSBhIHN0cndp
ZHRoIGZ1bmN0aW9uLCBzbyBpZiB3ZSB3YW50IHRvIGhhbmRsZQo+IGVuY29kaW5ncyBsaWtlIFNI
SUZULUpJUyB0aGVuIHNvbWV0aGluZyB1Z2xpZXJbMV0gbWlnaHQgY29tZSB0byBsaWZlLgoKSSB0
aGluayBVVEYtOCBpcyBlbm91Z2guIEdpdCBkb2VzIG5vdCBwcm9kdWNlIGNvbXBsZXggYW5zaSBl
c2NhcGUKY29kZXMuIFBlcmhhcHMgY2hlY2tpbmcgdGhlbSBhdCB0aGUgYmVnaW5uaW5nIGFuZCBy
ZXNldCBjb2RlIGF0IHRoZQplbmQgaXMgZW5vdWdoLgoKPiBbLi4uXQo+PiArc3RhdGljIHZvaWQg
cmVsYXlvdXQoY29uc3Qgc3RydWN0IGNvbHVtbl9sYXlvdXQgKmMsCj4+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpbnQgcGFkZGluZywgaW50IHNwYXJlLAo+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW50ICppbml0aWFsX3dpZHRoLCBpbnQgKip3aWR0aCwKPj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGludCAqcm93cywgaW50ICpjb2xzKQo+PiArewo+PiArIMKgIMKg
IGludCBuZXdfcm93cywgbmV3X2NvbHMsIG5ld19pbml0aWFsX3dpZHRoOwo+PiArIMKgIMKgIGlu
dCBpLCAqbmV3X3dpZHRoLCBuZXdfc3BhcmUsIHRvdGFsX3dpZHRoOwo+PiArCj4+ICsgwqAgwqAg
LyoKPj4gKyDCoCDCoCDCoCogQXNzdW1lIGFsbCBjb2x1bW5zIGhhdmUgc2FtZSB3aWR0aCwgd2Ug
d291bGQgbmVlZAo+PiArIMKgIMKgIMKgKiBpbml0aWFsX3dpZHRoKmNvbHMuIEJ1dCB0aGVuIGFm
dGVyIHNxdWVlemluZywgd2UgaGF2ZQo+PiArIMKgIMKgIMKgKiAic3BhcmUiIG1vcmUgY2hhcnMu
IEFzc3VtZSBhIG5ldyB0b3RhbF93aWR0aCB3aXRoCj4+ICsgwqAgwqAgwqAqIGFkZGl0aW9uYWwg
Y2hhcnMsIHRoZW4gcmUtc3F1ZWV6ZSB0byBzZWUgaWYgaXQgZml0cwo+PiArIMKgIMKgIMKgKiBj
LT53aWR0aC4KPj4gKyDCoCDCoCDCoCovCj4KPiBNaWdodCBiZSBlYXNpZXIgdG8gZGVidWcgaWYg
dGhpcyBwYXJ0IHdlcmUgZGVmZXJyZWQgdG8gYSBzZXBhcmF0ZQo+IHBhdGNoLiA6KQo+Cj4+ICsg
wqAgwqAgdG90YWxfd2lkdGggPSAoKmluaXRpYWxfd2lkdGgpKigqY29scykgKyBzcGFyZTsKPgo+
IEFuIG9kZCBoZXVyaXN0aWMuIMKgRG9lcyBpdCB3b3JrIHdlbGwgaW4gcHJhY3RpY2U/CgpJdCBz
ZWVtcyBzby4gSWYgaXQgZG9lcyBub3QsIEkgZ3Vlc3MgSSB3b3VsZCBuZWVkIHRvIGxvb2sgaW50
byBob3cgR05VCmxzIGRvZXMgaXQuCi0tIApEdXkK
