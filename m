Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96351F407
	for <e@80x24.org>; Sun, 10 Dec 2017 13:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdLJNvm (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 08:51:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:61449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdLJNvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 08:51:41 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvPgd-1f6THr3apH-010c0D; Sun, 10
 Dec 2017 14:51:32 +0100
Date:   Sun, 10 Dec 2017 14:50:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Todd Zullinger <tmz@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
In-Reply-To: <20171209144607.GA6443@tor.lan>
Message-ID: <alpine.DEB.2.21.1.1712101450010.4318@virtualbox>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com> <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com> <alpine.DEB.2.21.1.1712071643410.4318@virtualbox> <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com> <20171207213312.GB3693@zaya.teonanacatl.net>
 <20171209144607.GA6443@tor.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2117151292-1512913892=:4318"
X-Provags-ID: V03:K0:31Zx9EMduCn99yUw051mtWqtGgLjBM8NGhlE1rDn8a5jjU9NrHN
 Pfcj83tT26IBsYMHaDvTPhnMmcFBgEqZALb6ET7sIym6Hu5iXqVFQgFnjzUGk8k8Buex7gc
 YwccQO1CxSpmcKw3i5Ow3tV+wo44FgMfkdmhbdGhOEDMlbiEdi/d3g2T3Y5AlzKKskiP54x
 b6gpdG1s/XsLUbrkoa1/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ivUD1JxPsvQ=:DaFKj38hcSddLmDBheeRPb
 +IOcUrF40RVzj24f+qDnLHKL+D3A2Ceg/VfgIglUBae0Y6DPUR2Svuv0ZFHwEAUfqLNrSBwx6
 4tZq6HyzZbNCV/0dwtuUSnr/EXl7olmtV71cTSYwS1ItYRom8HZ2azKw9PT/eeFIbqguxGcpQ
 Dn/Ip0pxFgJ5AGSTHN4cz7NFDc5vBL8D9BOGFJCDJ9ytPsV4SSn37N8wt4nvLusG3pSgR1CKV
 ahyIP3n9glrUIu4no7HvU+qcQeTVuCKjzDtMOJLqzzKG5IzaKUThGQuI0FP7N0Ktn+KEaQkag
 zO/1Fu0XWnVBetEI0GbteL9Ebni9oaXfAuHLp1PeVVYlG344wqVWiP4VWeV61VAJQpXXiQfpe
 tIe4YsA/DiBOIDh8eyTnogtxrpWw5fu5g/12lSZehjSZk6KgWFKLizVrhZlauMRDuGTp/O4Fl
 03SqAhzEFHajOj1etsv/oQmD+5L5BL0+u113uoqEMECHoQc/sdxBcQIa4JLLEp6s+JQr8UfEJ
 d/jhLnqDCfMjahiE1JdEJMaG1t144ZwI2YGgIzU84D7L2xfKcXbllgVJLHQp4Sj+C5pJjcF1T
 GxN4ddnDpe0bxiG2+Z12c64FkG5aW08QCfGjwR3jCa8oJnuh43kIcmuTiV5M9CU7+BwuIjAFJ
 NlBOFnHkfFCAy9pdA2QFBP4LhsaN5fYkFOYsoNk3UO03bLAU2kLN80AO9YVNYG3Uk8fzVogB7
 N+NJqDfHzWw4+x0uWkBXJmSIpWzO/jRDE03X3MlCFqI7V5zatiojLlD2EJvd1/b67SakeTRMp
 Hox7+CgVHkp/ueHR6EGxiAB6pkpBv9wQ2TmTudpfBKoa3OtjnwXNzjn0VUgDi/+AHVXqvVp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2117151292-1512913892=:4318
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sat, 9 Dec 2017, Torsten B=C3=B6gershausen wrote:

> On Thu, Dec 07, 2017 at 04:33:12PM -0500, Todd Zullinger wrote:
> > Jeff Hostetler wrote:
> > >I'm looking at t5616 now on my mac.
> > >Looks like the MAC doesn't like my line counting in the tests.
> > >I'll fix in my next version.
> >=20
> []
> > =09=09| sort >expect_2.oids &&
> > -=09test "$(wc -l <expect_2.oids)" =3D "8" &&
> > +=09test_line_count =3D 8 expect_2.oids &&
> > =09git -C src blame master -- file.1.txt >expect.blame
> > '
>=20
>=20
> The problem seems to be the '"' around wc, this would work:
> test $(wc -l <expect_2.oids) =3D "8" &&
>=20
>=20
> What do you guys think a about a lint test like this:
>=20
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.p=
l
> index 03dc9d2852..9ebf65c26f 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -21,6 +21,7 @@ while (<>) {
>  =09/^\s*declare\s+/ and err 'arrays/declare not portable';
>  =09/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
>  =09/\btest\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (=
please use =3D)';
> +=09/\bwc -l.*"\s*=3D/ and err '`"$(wc -l)"` is not portable, please use =
`$(wc -l)`';
>  =09/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not port=
able (please use FOO=3Dbar && expo

Please suggest `test_line_count` instead.

Ciao,
Dscho
--8323329-2117151292-1512913892=:4318--
