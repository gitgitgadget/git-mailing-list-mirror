From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/2] bisect: cleanup formatting of git-bisect.sh
Date: Sat, 6 Aug 2011 13:40:27 +1000
Message-ID: <CAH3AnrpaTkSzCiCbtPM7Wv63y-5M+d5DPzPdMrzy2Ys0jkiuBw@mail.gmail.com>
References: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
	<7vsjpf3hvg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 05:40:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpXkX-0000zm-N4
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 05:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab1HFDk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 23:40:29 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60472 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab1HFDk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 23:40:28 -0400
Received: by vxi9 with SMTP id 9so1407335vxi.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vjBZ4xZURYozwHJAkms61OwiV1/mO1Ss9cD/vI1ENJ8=;
        b=LrsG6SsGWo9jLmFBPnkhZofD058YTnZ4VW61R+eIyMibVkwlCDcrayflReIsl0f+CV
         aymPBvGW0zL03zOkDFIGasO3I1OH3GCMhRvJvNGfym/uIVC4NAfMTD3hojT6MO5SJV/0
         LTgsKHvuwmO6Ryy47FmNwWCqJxIEqlDkNJf6Y=
Received: by 10.52.95.141 with SMTP id dk13mr2873941vdb.265.1312602027591;
 Fri, 05 Aug 2011 20:40:27 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Fri, 5 Aug 2011 20:40:27 -0700 (PDT)
In-Reply-To: <7vsjpf3hvg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178822>

T24gU2F0LCBBdWcgNiwgMjAxMSBhdCAzOjA5IEFNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyb3RlOgo+IEpvbiBTZXltb3VyIDxqb24uc2V5bW91ckBnbWFpbC5jb20+IHdy
aXRlczoKPgo+PiBUaGlzIHNlcmllcyBpcyBpbnRlbmRlZCB0byBiZSBhcHBsaWVkIG9uIHRvcCBq
cy9iaXNlY3Qtbm8tY2hlY2tvdXQuCj4KPiBUaGFua3M7IEkgd29uZGVyIGlmIHdlIHdhbnQgdG8g
Z28gYSBiaXQgZnVydGhlci4KPgo+IC0tID44IC0tCj4gU3ViamVjdDogYmlzZWN0OiBmdXJ0aGVy
IHN0eWxlIG5pdHBpY2tzCj4KPiBGaXggYSBmZXcgcmVtYWluaW5nIGxpbmVzIHRoYXQgaW5kZW50
ZWQgd2l0aCBzcGFjZXMuCj4KPiBBbHNvIHNpbXBsaWZ5IHRoZSBsb2dpYyBvZiBjaGVja2luZyBv
dXQgdGhlIG9yaWdpbmFsIGJyYW5jaCBhbmQgcmVwb3J0aW5nCj4gZXJyb3IgZHVyaW5nICJiaXNl
Y3QgcmVzZXQiLgo+Cj4gU2lnbmVkLW9mZi1ieTogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9i
b3guY29tPgo+IC0tLQo+IMKgZ2l0LWJpc2VjdC5zaCB8IMKgIDE4ICsrKysrKysrLS0tLS0tLS0t
LQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2dpdC1iaXNlY3Quc2ggYi9naXQtYmlzZWN0LnNoCj4gaW5kZXggMWYz
YzQ2ZC4uMjJjNGRhNSAxMDA3NTUKPiAtLS0gYS9naXQtYmlzZWN0LnNoCj4gKysrIGIvZ2l0LWJp
c2VjdC5zaAo+IEBAIC05NCw5ICs5NCw5IEBAIGJpc2VjdF9zdGFydCgpIHsKPiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpZSAiJChldmFsX2dldHRleHQgInVucmVjb2duaXNl
ZCBvcHRpb246ICdcJGFyZyciKSIgOzsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCopCj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXY9JChnaXQgcmV2LXBhcnNlIC1xIC0t
dmVyaWZ5ICIkYXJnXntjb21taXR9IikgfHwgewo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdGVzdCAkaGFzX2RvdWJsZV9kYXNoIC1lcSAxICYmCj4gLSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWUgIiQoZXZhbF9nZXR0ZXh0ICInXCRhcmcnIGRv
ZXMgbm90IGFwcGVhciB0byBiZSBhIHZhbGlkIHJldmlzaW9uIikiCj4gLSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhawo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdCAkaGFzX2RvdWJsZV9kYXNoIC1lcSAxICYmCj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWUgIiQoZXZh
bF9nZXR0ZXh0ICInXCRhcmcnIGRvZXMgbm90IGFwcGVhciB0byBiZSBhIHZhbGlkIHJldmlzaW9u
IikiCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVh
awo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAkYmFkX3NlZW4gaW4KPiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDApIHN0YXRlPSdiYWQnIDsgYmFkX3NlZW49MSA7Owo+IEBAIC0x
MjUsNyArMTI1LDcgQEAgYmlzZWN0X3N0YXJ0KCkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RhcnRfaGVhZD0kKGNhdCAiJEdJVF9ESVIvQklTRUNUX1NUQVJUIikKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHRlc3QgInokbW9kZSIgIT0gInotLW5vLWNoZWNrb3V0Igo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdGhlbgo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ2l0IGNo
ZWNrb3V0ICIkc3RhcnRfaGVhZCIgLS0KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGdpdCBjaGVja291dCAiJHN0YXJ0X2hlYWQiIC0tCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBmaQo+IMKgIMKgIMKgIMKgZWxzZQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBHZXQgcmV2
IGZyb20gd2hlcmUgd2Ugc3RhcnQuCj4gQEAgLTMzMiw3ICszMzIsNyBAQCBiaXNlY3RfdmlzdWFs
aXplKCkgewo+IMKgIMKgIMKgIMKgaWYgdGVzdCAkIyA9IDAKPiDCoCDCoCDCoCDCoHRoZW4KPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHRlc3QgLW4gIiR7RElTUExBWStzZXR9JHtTRVNTSU9O
TkFNRStzZXR9JHtNU1lTVEVNK3NldH0ke1NFQ1VSSVRZU0VTU0lPTklEK3NldH0iICYmCj4gLSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHR5cGUgZ2l0ayA+L2Rldi9udWxsIDI+JjEKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHR5cGUgZ2l0ayA+L2Rldi9udWxsIDI+JjEK
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRoZW4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNldCBnaXRrCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlCj4gQEAgLTM2
NCwxMyArMzY0LDExIEBAIGJpc2VjdF9yZXNldCgpIHsKPiDCoCDCoCDCoCDCoCopCj4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB1c2FnZSA7Owo+IMKgIMKgIMKgIMKgZXNhYwo+IC0gwqAgwqAgwqAg
aWYgISB0ZXN0IC1mICIkR0lUX0RJUi9CSVNFQ1RfSEVBRCIKPiArCj4gKyDCoCDCoCDCoCBpZiAh
IHRlc3QgLWYgIiRHSVRfRElSL0JJU0VDVF9IRUFEIiAmJiAhIGdpdCBjaGVja291dCAiJGJyYW5j
aCIgLS0KPiDCoCDCoCDCoCDCoHRoZW4KPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICEgZ2l0
IGNoZWNrb3V0ICIkYnJhbmNoIiAtLQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGhlbgo+IC0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllICIkKGV2YWxfZ2V0dGV4dCAiQ291
bGQgbm90IGNoZWNrIG91dCBvcmlnaW5hbCBIRUFEICdcJGJyYW5jaCcuCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkaWUgIiQoZXZhbF9nZXR0ZXh0ICJDb3VsZCBub3QgY2hlY2sgb3V0IG9yaWdp
bmFsIEhFQUQgJ1wkYnJhbmNoJy4KPiDCoFRyeSAnZ2l0IGJpc2VjdCByZXNldCA8Y29tbWl0Picu
IikiCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaQo+IMKgIMKgIMKgIMKgZmkKPiDCoCDCoCDC
oCDCoGJpc2VjdF9jbGVhbl9zdGF0ZQo+IMKgfQo+CgpMb29rcyBnb29kLCB0aGFua3MuCgpqb24u
Cg==
