From: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password 
	scrambling.
Date: Thu, 13 Aug 2009 21:19:57 +0200
Message-ID: <4da546dc0908131219q149844abi453d8429847af1cf@mail.gmail.com>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com> 
	<20090410093434.6117@nanako3.lavabit.com> <7vhc0udiac.fsf@gitster.siamese.dyndns.org> 
	<alpine.DEB.1.00.0908131837110.7429@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174be27065354304710ad3c4
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbfqh-0006D1-E8
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZHMTUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbZHMTUT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:20:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:45516 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZHMTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:20:17 -0400
Received: by ewy10 with SMTP id 10so1025281ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4zUBROrxvetnWtKJzOCvm8xy+1V98DWV00VfBZPG6Q8=;
        b=iNg1MuCIbfX7oIjhZJkxStJLg2bmQK15IgHgLF6ZhtqEZ3mku2155wtOMo7z7dg0uq
         40WqHlxveqKvlC6Q/oR5y2TPtiq8LujMOUoDCV5nPfpE4QZXh8QgOy+H1nqwBv6c2YY4
         nE7104XGYybBeXVnmVxWgHiSKs2eWjMBh6vuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OsxjGvIE+S+US4c/z8uI6daV3sy56cCZag7JwlT6qm+pBpe6bU6Nsl5eh/ikZfqJ06
         80WPS8Aaj05CCdQAZtIUfHewlcoEZ5ECeLWPJuZtcOuxduRawvSocdaBmnLniKIx17WR
         7vsAmzyqBEJis75VPlGNc8t2BR9w4Zyl+89jM=
Received: by 10.210.12.13 with SMTP id 13mr4431948ebl.12.1250191217079; Thu, 
	13 Aug 2009 12:20:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908131837110.7429@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125854>

--0015174be27065354304710ad3c4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

sorry for the long delay, but I finally sat down, hacked two testcases
and amended the patch after rebasing to the most recent HEAD. Find it
attached to this mail.

Ciao,
Dirk

On Thu, Aug 13, 2009 at 6:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Sat, 11 Apr 2009, Junio C Hamano wrote:
>
> > Nanako Shiraishi <nanako3@lavabit.com> writes:
> >
> > > Quoting Dirk H=F6rner:
> > >
> > >> Instead of a cleartext password, the CVS pserver expects a scrambled=
 one
> > >> in the authentication request. With this patch it is possible to imp=
ort
> > >> CVS repositories only accessible via pserver and user/password.
> > >>
> > >> Signed-off-by: Dirk Hoerner <dirker@gmail.com>
> > >
> > > Junio, may I ask what happened to this patch?
> >
> > I do not use cvs emulation myself, nor pserver access, and I actually h=
ave
> > been waiting for people who do use pserver access to report breakages a=
nd
> > people pointing this patch out.
>
> I really think it would be good if this patch was amended with a simple
> and quick test. Using the stdin/stdout server method, it should not be
> hard.
>
> Ciao,
> Dscho

--0015174be27065354304710ad3c4
Content-Type: application/octet-stream; 
	name="0001-git-cvsimport-add-support-for-cvs-pserver-password-s.patch"
Content-Disposition: attachment; 
	filename="0001-git-cvsimport-add-support-for-cvs-pserver-password-s.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fybvjtt40

RnJvbSAyZjNkZWVhNDBkZWYwNDI4NmYwNDgzYmQzM2E1NzU2YWMyMzM4MzhhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEaXJrIEhvZXJuZXIgPGRpcmtlckBnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMjggTm92IDIwMDggMTk6MTE6MzggKzAyMDAKU3ViamVjdDogW1BBVENIXSBnaXQtY3Zz
aW1wb3J0OiBhZGQgc3VwcG9ydCBmb3IgY3ZzIHBzZXJ2ZXIgcGFzc3dvcmQgc2NyYW1ibGluZy4K
Ckluc3RlYWQgb2YgYSBjbGVhcnRleHQgcGFzc3dvcmQsIHRoZSBDVlMgcHNlcnZlciBleHBlY3Rz
IGEgc2NyYW1ibGVkIG9uZQppbiB0aGUgYXV0aGVudGljYXRpb24gcmVxdWVzdC4gV2l0aCB0aGlz
IHBhdGNoIGl0IGlzIHBvc3NpYmxlIHRvIGltcG9ydApDVlMgcmVwb3NpdG9yaWVzIG9ubHkgYWNj
ZXNzaWJsZSB2aWEgcHNlcnZlciBhbmQgdXNlci9wYXNzd29yZC4KClNpZ25lZC1vZmYtYnk6IERp
cmsgSG9lcm5lciA8ZGlya2VyQGdtYWlsLmNvbT4KLS0tCiBnaXQtY3ZzaW1wb3J0LnBlcmwgICB8
ICAgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiB0L3Q5NjAwLWN2
c2ltcG9ydC5zaCB8ICAgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9naXQtY3ZzaW1wb3J0LnBlcmwgYi9naXQtY3ZzaW1wb3J0LnBlcmwKaW5kZXgg
ZTQzOTIwMi4uNTkzODMyZCAxMDA3NTUKLS0tIGEvZ2l0LWN2c2ltcG9ydC5wZXJsCisrKyBiL2dp
dC1jdnNpbXBvcnQucGVybApAQCAtMjUyLDcgKzI1Miw4IEBAIHN1YiBjb25uIHsKIAkJCQl9CiAJ
CQl9OwogCQl9Ci0JCSRwYXNzPSJBIiB1bmxlc3MgJHBhc3M7CisKKwkJJHBhc3MgPSAkc2VsZi0+
X3NjcmFtYmxlKCRwYXNzKTsKIAogCQlteSAoJHMsICRyZXApOwogCQlpZiAoJHByb3h5aG9zdCkg
ewpAQCAtNDg0LDYgKzQ4NSw0MiBAQCBzdWIgX2ZldGNoZmlsZSB7CiAJcmV0dXJuICRyZXM7CiB9
CiAKK3N1YiBfc2NyYW1ibGUgeworCW15ICgkc2VsZiwgJHBhc3MpID0gQF87CisJbXkgJHNjcmFt
YmxlZCA9ICJBIjsKKworCXJldHVybiAkc2NyYW1ibGVkIHVubGVzcyAkcGFzczsKKworCW15ICRw
YXNzX2xlbiA9IGxlbmd0aCgkcGFzcyk7CisJbXkgQHBhc3NfYXJyID0gc3BsaXQoIiIsICRwYXNz
KTsKKwlteSAkaTsKKworCSMgZnJvbSBjdnMvc3JjL3NjcmFtYmxlLmMKKwlteSBAc2hpZnRzID0g
KAorCQkgIDAsICAxLCAgMiwgIDMsICA0LCAgNSwgIDYsICA3LCAgOCwgIDksIDEwLCAxMSwgMTIs
IDEzLCAxNCwgMTUsCisJCSAxNiwgMTcsIDE4LCAxOSwgMjAsIDIxLCAyMiwgMjMsIDI0LCAyNSwg
MjYsIDI3LCAyOCwgMjksIDMwLCAzMSwKKwkJMTE0LDEyMCwgNTMsIDc5LCA5NiwxMDksIDcyLDEw
OCwgNzAsIDY0LCA3NiwgNjcsMTE2LCA3NCwgNjgsIDg3LAorCQkxMTEsIDUyLCA3NSwxMTksIDQ5
LCAzNCwgODIsIDgxLCA5NSwgNjUsMTEyLCA4NiwxMTgsMTEwLDEyMiwxMDUsCisJCSA0MSwgNTcs
IDgzLCA0MywgNDYsMTAyLCA0MCwgODksIDM4LDEwMywgNDUsIDUwLCA0MiwxMjMsIDkxLCAzNSwK
KwkJMTI1LCA1NSwgNTQsIDY2LDEyNCwxMjYsIDU5LCA0NywgOTIsIDcxLDExNSwgNzgsIDg4LDEw
NywxMDYsIDU2LAorCQkgMzYsMTIxLDExNywxMDQsMTAxLDEwMCwgNjksIDczLCA5OSwgNjMsIDk0
LCA5MywgMzksIDM3LCA2MSwgNDgsCisJCSA1OCwxMTMsIDMyLCA5MCwgNDQsIDk4LCA2MCwgNTEs
IDMzLCA5NywgNjIsIDc3LCA4NCwgODAsIDg1LDIyMywKKwkJMjI1LDIxNiwxODcsMTY2LDIyOSwx
ODksMjIyLDE4OCwxNDEsMjQ5LDE0OCwyMDAsMTg0LDEzNiwyNDgsMTkwLAorCQkxOTksMTcwLDE4
MSwyMDQsMTM4LDIzMiwyMTgsMTgzLDI1NSwyMzQsMjIwLDI0NywyMTMsMjAzLDIyNiwxOTMsCisJ
CTE3NCwxNzIsMjI4LDI1MiwyMTcsMjAxLDEzMSwyMzAsMTk3LDIxMSwxNDUsMjM4LDE2MSwxNzks
MTYwLDIxMiwKKwkJMjA3LDIyMSwyNTQsMTczLDIwMiwxNDYsMjI0LDE1MSwxNDAsMTk2LDIwNSwx
MzAsMTM1LDEzMywxNDMsMjQ2LAorCQkxOTIsMTU5LDI0NCwyMzksMTg1LDE2OCwyMTUsMTQ0LDEz
OSwxNjUsMTgwLDE1NywxNDcsMTg2LDIxNCwxNzYsCisJCTIyNywyMzEsMjE5LDE2OSwxNzUsMTU2
LDIwNiwxOTgsMTI5LDE2NCwxNTAsMjEwLDE1NCwxNzcsMTM0LDEyNywKKwkJMTgyLDEyOCwxNTgs
MjA4LDE2MiwxMzIsMTY3LDIwOSwxNDksMjQxLDE1MywyNTEsMjM3LDIzNiwxNzEsMTk1LAorCQky
NDMsMjMzLDI1MywyNDAsMTk0LDI1MCwxOTEsMTU1LDE0MiwxMzcsMjQ1LDIzNSwxNjMsMjQyLDE3
OCwxNTIKKwkpOworCisJZm9yICgkaSA9IDA7ICRpIDwgJHBhc3NfbGVuOyAkaSsrKSB7CisJCSRz
Y3JhbWJsZWQgLj0gcGFjaygiQyIsICRzaGlmdHNbb3JkKCRwYXNzX2FyclskaV0pXSk7CisJfQor
CisJcmV0dXJuICRzY3JhbWJsZWQ7Cit9CiAKIHBhY2thZ2UgbWFpbjsKIApkaWZmIC0tZ2l0IGEv
dC90OTYwMC1jdnNpbXBvcnQuc2ggYi90L3Q5NjAwLWN2c2ltcG9ydC5zaAppbmRleCAzNjMzNDVm
Li41N2MwZWFjIDEwMDc1NQotLS0gYS90L3Q5NjAwLWN2c2ltcG9ydC5zaAorKysgYi90L3Q5NjAw
LWN2c2ltcG9ydC5zaApAQCAtMTI4LDQgKzEyOCw0NSBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICdp
bXBvcnQgZnJvbSBhIENWUyB3b3JraW5nIHRyZWUnICcKIAogdGVzdF9leHBlY3Rfc3VjY2VzcyAn
dGVzdCBlbnRpcmUgSEVBRCcgJ3Rlc3RfY21wX2JyYW5jaF90cmVlIG1hc3RlcicKIAoraWYgISB0
eXBlIG5jID4vZGV2L251bGwgMj4mMQordGhlbgorCXNheSAnc2tpcHBpbmcgY3ZzaW1wb3J0IHBz
ZXJ2ZXIgdGVzdCwgbmMgbm90IGZvdW5kJworCXRlc3RfZG9uZQorCWV4aXQKK2ZpCisKK2NhdCA8
PCBFT0YgPmV4cGVjdGVkCitCRUdJTiBBVVRIIFJFUVVFU1QKKy9jdnMKK21lCitBeXVoZWRFSWM/
Xl0nJT0wOnEgWixiPDMhYT4KK0VORCBBVVRIIFJFUVVFU1QKK0VPRgorCit0ZXN0X2V4cGVjdF9z
dWNjZXNzICdjb25uZWN0IHRvIHBzZXJ2ZXIgd2l0aCBwYXNzd29yZCcgJworCisJZWNobyAiSSBI
QVRFIFlPVSIgfCBuYyAtbCAyNDAxID5hY3R1YWwgJgorCXRlc3RfbXVzdF9mYWlsIGdpdCBjdnNp
bXBvcnQgLWQgXAorCQk6cHNlcnZlcjptZTphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ekBsb2Nh
bGhvc3Q6L2N2cyBmb28gXAorCQk+L2Rldi9udWxsIDI+JjEgJiYKKwl0ZXN0X2NtcCBleHBlY3Rl
ZCBhY3R1YWwKKycKKworY2F0IDw8IEVPRiA+ZXhwZWN0ZWQKK0JFR0lOIEFVVEggUkVRVUVTVAor
L2N2cworYW5vbnltb3VzCitBCitFTkQgQVVUSCBSRVFVRVNUCitFT0YKKwordGVzdF9leHBlY3Rf
c3VjY2VzcyAnY29ubmVjdCB0byBwc2VydmVyIHdpdGhvdXQgcGFzc3dvcmQnICcKKworCWVjaG8g
IkkgSEFURSBZT1UiIHwgbmMgLWwgMjQwMSA+YWN0dWFsICYKKwl0ZXN0X211c3RfZmFpbCBnaXQg
Y3ZzaW1wb3J0IC1kIFwKKwkJOnBzZXJ2ZXI6YW5vbnltb3VzQGxvY2FsaG9zdDovY3ZzIGZvbyBc
CisJCT4vZGV2L251bGwgMj4mMSAmJgorCXRlc3RfY21wIGV4cGVjdGVkIGFjdHVhbAorJworCiB0
ZXN0X2RvbmUKLS0gCjEuNi40Cgo=
--0015174be27065354304710ad3c4--
