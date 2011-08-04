From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: gitweb highligh generate illegal char when the content had utf-8 chars
Date: Thu, 4 Aug 2011 14:41:26 +0530
Message-ID: <CALkWK0kURz_Rax-JOPT2sW1x4VrqWk=KDjUzzw4apacDo1UTyg@mail.gmail.com>
References: <20110804053123.GA13198@greatfirst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: zzs <zzs213@126.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoty4-0005Et-KO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab1HDJLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 05:11:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45475 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1HDJLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 05:11:47 -0400
Received: by wyf22 with SMTP id 22so373427wyf.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VsBWCof0/x+KCeabDmujtpA4LiPd23kbTiZOqitdXGk=;
        b=CKGYo8hvxL5FQ6T579P730qy4vw/vquudPyPK2XwuyHrlEio/Zp0NNDlgPW1icrVyU
         aiypglvjsrTj6ZhMALsrmt2vI+YGgjh156RCmBA4WiBTCzUxTbQjleHb3N/CjK5Myo6C
         oxNgkDnDGe2I4CU9wjCDKKAOKtjjNzNwLrO5I=
Received: by 10.216.82.205 with SMTP id o55mr1514966wee.64.1312449106407; Thu,
 04 Aug 2011 02:11:46 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 02:11:26 -0700 (PDT)
In-Reply-To: <20110804053123.GA13198@greatfirst.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178708>

SGksCgp6enMgd3JpdGVzOgo+IGRpZmYgLS1naXQgYS9naXR3ZWIvZ2l0d2ViLnBlcmwgYi9naXR3
ZWIvZ2l0d2ViLnBlcmwKPiBpbmRleCBkYWI4OWYyLi40OGRlZjM4IDEwMDc1NQo+IC0tLSBhL2dp
dHdlYi9naXR3ZWIucGVybAo+ICsrKyBiL2dpdHdlYi9naXR3ZWIucGVybAo+IEBAIC02NDY1LDcg
KzY0NjUsNyBAQCBzdWIgZ2l0X2Jsb2Igewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgJG5yKys7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAkbGluZSA9
IHVudGFiaWZ5KCRsaW5lKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBy
aW50ZiBxcSE8ZGl2IGNsYXNzPSJwcmUiPjxhIGlkPSJsJWkiIGhyZWY9IiVzI2wlaSIgY2xhc3M9
ImxpbmVuciI+JTRpPC9hPiAlczwvZGl2PlxuISwKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJG5yLCBlc2NfYXR0cihocmVmKC1yZXBsYXkgPT4gMSkpLCAk
bnIsICRuciwgJHN5bnRheCA/ICRsaW5lIDogZXNjX2h0bWwoJGxpbmUsIC1uYnNwPT4xKTsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJG5yLCBlc2NfYXR0
cihocmVmKC1yZXBsYXkgPT4gMSkpLCAkbnIsICRuciwgJHN5bnRheCA/IHRvX3V0ZjgoJGxpbmUp
IDogZXNjX2h0bWwoJGxpbmUsIC1uYnNwPT4xKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0K
PiDCoCDCoCDCoCDCoH0KPiDCoCDCoCDCoCDCoGNsb3NlICRmZAoKTG9va3Mgc2FuZSwgYnV0IEkg
ZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgR2l0d2ViIHRvIGNvbW1lbnQuCitDQzogSmFrdWIsIHdo
byBjYW4gcHJvYmFibHkgc2F5IG1vcmUuCgpUaGFua3MuCgotLSBSYW0K
