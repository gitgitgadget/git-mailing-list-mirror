From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v2] tg-push: add bash completion
Date: Tue, 2 Jun 2009 22:44:56 +0200
Message-ID: <36ca99e90906021344k340b5747q7d45a7b1d98f8f67@mail.gmail.com>
References: <1243377428-27546-1-git-send-email-bert.wesarg@googlemail.com>
	 <1243380694-7744-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBar3-0000WR-L4
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZFBUo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbZFBUo6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:44:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:43036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZFBUo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:44:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so947612fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bZhh1itBMm8N8h3DuyjJYwELkDMkmjnREpGDq3hRW/E=;
        b=OEshdzy9rgy3YYds9iV50wxU1zWfNxPusYFP6ng6xWsDshGi9o+4UoFgF35vCWnZJ1
         VjZcVaQz/pIKopKJgv5OwiJXBysgn/XP7mkuOaZdF2CtyGOF/uaLItoEyasXgBOoDdD6
         Uf8cUcxsSXhCB1kZxO/9hR994yao1zZJZHq/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LP2Y2XGcPZXkcTx0sE9aCVrscHxBUxa2UZtZFs+TVM0bEga+DWQKlMB3Bja3eiCvuL
         7G4MkXURaOgllBRXsi4q9iYMU/sVkmt1XCiKMLh6VS2FI1hJM6yPIHHbUNnpxTkT42fq
         Q067F+dyKLyws3AhnOTWIil1tmLtDzBQSYcDY=
Received: by 10.223.108.15 with SMTP id d15mr106802fap.62.1243975497691; Tue, 
	02 Jun 2009 13:44:57 -0700 (PDT)
In-Reply-To: <1243380694-7744-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120546>

UGluZy4KClJlZ2FyZHMsCkJlcnQKCk9uIFdlZCwgTWF5IDI3LCAyMDA5IGF0IDAxOjMxLCBCZXJ0
IFdlc2FyZyA8YmVydC53ZXNhcmdAZ29vZ2xlbWFpbC5jb20+IHdyb3RlOgo+IEluY2x1ZGUgYWxs
IG9wdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBCZXJ0IFdlc2FyZyA8YmVydC53ZXNhcmdAZ29v
Z2xlbWFpbC5jb20+Cj4KPiAtLS0KPiDCoGNvbnRyaWIvdGctY29tcGxldGlvbi5iYXNoIHwgwqAg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvY29udHJpYi90Zy1jb21w
bGV0aW9uLmJhc2ggYi9jb250cmliL3RnLWNvbXBsZXRpb24uYmFzaAo+IGluZGV4IGRlOGE3YjUu
LjBlZTIzM2MgMTAwNzU1Cj4gLS0tIGEvY29udHJpYi90Zy1jb21wbGV0aW9uLmJhc2gKPiArKysg
Yi9jb250cmliL3RnLWNvbXBsZXRpb24uYmFzaAo+IEBAIC0zNzAsNiArMzcwLDI5IEBAIF90Z19w
YXRjaCAoKQo+IMKgIMKgIMKgIMKgZXNhYwo+IMKgfQo+Cj4gK190Z19wdXNoICgpCj4gK3sKPiAr
IMKgIMKgIMKgIGxvY2FsIGN1cj0iJHtDT01QX1dPUkRTW0NPTVBfQ1dPUkRdfSIKPiArCj4gKyDC
oCDCoCDCoCBfX3RnX2NvbXBsZXRlX2FyZyAiLXIiICYmIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIF9fdGdjb21wICIkKF9fdGdfcmVtb3RlcykiCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm4KPiArIMKgIMKgIMKgIH0KPiArCj4gKyDCoCDCoCDCoCBjYXNlICIkY3VyIiBpbgo+ICsg
wqAgwqAgwqAgLSopCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3RnY29tcCAiCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtLW5vLWRlcHMKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC0tZHJ5LXJ1bgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLS10Z2lzaC1vbmx5Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAtcgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgIgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
OzsKPiArIMKgIMKgIMKgICopCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3RnY29tcCAiJChf
X3RnX3RvcGljcykiCj4gKyDCoCDCoCDCoCBlc2FjCj4gK30KPiArCj4gwqBfdGdfcmVtb3RlICgp
Cj4gwqB7Cj4gwqAgwqAgwqAgwqBsb2NhbCBjdXI9IiR7Q09NUF9XT1JEU1tDT01QX0NXT1JEXX0i
Cj4gQEAgLTQ0OSw2ICs0NzIsNyBAQCBfdGcgKCkKPiDCoCDCoCDCoCDCoGluZm8pIMKgIMKgIMKg
IMKgX3RnX2luZm8gOzsKPiDCoCDCoCDCoCDCoG1haWwpIMKgIMKgIMKgIMKgX3RnX21haWwgOzsK
PiDCoCDCoCDCoCDCoHBhdGNoKSDCoCDCoCDCoCBfdGdfcGF0Y2ggOzsKPiArIMKgIMKgIMKgIHB1
c2gpIMKgIMKgIMKgIMKgX3RnX3B1c2ggOzsKPiDCoCDCoCDCoCDCoHJlbW90ZSkgwqAgwqAgwqBf
dGdfcmVtb3RlIDs7Cj4gwqAgwqAgwqAgwqBzdW1tYXJ5KSDCoCDCoCBfdGdfc3VtbWFyeSA7Owo+
IMKgIMKgIMKgIMKgdXBkYXRlKSDCoCDCoCDCoF90Z191cGRhdGUgOzsKPiAtLQo+IHRnOiAoYjcy
NWZjOS4uKSBidy9wdXNoLWNvbXBsZXRpb24gKGRlcGVuZHMgb246IG1hc3RlcikKPgo=
