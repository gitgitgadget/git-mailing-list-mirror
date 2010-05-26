From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: (Mosty harmless) protocol error when pushing
Date: Wed, 26 May 2010 07:58:29 +0200
Message-ID: <AANLkTilc9-B79EhmmO2t-VsHFZdupQn8zX9LFYRrn5of@mail.gmail.com>
References: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
	 <20100525072824.GA19612@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 26 07:58:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9dY-0001nr-MV
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185Ab0EZF6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:58:35 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63937 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0EZF6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:58:34 -0400
Received: by wwb13 with SMTP id 13so46626wwb.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 22:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LZ5Fdw2kQWwgKyC8UyM+xZ/qBcnvpZnGRryRv6im1to=;
        b=Dw296bQ0oIqg/6Q1GHvjXA4EDl0a7MxLmiMD/mYadjeARmJRV5oN6Wh/TAhBeg3Hf8
         mpUeaVfL/po7tyBRTv7ZkUnI06Uj2CnnSaAn+xe3YpwUDkld3ZXuh7EreK4lccdQNiKf
         v+sI/LPyotoZQ1FkR5L2sG1HrBrcm84VhH65o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YkHc8dj3FqJ2qmmT3f2PjGYXFGWs/YsDqvnFyeo71+0osY4brevW1pZXpMpdQ1AOtQ
         yVk45NsHPmdHKdpZJRopqN6tqyG76wrbXRCyvctlWp/DPVAKIp98DyNmLWwlMvs+tZ3m
         Bknud6wVG6/SsHPR7Gd0jZubRmTO+UjIst+cw=
Received: by 10.216.160.12 with SMTP id t12mr4789062wek.154.1274853509226; 
	Tue, 25 May 2010 22:58:29 -0700 (PDT)
Received: by 10.216.183.204 with HTTP; Tue, 25 May 2010 22:58:29 -0700 (PDT)
In-Reply-To: <20100525072824.GA19612@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147748>

MjAxMC81LzI1IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD46Cgo+IGRpZmYgLS1naXQgYS9idWls
dGluL3JlY2VpdmUtcGFjay5jIGIvYnVpbHRpbi9yZWNlaXZlLXBhY2suYwo+IGluZGV4IGJiMzQ3
NTcuLmMwYTZhM2IgMTAwNjQ0Cj4gLS0tIGEvYnVpbHRpbi9yZWNlaXZlLXBhY2suYwo+ICsrKyBi
L2J1aWx0aW4vcmVjZWl2ZS1wYWNrLmMKPiBAQCAtODQzLDcgKzg0MywyMCBAQCBpbnQgY21kX3Jl
Y2VpdmVfcGFjayhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZp
eCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKmFyZ3Zf
Z2NfYXV0b1tdID0gewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgImdjIiwgIi0tYXV0byIsICItLXF1aWV0IiwgTlVMTCwKPiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH07Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBydW5fY29tbWFuZF92X29wdChhcmd2X2djX2F1dG8sIFJVTl9HSVRfQ01EKTsKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBjaGlsZF9wcm9jZXNzIHByb2M7Cj4g
Kwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWVtc2V0KCZwcm9jLCAwLCBz
aXplb2YocHJvYykpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJvYy5u
b19zdGRpbiA9IDE7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcm9jLnN0
ZG91dF90b19zdGRlcnIgPSAxOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cHJvYy5lcnIgPSB1c2Vfc2lkZWJhbmQgPyAtMSA6IDA7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBwcm9jLmdpdF9jbWQgPSAxOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcHJvYy5hcmd2ID0gYXJndl9nY19hdXRvOwo+ICsKPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghc3RhcnRfY29tbWFuZCgmcHJvYykpIHsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh1c2Vfc2lkZWJh
bmQpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBjb3B5X3RvX3NpZGViYW5kKHByb2MuZXJyLCAtMSwgTlVMTCk7Cj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaW5pc2hfY29tbWFuZCgmcHJv
Yyk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9Cj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYXV0b191cGRhdGVfc2Vy
dmVyX2luZm8pCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1cGRhdGVfc2Vy
dmVyX2luZm8oMCk7Cj4KPiBVbmZvcnR1bmF0ZWx5IEkgY2FuJ3QgYWN0dWFsbHkgdGVzdCBpdC4g
OikKClRoYW5rcyEKClVuZm9ydHVuYXRlbHksIEkgd2FzIGFsc28gdW5hYmxlIHRvIHJlcHJvZHVj
ZSB0aGUgcHJvYmxlbSwKc28gSSBjYW4ndCB0ZXN0IGl0IGVpdGhlci4KClRoZXJlIGlzIG5vIGVh
c3kgd2F5IHRvIGZvcmNlIGEgR0Mgb24gbXkgcmVwb3NpdG9yeSBhdCBnaXRodWIsCnNvIEkgdHJp
ZWQgdG8gcHVzaCB0byBhIGxvY2FsIHJlcG9zaXRvcnkgaGF2aW5nIHRvbyBtYW55IGxvb3NlCm9i
amVjdHMgdXNpbmcgdGhlICJmaWxlOiIgcHJvdG9jb2wgYnV0IHRoZSBwcm9ibGVtIGRpZCBub3Qg
b2NjdXIKKGkuZS4gdGhlIHJlcG9zaXRvcnkgd2FzIGF1dG8gcGFja2VkIGJ1dCB0aGUgcHJvdG9j
b2wgZXJyb3IgZGlkCm5vdCBoYXBwZW4pLgoKLS0gCkJqw7ZybiBHdXN0YXZzc29uLCBFcmxhbmcv
T1RQLCBFcmljc3NvbiBBQgo=
