Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028B71F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfF1Mqg (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:46:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:49771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfF1Mqf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561725990;
        bh=SBnWwI+0CHhN0M0lO7h6AfNEqlCuuLDCJne6+JZ5DCk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y1aN/9YbnunZkfQFFMQHamWEfzp6Cv8pXkfX9UlNrbtI1JzdFdMFc9HHsiEMjEH2t
         UOXBHU6KbYW3IaZo9mPo014Q2M0kwVe0H84TDTsgpatRRtTKcva6DfPGEZNhWvKV67
         g3a9cRzYnOlJcUIbjfiJW+7NKDmQfP7StADW6fuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1iibCH2o95-012tNS; Fri, 28
 Jun 2019 14:46:30 +0200
Date:   Fri, 28 Jun 2019 14:46:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/6] sha1-file.c: remove the_repo from
 read_object_with_reference()
In-Reply-To: <20190627092852.11326-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906281440400.44@tvgsbejvaqbjf.bet>
References: <20190624095533.22162-1-pclouds@gmail.com> <20190627092852.11326-1-pclouds@gmail.com> <20190627092852.11326-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1586258442-1561726014=:44"
X-Provags-ID: V03:K1:s60QCSXHu6ulO0Z5SSjqqNjsX7/MKNAolnBZtEW2VuGK+b+Qh0G
 LHMOCOw6wpjxoHc+McK3GaKIwiAggFO07ucctn81GlSY2DJAei90l3woQD1G6CngpiY0znI
 rRRanhSOT3cc6WFxm+yzlTLh3HXmErwTiWL0FuNT88JB/XDFGTMT5fG57kqPDmdDH8JY3vX
 pnuoXRkviGEQKv9UkeZGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w1vgtgFzVoM=:TXMXTYm7btVTJlIeRMfeWk
 F8bXwEGX1XSzdEncP6iES7kSj4gl/Js/p+IkhW9CgntpQPj9GQ67rfLJawFp084+W6DXN5ief
 qMpNpg7VDt3ul7hBzKnaLT61tOesC352KsUk6SlzQNBnnzWYPf6JJFjZO0NhFJx4x6G7YZcpP
 nwdNSZ3VLC2nIhtVBDCsK8orGgTlZ5DDwKvChb4ZoiSY2jTrNZ4E8OowrDUmlMt0+7AOIFyil
 uB3/ITfLEprm26N3FDXyR0AJPZPGyhM2mq+4vGtZsUthfGxVuTA1RLgOnkbqkBuu8QoUt7pfE
 xJGv2LebihS1CPN4yBbxdC5jwhWnxA7PulzjmhYz6K+sMlAiKnhntjsSkQ1drWIawjPYn1Y4Z
 kOLA5BLH+UWvB+CveXFJkJJLHQ6EbvXJ3eEXq/Ky6DTDTMdgBNVSogRo+COAQwR1tQSpVELSt
 HAQ5AaoGOvOHTDwtTff+9rTNKf2Aa0kyL8KMjRGqriAsCp0olX2LJNGrHAPBdRhLyaK3cfPyB
 f6a1gm6OGKz4bpL9htvBhSpgpps/kdXJhJ5jXfK9L/YYF28S7Ec3U8VV91svzLI307CcicPc9
 GpLEz+OPA5GgVG6/320/WRc+HEQdqmiy8IlNMRTGqczqzz/ajpvevp92IbD2QQARdoQalGEV3
 O8QgglWeBW7LZpaw7Z2Xpcu8Jgr2K9H6OC/JbnpuhP2hjuUyeAHhj4PaIVrHexBSycMJUY3mF
 KVTRsjCRU3OQZjLR4cdwToryn+JOFiyoJkN8CQ0IJGDAZremO0kQFRkJLuQb+6irExUqB4Krw
 mP7KsuA0LtRxQkO/9A6EQFO0SK0rRzlQNHM/IjOYp4i8nRsNG49Z3b6rQjsV8YlL6EBUYHti2
 +JvjIY3lXv03w6L5V5rTY2kazGhL4wqC5iufnBKIEdaGmBXt9KCYh+v9fxdWoD0Kx1vP0ZX0v
 LpzFsQgGuQGGh+uw4878hd+S1M13bQ4zDq5Vn05e/7FrQeJh9R3GPyMnHtNHcLirtsSadTH7c
 6GhL5xVPOMesBh86mGx/BNzi+igBUvFUU97hLw5+O0P+gsVttcTYwQxwxAjubxMNJR/PKGlzu
 juGLPUyw+IUf/d9BJYTGQ9l1+EXu8pBmtSC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1586258442-1561726014=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Thu, 27 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
> ---

This commit is _awfully_ short given that...

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 580fd38f41..560051784e 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -458,7 +458,8 @@ static int grep_submodule(struct grep_opt *opt,
>  		object =3D parse_object_or_die(oid, oid_to_hex(oid));
>
>  		grep_read_lock();
> -		data =3D read_object_with_reference(&object->oid, tree_type,
> +		data =3D read_object_with_reference(&subrepo,
> +						  &object->oid, tree_type,

... this change and...

>  						  &size, NULL);
>  		grep_read_unlock();
>
> @@ -623,7 +624,8 @@ static int grep_object(struct grep_opt *opt, const s=
truct pathspec *pathspec,
>  		int hit, len;
>
>  		grep_read_lock();
> -		data =3D read_object_with_reference(&obj->oid, tree_type,
> +		data =3D read_object_with_reference(opt->repo,
> +						  &obj->oid, tree_type,

... this change is totally not what would be intuitively the easiest: to
use `the_repository` in all built-ins.

It might take quite a lot of convincing that these changes are correct, in
particular in light of the regressions introduced by the first iteration
(to paraphrase Warren Buffet [*1*]: one slip in a patch series touching as
central parts as this one will need a lot of time to restore trust in
subsequent iterations' correctness.)

In short: with such an empty commit message, this patch is no good. It's
as if it was optimized to pass the test suite on Linux instead of a best
effort to make the conversion as correct as you can make it.

Ciao,
Johannes

Footnote *1*:
https://www.forbes.com/sites/jamesberman/2014/04/20/the-three-essential-wa=
rren-buffett-quotes-to-live-by/

--8323328-1586258442-1561726014=:44--
