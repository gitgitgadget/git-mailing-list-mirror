Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B55F1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfIZSor (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:44:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbfIZSor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569523480;
        bh=H654YJXfXIexgM4qvq59pv7hDpOeRpCx3t6n5iJyvwA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Dkk5ZHeIcGz4zhsJNaTI3ZcMELClbfdtiZPESH9cM3gfjWn+4FPZj/cRgan8E6Puh
         NC+4AOLP+DiVnQwzxKr5bbl4Or8bflI+Y3/qrOpVeLP168PvMavJASWqfSTPgVJmbf
         96hsJ1RbiAcNFEruvWvnSB6+td/dCjj0urgd8lI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1iLpxm2ISc-00AZg2; Thu, 26
 Sep 2019 20:44:40 +0200
Date:   Thu, 26 Sep 2019 20:44:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui contributions, was Re: What's cooking in git.git (Sep
 2019, #02; Wed, 18)
In-Reply-To: <20190924122306.bcwe37wlahjimve7@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1909262042590.15067@tvgsbejvaqbjf.bet>
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1909232132570.15067@tvgsbejvaqbjf.bet> <20190924122306.bcwe37wlahjimve7@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v2KWhBqJlsOpFhpkpEMcFVnzBfSTXYZuda0n5KqaJFHEKdpfyUt
 kBcqwJrujKVm5qPHpGdSQ+/nNAJ75p90xwAZGCZWmRlth/UCNNTkG7i5f1kzWpHGJIYFjij
 yq8Qu0sCjrKTlxfK6ACgZ7BVtWLoN4CmRPZ5+UsN5kviSAtcu6pcPPvX4nqZL8WB0Pz4z3e
 OnrbtlwTuiUEzPaKHBMIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2I9Kve43/eo=:8TKNb7ueEEA+jJwqp65G6R
 GE1RLZ7SZ1zHOwCoDrdj/qtybd0eLbRtUKtZPsTAjGs8Ca32ZcwBGma/fnNIOarCklV2jYKHJ
 NVpizzth8PLvoGh18TvD7mtU/kjh3B+TjXrxHqdEzOQH0g3g+nr5pE7ZXoeroqrs64D2s65uG
 4n/57NoF4p5MT0UqUhFN21JhNh2crf1Y4bZ54RyKLnyTT8oHQlHfQUg7Jx/uqtCtF97/ubvcC
 p7u4HN3ozsF1qTVYDakiqr6u9ozpvdSR1COab+Rzbr5hcZyTwbQguN5rwPIj4LDkEE1y/RUuh
 UzSYxDd8sjQAeymdxyqkGepuAPW/JiZYc/U/JPCa6CG/+QDYmMRPeclZ7vjr+EaZFRe+PLVBj
 UUPNisSWgrZulL8ctVglL9JtaRK0cKJaPbA0hc+ehBKwWsi4IxuDuqq7u1i6uiP/DWco09OBw
 EEjj/bAbAx887StQeldXuFt1lArlycVM8rR8n+hrMAp4EdmBQU/sSVS586JIOS4c6/MglwBSR
 yqU5W6rUQ9yRHhb2oLWvgghFdbYiMb7KvbjCILhdZYHzGRH8n47kzOE7FszSVZxE8f6CCSVqZ
 Cka+gUfjAZTG0ZdACoGrLQfPxvU4yhE4caUZ0taMtuFZbl4WMRJ/SO0QpqoJbcEnm57EH1unN
 fDz4BDNDY0BLNEscZE1zgDlJj8e6RwRNHDydbhSKLvZlbAKDK4eMmasjjBkHI+nPNjTQ98Tvn
 rxDoM4AeIuUZFpKpDS6o8PTi8RPtb9DjlDXCrOEjDMsdiPSKo76dTgf59M3y/NFbxRvOgUG4v
 S/tGzBTpESbEy4LTMs8d5hw5go3fuMwBuHqyHKtS3knPIzbXSNbGPU3T/eZ/O9IKu1i2YjofJ
 noTH7At1lXtEXaZ3IX6aPfP3X3kWizK2G8irGwrADjtnLAVpX7LQlLhT5cKvMoKzudH5aVbPu
 aVmdykfYSlaMYCOVeAEt9h/uoquJTPfDoAHwKUvMOmhccAVEzTw6zwP2+5J06Oq5X2gHnk0TO
 BW4CZDr+j0zcN5MUfQshdBfcYhWpwJwStMsKTeqYfdhpW755zoscwn8Km8gJd2drupAfJHeu/
 2UnqRexW87DHOIVrfRtT/ikeZn4o1R+HohCgx7r9qF8k60dA6ZHStY6OSPHj2PlE7vFJD3dts
 HnBHxzNvtdDf1/mUBixa+JW9D6fyPDDTBY7YWbc2VTQYSfhqGzLXERt3Khrnq7YnjtWIh3nWl
 HJmI2A5+IVpcK2XtFYjjiYVtP0T9ZxJ007YAzslde7GegxyKUyj1ONO9hPfg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 24 Sep 2019, Pratyush Yadav wrote:

> On 23/09/19 09:35PM, Johannes Schindelin wrote:
> > Hi,
> >
> > On Wed, 18 Sep 2019, Junio C Hamano wrote:
> >
> > > We have a new maintainer for git-gui now.  Thanks Pratyush for
> > > volunteering.
> >
> > Excellent!
> >
> > I opened PRs at https://github.com/prati0100/git-gui/pulls. Pratyush, =
do
> > you accept contributions in this form, or should I do anything
> > differently?
>
> I prefer email. Also, please Cc this list so other people interested in
> git-gui can take a look.

I did so.

Since mailing list-centric workflow is cumbersome for me, I used
GitGitGadget (I had to work a bit to allow for that, and you are Cc:ed
manually, that bit is not automated, I hope that other contributors
implement that in https://github.com/gitgitgadget/gitgitgadget if they
want that).

Ciao,
Johannes
