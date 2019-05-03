Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C80E1F453
	for <e@80x24.org>; Fri,  3 May 2019 17:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfECRBv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 13:01:51 -0400
Received: from mout.web.de ([212.227.17.11]:44571 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfECRBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 13:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556902909;
        bh=aoX9a5/6ompB8Prm+W6/xXjMP1u3ewKVrvlKOk50fTc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fuFmSL4J5kPoPF27R50I4E4cs9vJSmaOMhbVjA4XzOy+dTTMFX8g2Z16+mc6NbQhh
         ylwYCs91mIKqze5nm9R3twaGqdTAxAnJxs8ibD1hDLNEG8DpceiuYRy4VboSStnax5
         ijhYKr3omA8qDJBlv93H+QQ6NHbsgAMtZbJct3QA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBPe-1h6a2t20II-00PxnA; Fri, 03
 May 2019 19:01:49 +0200
Date:   Fri, 3 May 2019 19:01:48 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Andrew Molyneux <andrew.molyneux@neuxpower.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc/gitattributes: fix typo (UTF-16LE-BOM)
Message-ID: <20190503170148.km4ftgg6gbgzd6pn@tb-raspi4>
References: <20190503140952.9029-1-andrew.molyneux@neuxpower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190503140952.9029-1-andrew.molyneux@neuxpower.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:kdIMOsS674mg39Z+E1VdB1tFVEVIR4NxQ8N6YldV4jT33UJuNcp
 21Y96VE5Cyx8lh/76U6bNjcnI/0emQiu1L8iqZsHBXBloRYWmvtZa4foa4XxtDEP0ccDocQ
 U17I3Gotj4Enslf5lbyuuv+5LNrB1GZOzBPx6+u1Ap+IMJPaOQK1UcaEisbaeWIW3/2slMO
 cc9uTEZ5LVuaMl5Y4cwmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7AWiFuACKs=:4eyvR4c4jRwFZgAahBvC3m
 j+CC3gie3Jm9IroNluVYRDR7qZRRkMXQkhbZE3Zh8N4xWD9JTGFTz4zxwgfSpAhjz/ULi+7im
 +PJbT4A5Q1g0zaiyzw4Uenb50vKaJW65UtuoBj1TQgDLiptddr7mG9VoCwLY/fJuB3WVaQl4P
 UHNL02+0tCX3QN33P4+g5s7ljXNaUMNVitN80bFiu6uXIpZbgaSo/zfZo13qSnoqGT1LNyGJ/
 84qiEoKpFbFtefgeryjeSi1LV3aHShg4YnpNFg/NEd/t26uF/CIQgOSQWPnbpen4Z72tLD5Ym
 FHIY94uSI9krWn1zRoDscmwmSMHUpKCHD1BOby36DfaqdT0OkjyxUVmq/LXbtB00UDL3A5yJv
 pUSQohLQBLhALPNA/jX+Kkj84bLKV6liYfU8C8EGw7w1BMVdYwlbyPSnEIcQFlEZnD2P+wexU
 dYOzEBm/pnN2cR+JDdjhUWMl31SKhzdP6P2LWIJKPVe1jruu7CphsxuUXzDOrl52iustr4r2v
 YFu0GNEKaI147EMketRxRG3/WewIeU/A8FlqRVUBPAYWGF2wHLFcEXmWcG/wpNrge/TLJf3SA
 eltZmQ0Zby1a0snuLHzgMDeHvF3OiPww7qCsjLqJ/FQN9ZyRLDd1Q452TZQWsVygb0vC4vagr
 XSwV99+C0IuBAucNJvHeD1688yduYe7w1K2Z1QZG5aDLnB49I6hPUf0bLiKOsv4hAxMUqAoyK
 t1Zle9juy7udNibe06rFmyVzJwvShk0pxP6lT4SuJkDlvACfvYR++EuJsuVF/SYKovQZHaHWh
 swymwEYsBUHdzJ7+OEXDSaM4EadUY1347Oput74U3K0NeO63ckopR1EoZGfhm2APn2o9I2crH
 NcclqnV+1jLSUeZwQVzSurQZXWk0IUcV8HBYPcXU+uEDQsrlf6me42ppgxm5/t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 03:09:51PM +0100, Andrew Molyneux wrote:
> Encoding name was erroneously documented as UTF-16-LE-BOM; this should
> in fact be UTF-16LE-BOM (no hyphen between '16' and 'LE').
> ---
>  Documentation/gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 9b41f81c06..bdd11a2ddd 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -346,7 +346,7 @@ automatic line ending conversion based on your platf=
orm.
>
>  Use the following attributes if your '*.ps1' files are UTF-16 little
>  endian encoded without BOM and you want Git to use Windows line endings
> -in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
> +in the working directory (use `UTF-16LE-BOM` instead of `UTF-16LE` if
>  you want UTF-16 little endian with BOM).
>  Please note, it is highly recommended to
>  explicitly define the line endings with `eol` if the `working-tree-enco=
ding`
> --
> 2.21.0.windows.1
>

Thanks for the patch.

I think that patch 1/2  is in upstream Git,
and even in git-for-windows/master - on which codebase are you ?

commit e6e15194a85af68db9f9ce076eb32c47e7063b3c
   gitattributes.txt: fix typo

    `UTF-16-LE-BOM` to `UTF-16LE-BOM`.

    this closes https://github.com/git-for-windows/git/issues/2095

    Signed-off-by: Yash Bhatambare <ybhatambare@gmail.com>
    Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
[snip]
 -in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
 +in the working directory (use `UTF-16LE-BOM` instead of `UTF-16LE` if


Patch 2/2 makes sense and cleans up my mess.

