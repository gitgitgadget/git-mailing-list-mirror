From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 22:38:46 +0800
Message-ID: <46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	 <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7001_24404357.1208875126942"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:41:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoJf8-0008Gt-Sm
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 16:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761914AbYDVOiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761318AbYDVOiu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 10:38:50 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:7285 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074AbYDVOis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 10:38:48 -0400
Received: by an-out-0708.google.com with SMTP id d31so603182and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=d6SQHbHYrRvijgWSHY7RcFhWjo0nINXVdjb3FFUxwhA=;
        b=v28OzLBsrlHWoIfOdGyX90F9rvuP7iBkPf0e4rC55XHnknxuZsCs4/tQHien3VLXOcRm0BMaaX4hPWiC4cHRrOahMRtBAjCBgFif9cgCd/G+Xttr0xnd/VEqYY+m7MpeKtZzYqDmPKc7YZi8yGaZOk+3b65ddVi05XPeNRF+USA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=iTBTY+m5dL2KuGTaMd7r/1F+8bz+vZzWaegom//QaS1RzgIE2CrH/EgYEaUJFHOf1WTDD+TCKwVUd4iSqcNOoOM1F53VB4pCNcHqrKjiqvvInpyvL9sL1qZvRhcXIqwN6poxFcxXbRo19NWdVd3GRGvUvEf1a+1EsE4xkQ4Ejrg=
Received: by 10.100.164.10 with SMTP id m10mr516105ane.33.1208875126972;
        Tue, 22 Apr 2008 07:38:46 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 07:38:46 -0700 (PDT)
In-Reply-To: <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80125>

------=_Part_7001_24404357.1208875126942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>  >  Please have that kind of justification in the proposed commit log message.
>  >  When these changes are made into history, people cannot ask you questions
>  >  like I did and expect the history to produce such answer on demand ;-)
>  >
>
>  OK, i'll resend this patch tonight.

See attached patch


-- 
Ping Yin

------=_Part_7001_24404357.1208875126942
Content-Type: text/x-patch;
 name=0002-git-submodule-Fix-inconsistent-handling-of-relative.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffcl1i4v0
Content-Disposition: attachment;
 filename=0002-git-submodule-Fix-inconsistent-handling-of-relative.patch

RnJvbSBmODliMDhlZGFhNDRmODlhNTM0ZGNiNGZjMTczNDRlYTQ5YzVkYWRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nIFlpbiA8cGt1ZnJhbmt5QGdtYWlsLmNvbT4KRGF0ZTog
VGh1LCAxMyBNYXIgMjAwOCAwMDowOTo1NyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi83XSBnaXQt
c3VibW9kdWxlOiBGaXggaW5jb25zaXN0ZW50IGhhbmRsaW5nIG9mIHJlbGF0aXZlIHVybHMgd2l0
aCAnLi8nIHByZWZpeAoKVGhlcmUgaXMgYSBsaXR0bGUgaW5jb25zaXN0ZW5jZSBpbiBjdXJyZW50
IGhhbmRsaW5nIG9mIHJlbGF0aXZlIHVybAp3aXRoICIuLyIKCi0gImdpdCBzdWJtb2R1bGUgYWRk
IC4vZm9vIiB3aWxsIGNsb25lIHRoZSBzdWJtb2R1bGUgd2l0aCB1cmwKICAiJHtyZW1vdGUub3Jp
Z2luLnVybH0vZm9vIiBhbmQgaW5pdCBhbiBlbnRyeSAnc3VibW9kdWxlLmZvby51cmw9Li9mb28i
CiAgaW4gLmdpdG1vZHVsZXMKCi0gImdpdCBzdWJtb2R1bGUgaW5pdCIgd2lsbCBpbml0IGFuIGVu
dHJ5IGluICRHSVRfRElSL2NvbmZpZyBhcwogICJzdWJtb2R1bGUuZm9vLnVybD0ke3JlbW90ZS5v
cmlnaW4udXJsfS9mb28iCgotIEhvd2V2ZXIsIGlmIHRoZXJlIGlzIGFuIGVudHJ5ICJzdWJtb2R1
bGUuZm9vLnVybD0uL2ZvbyIgaW4KICAkR0lUX0RJUi9jb25maWcsICJnaXQgc3VibW9kdWxlIHVw
ZGF0ZSIgd2lsbCBub3QgZXhwYW5kCiAgIi4vZm9vIiB3aXRoIHJlbW90ZS5vcmlnaW4udXJsCgpU
aGlzIHBhdGNoIHVuaWZpZXMgdGhlIGJlaGF2aW91ciBvZiBoYW5kbGluZyByZWxhdGl2ZSB1cmxz
IHdpdGggJy4vJwpwcmVmaXguIE5vdyAiZ2l0IHN1Ym1vZHVsZSBpbml0IiBjb3BpZXMgdXJscyBm
cm9tIC5naXRtb2R1bGVzIHRvCiRHSVRfRElSL2NvbmZpZyBhcyBpcyB3aXRob3V0IGV4cGFuZGlu
Zy4gQW5kIHRoZSB1cmwgZXhwYW5kaW5nIGhhcHBlbnMKb25seSBhdCBydW50aW1lLCBzYXkgd2hl
biAiZ2l0IHN1Ym1vZHVsZSBhZGQiIG9yICJnaXQgc3VibW9kdWxlIHVwZGF0ZSIuCgphYnNvbHV0
ZV91cmwgaXMgZXh0cmFjdGVkIHRvIHJlbW92ZSBjb2RlIHJlZHVuZGFuY2UgYW5kIGZpeCBpbmNv
bnNpc3RlbmNlCmluIGNtZF9pbml0IGFuZCBjbWRfYWRkIHdoZW4gcmVzb2x2aW5nIHJlbGF0aXZl
IHVybC9wYXRoIHRvIGFic29sdXRlIG9uZS4KCkFsc28gbW92ZSByZXNvbHZpbmcgYWJzb2x1dGUg
dXJsIGxvZ2ljIGZyb20gY21kX2FkZCB0byBtb2R1bGVfY2xvbmUgd2hpY2gKcmVzdWx0cyBpbiB0
aGUgZXhwZWN0ZWQgYmVoYXZpb3VyIGNoYW5nZTogY21kX3VwZGF0ZSB3aWxsIHJlc29sdmUgdXJs
CicuL2ZvbycgaW4gJEdJVF9ESVIvY29uZmlnIGFzICIke3JlbW90ZS5vcmlnaW4udXJsfS9mb28i
IGluc3RlYWQgb2YKIiQocHdkKS9mb28iLgoKVGhpcyBiZWhhdmlvdXIgY2hhbmdlIGJyZWFrcyB0
NzQwMCB3aGljaCB1c2VzIHJlbGF0aXZlIHVybCAnLi8uc3VicmVwbycuCkhvd2V2ZXIsIHRoaXMg
dGVzdCBvcmlnaW5hbGx5IGRvZXNuJ3QgbWVhbiB0byB0ZXN0IHJlbGF0aXZlIHVybCB3aXRoICcu
LycKcHJlZml4LCBzbyBmaXggdGhlIHVybCBhcyAnLnN1YnJlcG8nLgoKU2lnbmVkLW9mZi1ieTog
UGluZyBZaW4gPHBrdWZyYW5reUBnbWFpbC5jb20+Ci0tLQogZ2l0LXN1Ym1vZHVsZS5zaCAgICAg
ICAgICAgfCAgIDQxICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0
L3Q3NDAwLXN1Ym1vZHVsZS1iYXNpYy5zaCB8ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ2l0LXN1Ym1vZHVs
ZS5zaCBiL2dpdC1zdWJtb2R1bGUuc2gKaW5kZXggZTcxZTFmMC4uMTk4ZWE0NCAxMDA3NTUKLS0t
IGEvZ2l0LXN1Ym1vZHVsZS5zaAorKysgYi9naXQtc3VibW9kdWxlLnNoCkBAIC02NSw2ICs2NSwy
MSBAQCByZXNvbHZlX3JlbGF0aXZlX3VybCAoKQogCWVjaG8gIiRyZW1vdGV1cmwvJHVybCIKIH0K
IAorIyBSZXNvbHZlIHJlbGF0aXZlIHVybC9wYXRoIHRvIGFic29sdXRlIG9uZQorYWJzb2x1dGVf
dXJsICgpIHsKKwljYXNlICIkMSIgaW4KKwkuLyp8Li4vKikKKwkJIyBkZXJlZmVyZW5jZSBzb3Vy
Y2UgdXJsIHJlbGF0aXZlIHRvIHBhcmVudCdzIHVybAorCQl1cmw9IiQocmVzb2x2ZV9yZWxhdGl2
ZV91cmwgJDEpIiA7OworCSopCisJCSMgVHVybiB0aGUgc291cmNlIGludG8gYW4gYWJzb2x1dGUg
cGF0aCBpZiBpdCBpcyBsb2NhbAorCQl1cmw9JChnZXRfcmVwb19iYXNlICIkMSIpIHx8CisJCXVy
bD0kMQorCQk7OworCWVzYWMKKwllY2hvICIkdXJsIgorfQorCiAjCiAjIE1hcCBzdWJtb2R1bGUg
cGF0aCB0byBzdWJtb2R1bGUgbmFtZQogIwpAQCAtMTEyLDcgKzEyNyw3IEBAIG1vZHVsZV9pbmZv
KCkgewogbW9kdWxlX2Nsb25lKCkKIHsKIAlwYXRoPSQxCi0JdXJsPSQyCisJdXJsPSQoYWJzb2x1
dGVfdXJsICIkMiIpCiAKIAkjIElmIHRoZXJlIGFscmVhZHkgaXMgYSBkaXJlY3RvcnkgYXQgdGhl
IHN1Ym1vZHVsZSBwYXRoLAogCSMgZXhwZWN0IGl0IHRvIGJlIGVtcHR5IChzaW5jZSB0aGF0IGlz
IHRoZSBkZWZhdWx0IGNoZWNrb3V0CkBAIC0xOTUsMjEgKzIxMCw3IEBAIGNtZF9hZGQoKQogCQkJ
ZGllICInJHBhdGgnIGFscmVhZHkgZXhpc3RzIGFuZCBpcyBub3QgYSB2YWxpZCBnaXQgcmVwbyIK
IAkJZmkKIAllbHNlCi0JCWNhc2UgIiRyZXBvIiBpbgotCQkuLyp8Li4vKikKLQkJCSMgZGVyZWZl
cmVuY2Ugc291cmNlIHVybCByZWxhdGl2ZSB0byBwYXJlbnQncyB1cmwKLQkJCXJlYWxyZXBvPSIk
KHJlc29sdmVfcmVsYXRpdmVfdXJsICRyZXBvKSIgOzsKLQkJKikKLQkJCSMgVHVybiB0aGUgc291
cmNlIGludG8gYW4gYWJzb2x1dGUgcGF0aCBpZgotCQkJIyBpdCBpcyBsb2NhbAotCQkJaWYgYmFz
ZT0kKGdldF9yZXBvX2Jhc2UgIiRyZXBvIik7IHRoZW4KLQkJCQlyZXBvPSIkYmFzZSIKLQkJCWZp
Ci0JCQlyZWFscmVwbz0kcmVwbwotCQkJOzsKLQkJZXNhYwotCi0JCW1vZHVsZV9jbG9uZSAiJHBh
dGgiICIkcmVhbHJlcG8iIHx8IGV4aXQKKwkJbW9kdWxlX2Nsb25lICIkcGF0aCIgIiRyZXBvIiB8
fCBleGl0CiAJCSh1bnNldCBHSVRfRElSOyBjZCAiJHBhdGgiICYmIGdpdCBjaGVja291dCAtcSAk
e2JyYW5jaDorLWIgIiRicmFuY2giICJvcmlnaW4vJGJyYW5jaCJ9KSB8fAogCQlkaWUgIlVuYWJs
ZSB0byBjaGVja291dCBzdWJtb2R1bGUgJyRwYXRoJyIKIAlmaQpAQCAtMjYyLDEzICsyNjMsNyBA
QCBjbWRfaW5pdCgpCiAJCXRlc3QgLXogIiR1cmwiICYmCiAJCWRpZSAiTm8gdXJsIGZvdW5kIGZv
ciBzdWJtb2R1bGUgcGF0aCAnJHBhdGgnIGluIC5naXRtb2R1bGVzIgogCi0JCSMgUG9zc2libHkg
YSB1cmwgcmVsYXRpdmUgdG8gcGFyZW50Ci0JCWNhc2UgIiR1cmwiIGluCi0JCS4vKnwuLi8qKQot
CQkJdXJsPSIkKHJlc29sdmVfcmVsYXRpdmVfdXJsICIkdXJsIikiCi0JCQk7OwotCQllc2FjCi0K
KwkJdXJsPSQoYWJzb2x1dGVfdXJsICIkdXJsIikKIAkJZ2l0IGNvbmZpZyBzdWJtb2R1bGUuIiRu
YW1lIi51cmwgIiR1cmwiIHx8CiAJCWRpZSAiRmFpbGVkIHRvIHJlZ2lzdGVyIHVybCBmb3Igc3Vi
bW9kdWxlIHBhdGggJyRwYXRoJyIKIApkaWZmIC0tZ2l0IGEvdC90NzQwMC1zdWJtb2R1bGUtYmFz
aWMuc2ggYi90L3Q3NDAwLXN1Ym1vZHVsZS1iYXNpYy5zaAppbmRleCAyZWY4NWE4Li5lNWQ1OWI4
IDEwMDc1NQotLS0gYS90L3Q3NDAwLXN1Ym1vZHVsZS1iYXNpYy5zaAorKysgYi90L3Q3NDAwLXN1
Ym1vZHVsZS1iYXNpYy5zaApAQCAtNzUsNyArNzUsNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICdp
bml0IHNob3VsZCByZWdpc3RlciBzdWJtb2R1bGUgdXJsIGluIC5naXQvY29uZmlnJyAnCiAJdGhl
bgogCQllY2hvICJbT09QU10gaW5pdCBzdWNjZWVkZWQgYnV0IHN1Ym1vZHVsZSB1cmwgaXMgd3Jv
bmciCiAJCWZhbHNlCi0JZWxpZiAhIGdpdCBjb25maWcgc3VibW9kdWxlLmV4YW1wbGUudXJsIC4v
LnN1YnJlcG8KKwllbGlmICEgZ2l0IGNvbmZpZyBzdWJtb2R1bGUuZXhhbXBsZS51cmwgLnN1YnJl
cG8KIAl0aGVuCiAJCWVjaG8gIltPT1BTXSBpbml0IHN1Y2NlZWRlZCBidXQgdXBkYXRlIG9mIHVy
bCBmYWlsZWQiCiAJCWZhbHNlCi0tIAoxLjUuNS43MC5nZDY4YQoK
------=_Part_7001_24404357.1208875126942--
