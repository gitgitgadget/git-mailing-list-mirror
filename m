Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8931FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbdBNNgF (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 08:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbdBNJn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:43:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4337C0567B2;
        Tue, 14 Feb 2017 09:43:27 +0000 (UTC)
Received: from localhost (ovpn-117-160.ams2.redhat.com [10.36.117.160])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1E9hPh7008327;
        Tue, 14 Feb 2017 04:43:27 -0500
Date:   Tue, 14 Feb 2017 09:43:20 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
Message-ID: <20170214094320.GA23310@stefanha-x1.localdomain>
References: <20170120171126.16269-1-stefanha@redhat.com>
 <20170120171126.16269-3-stefanha@redhat.com>
 <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
 <20170120235133.GA146274@google.com>
 <20170207150414.GD8583@stefanha-x1.localdomain>
 <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
 <20170209035839.wqsh6ibgnmxyjusi@sigill.intra.peff.net>
 <xmqqtw84rlna.fsf@gitster.mtv.corp.google.com>
 <20170209052034.ksoupjcj4qs7x4hz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20170209052034.ksoupjcj4qs7x4hz@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 14 Feb 2017 09:43:28 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2017 at 12:20:34AM -0500, Jeff King wrote:
> On Wed, Feb 08, 2017 at 09:14:17PM -0800, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> (I _do_ think Stefan's proposed direction is worth it simply because the
> result is easier to read, but I agree the whole thing can be avoided by
> using pathspecs, as you've noted).

I won't be pushing this series further due to limited time.

Stefan

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYotE4AAoJEJykq7OBq3PI2I8IAIAC+9ZjbVCJTDwdq9eC9sKv
8YX6raATpxpm0mmgOdEe4L15y8ekW8XVX1lqJXLDS73mKGA3ZHDwfdRMPeGRB4fb
SQBpwqXdaWTZTCZ4GyFX2C5Tk03Gb8V+eGJUrFmJBDiXdxg4fB/9VrrpbvKBqlro
iWQdNxwlQR2kQAQM/5zS2SGHXPUNhz4dYWipOXqNqeJbV2rQ7mlEoAfrbjtVn6tj
GtYpD+5OXlNqScCHTmE8EnYlADo2VABMVn+1kFerqYMmTvwZ0ySrfv7NnIqIDbSr
rNSyqEIfr7gxHUehVIu78/PgTLs+nsyPyoVn3ms9vSM1ORCuIpMClJfNU8CKUW8=
=FWDB
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
