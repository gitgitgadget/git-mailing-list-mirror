Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8EC433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22C0611EF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhDQIy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:54:56 -0400
Received: from mout.web.de ([212.227.17.12]:56285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236057AbhDQIyH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618649616;
        bh=oe7hBhjNbyDUVBJOFfIs0A1T9xqwQIwgyrTUv/FGd7A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fHu/nle9gveL3AzlZc7zjY8O0t9z+fGoJk8PsX7TrogYGvZT3Rj5OfcjvJvyCxs5F
         MHPvrmzw9uRGm/oWTGK43a5Jr+q8T7TopY7EN36vgC1EVa96RFSGKWvN2r/MUar59h
         OnV+JaZEFFnUcZKUDjavovocLlKMRftob+3bFBLE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8X7-1lXxp31D3R-000Ova; Sat, 17
 Apr 2021 10:53:36 +0200
Date:   Sat, 17 Apr 2021 10:53:35 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands in
 Perl/SH
Message-ID: <20210417085335.ib6m4jagiekeulec@tb-raspi4>
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hDgCPNGyCyhW96wReybEZh9jSsViFwYZp9R8JlgoLevBeG7qnzh
 JVxLyficAs4/XCPaLUxaTk4Up2TTTA7zuQiCX6CpvL6IG88JjilxVwpnCRGwb6GeGi8fG6L
 5jvtsqXa3FURLQkiDAcoexJWZfmJk7b87ymqdszDotTkoukwEp/MFpksuARgfnY5MH/sS8c
 EBrwG4jeYPYNtVu8SmRjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGmrntDj/78=:8KJVmahzSifSaOxJr6t57Y
 cpKeQWcZR5GYoG0V8lhW846cORAH7mlJzPDuwd+SjPtRhI4KE9luyCgOsQqjWrnfHodtxJuiT
 vrtKusNYnnlo3wy83899bLGhQVrE0WC+od70zgdqt+Dmg8LM8lIt0/TMCf+5UlZTp+l4rLRFl
 O7hjy738VWW11RY9q/rIuZuOg5xhIb3VBb38qRYN0sJlumIVaSwSkDiaOP5vxoBxySH8y/uZY
 /hZ+2nPVkuhkaI3HsCDtwZx/otm8OcO9UEIeTjF0b4hDOog3eMU31y8ZumYpgjC1HwmJ/CN3C
 hKcuwOQA2GuTaaMna0odaeM/fupzIJgFt9mwS8PF3ini9TGZav2Z9ALixt09AOhHjraNAUddv
 I8B1UyJH3xvr+sGjhRNGPJfTdYxBLmrHzB7jxZGjyt5YMRSV+O4Y+Pk+XyDfC/v1F07ZNIEF0
 Xjoen/CSngg2okx8PnciZ6aT6elqQiA3LjF8uV2aik6O+W9XXnnL9p0IUv4ZvXx24lY8ygcBE
 pu+sFWf7gPKImA2KiLnagGsdAfdsD1SpvYb1IbB1iz6F425Qbbs2hEDUXPZ5Z1RCwANa4hjf1
 Q/ieIX+Flpx60cCCvnmq/mwzmVC7wA316ddqjIcFBwzzBsWFvXZB6zRfaAyOUj58LvI7W/51l
 7jV582IdAapgALbGZoGO+oSokQAu43maa+K8qxSJd5sVOQLk+HkDeeq0f1GqDx+8Cegiv0GUG
 w2eHXtVDeuHZOLSl1JW3Br/Fc3BhrpkVfHiKfFvvd2PJ2HyZnynTlYwwYhwNP1FaBJMPdqijY
 12LN4GSCioHNleIAsazXG5pbRG/vcu9TTGBvqBok1TQOy/Q5QRbiWmttBrg3MWc49W4kPkKA/
 gTdvziI/1R4ntXrQZ4Uq/9OLuFutBGKFnmiOc8XDDZwxbQq3fqHLZxoSJ62/EShOtHNEngQII
 XT7tq2VdllWNknul06OTAQl5tpDm+dMqE2KZH4S4SydpmYpnKpl97xCr/gA+EQPl2HuC64eA8
 JehMdGhK3yf8alCmbMPW6TTx/ibeXXf99/Gckgfrp64dK/gJC3YGBepMQu9mfPC8OOCsOgtBg
 Ux/XLjq5opqMnpFgDLFK2ZpbhfVE7BivgvXY0lDxSlA8Ee/Qv3RHVoIGTEJX2O1jAkD0rThev
 MDeFkWoul+vfRgJUmXpUl2lVjNYnrMih4WutmieTvcnhCBTpREh4AmEe7XeSuB0jN34Sc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 10:43:54AM +0200, =C6var Arnfj=F6r=F0 Bjarmason wr=
ote:
> Remove a suggestion to write new commands in Perl or Shell to
> experiment. This advice was added in 6d0618a820a (Add
> Documentation/CodingGuidelines, 2007-11-08).
>
> Since then the consensus changed to having no new such commands unless
> necessary, and existing ones have been actively migrated to C.
>
> Signed-off-by: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>

The patch looks good - but the Umlauts are garbled:
ISO-2022-JP is used ?

> ---
>  Documentation/CodingGuidelines | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidel=
ines
> index 45465bc0c98..b9cd55db6a8 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -416,11 +416,6 @@ For C programs:
>     that are made available to it by including one of the header files
>     it must include by the previous rule.
>
> - - If you are planning a new command, consider writing it in shell
> -   or perl first, so that changes in semantics can be easily
> -   changed and discussed.  Many Git commands started out like
> -   that, and a few are still scripts.
> -
>   - Avoid introducing a new dependency into Git. This means you
>     usually should stay away from scripting languages not already
>     used in the Git core command set (unless your command is clearly
> --
> 2.31.1.687.g1d87aeed692
>
