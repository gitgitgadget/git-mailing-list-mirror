From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 16:42:28 +0100
Message-ID: <b0943d9e050922084232f704d@mail.gmail.com>
References: <433107C7.60901@drzeus.cx>
	 <b0943d9e05092101033dd5d366@mail.gmail.com>
	 <433290A5.5070008@drzeus.cx> <tnxhdcd2tfn.fsf@arm.com>
	 <4332BA3E.2080607@drzeus.cx> <tnxr7bh188q.fsf@arm.com>
	 <4332C880.1060906@drzeus.cx>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9029_16492160.1127403748298"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 17:45:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITDU-0001PE-3g
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbVIVPm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIVPm3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:42:29 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:50422 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030409AbVIVPm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 11:42:29 -0400
Received: by xproxy.gmail.com with SMTP id i30so486206wxd
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 08:42:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FOmT3PhBaYKOeyMu1VbPz2r/nVBsbEYqXVTBEy/PZ28OQc0N4Uxp4mTRuYj6iqQz8Afva+UawGiJePMPer7m7T8CPC/fFjqZs3gQnIEKd9pssU4+BYUSgeBq6GGToJk97ZcJt/vulHZAfi8wxfxygr+Awe/xJq3ci75ocvmDWTE=
Received: by 10.70.53.9 with SMTP id b9mr337998wxa;
        Thu, 22 Sep 2005 08:42:28 -0700 (PDT)
Received: by 10.70.27.20 with HTTP; Thu, 22 Sep 2005 08:42:28 -0700 (PDT)
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <4332C880.1060906@drzeus.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9128>

------=_Part_9029_16492160.1127403748298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 22/09/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Bummer. I checked with the local Python guru here and he suggested
> changing the for loop to an infinite while and f.readline().

It works, thanks for this. I attached a patch if you want to try.

--
Catalin

------=_Part_9029_16492160.1127403748298
Content-Type: application/octet-stream; name="import-stdin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="import-stdin"

Rml4IGltcG9ydGluZyBmcm9tIHN0ZGluCgpUaGUgY3VycmVudCBzdGRpbiBwYXRjaCBpbXBvcnRp
bmcgZXhwZWN0cyB0d28gRU9GcyBzaW5jZSB0aGUgJ2ZvcicgbG9vcApkb2Vzbid0IHN0YXJ0IGJl
Zm9yZSBvbmUgRU9GIGlzIHJlY2VpdmVkLiBBcyBzdWdnZXN0ZWQsIHRoaXMgcGF0Y2ggY2hhbmdl
cwp0aGUgJ2ZvcicgbG9vcCB3aXRoIGEgJ3doaWxlIFRydWUnIGxvb3AuCgpTaWduZWQtb2ZmLWJ5
OiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0BnbWFpbC5jb20+Ci0tLQoKIHN0Z2l0
L2NvbW1hbmRzL2ltcHJ0LnB5IHwgICAgNiArKysrKy0KIHN0Z2l0L2dpdC5weSAgICAgICAgICAg
IHwgICAgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc3RnaXQvY29tbWFuZHMvaW1wcnQucHkgYi9zdGdpdC9jb21t
YW5kcy9pbXBydC5weQotLS0gYS9zdGdpdC9jb21tYW5kcy9pbXBydC5weQorKysgYi9zdGdpdC9j
b21tYW5kcy9pbXBydC5weQpAQCAtMTM0LDcgKzEzNCwxMSBAQCBkZWYgX19wYXJzZV9wYXRjaChm
aWxlbmFtZSA9IE5vbmUpOgogICAgIGF1dGhuYW1lID0gYXV0aGVtYWlsID0gYXV0aGRhdGUgPSBO
b25lCiAKICAgICBkZXNjciA9ICcnCi0gICAgZm9yIGxpbmUgaW4gZjoKKyAgICB3aGlsZSBUcnVl
OgorICAgICAgICBsaW5lID0gZi5yZWFkbGluZSgpCisgICAgICAgIGlmIG5vdCBsaW5lOgorICAg
ICAgICAgICAgYnJlYWsKKwogICAgICAgICAjIHRoZSBmaXJzdCAnU2lnbmVkLW9mLWJ5OicgaXMg
dGhlIGF1dGhvcgogICAgICAgICBpZiBub3QgYXV0aG5hbWUgYW5kIHJlLm1hdGNoKCdzaWduZWQt
b2ZmLWJ5OlxzKycsIGxpbmUsIHJlLkkpOgogICAgICAgICAgICAgYXV0aCA9IHJlLmZpbmRhbGwo
J14uKj86XHMrKC4qKSQnLCBsaW5lKVswXQpkaWZmIC0tZ2l0IGEvc3RnaXQvZ2l0LnB5IGIvc3Rn
aXQvZ2l0LnB5Ci0tLSBhL3N0Z2l0L2dpdC5weQorKysgYi9zdGdpdC9naXQucHkKQEAgLTExMyw3
ICsxMTMsMTAgQEAgZGVmIGdldF9jb25mbGljdHMoKToKIAogZGVmIF9pbnB1dChjbWQsIGZpbGVf
ZGVzYyk6CiAgICAgcCA9IHBvcGVuMi5Qb3BlbjMoY21kKQotICAgIGZvciBsaW5lIGluIGZpbGVf
ZGVzYzoKKyAgICB3aGlsZSBUcnVlOgorICAgICAgICBsaW5lID0gZmlsZV9kZXNjLnJlYWRsaW5l
KCkKKyAgICAgICAgaWYgbm90IGxpbmU6CisgICAgICAgICAgICBicmVhawogICAgICAgICBwLnRv
Y2hpbGQud3JpdGUobGluZSkKICAgICBwLnRvY2hpbGQuY2xvc2UoKQogICAgIGlmIHAud2FpdCgp
Ogo=
------=_Part_9029_16492160.1127403748298--
