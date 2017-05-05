Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44356207B3
	for <e@80x24.org>; Fri,  5 May 2017 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755593AbdEEVWA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 17:22:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:63475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754341AbdEEVVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 17:21:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcmN9-1doIgD1lKR-00k78M; Fri, 05
 May 2017 23:21:42 +0200
Date:   Fri, 5 May 2017 23:21:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive
 add
In-Reply-To: <20170505201621.25560-1-avarab@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705052320270.146734@virtualbox>
References: <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <20170505201621.25560-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-572000080-1494019302=:146734"
X-Provags-ID: V03:K0:MHEOXnvKCH/+kxhJ1N9ZjfoRe3YcrFEbsunYwc0Z43D3QXoqdwR
 ZJursottF7Ckprdq/8wlcYXlW66XLDPneGPwt2bLA4ODmrhJJKLmnpJwBlHFLFUGBkqIzyF
 /pkaEcqvkL/j6wQOBsuRBFcOrJzZnOHPvcod8jJZUJANslzpSIoi/QR8X5No/WxfFEDvmPW
 v97U1xgmwqD6JCQroiuyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0wNxIECiRsE=:TpBuL8zj6LVFM+kv/NF6nL
 3Bi7miaBb1It98pMDLKl9lJuIyKR8EA1dA/j/b6+TEAcZYfWuePMaQ4JgrZLP1R6ukGsRhU2T
 j6flqQB03LQZN/8LsJui9uRRx5SjYPUKj0b8t9PfRnKI6flE/Xs9yj+LD+AwsAVccPvLQhWxP
 yisvpbKkb4iCBQ0oPe+y3zA9us7vAtWWYmUkYYLKqFDoL8ePYUb1K+xfyL/EEthSd34npnVkc
 IHAsFaCAl8mghsgokIqNmDonTIseUNvOE+hleYF2KXELjQzBKJElB5H+n9os7fQL6tRBuv65o
 Jfg7+RyNC2+biMLMmXD5PqxspTKEOVppiY9sDBKvLVS2M1IWmrlbtB7KoUxYgx18nYBXxjLHi
 G67xfWUHeznmEupMXfc8Vz4H0PnDkwWIBafYyf49C0AWMlQTslO1O0zMvCHc202kaGFE1q7jW
 aLNm8PGrcVB9M2Tgi+IUpJOEP6wf/XewjsNTga2bHjqPJ2jyKdt12UnsH/u3vLNBPbg6L12Au
 uveXOvaGTGuPVhLOXBbAPJVb+NsddgiJzacwyA2qsoWPMoJfQAMz62a4OVhXeoUse2UG9VT+A
 ARL8eYu1d/NP4uW4hXS4S2f4ez03hdpwodrAo4suZJEKEqa2ds3ujLVbaFqRW5roVAWCHc/k+
 Yn6lzoqtYjkJTbIQU0FDFP51Avbcdj4lGBEh2oZm5R/1UMZoMaSr3NH4wEckAECeD033XTZGf
 +E17S3Bo2TqgNofNyPe2YzP8RRhZshQxEY7A6dLuwH9sInXQXjr/zo5RfjwqtbgjWB+dHyQws
 05qDJ3O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-572000080-1494019302=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 5 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>  int cmd_add_interactive__helper(int argc, const char **argv, const char =
*prefix)
>  {
> -=09int i, found_opt =3D 0;
> -
> -=09git_config(git_add_interactive_config, NULL);
> +=09int opt_status =3D 0;
> =20
> -=09for (i =3D 1; i < argc; i++) {
> -=09=09const char *arg =3D argv[i];
> +=09struct option options[] =3D {
> +=09=09OPT_BOOL(0, "status", &opt_status,
> +=09=09=09 N_("print status information with diffstat")),

Please use OPT_CMDMODE() instead; it was invented exactly for this kind of
scenario.

> --=20
> 2.11.0

Really? ;-)

Ciao,
Dscho
--8323329-572000080-1494019302=:146734--
