Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D92D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbdASWDD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:03:03 -0500
Received: from www.zeus03.de ([194.117.254.33]:38444 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdASWDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:03:02 -0500
Received: (qmail 21215 invoked from network); 19 Jan 2017 23:02:58 +0100
Received: from p54b33be7.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@84.179.59.231)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 19 Jan 2017 23:02:58 +0100
Date:   Thu, 19 Jan 2017 23:02:58 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
Message-ID: <20170119220257.GB1747@katana>
References: <20170115183051.3565-1-wsa@the-dreams.de>
 <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
 <20170119204343.xtotmjddhbum2mvr@ninjato>
 <xmqq7f5qzqx3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <xmqq7f5qzqx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I didn't know about trailers before. As I undestand it, I could use
> > "Tested-by" as the key, and the commit subject as the value. This list
> > then could be parsed and brought into proper output shape. It would
> > simplify the subject parsing, but most things my AWK script currently
> > does would still need to stay or to be reimplemented (extracting names
> > from tags, creating arrays of tags given by $name). Am I correct?
>=20
> That is not exactly what I had in mind.  I was wondering if we can
> do without any external script, implementing the logic you added
> inside shortlog with an extra option that triggers the whole thing,
> which may call into the same trailers API as used by the
> interpret-trailers command to do the parsing and picking out parts.

Sorry for being unclear. That's what I meant with "or to be
reimplemented". I should have added "in C".

I am afraid this also requires more time than I am willing to
spend on this issue. Seems my hack is going to stay for a while here.

However, thank you for your time and assisting me with pointers!


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgTeRAAoJEBQN5MwUoCm2SoAP/0Y5hUa9Vmeeq+F2Xw2rWO2R
+Fk2YmZW6bmqMyBRyKstpdIlrLlGgDf95VIMMkuwi2RuTn+NPlahSwUym/4xqipR
WqFz3HNmFGm/dDkPQ3K6OMXPLkNuwJmwkV0NmrX6qlor2Idzq2ouYFIHPKIWvOBI
AAAiyBI23gV9JC8P9pmgsg8vF68P49mnV60RFXQ7LVAFLM311/8bEcNnKBbBmTGf
XZOtwduj+cj/Oiuly+WCOsS+oPAXeI/L2wJD0msIJKPEA4KOjBlENBFKTJ1h2/Bq
VLybFm6Z7QvbAotdfke1bvB5NKy3aHGOP6fVuSvnOqynRfmpAOmFvYgNuCRcqR6R
plcWHry8ce6Gq/6L5jfvAMbPHOyh8taMSmJVVab1RVUOk+glMgVXgBfiYq2OsBr2
ywdd/YBnYigGSkaIkoLGcJ2EAflP217o7QyfiD5Fptu2S1jBNcOoyYTpanAeLePw
R+F9qc6mT17BvX0r4Q9NJ0XE9iEtzgZQFmfF99BepKiPCbAKEYEN9kMIKQO3CFM0
UAdxTFnAichfKJvLeKHGitSIy7c6n2Bpx5hReJ0vuIdLUUOMVfiQOiqiyAVhUWaE
GYs7GQ07g6xIBsxt/fGhs2AaAHGHZdJ0mM1H8+MRWzPrkQV4st0GvhZaN5q4lC6t
EL/UMPSmZ0JW9fURKHDE
=I07U
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
