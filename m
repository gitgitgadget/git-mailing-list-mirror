Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C1220C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdK0XnB (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:43:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:65091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbdK0Xm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:42:59 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8JyQ-1f6MN4227e-00vt0c; Tue, 28
 Nov 2017 00:42:52 +0100
Date:   Tue, 28 Nov 2017 00:42:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dan Jacques <dnj@google.com>
cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
In-Reply-To: <20171127164055.93283-5-dnj@google.com>
Message-ID: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox>
References: <20171127164055.93283-1-dnj@google.com> <20171127164055.93283-5-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-203006063-1511826172=:6482"
X-Provags-ID: V03:K0:zk7bnw0w0LFlQA2vXPjYvIHDDsLoGqXovydUmzjji/EF2Nhiuj6
 zSGIfCFgOUNW93eOcbr28vddGi34vVvRjvitFGFPQ60exJMYyHyw2qlEd6LQEIKd5Tkbko3
 fqSOWdxqmc7PIPaFgG0P323D+IXqrYRBx1dxIpAqxhBMkolmp8LhcYe8l08LwKqpJ7NcbSC
 h8b9B9SMDt+d5+VRd5TDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ql8fCmIiGjk=:69fUFfYW7AFGFodj5qrrYZ
 OUKSQSuD/cZ/FlhoiecmBhZltalKW/YygITgc2LLXcI6ESCo8UYtCfkiFZsHIM0Ch9J/jR+Rt
 XhgrQJpToudxZ3UNaDpFf3h8eF7CAVwgx/BK0eiOO9iONWZxxyFzfzJWr+0JkUVfrTFGZgW5k
 LvrHXosxaTlAX7zh9urZWahxo4aKf/bAm7+ey3KliHJvjCOSiZblsCAGD1y9GOTS99XhrmtQQ
 c3QjyjnK7MIf5JnW7DsJRI5akr2w0/9PQKajh2pJlp3ICjEk/O51ZqCT/mdUzo/xITELdAsQO
 PfIma1yodngz0avHoNS7Zs8ZhhnNho9v6R5nq2LLXt21/y3bPzWGRXNVGWJqpRAOmpAHC/iFo
 73bwvfMhh7SD44qmz2HKs5J+dyksG2adfTDHwBk5tpMNeZy+BKBc1VhQmTlEQ5zCui2L9NewI
 KLTCxWjUewJ5jASez3GwySjhs10/quWlNDBhpoKqgbFn0TaKsKDISG+J/W7JbipZNv7RASPd4
 wdIeSI4CsBbQfId2m52GsAeKjmyqWLCP3LyRPSlXwFhsC/YE1j5jYtHrJgaI6FZI7lZI9A1q8
 RoRTFgS8QvXq8NYxLiLxV2ZJdEdi1s62JHdVV+zOgLjaEVVQLGsh8FSHivI88a2MegWCUg9Fq
 5h8/h5T303mzE9TGtqx1E6OGmuS7TvHzpmKi4bI3TTmVfx1ZzLdWbREnZ6OJY66MrMq0axWDe
 dIZHrWfLdOQ36IbRaB0fSye3C4oOsG9XM1C3WdlP2BhaYfL8IvTFLkb0glVzTDuTlGIHfgHZ2
 owWKIKIkCAfKG03HQzByYnZugaRJRb5cRgCtMx5PalGvhtvKs25QPODlr94PpqIQ6IcOOnR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-203006063-1511826172=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dan,

On Mon, 27 Nov 2017, Dan Jacques wrote:

> diff --git a/gettext.c b/gettext.c
> index db727ea02..6b64d5c2e 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -2,7 +2,8 @@
>   * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>   */
> =20
> -#include "git-compat-util.h"
> +#include "cache.h"
> +#include "exec_cmd.h"
>  #include "gettext.h"
>  #include "strbuf.h"
>  #include "utf8.h"
> @@ -157,10 +158,11 @@ static void init_gettext_charset(const char *domain=
)
> =20
>  void git_setup_gettext(void)
>  {
> -=09const char *podir =3D getenv("GIT_TEXTDOMAINDIR");
> +=09const char *podir =3D getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
> =20
>  =09if (!podir)
> -=09=09podir =3D GIT_LOCALE_PATH;
> +=09=09podir =3D system_path(GIT_LOCALE_PATH);

In Git for Windows, we have an almost identical patch:

=09https://github.com/git-for-windows/git/commit/bdd739bb2b0b

We just guard the call to system_path() behind a test whether podir is
already absolute, but these days, system_path() does that itself.

I am too little of a Perl expert to be helpful with the other patches, but
I would gladly runa build & test on Windows if you direct me to an
easily-pullable branch.

Ciao,
Johannes
--8323329-203006063-1511826172=:6482--
