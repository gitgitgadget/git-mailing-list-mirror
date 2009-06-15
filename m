From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Mon, 15 Jun 2009 23:07:07 +0100
Message-ID: <e5bfff550906151507t3f6ccf39j177f7c39d8495f5a@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
	 <200906131333.57725.markus.heidelberg@web.de>
	 <200906152313.20002.markus.heidelberg@web.de>
	 <e5bfff550906151425p2dacdcdasbae09af4ce34813d@mail.gmail.com>
	 <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dbe8896838a3046c6a4780
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Jun 16 00:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGKKl-0007PM-32
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 00:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998AbZFOWHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbZFOWHH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 18:07:07 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:45405 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbZFOWHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 18:07:06 -0400
Received: by ewy6 with SMTP id 6so5432675ewy.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VsdnACN1FnBEZgpNnQEl+3kaRCXe/P+gbtioSZCQp7A=;
        b=EpBY8iBGYnt/Yu2IwpB12McaDHMKiBIZwmyfGBoMrXgzIKBAeqklzNPZRRwIMey1a6
         ejfp6AWDhpJPOAkV0ACF0btQq1xR/FDTmW/v2unfQBoJhVPJRVZOSW6O9yXeFg0UyHpB
         JwufyR3kG+yWaRU4RwDdrL89hFWxTCnLLo6f4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AzLi7MDcRM1fnBhIQ+Xw8TBSPT83pBEqb8QyL5mARj1rMn9465OZn5otwMOIvlBlyV
         e5DKmMObsMx3DDE38K5pCYZSz+uTBZJ58n/kC2shp6Yap/Y3RouzoJNTykVIt/hu6jrU
         Qke91wH9SsWrkKwqo1cq9CgJr9O4RMrzHiVAg=
Received: by 10.216.24.141 with SMTP id x13mr2601445wex.106.1245103627188; 
	Mon, 15 Jun 2009 15:07:07 -0700 (PDT)
In-Reply-To: <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121635>

--0016e6dbe8896838a3046c6a4780
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jun 15, 2009 at 22:45, Marco Costalba<mcostalba@gmail.com> wrote:
> On Mon, Jun 15, 2009 at 22:25, Marco Costalba<mcostalba@gmail.com> wrote:
>>
>> This is really strange !
>>
>

I have prepared a possible patch, could you please test if fixes the
problem for you.

Patch is in attachment.

Thanks
Marco

--0016e6dbe8896838a3046c6a4780
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Fix-format-patch-bad-selected-revision-order.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-format-patch-bad-selected-revision-order.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvzqeiik0

RnJvbSA4ZTRhYzRiZjliNmMwNGIwOWUxNmEyYTQ5Yjk2ZjZiZjRjNzVkMmU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJjbyBDb3N0YWxiYSA8bWNvc3RhbGJhQGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCAxNSBKdW4gMjAwOSAyMzowMTo0MiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEZp
eCBmb3JtYXQgcGF0Y2ggYmFkIHNlbGVjdGVkIHJldmlzaW9uIG9yZGVyCgpXZSBjYW5ub3QgdHJ1
c3QgdGhlIG9yZGVyIG9mIHNlbGVjdGVkIGl0ZW1zIHJldHVybmVkCmJ5IFFJdGVtU2VsZWN0aW9u
TW9kZWw6OnNlbGVjdGVkUm93cygpIHRoYXQgaXMgdXNlZAp0byBjYWxsIGdpdCBmb3JtYXQtcGF0
Y2guCgpJdCBpcyBub3QgZG9jdW1lbnRlZCBhbmQgY291bGQgY2hhbmdlIHdpdGggYSBuZXcgdmVy
c2lvbgpvZiBRdCBsaWJyYXJpZXMuCgpTbyBtYW51YWxseSByZW9yZGVyIHRoZSBzZWxlY3RlZCBy
ZXZpc2lvbnMgYmVmb3JlIHRvIGZlZWQKZ2l0IGZvcm1hdC1wYXRjaC4KClNpZ25lZC1vZmYtYnk6
IE1hcmNvIENvc3RhbGJhIDxtY29zdGFsYmFAZ21haWwuY29tPgotLS0KIHNyYy9naXQuY3BwIHwg
ICAxNSArKysrKysrKysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvZ2l0LmNwcCBiL3NyYy9naXQuY3BwCmlu
ZGV4IDg1NDZmNmYuLmQ1NWQxYzIgMTAwNjQ0Ci0tLSBhL3NyYy9naXQuY3BwCisrKyBiL3NyYy9n
aXQuY3BwCkBAIC0xNTc3LDkgKzE1NzcsMTggQEAgYm9vbCBHaXQ6OmZvcm1hdFBhdGNoKFNDTGlz
dCBzaGFMaXN0LCBTQ1JlZiBkaXJQYXRoLCBTQ1JlZiByZW1vdGVEaXIpIHsKIAlpZiAocmVtb3Rl
KQogCQl3b3JrRGlyID0gcmVtb3RlRGlyOyAvLyBydW4oKSB1c2VzIHdvcmtEaXIgdmFsdWUKIAot
CS8vIHNoYUxpc3QgaXMgb3JkZXJlZCBieSBuZXdlc3QgdG8gb2xkZXN0Ci0JcnVuQ21kLmFwcGVu
ZCgiICIgKyBzaGFMaXN0Lmxhc3QoKSk7Ci0JcnVuQ21kLmFwcGVuZChRU3RyaW5nOjpmcm9tTGF0
aW4xKCJeLi4iKSArIHNoYUxpc3QuZmlyc3QoKSk7CisJLy8gRG9uJ3QgdHJ1c3Qgc2hhTGlzdCBv
cmRlciBidXQgcmVvcmRlciBmcm9tIG5ld2VzdCB0byBvbGRlc3QKKwlRU3RyaW5nTGlzdCBvcmRl
cmVkU2hhTGlzdDsKKwlGT1JFQUNIX1NMIChpdCwgc2hhTGlzdCkKKwkJYXBwZW5kTmFtZXNXaXRo
SWQob3JkZXJlZFNoYUxpc3QsICppdCwgUVN0cmluZ0xpc3QoKml0KSwgdHJ1ZSk7CisKKwlvcmRl
cmVkU2hhTGlzdC5zb3J0KCk7CisJUVN0cmluZ0xpc3Q6Oml0ZXJhdG9yIGl0TihvcmRlcmVkU2hh
TGlzdC5iZWdpbigpKTsKKwlmb3IgKCA7IGl0TiAhPSBvcmRlcmVkU2hhTGlzdC5lbmQoKTsgKytp
dE4pIC8vIHN0cmlwICdpZHgnCisJCSgqaXROKSA9ICgqaXROKS5zZWN0aW9uKCcgJywgLTEsIC0x
KTsKKworCXJ1bkNtZC5hcHBlbmQoIiAiICsgb3JkZXJlZFNoYUxpc3QubGFzdCgpKTsKKwlydW5D
bWQuYXBwZW5kKFFTdHJpbmc6OmZyb21MYXRpbjEoIl4uLiIpICsgb3JkZXJlZFNoYUxpc3QuZmly
c3QoKSk7CiAJYm9vbCByZXQgPSBydW4ocnVuQ21kKTsKIAl3b3JrRGlyID0gdG1wOwogCXJldHVy
biByZXQ7Ci0tIAoxLjYuMS45Lmc5N2MzNAoK
--0016e6dbe8896838a3046c6a4780--
