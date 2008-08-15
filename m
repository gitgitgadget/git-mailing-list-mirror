From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix t3700 on filesystems which do not support question marks in names
Date: Fri, 15 Aug 2008 09:32:30 +0200
Message-ID: <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
	 <7vproabvcr.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_114533_21022852.1218785550055"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Kevin Ballard" <kevin@sb.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:34:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTtot-0001X0-VI
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 09:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYHOHcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYHOHcb
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 03:32:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:12380 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYHOHca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 03:32:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so824473rvb.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=1qHGjO6KlNDGM96249zzdT1cUj44IhKDnbdUGPBAJGg=;
        b=PrYOUMG5nHUFZfGZbMab9iBitAf3X0mjunna0KNlWxLAmDV1qnSfMB5ERCzu39wpC8
         ZEpCgUTIJt5oNVaa/i8xHAfT528qbr0gkAwk0YvU9BcbUCwEwmdBIFj0lzonCIvXuzsz
         ULn8/4jcypz4IQNswr9x/tJVRgT6l7ww2UnMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=iMbLs4RDQ81Ly9cbSgQGqiQiTVfaLlbgnegw3Je+DjRZ6+XKSBIAQa6i9cvtN/14fG
         4ViX0LMHG+Hqm6O2v2RSjgLKOxzGlBL1zfiQ4lpCldp+++rppJvURYjwcXBIvRioCk4+
         UopP3wtQznOVCGYe7QB16D+fkyEV1UzrXtr8k=
Received: by 10.114.73.1 with SMTP id v1mr2203720waa.166.1218785550047;
        Fri, 15 Aug 2008 00:32:30 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 15 Aug 2008 00:32:30 -0700 (PDT)
In-Reply-To: <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92463>

------=_Part_114533_21022852.1218785550055
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Use square brackets instead.

And the prominent example of the deficiency are, as usual, the filesystems
of Microsoft house.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

2008/8/15 Junio C Hamano <gitster@pobox.com>:
>>> And the prominent example of the deficiency are, as usual, the filesystems
>>> of Microsoft house.
>>
>> Can other glob specials such as '*' or '[' be used instead of skipping the
>> test?
>
> Ah... The brackets are allowed.

Sorry, should have thought of it.

 t/t3700-add.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

------=_Part_114533_21022852.1218785550055
Content-Type: text/x-patch;
 name=0001-Fix-t3700-on-filesystems-which-do-not-support-questi.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fjwhfxti0
Content-Disposition: attachment;
 filename=0001-Fix-t3700-on-filesystems-which-do-not-support-questi.patch

RnJvbSAzYTI1NTI3ZmE2MTQ2M2Q1OTY4NTg2ZWZhMWYzNDc0MDA4YmJlMmQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDE1IEF1ZyAyMDA4IDA5OjAwOjU0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHQz
NzAwIG9uIGZpbGVzeXN0ZW1zIHdoaWNoIGRvIG5vdCBzdXBwb3J0IHF1ZXN0aW9uIG1hcmtzIGlu
IG5hbWVzCgpVc2Ugc3F1YXJlIGJyYWNrZXRzIGluc3RlYWQuCgpBbmQgdGhlIHByb21pbmVudCBl
eGFtcGxlIG9mIHRoZSBkZWZpY2llbmN5IGFyZSwgYXMgdXN1YWwsIHRoZSBmaWxlc3lzdGVtcwpv
ZiBNaWNyb3NvZnQgaG91c2UuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxA
Z21haWwuY29tPgotLS0KIHQvdDM3MDAtYWRkLnNoIHwgICAgOCArKysrLS0tLQogMSBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90
MzcwMC1hZGQuc2ggYi90L3QzNzAwLWFkZC5zaAppbmRleCA3N2E3ODJjLi4yYWM5M2EzIDEwMDc1
NQotLS0gYS90L3QzNzAwLWFkZC5zaAorKysgYi90L3QzNzAwLWFkZC5zaApAQCAtMjIyLDExICsy
MjIsMTEgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGFkZCAoYWRkLmlnbm9yZS1lcnJvcnMg
PSBmYWxzZSknICcKIAkhICggZ2l0IGxzLWZpbGVzIGZvbzEgfCBncmVwIGZvbzEgKQogJwogCi10
ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgYWRkICdcJydmb1w/YmFyJ1wnJyBpZ25vcmVzIGZvb2Jh
cicgJwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGFkZCAnXCcnZm9cW291XF1iYXInXCcnIGln
bm9yZXMgZm9vYmFyJyAnCiAJZ2l0IHJlc2V0IC0taGFyZCAmJgotCXRvdWNoIGZvXD9iYXIgZm9v
YmFyICYmCi0JZ2l0IGFkZCAnXCcnZm9cP2JhcidcJycgJiYKLQlnaXQgbHMtZmlsZXMgZm9cP2Jh
ciB8IGdyZXAgLUYgZm9cP2JhciAmJgorCXRvdWNoIGZvXFtvdVxdYmFyIGZvb2JhciAmJgorCWdp
dCBhZGQgJ1wnJ2ZvXFtvdVxdYmFyJ1wnJyAmJgorCWdpdCBscy1maWxlcyBmb1xbb3VcXWJhciB8
IGdyZXAgLUYgZm9cW291XF1iYXIgJiYKIAkhICggZ2l0IGxzLWZpbGVzIGZvb2JhciB8IGdyZXAg
Zm9vYmFyICkKICcKIAotLSAKMS42LjAucmMyLjY4Lmc0OWZhMwoK
------=_Part_114533_21022852.1218785550055--
