Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2AA91F954
	for <e@80x24.org>; Thu, 23 Aug 2018 05:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHWIhs (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 04:37:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbeHWIhs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Aug 2018 04:37:48 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A46B16047A;
        Thu, 23 Aug 2018 05:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535000994;
        bh=jD4hEMdCE8goxlozatbTUyOzpo6ldxmvGlLqNkLvFig=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VWaq1Ioeod72/sCEXZnhEg36o2C8noOIJojdPmwa3/3/wJbLGTwYlXsC2LycSDYyF
         e7Q5V5OnQDpYslrnuCjo3CXLBvTeinN8Jvkt4K7bIKJ3bCLnE9NTS1Id6PJqO3JlhM
         WMaCvsYjIA6ZIb63uhA+/Dc31G5unpnxRK7lxTGlaSkIU75IWHxtrq79fMGX5fg4pc
         frc/5yu/gGOR2DVQEnAsZ4GNEVPjM4cLumkSnEX8l8oZxtLTYBPDP+JlyMHtuOSxZm
         QjVn3tqpF0mhFlvz6z2uDrt6x9C04O/lZ+GpRrprF8TWlIpZo6orVJkKhzL4ebTAKg
         x0ZAJXQJe63mgTefAa8wshcU18hJane4LIYiKLw/lDEt2ThiBaBd7x4mcC3K/sQFum
         M4FZ1GPpBsIrGGOyGeHmhM5TAWxr3CQusneGCfKFISsmpo9b8zXufrT2E6zmF29Exp
         cytAeCQ4/N/snlwjq2uGtqIvhMd4Yl5XB6bqFZvvx5snV+t8o60
Date:   Thu, 23 Aug 2018 05:09:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823050948.GE535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823022756.GF92374@aiede.svl.corp.google.com>
 <20180823050224.GA318@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <20180823050224.GA318@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 01:02:25AM -0400, Jeff King wrote:
> Here's the patch. For some reason my numbers aren't quite as large as
> they were yesterday (I was very careful to keep the system unloaded
> today, whereas yesterday I was doing a few other things, so perhaps that
> is the difference).

This looks sane to me.  Thanks for writing this up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt+QZwACgkQv1NdgR9S
9otRbRAAs3Q5MOGxNuh4GL3R1/+lbtEx1VIc/jxmeXukw/wNtKv4CE8l38gDamvh
jNOQDOvX5OQpHzMyfv7I4Al3n8RHQCtrq6wyyY6ybB3demv0ONEtUGb1EHWVWDGv
DUnzBROJ9VgbeG8Dh4DGSDirhjGc31M7ZmxoBdyKFJPaAho6Yft4vgHGAz837ue6
Y+y4fFGlGYAztU81hJxGzD0nR7J05PKmmhB+JbjB6dn/uzmXSiVEACTfVGIEG7jx
mOlDvTsuyr0VmwilD6829AZJYorfm7VvvTnt+mdwT3/10Z8l7OJkq65vKptFnIbv
FanJ1U0mZTpEd02KJ4/vSiQ8aVNsiiQpsxyZxjJlbAUKORpP0s0uJLPJ8a3rdsNy
XRVinZ6ybEQiqfilhWgm63Lb3bnouS2VTt6owkiharzfRyTzr/fCMrH6xeEGRXv3
9ccsie8DUTZSwdun5DbCq13Ih0Baz5dVyBaFfRsZiCOn9q2wlCNHlPEn6rVOSZ3A
b9q06KPvmPS8jfzDZkW6tCOJ6O3Yd/MYXhvBrin/7HMHyCo1XL3fDgtU+1KTl7Mk
x9b4ApN5+J0sxX1aIuqDurUf8XDhhwL8ItKpJOKfr3L4KTP/Mk7ZOZkQpVo5rVww
2V3KZEFFKeWGFuB1deZRGZT+l+HpyGLK8mW0k8lUOUDGgM5gE9w=
=pmkK
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
