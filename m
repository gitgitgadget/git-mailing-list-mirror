Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18E72036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdJCVlj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:41:39 -0400
Received: from mout02.posteo.de ([185.67.36.142]:34529 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdJCVli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:41:38 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Oct 2017 17:41:38 EDT
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 3y6C2t3H10zypM
        for <git@vger.kernel.org>; Tue,  3 Oct 2017 23:33:58 +0200 (CEST)
Date:   Tue, 3 Oct 2017 23:33:53 +0200
From:   Christian Rebischke <Chris.Rebischke@archlinux.org>
To:     git@vger.kernel.org
Subject: [bug] git version 2.4.12 color.ui = always breaks git add -p
Message-ID: <20171003213353.GA9195@motoko>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everybody,
I played around with my gitconfig and I think I found a bug while doing
so. I set the following lines in my gitconfig:

[color]
    ui = always

When I try to use `git add -p <filename>` I don't see the 'Stage
this hunk'-dialog anymore. First I thought it's some other configuration
but now I can definitly say that this configuration breaks `git add -p`
interactive mode.

best regards

chris

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEba97gI+d8lE5YgAA0hRh49/iBg0FAlnUAj8ACgkQ0hRh49/i
Bg0TkA/+MzH4pKJ4uc/p4bVF6Fx7yzdd2xX3Ne2gNvcAJ2OPKRVoSRH/4m/hUZjN
bad9vkUtRRDit8znAPuROcuMyB74GV6/HDWnXo11cZcwJ0SKhFtAHuM6eGmZQ6mC
HT7ih/BbbalwRhMpoegHwQZkI1JGvtgNabxX1A/jxMWyfC2LEoZ/SLTqPZIB+/v1
ZLQzzfmu/kg+H1jEb1wupkj/a9oXZh9LISyk7ibOJ9zbeiynAL9FVGGZWd2BJI3Y
KykXLxw7MuXpGbbe+ZIloUl4FiVoqbhgMykSzy5uiPGeN2iurzdSVW+TsGz2KztZ
PSf8R5lm+h//LXwk3BIFGYf9l+Hcery84d9WGOXqPajYlyEHYZdXVk4yZ31nsuXu
M/DYb/bxBb44s6tVDtnxwU1QvgIp7NSh9Iz23YuQUduXC4s1X4/CKb5xH52hWb9z
o9k7ZNalAuz8ZENBSF70XnhrP620KHL3JQP52Ql4HBfTF7SUSflydYHzLV6g3fQu
yM0vacVWBQ2R9LcusDSu3azseXWAQHnjsV2TfAr0z+qul6WRskYTH1nBC7pxrZX3
QAcdi65NPVQeCpJCfJ9799/TNEO3WZO1pYza1ulwo4sxGJjffYyHzEwTO1FlNHOv
gDp12+EqYDuMUswoJN4Qw4isuelb6zRfdDbE97wolpzOS1OqF8o=
=h5jC
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
