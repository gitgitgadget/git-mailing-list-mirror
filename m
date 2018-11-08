Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D601F453
	for <e@80x24.org>; Thu,  8 Nov 2018 13:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeKHWjv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 17:39:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:56045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 17:39:51 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lgql4-1fgg4b08RC-00oBe3; Thu, 08
 Nov 2018 14:04:19 +0100
Date:   Thu, 8 Nov 2018 14:04:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811081356350.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com> <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet> <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com> <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ffGHcUOcvITBSTy0ltTJJEhiYbVeuWLHXT3Cg+nymZVRX30uBUY
 SjxnaUx4ZDtr4W3UWcTuzb64r01HYvLrMYORjsE+pYb7pkZuQYR+l6ib+JmeP5BXw7jnXDz
 E78vb8Y4eSvIO4OaeoLBR/WUeSKtIH3IABmoW76lm954rs/BKgc90vbR6IY5qLFKBuwGdCS
 bnD/a6BXrCakBe0zVzqjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a2RKn2Y8Zlk=:IxJl0mHzkGRxxti94zO9dx
 QZoxlGHJD0+StCOYETyVtb7+HZUhc5fQZIAD0YZzoFsb5yU/THVvgRsrET/htfW8dBIePGs9V
 4RkeROfDXTbKAQzyGRdCp2IphaN/sX4i55HMOgR8MbLWGErU44kEZEopywku02X9pNnNfBaIX
 ccvbiil6V52mnVhflgZ8WkWFShH1lDuOhFqqLyM8XpUrL3bbrKedsN6CLr5FHo15F986qPM9c
 doWn+DxQfG6BNpGU41eS2FhVFWE6m3wKxE3IRktplhXmSfEOUMNZSyDRWtR6tN9Nfo8lsmJ7S
 pWlUMVTAG8W9HPG5augT+ERlGB97bhRudnHQz1z1cDk5qG74A7qaVLFyNkziLnfDcE9gNrEfm
 XMMUjDBqCaFlW92b1qiEaGFY0GJRPqhR77B52YZDH7AP4Un6h649c84mkvqGaymtmEpTlMGPQ
 36EQWcylN2B0n8K59pmpdgZ/y1tnR8NXL5LTvpgMFweDcVTXi6htBoUC3yZFFcUEAK69Q9PAq
 Jqg1rHm15Mug+YlGvBQyEJIlIFiKxDIwzAr+lHF6OxPFqBOpb+HeFH+JHuoacxvIubFVGAkQA
 xhdHLok25EePe9r/u517HxRCtaUYwRYo/K4fZ81IUVUchpftPFCXQ5QQ2J8CHxu4mLSyOQEiJ
 RujQHCw0GdnYnjGkkQoWpXMD4Q59oYH7KII7pEfGrh93iyg60IU1NNmVsAjfWVV6e3S4lCv4Y
 GEcib6rz9sUzYS7dCWQgAoFE4z15axwnAGC/tAAYxnkAe87ccF6tcwsQJMhM1/laGvHPKDwEW
 KAp7+wvcZbCKEC2PfZu0hzPKzBGktmyyLYlfJXExr4qg4+EFJXt3YXaIiNP/WRvjduDmWiKkW
 1LU1BZ1i/B6me9dJpYwCXJYjrBijODhH1Y0vUGbwhsgkOFs0yiDvogx3S3SFFyqW+TI4gTnGd
 qgXr2xkCEEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 8 Nov 2018, Junio C Hamano wrote:

> I am tempted to say "//<token>/<the remainder>" might also be such a
> way, even in the POSIX world, but am not brave enough to do so, as I
> suspect that may have a fallout in the Windows world X-<.

It does. //server/share is the way we refer to UNC paths (AKA network
drives).

> An earlier suggestion by Duy in [*1*] to pretend as if we take
> $VARIABLE and define special variables might be a better direction.

My only qualm with this is that `$VARIABLE` is a perfectly allowed part of
a path. That is, you *could* create a directory called `$VARIABLE` and
reference that, and then the expand_user_path() function (or whatever name
we will give it) would always expand this, with no way to switch it off.

Granted, this is a highly unlikely scenario, but I would feel a bit more
comfortable with something like

	<RUNTIME_PREFIX>/ssl/certs/ca-bundle.crt

Of course, `<RUNTIME_PREFIX>` is *also* a perfectly valid directory name,
but I would argue that it is even less likely to exist than
`$RUNTIME_PREFIX` because the user would have to escape *two* characters
rather than one.

> Are there security implications if we started allowing references to
> environment varibables in strings we pass expand_user_path()?

Probably. But then, the runtime prefix is not even available as
environment variable...

Ciao,
Dscho

> If we cannot convince ourselves that it is safe to allow access to any
> and all environment variables, then we probably can start by specific
> "pseudo variables" under our control, like GIT_EXEC_PATH and
> GIT_INSTALL_ROOT, that do not even have to be tied to environment
> variables, perhaps with further restriction to allow it only at the
> beginning of the string, or something like that, if necessary.
> 
> [References]
> 
> *1* <CACsJy8DmyU_Kn4yytu_PQdpppXO8wLcuuzQ-fjwnyjA0ntB2Dw@mail.gmail.com>
> 
