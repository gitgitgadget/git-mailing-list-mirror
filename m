Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D6C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DB960FD7
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbhIBOBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:01:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:42099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhIBOBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630591217;
        bh=7jgXEjUhsatUrAFBWOkYKsNaxj/icw9rfY0E5Sm5X8I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cAW37mbbOHBrTt3cb3jxNmjwKXVV1eA6V3fGxKajy6/g4Z0E7mhpzAMB265UmpCPr
         D6ZRJNqWbnpJTPis4N05w5/3zJTcg2of7UjTgw2Nr3OHTX3Lh/YcCIbxqqhrLtbN25
         JSDEfmW2iGmjoXUa/R/beULpXyuY3Mx8WuZqYNZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1mgcRB07wa-00KvS4; Thu, 02
 Sep 2021 16:00:17 +0200
Date:   Thu, 2 Sep 2021 16:00:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 6/7] git-svn: drop support for `--preserve-merges`
In-Reply-To: <87zgswv34e.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021600070.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <a987e9439af6335e15a3d41b82832e9a8824317b.1630497435.git.gitgitgadget@gmail.com> <87zgswv34e.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-254040796-1630591226=:55"
X-Provags-ID: V03:K1:6zm+L6n1KXbiWN6cdGDsQx92Sp7zxpUj6hzp1rZIP4f4LUuVSIC
 WNhnOFP9cwyo3IOlmwPcs+PXhkaaa2IFLFVj4cYYW43Tc/6R5hsRB+ovfQEIi1bSoljAUge
 2c9J6fuu0tJswT43XCpi9ilmR2xAn2wiKM7f95REZMiuqtzrsOQ8X6jnb3kymBQZloHjF0v
 1PkyV4DxEQSmxOEX83dlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncOyfEVtlUE=:/O6hCopFVneCI6NpyU4tC0
 ZefU819rg4zwp88TEIVQ4MHLeuIY1c95rXmyMSiHVwsV9x3FWjdKAyJqkBCwZmsPI1NEOTAL5
 mMhITOTr3y/rl697Eygz4C9sLrbeGG1fb+gaCgXrEYhoJRdraZOJafmhCRC+5lBgOoEeWqw/9
 Sb4lVg3B9K+ychhcOv3398Km6QdSVabVYdeLIbeTv8mQ2xiCG7o+O2995gAa/hcay8Fr5sT4q
 qsbuGAfgsywcPYnMbh/JtHZYEYeahoO/4FYoaDZy5hX4p3llc3PfprSMjnSH9hASeij5GMMI8
 eJpGz1GqQTxqZH11sYt+u2r/SRQHcTYh3/yS9Ol+fgG9iMh1RsGyfSFVwkMMx4GKJj9E0nAwz
 nCPj7iE6tzw7mZujmzbm+UBMGPdH0l8uiDKLUbdAhnexrD4ajB3prjA29CuF9kvOGpYyDtQRM
 db9uG94Yj529LPHF9ey38/jB/YPxVB9DC4SIHUfRa+yXtg+fhJ1ZTAkgPSzQKv9OpwnmdzFmu
 g1achxnE2YSGaVk0pFFYa04T7H16RP+ScUApOhyI20oTq01y24xUFspfaoZcqoMKwK6UJPAtM
 qNdsEf0ZmY7XSqtmLkHOR/Qd0yZIVXd7n448RSCWl7H4XkAj+jBs7LnalSBViXIEmMaAYCqz+
 bo9GhbN2K8D74jTJcE8Srj+P2vNnWtXGwKZpNL5V+GiHWycgj0BsIW3hqrx5Q8rzJ9+lAcQZQ
 ko9Nd6cLFaa5JElA/xbO0/jj/WxcEzNMezopnqPKEppB32qYn2DtwoQXNfEq74dNy2LIXHU3p
 aTRNBpysBK0jCawZEPML3TV8Mtsw7x0f1nf2N3MlOprJ8qW2Xu7RLe8dSHPssdlwW+cQqL78k
 CQXYgsBpMtQLfMTPiojMO9lQMym0DGUQ6ZyVQNPkGWWHYKbhNAZr0hj4MPKexeIWLJWKDf+57
 j9fSZGzzB29+pf99SGpUI+M9HcacJi6DrorrSBqZnoZH7gv9Y08gACKwxyV7lyNJtAeBjOUy9
 zBAU/TXtzw7KC1cTCq0oxjojXY9Dk5i2i4NZCAFPfFYYBjSH+2BtUf7GK4tkO7tQ1Jr1i/XWn
 JFt8yubcFSeuKqUvCHLfsjsHJH+QcaJT3TmEk7nlGyTuQ89OJlce+QUlA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-254040796-1630591226=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We already passed the `--rebase-merges` option to `git rebase` instead=
,
> > now we make this move permanent.
>
> Unlike the cover letter's claim of deprecated since v2.22, this in
> particular has only been deprecated since v2.25, i.e. your follow-up
> ea8b7be1476 (git svn: stop using `rebase --preserve-merges`,
> 2019-11-22).
>
> I think it's fine to do this, but at least updating the commit message
> to note the difference would be good.

I will update the commit message.

Ciao,
Dscho

--8323328-254040796-1630591226=:55--
