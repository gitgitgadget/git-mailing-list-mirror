Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D353CA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 08:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348664AbjIAI5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjIAI5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 04:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E5110D2
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693558597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SsV90PShagrsGi7OtX74wTyFlgt+OKaa68Cd1b285/g=;
        b=VLon1f+6+noVclMrCh8+jMPVdcyM/wDQq4UZcHAz/UvH9M/8egExMYWpWNZSCwmpdx0ssM
        KpgBnKFwaz2k0AYl6GskSBiWanHm0UvXNTqbzMuo/pxkoPf5LrYrr5pM6l/o53woGU85l3
        4N85GQ8wFyHDpb5sHjTcItZpRRfF6q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-fYn_vzNdPoKOjm5s9llIcA-1; Fri, 01 Sep 2023 04:56:33 -0400
X-MC-Unique: fYn_vzNdPoKOjm5s9llIcA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3717685D183;
        Fri,  1 Sep 2023 08:56:33 +0000 (UTC)
Received: from [10.45.224.90] (unknown [10.45.224.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10492492C13;
        Fri,  1 Sep 2023 08:56:31 +0000 (UTC)
Message-ID: <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
Date:   Fri, 1 Sep 2023 10:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <xmqqo7inw2na.fsf@gitster.g>
From:   =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
Autocrypt: addr=vondruch@redhat.com; keydata=
 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
In-Reply-To: <xmqqo7inw2na.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wf0Wc1uVmSbnN0U7EFCiTn33"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wf0Wc1uVmSbnN0U7EFCiTn33
Content-Type: multipart/mixed; boundary="------------SH02t8y1LIcPFQZvNfIMGEWm";
 protected-headers="v1"
From: =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
Subject: Re: Is there a way to get the "format-patch" formatted file name?
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <xmqqo7inw2na.fsf@gitster.g>
In-Reply-To: <xmqqo7inw2na.fsf@gitster.g>

--------------SH02t8y1LIcPFQZvNfIMGEWm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpEbmUgMzEuIDA4LiAyMyB2IDE5OjE5IEp1bmlvIEMgSGFtYW5vIG5hcHNhbChhKToNCj4g
VsOtdCBPbmRydWNoIDx2b25kcnVjaEByZWRoYXQuY29tPiB3cml0ZXM6DQo+DQo+PiBNeSB0
eXBpY2FsIHVzZSBjYXNlIGlzIHRvIGRvd25sb2FkIHBhdGNoZXMgZnJvbSBHSCwgZS5nLjoN
Cj4+DQo+PiB+fn4NCj4+DQo+PiAkIGN1cmwgLU9MIGh0dHBzOi8vZ2l0aHViLmNvbS9yYWls
cy9zcHJvY2tldHMvcHVsbC83OTEucGF0Y2gNCj4gLi4uDQo+PiBUaGUgcHJvYmxlbSB3aXRo
IHRoaXMgaXMgdGhhdCBJIGVuZCB1cCB3aXRoIHRoZSAiNzkxLnBhdGNoIiBmaWxlLA0KPj4g
d2hpbGUgSSdkIGxpa2UgaGF2ZSBhIGZpbGUgd2l0aCBzaW1pbGFyIG5hbWUgYXMgaWYgSSBo
YXZlIHVzZWQgdGhlIGdpdA0KPj4gY29tbWFuZDoNCj4+DQo+Pg0KPj4gfn5+DQo+Pg0KPj4g
JCBnaXQgZm9ybWF0LXBhdGNoIC0xIDY1NTRiNmQNCj4+IDAwMDEtRml4LU1pbml0ZXN0LWNv
bnN0YW50LW5hbWUtaW4tdGVzdHMucGF0Y2gNCj4+DQo+PiB+fn4NCj4+DQo+Pg0KPj4gU28g
SSB3b25kZXIsIGlzIHRoZXJlIGEgd2F5IHRvIGdldCBzdWNoIGZpbGUgbmFtZT8NCj4gRG8g
eW91IG1lYW46IEdpdEh1YiBzaG91bGQgbGV0IG1lIHJ1biB0aGlzIGNvbW1hbmQgaW5zdGVh
ZA0KPg0KPiAgICAkIGN1cmwgLU9MIGh0dHBzOi8vZ2l0aHViLmNvbS9yYWlscy9zcHJvY2tl
dHMvcHVsbC8wMDAxLUZpeC1NaW5pdGVzdC1jb25zdGFudC1uYW1lLWluLXRlc3RzLnBhdGNo
DQo+DQo+IEl0IG1heSBiZSBuaWNlIGZvciB0aGVtIHRvIGdpdmUgYSBtb3JlIG1lYW5pbmdm
dWwgbmFtZSB0byB0aGVpciBwdWxsDQo+IHJlcXVlc3QgKG5vdCBqdXN0IHRoZSBvdXRwdXQg
ZmlsZSBuYW1lKSB0aGFuIGp1c3QgYW4gaW50ZWdlci4NCg0KDQpUaGlzIFVSTCB3b3VsZCBi
ZSBoYXJkIHRvIGNvbXBpbGUgYW5kIGl0IGNvdWxkIHBvdGVudGlhbGx5IGxlYWQgbWUgdG8g
DQp0aGUgc2FtZSBxdWVzdGlvbiA7KSBCdXQgbWF5YmUgaW4gY29tYmluYXRpb24gd2l0aCBg
LUpgIG9wdGlvbiwgR0ggKGJ1dCANCmFsc28gYWxsIG90aGVyIGZvcmdlcykgY291bGQgcHJv
YmFibHkgZG8gc29tZXRoaW5nIGFib3V0IGl0Lg0KDQoNCj4gQnV0DQo+IHRoYXQgaXMgbm90
IGEgcXVlc3Rpb24vcmVxdWVzdCB3ZSBjYW4gYW5zd2VyIGhlcmUgKHRoaXMgaXMgbm90IGEN
Cj4gaGVscCBmb3J1bSBmb3IgR2l0SHViIHVzZXJzKS4NCg0KDQpSaWdodC4NCg0KDQo+DQo+
IFNvbWV0aGluZyBhbG9uZyB0aGUgbGluZXMgb2YNCj4NCj4gICAgICBzZWQgLW5lICcvXlN1
YmplY3Q6IC97DQo+ICAgICAgICAgICAgICBzL15TdWJqZWN0OiAqXFtQQVRDSFteXV0qXF0g
Ki8vOw0KPiAgICAgICAgICAgICAgcy9bXmEtekEtWjAtOV0vLS9nOw0KPiAgICAgICAgICAg
ICAgcy8tLSovLS9nOw0KPiAgICAgICAgICAgICAgcy8kL1wucGF0Y2gvOw0KPiAJICAgIHA7
DQo+IAkgICAgcTsNCj4gICAgICB9JyA3OTEucGF0Y2gNCj4NCj4gc2hvdWxkIGJlIGRvYWJs
ZSwgYnV0IEkgYW0gbm90IHN1cmUgd2hhdCB0aGUgYmVuZWZpdCBpcy4NCg0KDQpJZiB0aGlz
IHdhcyBwcm92aWRlZCBhcyBhIHNvbWUgY29udmVuaWVudCBzY3JpcHQsIHRoZW4gSSB3b3Vs
ZCBub3QgbmVlZCANCnRvIGtub3cgd2hhdCB0aGUgc2FuaXRhdGlvbiBvZiB0aGUgc3ViamVj
dCBpcyBkb25lIHRvIGdldCB0aGUgZmlsZSBuYW1lLiANCkhvd2V2ZXIsIHNvIGZhciBJIHdh
cyBtb3N0bHkgZmluZSB3aXRoIG1hbnVhbGx5IHJlcGxhY2luZyBzcGFjZXMgYnkgDQpkYXNo
ZXMsIHNvIHdoYXQgaXMgc2FuaXRpemVkIGlzIG5vdCByZWFsbHkgdGhhdCBpbXBvcnRhbnQg
dG8gbWUuIEkganVzdCANCnRob3VnaCB0aGF0IGlmIEdpdCBoYXMgYWxyZWFkeSBzb21lIG9w
aW5pb24gYWJvdXQgaXQgYW5kIGl0IGlzIGFscmVhZHkgDQppbXBsZW1lbnRlZCwgaXQgd291
bGQgYmUgbmljZSB0byByZXVzZSB0aGUgZnVuY3Rpb25hbGl0eS4NCg0KDQo+ICAgIE9uY2Ug
eW91DQo+IGdldCBpdCBpbiBHaXQsDQoNCg0KQnV0IEkgdHlwaWNhbGx5IGRvbid0IGhhdmUg
YSBHaXQuDQoNCg0KPiAgIHlvdSdkIHBhcmsgaXQgb24gYSBicmFuY2ggd2l0aCBhIHVzZWZ1
bCBuYW1lIGFuZCB3ZQ0KPiBjYW4gZm9yZ2V0IGFib3V0ICI3OTEiLCBzbyB0aGUgIlRoZSBm
aWxlcyB3ZSBnZXQgZnJvbSBHaXRIdWIgYXJlDQo+IG5hbWVkIGluIGEgd2F5IHRoYXQgbWFr
ZXMgaXQgaGFyZCB0byBpZGVudGlmeSB0aGVtIiBkb2VzIG5vdCBzb3VuZA0KPiBsaWtlIGEg
R2l0IGlzc3VlLCBhdCBsZWFzdCB0byBtZS4NCj4NCj4NCj4NCg0KSXQgZG9lcyBub3Qgc2Vl
bXMgSSBoYXZlIGNvbnZpbmNlZCB5b3UgKGFuZCB0aGF0IGlzIGZpbmUpLiBJJ2xsIHByb2Jh
Ymx5IA0KbG9vayBhcm91bmQuIHBhdGNodXRpbHMgcHJvamVjdCBjb3VsZCBiZSBwcm9iYWJs
eSBnb29kIGNhbmRpZGF0ZSBmb3IgDQpzdWNoIHNjcmlwdC4gSSdsbCB0cnkgdG8gYXNrIHRo
ZXJlLiBNYXliZSBJJ2xsIGFsc28gdHJ5IHRvIGV4cGxvcmUgaWYgR0ggDQp3b3VsZCBiZSBv
cGVuIHRvIHByb3ZpZGUgc29tZSBiZXR0ZXIgZmlsZW5hbWUsIGxldmVyYWdpbmcgdGhlIGAt
SmAgY3VybCANCm9wdGlvbi4NCg0KDQpUaHggZm9yIHlvdSBoZWxwISBBcHByZWNpYXRlIHRo
YXQuDQoNCg0KVsOtdA0KDQo=

--------------SH02t8y1LIcPFQZvNfIMGEWm--

--------------Wf0Wc1uVmSbnN0U7EFCiTn33
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEjuEMC4xF8PxsGhoUDOCe55kXuHwFAmTxpz0FAwAAAAAACgkQDOCe55kXuHy+
Hw/+JcHuAeo7XsfLNCoiM+ZFtZ0BIqD1fKJsQ19rOM6NPwAgs20KJ2Isi/WocXcEd/bLGZKgEf4A
CqvhnXR6WX5WBgd/k/ql0iZyqpxHIvIl1gWWK6Bk/AmBIlPNc6o42HeLKJejT4SsNcXRhiF9+8Rp
FcdcbVmX+X8WiAQ26Lcx2WqaG98/ZWtvoIjDmdEy1GmEiVlTwhZ4gE2zub5+jKjDKmUQUejZpMoh
PPz2x/5x9/UnGRmO02X+N0QRvhnPlowI0SYIHr+9pac6c508eukqlY1SUSfmM7PGHGWYZPwpxkjp
Qz4nUzbT+Y0Ec9kqap/RZ/k/hlO7zQpadtv/Gb8yTS2L5Gm5swNvuwTCr7JGOYNBPnWJMXToHd8y
HkMgz75vzuKETFSVApvuScUbJCOgARsXcMeqyro1ouHeDLiqwjgPT8Oj9FPeAYJbZgCFtMxyhwpb
mzmrBdf8i0Fwp3SS955FlJUshZRNywoAtzoxAkOtBo6L7waEGjlmbldqew8XYtQJorGmeyAvYbB3
BSornmMCdHJrA0OSUutg2DucyulmU7bL61wmQyjOm9sC4648S4ya+LqGdGPOroLGgLx3v1rs+Muk
73fLcry8vj6sC2ST4NcO1v/cPuYuzcEqF5F1u5ENal9pn7LEhfreKUerErnMEEOiLk54aXcoAL4b
jJI=
=HGDW
-----END PGP SIGNATURE-----

--------------Wf0Wc1uVmSbnN0U7EFCiTn33--

