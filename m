From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0.5/4] t4041 (diff-submodule-option): don't hardcode SHA-1
 in expected outputs
Date: Tue, 27 Nov 2012 14:42:03 +0530
Message-ID: <CALkWK0=-zCJnsmoOSJWKnK7fGVwq+yFi47VKotH37GurgxzvCw@mail.gmail.com>
References: <CALkWK0=0SfOuKRZvgt=BOBsKTXtaO5Y7-wAWK4XftE_aY9idyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec550a988aef7b004cf76725b
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 10:12:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdHDe-0000V4-PF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 10:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527Ab2K0JM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 04:12:26 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38208 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758478Ab2K0JMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 04:12:24 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so12230170oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=a8szG2geiiQqrp5BLqWUq2PXP3GUbUzuDxWL8vQgjxI=;
        b=LwY1CdOrcVkylA32sS00CYqv7wwC6R5JJR+1qa3x2uLGGvEKgEn1i9wUqcCCJKg8F8
         w0fK/fzaSa8qKN0mySbif2R7kc7KQwVtdpSBSa8mSgeM6KYJxGHrEmEEWmQzE7JcWxRA
         zSu7i0DPGijh6tet1R71VYbBCr4EECqBpTfD3Q/Cfrkf/smgk+n4PlNaRdD4yf7Cc8Wz
         NBKdgJrzOLxFoUrEtiRRMwcBkLrc56YiO8tDPU6Z7O3p32WNIFbgR05aWUGDfAOurWU7
         7fvW1vFW4LsB4qNsS1XUIsQHPONfBqcX+wvRBP8gllO8gwlTrPbXzzBowwFuCE0i7WLF
         b//g==
Received: by 10.60.171.201 with SMTP id aw9mr11718988oec.126.1354007544002;
 Tue, 27 Nov 2012 01:12:24 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Tue, 27 Nov 2012 01:12:03 -0800 (PST)
In-Reply-To: <CALkWK0=0SfOuKRZvgt=BOBsKTXtaO5Y7-wAWK4XftE_aY9idyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210552>

--bcaec550a988aef7b004cf76725b
Content-Type: text/plain; charset=UTF-8

Ugh, line wrapping breaks my patch.  I've attached a copy.

Ram

--bcaec550a988aef7b004cf76725b
Content-Type: application/octet-stream; 
	name="0001-t4041-diff-submodule-option-don-t-hardcode-SHA-1-in-.patch"
Content-Disposition: attachment; 
	filename="0001-t4041-diff-submodule-option-don-t-hardcode-SHA-1-in-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha0t3a3v0

RnJvbSA5MGJjNzViNzhhNmRkNWU1OWQyMDU1YjA1YzA2NTQ0N2JmMDUxYmI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwu
Y29tPgpEYXRlOiBNb24sIDI2IE5vdiAyMDEyIDE5OjI0OjI4ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gdDQwNDEgKGRpZmYtc3VibW9kdWxlLW9wdGlvbik6IGRvbid0IGhhcmRjb2RlIFNIQS0xIGlu
CiBleHBlY3RlZCBvdXRwdXRzCgpUaGUgZXhwZWN0ZWQgU0hBLTEgZGlnZXN0cyBhcmUgYWx3YXlz
IGF2YWlsYWJsZSBpbiB2YXJpYWJsZXMuICBVc2UKdGhlbSBpbnN0ZWFkIG9mIGhhcmRjb2Rpbmcu
CgpTaWduZWQtb2ZmLWJ5OiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwuY29t
PgotLS0KIHQvdDQwNDEtZGlmZi1zdWJtb2R1bGUtb3B0aW9uLnNoIHwgMTAgKysrKystLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS90L3Q0MDQxLWRpZmYtc3VibW9kdWxlLW9wdGlvbi5zaCBiL3QvdDQwNDEtZGlmZi1zdWJt
b2R1bGUtb3B0aW9uLnNoCmluZGV4IDU3ZThhOWQuLjUzNzc2MzkgMTAwNzU1Ci0tLSBhL3QvdDQw
NDEtZGlmZi1zdWJtb2R1bGUtb3B0aW9uLnNoCisrKyBiL3QvdDQwNDEtZGlmZi1zdWJtb2R1bGUt
b3B0aW9uLnNoCkBAIC02Miw3ICs2Miw3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJy0tc3VibW9k
dWxlPXNob3J0IG92ZXJyaWRlcyBkaWZmLnN1Ym1vZHVsZScgIgogCWNhdCA+ZXhwZWN0ZWQgPDwt
RU9GICYmCiBkaWZmIC0tZ2l0IGEvc20xIGIvc20xCiBuZXcgZmlsZSBtb2RlIDE2MDAwMAotaW5k
ZXggMDAwMDAwMC4uYTJjNGRhYgoraW5kZXggMDAwMDAwMC4uJGhlYWQxCiAtLS0gL2Rldi9udWxs
CiArKysgYi9zbTEKIEBAIC0wLDAgKzEgQEAKQEAgLTc3LDcgKzc3LDcgQEAgdGVzdF9leHBlY3Rf
c3VjY2VzcyAnZGlmZi5zdWJtb2R1bGUgZG9lcyBub3QgYWZmZWN0IHBsdW1iaW5nJyAnCiAJY2F0
ID5leHBlY3RlZCA8PC1FT0YgJiYKIAlkaWZmIC0tZ2l0IGEvc20xIGIvc20xCiAJbmV3IGZpbGUg
bW9kZSAxNjAwMDAKLQlpbmRleCAwMDAwMDAwLi5hMmM0ZGFiCisJaW5kZXggMDAwMDAwMC4uJGhl
YWQxCiAJLS0tIC9kZXYvbnVsbAogCSsrKyBiL3NtMQogCUBAIC0wLDAgKzEgQEAKQEAgLTE3Mywx
MCArMTczLDEwIEBAIG12IHNtMS1iYWsgc20xCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICd0eXBlY2hh
bmdlZCBzdWJtb2R1bGUoc3VibW9kdWxlLT5ibG9iKSwgLS1jYWNoZWQnICIKIAlnaXQgZGlmZiAt
LXN1Ym1vZHVsZT1sb2cgLS1jYWNoZWQgPmFjdHVhbCAmJgogCWNhdCA+ZXhwZWN0ZWQgPDwtRU9G
ICYmCi1TdWJtb2R1bGUgc20xIDQxZmJlYTkuLi4wMDAwMDAwIChzdWJtb2R1bGUgZGVsZXRlZCkK
K1N1Ym1vZHVsZSBzbTEgJGhlYWQ0Li4uMDAwMDAwMCAoc3VibW9kdWxlIGRlbGV0ZWQpCiBkaWZm
IC0tZ2l0IGEvc20xIGIvc20xCiBuZXcgZmlsZSBtb2RlIDEwMDY0NAotaW5kZXggMDAwMDAwMC4u
OWRhNWZiOAoraW5kZXggMDAwMDAwMC4uJGhlYWQ1CiAtLS0gL2Rldi9udWxsCiArKysgYi9zbTEK
IEBAIC0wLDAgKzEgQEAKQEAgLTE5MCw3ICsxOTAsNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICd0
eXBlY2hhbmdlZCBzdWJtb2R1bGUoc3VibW9kdWxlLT5ibG9iKScgIgogCWNhdCA+ZXhwZWN0ZWQg
PDwtRU9GICYmCiBkaWZmIC0tZ2l0IGEvc20xIGIvc20xCiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2
NDQKLWluZGV4IDlkYTVmYjguLjAwMDAwMDAKK2luZGV4ICRoZWFkNS4uMDAwMDAwMAogLS0tIGEv
c20xCiArKysgL2Rldi9udWxsCiBAQCAtMSArMCwwIEBACi0tIAoxLjcuMTIuMS40MjguZzY1MjM5
OGEuZGlydHkKCg==
--bcaec550a988aef7b004cf76725b--
