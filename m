From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 12:42:52 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01CA1CCB.F9A7B75C"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 13:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbud8-0002hY-Fs
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 13:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbZHNLHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 07:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbZHNLHN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 07:07:13 -0400
Received: from raclette.synchrotron-soleil.fr ([195.221.0.6]:56014 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539AbZHNLHM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 07:07:12 -0400
X-Greylist: delayed 1446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2009 07:07:11 EDT
Received: from localhost (unknown [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 662947831E
	for <git@vger.kernel.org>; Fri, 14 Aug 2009 10:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xSUIQNfeIBk for <git@vger.kernel.org>;
	Fri, 14 Aug 2009 12:42:58 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 3BB9578105
	for <git@vger.kernel.org>; Fri, 14 Aug 2009 12:42:58 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: trailling whitespace with git am ?
Thread-Index: AcocyXGyTNGSKhq5RNOOVMuuZCfzFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125924>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1CCB.F9A7B75C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hello

I attached a patch that someone sent to me
the public repository is
http://repo.or.cz/w/diffractometer.git

this patch must be apply on the next branch

but when I try to use
git am, I have this sort of message:

mordor% git am =
/home/picca/Projets/patches/0001-Add-the-POGO-TO-DELETE-comment-to-Comput=
edAnglesClea.patch=20
Applying: 'Add the POGO TO DELETE comment to ComputedAnglesClear =
command'
/tmp/diffractometer/.git/rebase-apply/patch:13: trailing whitespace.

/tmp/diffractometer/.git/rebase-apply/patch:14: trailing whitespace.
	/* POGO TO DELETE */
error: patch failed: src/Diffractometer/Diffractometer.cpp:2023
error: src/Diffractometer/Diffractometer.cpp: patch does not apply
Patch failed at 0001 'Add the POGO TO DELETE comment to =
ComputedAnglesClear command'
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".


so git do not want to apply it.

I was looking in the patch file about thoses trailing whitespace but I =
found nothing
until I rewrote myself this complicate patch :)
then I produced a diff beetween my patch and the original one.

I also attached it.
using emacs/vi I saw immediately the problem... It was a dos/unix file =
format problem. So the first message of git am was no helpfull at all =
for me. It would be nice to detect this format
problem when applying the patch and says something like
this patch is in dos format on an unix platform I can not apply it.

the a short explaination of what solution are possibles for the users.

now the question is:

what must I tell to that person if I want to work with her (as she is =
charming the forget about here is a no op :))
change your editor or is it a git configuration problem ? I suppose she =
is using msygit but I can not affirm this.

thanks

Fr=E9d=E9ric


------_=_NextPart_001_01CA1CCB.F9A7B75C
Content-Type: text/x-patch;
	name="0001-Add-the-POGO-TO-DELETE-comment-to-ComputedAnglesClea.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Add-the-POGO-TO-DELETE-comment-to-ComputedAnglesClea.patch
Content-Disposition: attachment;
	filename="0001-Add-the-POGO-TO-DELETE-comment-to-ComputedAnglesClea.patch"

RnJvbSAyYWQxOWQyMTY2MGU3YTk0Y2JhMGU3ZWFlZGJiODY3MjA4ODMyY2EyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogdGVyZXNhIDx0bnVuZXpAbWFpbC5kZXN5LmRlPg0KRGF0ZTog
RnJpLCAxNCBBdWcgMjAwOSAxMDo0NjowOSArMDIwMA0KU3ViamVjdDogW1BBVENIXSAnQWRkIHRo
ZSBQT0dPIFRPIERFTEVURSBjb21tZW50IHRvIENvbXB1dGVkQW5nbGVzQ2xlYXIgY29tbWFuZCcN
Cg0KLS0tDQogc3JjL0RpZmZyYWN0b21ldGVyL0RpZmZyYWN0b21ldGVyLmNwcCB8ICAgIDIgKysN
CiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL3NyYy9EaWZmcmFjdG9tZXRlci9EaWZmcmFjdG9tZXRlci5jcHAgYi9zcmMvRGlm
ZnJhY3RvbWV0ZXIvRGlmZnJhY3RvbWV0ZXIuY3BwDQppbmRleCA1ZDJhNTVkLi45OGFkZDM1IDEw
MDY0NA0KLS0tIGEvc3JjL0RpZmZyYWN0b21ldGVyL0RpZmZyYWN0b21ldGVyLmNwcA0KKysrIGIv
c3JjL0RpZmZyYWN0b21ldGVyL0RpZmZyYWN0b21ldGVyLmNwcA0KQEAgLTIwMjMsNiArMjAyMyw4
IEBAIHZvaWQgRGlmZnJhY3RvbWV0ZXI6OmNvbXB1dGVkX2FuZ2xlc19jbGVhcigpDQogCURFQlVH
X1NUUkVBTSA8PCAiRGlmZnJhY3RvbWV0ZXI6OmNvbXB1dGVkX2FuZ2xlc19jbGVhcigpOiBlbnRl
cmluZy4uLiAhIiA8PCBlbmRsOw0KIA0KIAkvLwlBZGQgeW91ciBvd24gY29kZSB0byBjb250cm9s
IGRldmljZSBoZXJlDQorDQorCS8qIFBPR08gVE8gREVMRVRFICovDQogCV9jb21wdXRlZEFuZ2xl
c19zaXplID0gMDsNCiAJaWYoYXR0cl9Db21wdXRlZEFuZ2xlc19yZWFkKSB7DQogCQlkZWxldGUg
W10gYXR0cl9Db21wdXRlZEFuZ2xlc19yZWFkOw0KLS0gDQoxLjYuNA0KDQo=

------_=_NextPart_001_01CA1CCB.F9A7B75C
Content-Type: text/x-patch;
	name="toto.diff"
Content-Transfer-Encoding: base64
Content-Description: toto.diff
Content-Disposition: attachment;
	filename="toto.diff"

MSwyNWMxLDI1CjwgRnJvbSA1OGVkOTM0MzJmMDQzZWU1YjJhZDQ0ZDkyYTc2OWVkZGNlZjRjZmZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo8IEZyb206ID0/dXRmLTg/cT9QaWNjYT0yMEZyPUMz
PUE5ZD1DMz1BOXJpYy1FbW1hbnVlbD89IDxwaWNjYUBzeW5jaHJvdHJvbi1zb2xlaWwuZnI+Cjwg
RGF0ZTogRnJpLCAxNCBBdWcgMjAwOSAxMjoxMDo1MCArMDIwMAo8IFN1YmplY3Q6IFtQQVRDSF0g
KiB0ZXN0CjwgCjwgLS0tCjwgIHNyYy9EaWZmcmFjdG9tZXRlci9EaWZmcmFjdG9tZXRlci5jcHAg
fCAgICAyICsrCjwgIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQo8IAo8IGRpZmYgLS1naXQgYS9zcmMvRGlmZnJhY3RvbWV0ZXIvRGlmZnJhY3RvbWV0ZXIu
Y3BwIGIvc3JjL0RpZmZyYWN0b21ldGVyL0RpZmZyYWN0b21ldGVyLmNwcAo8IGluZGV4IDVkMmE1
NWQuLjk4YWRkMzUgMTAwNjQ0CjwgLS0tIGEvc3JjL0RpZmZyYWN0b21ldGVyL0RpZmZyYWN0b21l
dGVyLmNwcAo8ICsrKyBiL3NyYy9EaWZmcmFjdG9tZXRlci9EaWZmcmFjdG9tZXRlci5jcHAKPCBA
QCAtMjAyMyw2ICsyMDIzLDggQEAgdm9pZCBEaWZmcmFjdG9tZXRlcjo6Y29tcHV0ZWRfYW5nbGVz
X2NsZWFyKCkKPCAgCURFQlVHX1NUUkVBTSA8PCAiRGlmZnJhY3RvbWV0ZXI6OmNvbXB1dGVkX2Fu
Z2xlc19jbGVhcigpOiBlbnRlcmluZy4uLiAhIiA8PCBlbmRsOwo8ICAKPCAgCS8vCUFkZCB5b3Vy
IG93biBjb2RlIHRvIGNvbnRyb2wgZGV2aWNlIGhlcmUKPCArCjwgKwkvKiBQT0dPIFRPIERFTEVU
RSAqLwo8ICAJX2NvbXB1dGVkQW5nbGVzX3NpemUgPSAwOwo8ICAJaWYoYXR0cl9Db21wdXRlZEFu
Z2xlc19yZWFkKSB7CjwgIAkJZGVsZXRlIFtdIGF0dHJfQ29tcHV0ZWRBbmdsZXNfcmVhZDsKPCAt
LSAKPCAxLjYuMy4zCjwgCi0tLQo+IEZyb20gMmFkMTlkMjE2NjBlN2E5NGNiYTBlN2VhZWRiYjg2
NzIwODgzMmNhMiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogdGVyZXNhIDx0bnVu
ZXpAbWFpbC5kZXN5LmRlPg0KPiBEYXRlOiBGcmksIDE0IEF1ZyAyMDA5IDEwOjQ2OjA5ICswMjAw
DQo+IFN1YmplY3Q6IFtQQVRDSF0gJ0FkZCB0aGUgUE9HTyBUTyBERUxFVEUgY29tbWVudCB0byBD
b21wdXRlZEFuZ2xlc0NsZWFyIGNvbW1hbmQnDQo+IA0KPiAtLS0NCj4gIHNyYy9EaWZmcmFjdG9t
ZXRlci9EaWZmcmFjdG9tZXRlci5jcHAgfCAgICAyICsrDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zcmMvRGlm
ZnJhY3RvbWV0ZXIvRGlmZnJhY3RvbWV0ZXIuY3BwIGIvc3JjL0RpZmZyYWN0b21ldGVyL0RpZmZy
YWN0b21ldGVyLmNwcA0KPiBpbmRleCA1ZDJhNTVkLi45OGFkZDM1IDEwMDY0NA0KPiAtLS0gYS9z
cmMvRGlmZnJhY3RvbWV0ZXIvRGlmZnJhY3RvbWV0ZXIuY3BwDQo+ICsrKyBiL3NyYy9EaWZmcmFj
dG9tZXRlci9EaWZmcmFjdG9tZXRlci5jcHANCj4gQEAgLTIwMjMsNiArMjAyMyw4IEBAIHZvaWQg
RGlmZnJhY3RvbWV0ZXI6OmNvbXB1dGVkX2FuZ2xlc19jbGVhcigpDQo+ICAJREVCVUdfU1RSRUFN
IDw8ICJEaWZmcmFjdG9tZXRlcjo6Y29tcHV0ZWRfYW5nbGVzX2NsZWFyKCk6IGVudGVyaW5nLi4u
ICEiIDw8IGVuZGw7DQo+ICANCj4gIAkvLwlBZGQgeW91ciBvd24gY29kZSB0byBjb250cm9sIGRl
dmljZSBoZXJlDQo+ICsNCj4gKwkvKiBQT0dPIFRPIERFTEVURSAqLw0KPiAgCV9jb21wdXRlZEFu
Z2xlc19zaXplID0gMDsNCj4gIAlpZihhdHRyX0NvbXB1dGVkQW5nbGVzX3JlYWQpIHsNCj4gIAkJ
ZGVsZXRlIFtdIGF0dHJfQ29tcHV0ZWRBbmdsZXNfcmVhZDsNCj4gLS0gDQo+IDEuNi40DQo+IA0K

------_=_NextPart_001_01CA1CCB.F9A7B75C--
