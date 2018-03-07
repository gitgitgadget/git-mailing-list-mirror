Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8341FAE2
	for <e@80x24.org>; Wed,  7 Mar 2018 10:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeCGKs5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 05:48:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:52913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbeCGKs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 05:48:56 -0500
Received: from [172.16.7.182] ([84.88.84.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1eWF333eDc-00wZ6p; Wed, 07
 Mar 2018 11:48:46 +0100
Date:   Wed, 7 Mar 2018 11:48:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem
 to "repack -ad"
In-Reply-To: <20180306104158.6541-4-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803071140130.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com> <20180306104158.6541-4-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1939383465-1520419728=:20700"
X-Provags-ID: V03:K0:WhltFvZhlbjmjlk/i/ivNpGc8WvicVMOxFDu7JNUVzaniCPjiKF
 GLSQn9rUd5+4Ir1xo+xsJFBPH98ZhirSFAFyA8SOn8kJGn9G2zF7L4AQFV1dScsmEpd5Ryg
 vWhdO3PlnhgzAVXRN93uQyn0o+mqH2lm0LTnPPRW/mReQmUtb53mabpXKT8TNbdlDxhhI5P
 ugG2JGzG5E6N+vA3qb01A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kTqW95jtbLU=:BBkevQr9QE0WOqwgDWjHf9
 64hR4b8j3zTzTXmR+Z/A25OoR/u0DYtk6Ibe6ugQuGxD6aWbYb1v+Tyz2MrVq+P1PkPtv7EnL
 i99GvEYenkBZsfin63XP9uFlhSMzMl9dqfpK2Sv86bvoGRvAgdwYaRhX4kjOKW1Is1Do3pHVk
 49cSGVGXJ3bVGeajhdpGwoMXOch27EuL4jaJS8Keh2d5DFKD+7oKg5w5Z9WotmLfsIhOxGAq6
 Cyrt9X6GLPxrTIXzPGDsATaUfwMPV+r5O0ZStUI+ALcUY/ylhqiaJu4vPmpee23+pnmpJzfSe
 3B8z/fK2pfUboFPIyrs8QcSyt/b7zMCxLN6eSlAr2F8USuy2nHKVMpUICs3Dc1qiVIAyPo6Hc
 tzKXHQ5cNFUk4ZjpFWApQXyENrdvsUE+FEwnllDhiPklp9yVSmATTnnvPjYhpHOqPqqNz2y2g
 MZbEXnaPgWGrkxGWGzfbfCoMGmhPbTLUarm9HDR+hsLXCIIL54/FRqjb5mdbijRRkn+i8HXzI
 k2cjttZ2XKcbpdMb03cLV6ndZ9Vm7qEj4FyqEP4R1jidiKoIrC0V5FCsscLwe+V1nTa6auGlV
 6ePdn+hUcgaGvKh5MdTT/eFsICxjlRcMGHg4dVcEI0HJ4erNEM6/J+Z6F42j8Z3/lgkR8JO4n
 sn+i2PKL61oQt36cPWj5zrcGI4auxGMiBQw8kIWCxOJcBxtOrWBfKxd2kBDC/KS9fuRl+O+x3
 Zm2rmY32xfgW2tOXNzd1CPsqk1LQ2yNKLOVBND9kdCwOQhuzP5DDPMlI8w+RR6eIV+QDXVUuP
 W/jw3yufnd5lwLJE5MrJAvjMMJlOf4hqBOD8+VS2MIATMLNGQE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1939383465-1520419728=:20700
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Tue, 6 Mar 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 77fa720bd0..273657ddf4 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -187,7 +211,101 @@ static int too_many_packs(void)
>  =09return gc_auto_pack_limit < cnt;
>  }
> =20
> -static void add_repack_all_option(void)
> +static inline unsigned long total_ram(void)
> +{
> +=09unsigned long default_ram =3D 4;
> +#ifdef HAVE_SYSINFO
> +=09struct sysinfo si;
> +
> +=09if (!sysinfo(&si))
> +=09=09return si.totalram;
> +#elif defined(HAVE_BSD_SYSCTL) && defined(HW_MEMSIZE)
> +=09int64_t physical_memory;
> +=09int mib[2];
> +=09size_t length;
> +
> +=09mib[0] =3D CTL_HW;
> +=09mib[1] =3D HW_MEMSIZE;
> +=09length =3D sizeof(int64_t);
> +=09if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> +=09=09return physical_memory;
> +#elif defined(GIT_WINDOWS_NATIVE)
> +=09MEMORYSTATUSEX memInfo;
> +
> +=09memInfo.dwLength =3D sizeof(MEMORYSTATUSEX);
> +=09if (GlobalMemoryStatusEx(&memInfo))
> +=09=09return memInfo;ullTotalPhys;

This fails to compile:

builtin/gc.c: In function 'total_ram':
builtin/gc.c:235:10: error: incompatible types when returning type 'MEMORYS=
TATUSEX {aka struct _MEMORYSTATUSEX}' but 'long unsigned int' was expected
=09   return memInfo;ullTotalPhys;
=09          ^~~~~~~
builtin/gc.c:234:2: error: this 'if' clause does not guard... [-Werror=3Dmi=
sleading-indentation]
=09  if (GlobalMemoryStatusEx(&memInfo))
=09  ^~
builtin/gc.c:235:18: note: ...this statement, but the latter is misleadingl=
y indented as if it were guarded by the 'if'
=09   return memInfo;ullTotalPhys;
=09                  ^~~~~~~~~~~~
builtin/gc.c:235:18: error: 'ullTotalPhys' undeclared (first use in this fu=
nction)
builtin/gc.c:235:18: note: each undeclared identifier is reported only once=
 for each function it appears in

I suspect that the first semicolon wanted to be a period instead. At least
it fixes the build here (that's all I can test, I'm at GitMerge and miss a
very interesting discussion about the serialized commit graph to write
this):

-- snip --
diff --git a/builtin/gc.c b/builtin/gc.c
index 4f46a99ab54..9c12f1ee9af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -232,7 +232,7 @@ static inline unsigned long total_ram(void)
=20
 =09memInfo.dwLength =3D sizeof(MEMORYSTATUSEX);
 =09if (GlobalMemoryStatusEx(&memInfo))
-=09=09return memInfo;ullTotalPhys;
+=09=09return memInfo.ullTotalPhys;
 #else
 =09fprintf(stderr, _("unrecognized platform, assuming %lu GB RAM\n"),
 =09=09default_ram);

-- snap --

Junio, may I ask you to put this into a SQUASH??? commit so that the
Windows build no longer fails?

Thanks,
Dscho
--8323329-1939383465-1520419728=:20700--
