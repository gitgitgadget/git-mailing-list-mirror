From: Daniel Mack <zonque@gmail.com>
Subject: Suppressing auto-cc for specific addresses
Date: Sun, 07 Aug 2011 22:20:26 +0200
Message-ID: <4E3EF38A.9010307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080107070403080007050507"
Cc: Greg Kroah-Hartman <greg@kroah.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 22:20:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq9pv-0001Vb-TI
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab1HGUUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 16:20:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64531 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab1HGUUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 16:20:34 -0400
Received: by fxh19 with SMTP id 19so4652596fxh.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type;
        bh=VhGPgv80/P3G+ZKr6vD+n4my2VzetvzAUGYmmSfFLGE=;
        b=lg386FETqXoSaT0lrFPoIAz20+fgE6cLie17uGeeMVOi3yGTY7EEq/paxORg9NkREQ
         HBQze54U96H03PFD7HKIC7oKxrx2aACzL2jxf1ub/U+i+MW9ov9gsYFhRdW/rFH3/9UX
         v+Z9NHhs9tXecdQXm/tc2gIXb/cm34tvoZzak=
Received: by 10.204.48.208 with SMTP id s16mr1307924bkf.167.1312748432872;
        Sun, 07 Aug 2011 13:20:32 -0700 (PDT)
Received: from [10.0.1.6] (i59F72D40.versanet.de [89.247.45.64])
        by mx.google.com with ESMTPS id o11sm1431795bkt.4.2011.08.07.13.20.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 13:20:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178926>

This is a multi-part message in MIME format.
--------------080107070403080007050507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm looking for a way to suppress certain Cc: fields that are normally 
automatically added for addresses mentioned in Cc: lines found in patches.

In particular, the kernel rules for marking patches for stable release 
inclusion wants users to add a "Cc: stable@kernel.org" line in the patch 
itself but to not actually send a copy of that patch to that address. It 
will be picked automatically once the patch was applied upstream.

I couldn't find a proper way to do that with git send-email, so I dare 
to come up with a patch proposal. Is that acceptable or is there any 
better way (which I'm not aware about) to achive this?



Thanks,
Daniel

--------------080107070403080007050507
Content-Type: text/plain;
 name="0001-send-email-Allow-email-addresses-and-domains-as-supp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-send-email-Allow-email-addresses-and-domains-as-supp.pa";
 filename*1="tch"

RnJvbSBmMWExN2E0ZmJjMDM3MzI4MzY5NmNiNTYwYWZmZjNhZmEwNWMyZThmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgTWFjayA8em9ucXVlQGdtYWlsLmNvbT4K
RGF0ZTogU3VuLCA3IEF1ZyAyMDExIDIyOjE2OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
c2VuZC1lbWFpbDogQWxsb3cgZW1haWwgYWRkcmVzc2VzIGFuZCBkb21haW5zIGFzCiAtLXN1
cHByZXNzLWNjIG9wdGlvbnMKClNpZ25lZC1vZmYtYnk6IERhbmllbCBNYWNrIDx6b25xdWVA
Z21haWwuY29tPgotLS0KIERvY3VtZW50YXRpb24vZ2l0LXNlbmQtZW1haWwudHh0IHwgICAx
MCArKysrKysrLS0tCiBnaXQtc2VuZC1lbWFpbC5wZXJsICAgICAgICAgICAgICB8ICAgMTIg
KysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtc2VuZC1lbWFpbC50
eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1zZW5kLWVtYWlsLnR4dAppbmRleCAzMjcyMzNjLi41
OTY2YWJiIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1zZW5kLWVtYWlsLnR4dAor
KysgYi9Eb2N1bWVudGF0aW9uL2dpdC1zZW5kLWVtYWlsLnR4dApAQCAtMjMzLDkgKzIzMyw5
IEBAIEF1dG9tYXRpbmcKIAljYyBsaXN0LiBEZWZhdWx0IGlzIHRoZSB2YWx1ZSBvZiAnc2Vu
ZGVtYWlsLnNpZ25lZG9mZmJ5Y2MnIGNvbmZpZ3VyYXRpb24KIAl2YWx1ZTsgaWYgdGhhdCBp
cyB1bnNwZWNpZmllZCwgZGVmYXVsdCB0byAtLXNpZ25lZC1vZmYtYnktY2MuCiAKLS0tc3Vw
cHJlc3MtY2M9PGNhdGVnb3J5Pjo6Ci0JU3BlY2lmeSBhbiBhZGRpdGlvbmFsIGNhdGVnb3J5
IG9mIHJlY2lwaWVudHMgdG8gc3VwcHJlc3MgdGhlCi0JYXV0by1jYyBvZjoKKy0tc3VwcHJl
c3MtY2M9PGNhdGVnb3J5fGFkZHJlc3N8ZG9tYWluPjo6CisJU3BlY2lmeSBhbiBhZGRpdGlv
bmFsIGNhdGVnb3J5LCBlbWFpbCBhZGRyZXNzIG9yIGRvbWFpbiBvZiByZWNpcGllbnRzCisJ
dG8gc3VwcHJlc3MgdGhlIGF1dG8tY2MgZm9yLiBQb3NzaWJsZSBjYXRlZ29yaWVzIGFyZToK
ICsKIC0tCiAtICdhdXRob3InIHdpbGwgYXZvaWQgaW5jbHVkaW5nIHRoZSBwYXRjaCBhdXRo
b3IKQEAgLTI1MSw2ICsyNTEsMTAgQEAgQXV0b21hdGluZwogLSAnYWxsJyB3aWxsIHN1cHBy
ZXNzIGFsbCBhdXRvIGNjIHZhbHVlcy4KIC0tCiArCitJZiBhIGZ1bGwgZW1haWwgYWRkcmVz
cyBpcyBnaXZlbiwgYXV0by1jYyB3aWxsIGJlIHN1cHByZXNzZWQgZm9yIHRoaXMgcGFydGlj
dWxhcgorYWRkcmVzcy4gVGhpcyBhbHNvIHdvcmtzIGZvciBlbnRpcmUgZG9tYWlucyBpZiB0
aGUgcGFyYW1ldGVyIHN0YXJ0cyB3aXRoIHRoZSAnQCcKK3NpZ24uIEFsbCBlbWFpbCBhZGRy
ZXNzZXMgaW4gdGhhdCBkb21haW4gd2lsbCBoZW5jZSBiZSBpZ25vcmVkIGJ5IGF1dG8tY2Mu
CisrCiBEZWZhdWx0IGlzIHRoZSB2YWx1ZSBvZiAnc2VuZGVtYWlsLnN1cHByZXNzY2MnIGNv
bmZpZ3VyYXRpb24gdmFsdWU7IGlmCiB0aGF0IGlzIHVuc3BlY2lmaWVkLCBkZWZhdWx0IHRv
ICdzZWxmJyBpZiAtLXN1cHByZXNzLWZyb20gaXMKIHNwZWNpZmllZCwgYXMgd2VsbCBhcyAn
Ym9keScgaWYgLS1uby1zaWduZWQtb2ZmLWNjIGlzIHNwZWNpZmllZC4KZGlmZiAtLWdpdCBh
L2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQtc2VuZC1lbWFpbC5wZXJsCmluZGV4IDk4YWIz
M2EuLjIyODEzZTUgMTAwNzU1Ci0tLSBhL2dpdC1zZW5kLWVtYWlsLnBlcmwKKysrIGIvZ2l0
LXNlbmQtZW1haWwucGVybApAQCAtMzc0LDcgKzM3NCw3IEBAIG15KCVzdXBwcmVzc19jYyk7
CiBpZiAoQHN1cHByZXNzX2NjKSB7CiAJZm9yZWFjaCBteSAkZW50cnkgKEBzdXBwcmVzc19j
YykgewogCQlkaWUgIlVua25vd24gLS1zdXBwcmVzcy1jYyBmaWVsZDogJyRlbnRyeSdcbiIK
LQkJCXVubGVzcyAkZW50cnkgPX4gL14oPzphbGx8Y2NjbWR8Y2N8YXV0aG9yfHNlbGZ8c29i
fGJvZHl8Ym9keWNjKSQvOworCQkJdW5sZXNzICRlbnRyeSA9fiAvXig/OmFsbHxjY2NtZHxj
Y3xhdXRob3J8c2VsZnxzb2J8Ym9keXxib2R5Y2N8LipALiopJC87CiAJCSRzdXBwcmVzc19j
Y3skZW50cnl9ID0gMTsKIAl9CiB9CkBAIC0xMjEzLDYgKzEyMTMsMTEgQEAgZm9yZWFjaCBt
eSAkdCAoQGZpbGVzKSB7CiAJCQkJCX0gZWxzZSB7CiAJCQkJCQluZXh0IGlmICgkc3VwcHJl
c3NfY2N7J2NjJ30pOwogCQkJCQl9CisJCQkJCW5leHQgaWYgKCRzdXBwcmVzc19jY3skYWRk
cn0pOworCQkJCQlpZiAoJGFkZHIgPX4gL14oLispKEAuKykkLykgeworCQkJCQkJbXkgJGRv
bWFpbiA9ICQyOworCQkJCQkJbmV4dCBpZiAkc3VwcHJlc3NfY2N7JGRvbWFpbn07CisJCQkJ
CX0KIAkJCQkJcHJpbnRmKCIobWJveCkgQWRkaW5nIGNjOiAlcyBmcm9tIGxpbmUgJyVzJ1xu
IiwKIAkJCQkJCSRhZGRyLCAkXykgdW5sZXNzICRxdWlldDsKIAkJCQkJcHVzaCBAY2MsICRh
ZGRyOwpAQCAtMTI2MSw2ICsxMjY2LDExIEBAIGZvcmVhY2ggbXkgJHQgKEBmaWxlcykgewog
CQkJCW5leHQgaWYgJHN1cHByZXNzX2Njeydzb2InfSBhbmQgJHdoYXQgPX4gL1NpZ25lZC1v
ZmYtYnkvaTsKIAkJCQluZXh0IGlmICRzdXBwcmVzc19jY3snYm9keWNjJ30gYW5kICR3aGF0
ID1+IC9DYy9pOwogCQkJfQorCQkJbmV4dCBpZiAoJHN1cHByZXNzX2NjeyRjfSk7CisJCQlp
ZiAoJGMgPX4gL14oLispKEAuKykkLykgeworCQkJCW15ICRkb21haW4gPSAkMjsKKwkJCQlu
ZXh0IGlmICRzdXBwcmVzc19jY3skZG9tYWlufTsKKwkJCX0KIAkJCXB1c2ggQGNjLCAkYzsK
IAkJCXByaW50ZigiKGJvZHkpIEFkZGluZyBjYzogJXMgZnJvbSBsaW5lICclcydcbiIsCiAJ
CQkJJGMsICRfKSB1bmxlc3MgJHF1aWV0OwotLSAKMS43LjYKCg==
--------------080107070403080007050507--
