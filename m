Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D358C83F12
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 12:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjHaMO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbjHaMOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 08:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50893CDD
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693484016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zWiQgbENWMte3T6UeH1liwAGmw1Jxi8x7FJxqm5gCZU=;
        b=CzsEDGWjCz+7dc4wYqwUAhf8gytg093em9hmcS34Dk1a6SZgDBJ30O6tmC1xz0JEZuNqjx
        UUZ+NoI7QeQ2YlGGmvtmvgEmdwv1aXtPAjyiNa4kNB4R0EMfEX5ZbIeQ657UfQL2D0qNZL
        rni6enWX2uWeO853pUuHchvLYa0i2gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-g0rp-7LlO_K7yakGYpPSUg-1; Thu, 31 Aug 2023 08:13:34 -0400
X-MC-Unique: g0rp-7LlO_K7yakGYpPSUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56AB8101A5B9;
        Thu, 31 Aug 2023 12:13:34 +0000 (UTC)
Received: from [10.45.224.90] (unknown [10.45.224.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CFA2166B25;
        Thu, 31 Aug 2023 12:13:32 +0000 (UTC)
Message-ID: <3a7837fa-d7fb-1a85-dc67-94e94f4058c6@redhat.com>
Date:   Thu, 31 Aug 2023 14:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <ZPBzz3vvv9Ryn2tz@ugly>
From:   =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
Autocrypt: addr=vondruch@redhat.com; keydata=
 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
In-Reply-To: <ZPBzz3vvv9Ryn2tz@ugly>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------b780rbjxHsHYJP26vVU6vvVy"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------b780rbjxHsHYJP26vVU6vvVy
Content-Type: multipart/mixed; boundary="------------W0Ok0ZSRmYTMyueaYHIEmJpL";
 protected-headers="v1"
From: =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Message-ID: <3a7837fa-d7fb-1a85-dc67-94e94f4058c6@redhat.com>
Subject: Re: Is there a way to get the "format-patch" formatted file name?
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <ZPBzz3vvv9Ryn2tz@ugly>
In-Reply-To: <ZPBzz3vvv9Ryn2tz@ugly>

--------------W0Ok0ZSRmYTMyueaYHIEmJpL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RG5lIDMxLiAwOC4gMjMgdiAxMzowNCBPc3dhbGQgQnVkZGVuaGFnZW4gbmFwc2FsKGEpOg0K
PiBPbiBUaHUsIEF1ZyAzMSwgMjAyMyBhdCAxMTo0OToxMEFNICswMjAwLCBWw610IE9uZHJ1
Y2ggd3JvdGU6DQo+PiAkIGdpdCBleHRyYWN0LWZpbGVuYW1lcy1mcm9tLXBhdGNoIDc5MS5w
YXRjaA0KPj4NCj4+IDAwMDEtRml4LU1pbml0ZXN0LWNvbnN0YW50LW5hbWUtaW4tdGVzdHMu
cGF0Y2gNCj4+DQo+IGBnaXQgbG9nIC0tcHJldHR5PWZvcm1hdDolZmAgZG9lcyB0aGF0Lg0K
PiBvZiBjb3Vyc2UgeW91IG5lZWQgdG8gYXBwbHkgdGhlIHBhdGNoIGZpcnN0IGZvciB0aGF0
IHRvIHdvcmsNCg0KDQpUaGF0IChhcHBseWluZyB0aGUgcGF0Y2gpIGlzIHRoZSBwcm9ibGVt
IGFjdHVhbGx5LiBJIGFtIGxvb2tpbmcgZm9yIA0KZnVuY3Rpb25hbGl0eSBsaWtlIHRoaXMg
aW4gdGhlIGNvbnRleHQgb2bCoCBGZWRvcmEgcGFja2FnaW5nLCB3aGVyZSB3ZSANCndvcmsg
d2l0aCBzb3VyY2UgdGFyYmFsbHMuIFRoZXJlZm9yZSBJIGRvbid0IHR5cGljYWxseSBoYXZl
IGFuIA0KcmVwb3NpdG9yeSBhcm91bmQuDQoNCkFuZCBpZiBJIGhhZCBhIHJlcG9zaXRvcnks
IEkgY291bGQgcG9zc2libHkgdXNlIGBnaXQgZm9ybWF0LXBhdGNoYC4NCg0KDQpWw610DQoN
Cg==

--------------W0Ok0ZSRmYTMyueaYHIEmJpL--

--------------b780rbjxHsHYJP26vVU6vvVy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEjuEMC4xF8PxsGhoUDOCe55kXuHwFAmTwg+oFAwAAAAAACgkQDOCe55kXuHzC
5A//Vu7qSHZLAffB6FE4RxoCMrQMP16MFRH1fYq3eBh+8hxfi/qS7jwlaXV1O2KTLLjCYp5XAwOS
Tsna2ZmQ+P/QBYAqjzjVykeTM4HUPY1yFCGi/5z6kxrA81RtB2Z81k1/DDpCoZ7Bl6qIWp8NMpzu
eQ/uqk0gXn1KhMgpF7ACrZt6SrlCot8ZjbrIuYFF1cvV2xPin65YbZ9iOO4nPRRZTIMY92rr4+VZ
jZtqPXl85MSzT/60dz9NvMzxoMwmzxswtdkntK/uZoF5Jutk68GizZ0RRIcGrWdmPJSSUL0XmoYD
OqNfOCgP+wtDnggBZSdTeJu4L3oXgdd+qsV6g1N8zPt8oLnc4GYeYcj48GpvVYHxnwFlhmpeD+Jn
Un+8CiJ1mVHClBpj3Jlsi0dwYfsd41kAdTMJFtuTtxIyWnTtNR/Hz/UL2kHAFM6c2gnCyywlQu72
rr/l+34WKy/o9M0G+DP+4Uk+qFy3+jKLMqIos4GNCtUCdWCLiDdOoqgtK/ccUmRFv4Mi8HhBYYio
AjZcEH9/R5Wx2bVxhROSU4h6S+fFSyUNFn4OakHqyomRjsQ0WW6UPf4HH0pMX0z3lny2HXwLj8te
p57uTo1TZOf0YyXc0y6WxFBHTldts8Es87NgB1Xz58RD18cF6fF6+xn93EHpuk5WaY9aYqKBnVyx
7Tg=
=TzJB
-----END PGP SIGNATURE-----

--------------b780rbjxHsHYJP26vVU6vvVy--

