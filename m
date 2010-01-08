From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add quiet option to git-ls-files
Date: Fri, 8 Jan 2010 07:47:55 +0530
Message-ID: <f3271551001071817g3e8dd85cya090be715ae48240@mail.gmail.com>
References: <f3271551001071137u6158fa4fm1bf7a51a83354574@mail.gmail.com> 
	<7v1vi14qiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b80f2d8dd63047c9dcccb
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 03:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Qe-0006iu-U2
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0AHCSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172Ab0AHCSR
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:18:17 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:55773 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0AHCSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:18:16 -0500
Received: by gxk3 with SMTP id 3so8204057gxk.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ORuBkaN+fZ6uMESUAtp96FM5U9KCyuFmvRhALXJ90O4=;
        b=DrgfyRSxcmIVlO10F2hTOCCYXJWtC7yPLh2t+7eVnlR8CQKymDGdZ/OgnAM2PMozMm
         eF3w/kom7XnnoNxzOvVjX6TGE+6Jtosu1HmSooGVZ6jj3AGtEd7esSBAdztw87x5XWlK
         Y1+6qO+ejBy8QAgiM6V0TX+gYlwBlZDuJCLvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JIEdaEC9JBuH1+fWxqyovCb8XTmrLKWU6udHcr/w2StXmUh5hjUc6F1jQEMH+tiBOq
         SNTvv2u8n+LpM7KFYmen8W08xahDr6Gjx1Qf4qjjtzQfnN5mkUgxiqAbuaaOYFxlgHQs
         7gR6ZDSlg+uwcFfFlKQ70xsg2iH1yQ8Ol+snI=
Received: by 10.91.16.25 with SMTP id t25mr7076284agi.118.1262917095316; Thu, 
	07 Jan 2010 18:18:15 -0800 (PST)
In-Reply-To: <7v1vi14qiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136412>

--0016363b80f2d8dd63047c9dcccb
Content-Type: text/plain; charset=ISO-8859-1

> The code doesn't seem to match the claim.

I'm sorry- That was horribly sloppy of me. I figured that passing
`quiet' to report_path_error would break too many things, so I've
dropped that patch altogether. I've removed the reference to ls-files
--quiet in my second patch ( viz.
0002-Replace-redirect-to-dev-null-in-favor-of-quiet-optio.patch) and
attached version 2.

Thanks and regards,
Ramkumar

--0016363b80f2d8dd63047c9dcccb
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-Replace-redirect-to-dev-null-in-favor-of-quiet-optio.patch"
Content-Disposition: attachment; 
	filename="0002-Replace-redirect-to-dev-null-in-favor-of-quiet-optio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g46by6bx0

RnJvbSBjMzRjNzI4MDE4MDRkYTYxMTY5YWI2ODY2ZDZjZTI2MmVhNmNmNWMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwu
Y29tPgpEYXRlOiBGcmksIDggSmFuIDIwMTAgMDc6MzI6MjkgKzA1MzAKU3ViamVjdDogW1BBVENI
IHYyXSBSZXBsYWNlIHJlZGlyZWN0IHRvIC9kZXYvbnVsbCBpbiBmYXZvciBvZiBxdWlldCBvcHRp
b24KClNpZ25lZC1vZmYtYnk6IFJhbWt1bWFyIFJhbWFjaGFuZHJhIDxhcnRhZ25vbkBnbWFpbC5j
b20+Ci0tLQogZ2l0LW1lcmdldG9vbC5zaCB8ICAgIDIgKy0KIGdpdC1wdWxsLnNoICAgICAgfCAg
ICAyICstCiBnaXQtcmViYXNlLnNoICAgIHwgICAgMiArLQogZ2l0LXN0YXNoLnNoICAgICB8ICAg
MTIgKysrKysrLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9naXQtbWVyZ2V0b29sLnNoIGIvZ2l0LW1lcmdldG9vbC5z
aAppbmRleCBiNTJhNzQxLi4xYzkwMmFhIDEwMDc1NQotLS0gYS9naXQtbWVyZ2V0b29sLnNoCisr
KyBiL2dpdC1tZXJnZXRvb2wuc2gKQEAgLTEwMSw3ICsxMDEsNyBAQCByZXNvbHZlX2RlbGV0ZWRf
bWVyZ2UgKCkgewogCQlyZXR1cm4gMAogCQk7OwogCSAgICBbZERdKikKLQkJZ2l0IHJtIC0tICIk
TUVSR0VEIiA+IC9kZXYvbnVsbAorCQlnaXQgcm0gLS1xdWlldCAtLSAiJE1FUkdFRCIKIAkJY2xl
YW51cF90ZW1wX2ZpbGVzCiAJCXJldHVybiAwCiAJCTs7CmRpZmYgLS1naXQgYS9naXQtcHVsbC5z
aCBiL2dpdC1wdWxsLnNoCmluZGV4IDllNjlhZGEuLjMzNmU5MWEgMTAwNzU1Ci0tLSBhL2dpdC1w
dWxsLnNoCisrKyBiL2dpdC1wdWxsLnNoCkBAIC0xNzAsNyArMTcwLDcgQEAgdGVzdCB0cnVlID0g
IiRyZWJhc2UiICYmIHsKIAkuIGdpdC1wYXJzZS1yZW1vdGUgJiYKIAlyZW1vdGVyZWY9IiQoZ2V0
X3JlbW90ZV9tZXJnZV9icmFuY2ggIiRAIiAyPi9kZXYvbnVsbCkiICYmCiAJb2xkcmVtb3RlcmVm
PSIkKGdpdCByZXYtcGFyc2UgLXEgLS12ZXJpZnkgIiRyZW1vdGVyZWYiKSIgJiYKLQlmb3IgcmVm
bG9nIGluICQoZ2l0IHJldi1saXN0IC1nICRyZW1vdGVyZWYgMj4vZGV2L251bGwpCisJZm9yIHJl
ZmxvZyBpbiAkKGdpdCByZXYtbGlzdCAtLXF1aWV0IC0td2Fsay1yZWZsb2dzICRyZW1vdGVyZWYp
CiAJZG8KIAkJaWYgdGVzdCAiJHJlZmxvZyIgPSAiJChnaXQgbWVyZ2UtYmFzZSAkcmVmbG9nICRj
dXJyX2JyYW5jaCkiCiAJCXRoZW4KZGlmZiAtLWdpdCBhL2dpdC1yZWJhc2Uuc2ggYi9naXQtcmVi
YXNlLnNoCmluZGV4IGIxMjFmNDUuLmJmZTA0NzUgMTAwNzU1Ci0tLSBhL2dpdC1yZWJhc2Uuc2gK
KysrIGIvZ2l0LXJlYmFzZS5zaApAQCAtMTAwLDcgKzEwMCw3IEBAIGNhbGxfbWVyZ2UgKCkgewog
CWNtdD0iJChjYXQgIiRkb3Rlc3QvY210LiQxIikiCiAJZWNobyAiJGNtdCIgPiAiJGRvdGVzdC9j
dXJyZW50IgogCWhkPSQoZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSBIRUFEKQotCWNtdF9uYW1lPSQo
Z2l0IHN5bWJvbGljLXJlZiBIRUFEIDI+IC9kZXYvbnVsbCB8fCBlY2hvIEhFQUQpCisJY210X25h
bWU9JChnaXQgc3ltYm9saWMtcmVmIC0tcXVpZXQgSEVBRCB8fCBlY2hvIEhFQUQpCiAJbXNnbnVt
PSQoY2F0ICIkZG90ZXN0L21zZ251bSIpCiAJZW5kPSQoY2F0ICIkZG90ZXN0L2VuZCIpCiAJZXZh
bCBHSVRIRUFEXyRjbXQ9JyIke2NtdF9uYW1lIyNyZWZzL2hlYWRzL31+JCgoJGVuZCAtICRtc2du
dW0pKSInCmRpZmYgLS1naXQgYS9naXQtc3Rhc2guc2ggYi9naXQtc3Rhc2guc2gKaW5kZXggM2Ew
Njg1Zi4uNTYwNWQxOSAxMDA3NTUKLS0tIGEvZ2l0LXN0YXNoLnNoCisrKyBiL2dpdC1zdGFzaC5z
aApAQCAtMzksNyArMzksNyBAQCBjbGVhcl9zdGFzaCAoKSB7CiAJdGhlbgogCQlkaWUgImdpdCBz
dGFzaCBjbGVhciB3aXRoIHBhcmFtZXRlcnMgaXMgdW5pbXBsZW1lbnRlZCIKIAlmaQotCWlmIGN1
cnJlbnQ9JChnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICRyZWZfc3Rhc2ggMj4vZGV2L251bGwpCisJ
aWYgY3VycmVudD0kKGdpdCByZXYtcGFyc2UgLS1xdWlldCAtLXZlcmlmeSAkcmVmX3N0YXNoKQog
CXRoZW4KIAkJZ2l0IHVwZGF0ZS1yZWYgLWQgJHJlZl9zdGFzaCAkY3VycmVudAogCWZpCkBAIC0y
MDAsNyArMjAwLDcgQEAgc2F2ZV9zdGFzaCAoKSB7CiB9CiAKIGhhdmVfc3Rhc2ggKCkgewotCWdp
dCByZXYtcGFyc2UgLS12ZXJpZnkgJHJlZl9zdGFzaCA+L2Rldi9udWxsIDI+JjEKKwlnaXQgcmV2
LXBhcnNlIC0tcXVpZXQgLS12ZXJpZnkgJHJlZl9zdGFzaCA+L2Rldi9udWxsCiB9CiAKIGxpc3Rf
c3Rhc2ggKCkgewpAQCAtMzM3LDE2ICszMzcsMTYgQEAgZHJvcF9zdGFzaCAoKSB7CiAJZmkKIAkj
IFZlcmlmeSBzdXBwbGllZCBhcmd1bWVudCBsb29rcyBsaWtlIGEgc3Rhc2ggZW50cnkKIAlzPSQo
Z2l0IHJldi1wYXJzZSAtLXZlcmlmeSAiJEAiKSAmJgotCWdpdCByZXYtcGFyc2UgLS12ZXJpZnkg
IiRzOiIgICA+IC9kZXYvbnVsbCAyPiYxICYmCi0JZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSAiJHNe
MToiID4gL2Rldi9udWxsIDI+JjEgJiYKLQlnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICIkc14yOiIg
PiAvZGV2L251bGwgMj4mMSB8fAorCWdpdCByZXYtcGFyc2UgLS1xdWlldCAtLXZlcmlmeSAiJHM6
IiAgID4gL2Rldi9udWxsICYmCisJZ2l0IHJldi1wYXJzZSAtLXF1aWV0IC0tdmVyaWZ5ICIkc14x
OiIgPiAvZGV2L251bGwgJiYKKwlnaXQgcmV2LXBhcnNlIC0tcXVpZXQgLS12ZXJpZnkgIiRzXjI6
IiA+IC9kZXYvbnVsbCB8fAogCQlkaWUgIiQqOiBub3QgYSB2YWxpZCBzdGFzaGVkIHN0YXRlIgog
CiAJZ2l0IHJlZmxvZyBkZWxldGUgLS11cGRhdGVyZWYgLS1yZXdyaXRlICIkQCIgJiYKIAkJc2F5
ICJEcm9wcGVkICQqICgkcykiIHx8IGRpZSAiJCo6IENvdWxkIG5vdCBkcm9wIHN0YXNoIGVudHJ5
IgogCiAJIyBjbGVhcl9zdGFzaCBpZiB3ZSBqdXN0IGRyb3BwZWQgdGhlIGxhc3Qgc3Rhc2ggZW50
cnkKLQlnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICIkcmVmX3N0YXNoQHswfSIgPiAvZGV2L251bGwg
Mj4mMSB8fCBjbGVhcl9zdGFzaAorCWdpdCByZXYtcGFyc2UgLS1xdWlldCAtLXZlcmlmeSAiJHJl
Zl9zdGFzaEB7MH0iID4gL2Rldi9udWxsIHx8IGNsZWFyX3N0YXNoCiB9CiAKIGFwcGx5X3RvX2Jy
YW5jaCAoKSB7Ci0tIAoxLjYuNQoK
--0016363b80f2d8dd63047c9dcccb--
