Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE1BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB62060F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhH3TSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:18:11 -0400
Received: from mout.web.de ([212.227.15.3]:44767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhH3TSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 15:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630351032;
        bh=tQZK+WZKzRZLimMCzrZPPq6TD0WiihTAClHsEz6F4bA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PrFs2J4iPTKcixDuzJXSRGLT23OeDZeD2NWfp/mXXbrjOLFzZK+HUeNcwz+Uw6Aa9
         oG7ROuCicUBWmrunUbJFvAMjti4jKSpn1z3zB/bpRMjmBoSp0s7g1YsCMHrxMEgF7A
         DELLhyBlchTcuXkYMuvAoVrodOF9g1JT04IwAWqM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1mufUo2bzu-00Zy9n; Mon, 30
 Aug 2021 21:17:12 +0200
Date:   Mon, 30 Aug 2021 21:17:12 +0200
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     PugzAreCute <me@pugzarecute.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Bug with line endings on git.
Message-ID: <20210830191712.4nufzooxfoyuh5yc@tb-raspi4>
References: <17b982ef1f2.b8f13d4136798.2688982303431691937@pugzarecute.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b982ef1f2.b8f13d4136798.2688982303431691937@pugzarecute.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Wl1ZOZYGR9H2vmpdQMZR3zmsdsM8bWfFHjbSgiVzm3F48u3ivgK
 tJODA8QEERy+28X0UQhlhpitfvxnkMBQ4VtoqEp25gGajAYgPddCMa4I82L07x/3bBpWCLD
 k8Zwrkqk5okyqObWoX+PQJ0r3tVb1146ICuyo/55iqM7893MDMXQaq6alBvJLrJS/bgEVl8
 VP3xKay16MVP8Nv5TJoHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYmDHoT6JoE=:wpto6UAhZeNMzgCZiTlSa4
 UAxIWAipDjCzm1GXBKaNHoclxkNpCrfyhjUeSEeihTTusQTiy/eDJM76ZBrbP2nieGlYx3rm1
 ls9oZpdu+g/fLJXhS/a81rWriRA13JywaM0bIj6HBdMQ4b8UgH54E8GYAXyMkH39zexIQt0lL
 LQG8yWADmx6cxnrEuwVqzuUJR7Zi6ToEUjwATaFk/YXbOL4x3jRZQ3NX8lbbLSHgut4NynD8o
 wpiOnzsvx6D72kxSg3GNJvUaekh8KXQPi99lumIov7GmehMY+H93/zx5BQP0Q2Hj+hJIKhJOF
 noYpLjrn0oAfVKATVTQdbYHHCzJzk/oRF1uR6y7IejtQ0+YVj79L9h64s3i/BD/F4cANGCt8w
 OveCWsLTrYSNPFfJjhFXEztp+0atP0eeRODCrQpfExv2ES55mQKPUAxE8D8Uv0vyc0VhY2UEQ
 6cE2u5Fe1dLz/grD8yUBOhmS+z7LI+rKu4ceueGAr4OOweIIcjP7MWSM/ivk2rUffRxhmlbpZ
 GBYEVlW8EYI4MqkX/9TYUMVzzBvRpRfk8oMzMnWPopmOuSsaFGSjB01YhY35xa/wKx5TKU6WT
 R9LnKzyPzQugMtnl93KWz4wvamRhrOJ7wwOxEQslKr2rLMTCJmRcQVAA9lQoudew8G2DVSzzX
 33fpTm/uoI7bxc5oX7RVQ6bmfgslNZOCvlOtggOhDQ6rfXuqQtVSyxV98HnWT3f75Zwzb/THJ
 AdvNtacEnTpGfg8qdjnoV+/Fxht0XHrRCS0ADmjowXpKr6SExG+G3RzoQ/+fPZ0qd6fFFoUNB
 t4vwPMiWzV74LVODxcDYQihH3ilArQa2C15QENHWSBm83iuNR9GLgVbTjj9kSRMpRf6UpPTkQ
 P+Du7po5AIuGWMWmP/lJxLEhcwixKEynAsGdvRaDE15lfhh6+KR+yWZwO6B28xctxsrFZqQAZ
 +ZjGDrydO0jL9ZdMg7bjOuYq7lqS7zkHreepIhkANm/suNc9lrgkDsHT5NF3Obgd2VDlOENvP
 Ymkr3gI+MUJUMeLilkEPD8iFKkyClgfxZJBhy+VYMLXGXRhLp05l6+m30M74XCj6hiLbxQ8e/
 BZt6IdMPNUEXHNDJ7u3fXq6Pt58En1zEFzU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 11:20:18PM +0530, PugzAreCute wrote:
> Hello,
> I want to report a bug with git that causes "empty" commits if the line =
ending of a file is changed.
>
> For example: https://github.com/PugzAreCute/RFOEC/commit/31f5189cac3e076=
252372d634708b875a364dece.patch (patch) / https://github.com/PugzAreCute/R=
FOEC/commit/31f5189cac3e076252372d634708b875a364dece (commit)
>
> First seen by me on https://github.com/PugsMods/WoneWay/commit/fe58a0914=
98eb5d891e351dba0273fd8e6d4d283 / https://github.com/PugsMods/WoneWay/comm=
it/fe58a091498eb5d891e351dba0273fd8e6d4d283.patch
>
>
> Happy to provide more info!

More info would be appreciated.
Are you working under Windows ?

Both commits (31f5189cac3e076252372d634708b875a364dece and
be50904c84b56926f9f7f9912af6456edab82ca1) have the same content:

git ls-files -s

100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       COMMIT
100644 0eb95c07f7dd518679684826ff9ea516010c3847 0       README.md

So what exactly did you change ?
The line endings in the working tree ?
What does
git config --get  core.autocrlf
give you ?

>
> Thanks,
> PugzAreCute(Murali H.)

