Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0760AC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA42D22240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cb5vPtig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKMOTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:19:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:44925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605277151;
        bh=VqnyalnKeWrHGNB5Pjrhxr7rG0yo+uhjhWEl1suA1y4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cb5vPtigo58aPreW1ryEA+Qml3HnTcx1MxH4/IxnU9wfq9x9ktgn6RRSA9iN/Pyyu
         OBLUZASYUq5gMaFRW+Nu95YVqwZKeOf64OKP++H/yzmspbH6PDCJKC02eBlq6uVX06
         gNIg/f6okFqTZl9nXGU/hQVKZInYEA2pC5rbm9lE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1ksVT32DTW-00KQoM; Fri, 13
 Nov 2020 15:19:11 +0100
Date:   Fri, 13 Nov 2020 15:18:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 14/28] t55[23]*: adjust the references to the default
 branch name "main"
In-Reply-To: <87sg9dfucb.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131511060.18437@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <3aef39320e96aad10e133f1c97a9010aa85aa894.1605221039.git.gitgitgadget@gmail.com> <87sg9dfucb.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-371731460-1605277095=:18437"
X-Provags-ID: V03:K1:0Y4s4PxURxxA6dYIDzc3JaPAd9aWbMx8CQbI6CV9EOa98TyZJNZ
 R9ZJDo+o0krRUgOn53jJAb//YZBTJu4kl3uKsUm/qfuvN/61/wm4bgF9RRtZoJRZPotcw86
 LKx6+K4doQX0q3IRcCY4CVedPTAF+WVXxKplLqnKvi6wpVC6IZYmH6wvYNtoyiRIsx0Yy+I
 q0QOfWxW8yLH1QoWiRbCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10A7qD84igQ=:htN+wKSiavuLAeaBt9PMCk
 TNcAcBxlLSMaIwWxNxM+JgypRgw+XDzPjeuYTqQ6GGE+zzpFBUmN06FJxew5R8c7UDzuoNcFe
 sWlpn5DLvx4NFOcwQRRtSQ6zSPBao6oUusEMC4L/T101dzDUwkVuUYxv7unkaAmntWn9n609R
 31Kg/qn/MJVMBQzds1pFzNVEHP30CtXV9KiYsFwn1ZxFD75diejOjx6i3biZy4ix3ayAPxbz5
 itGCnc71ymEa1BSbAvDSMwNbZHo9qAJrkgVTiSJOWWrxFFaP9BpTVlJZ3nsdIcXSP0IzmbbPf
 tOa/ejSIPHdaGFngi/Uxj9QeHfTMN8WmquwsvPkk3B2Y8w167h8o86kCMtABoEh8rmlmSWgKJ
 zUMPXDPx+DGq7jrHvTR9Ruhv0BCrkJ2g5DQW7OUGJBNLGBTCtqMxP4LtlvO/UnujkNnAhFKky
 rUVlD9Zqtg+Y/pSdBM0ahaL0UfZgl6/dc+veNYftSgL4Jr+5B+9U/QqpWWRKuEoqgiMr00WVE
 rq/EHBdoHYrqKpaMwlgySUDC2Y+khs9il7Fr8MIdALMCipAQXC/KdgljH5qrN9X8P2lPLUE6C
 F30d/70nhAl9cPS3PiFXlJzmCxbN00jUW0AaUGLkC1u7pdPEfRed/y8i0qv+FeegSLk+S7nH7
 VdfgAsArCVaGW3JbEW1RfUn+FxNTQ0WlCjkmPS/895WhwZlBqznA+gDioCOjcpLSrDwR5CpF9
 IXBWAngj5+EAPZyWc4z4iDkc0w9u3jxQhBLvN0fkJ1yoiAxL25+k2ZF9Tl/jUJn6fyMKPkhdu
 kSeCCwQRCj/ir4e6rOEDTloc0qIOshw4c8iM5CZMYPvy306o/z7I11KLI8R1k0/v4WZFJsVnK
 7ub7k3V/WBopeh33Xs09TREmLPKnnn8rU/Mse/6jI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-371731460-1605277095=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 13 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Nov 12 2020, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This trick was performed via
> >
> > 	$ (cd t &&
> > 	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
> > 		-e 's/Master/Main/g' -e 's/naster/nain/g' -- t55[23]*.sh)
> >
> > Note that t5533 contains a variation of the name `master` (`naster`)
> > that we rename here, too.
> >
> > This commit allows us to define
> > `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain` for that range of tests.
>
> There's also a "naster" in t/t1402-check-ref-format.sh that's not
> changed here and missed by 02/28 of this series.

Whoops, you're right. It's not even new: 7c3f847aad7 (check-ref-format
=2D-branch: do not expand @{...} outside repository, 2017-10-17) introduce=
d
it. I missed that one, thank you for pointing it out.

I will follow up with a separate patch to fix that, once the dust settles
on this here patch series.

> Is there some meaning to the name "nain" and "naster" that I'm missing?

I guess the original reasoning was to stay close to the original default
branch name. I'm not sure whether it is worth changing that idea. Like, if
you ask me whether it hurts to use "nain"? I looked up possible
connotations, and the most common one was "grandmother", and that's rather
endearing to me.

Ciao,
Dscho

> If not can we just call this "topic" or something while we're at it?
> I.e. this on top (just s/nain/topic/g):
>
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 9fcec604c3..4e33ec1fb9 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -201,12 +201,12 @@ test_expect_success 'cover everything with default=
 force-with-lease (protected)'
>  	setup_srcdst_basic &&
>  	(
>  		cd src &&
> -		git branch nain main^
> +		git branch topic main^
>  	) &&
>  	git ls-remote src refs/heads/\* >expect &&
>  	(
>  		cd dst &&
> -		test_must_fail git push --force-with-lease origin main main:nain
> +		test_must_fail git push --force-with-lease origin main main:topic
>  	) &&
>  	git ls-remote src refs/heads/\* >actual &&
>  	test_cmp expect actual
> @@ -216,16 +216,16 @@ test_expect_success 'cover everything with default=
 force-with-lease (allowed)' '
>  	setup_srcdst_basic &&
>  	(
>  		cd src &&
> -		git branch nain main^
> +		git branch topic main^
>  	) &&
>  	(
>  		cd dst &&
>  		git fetch &&
> -		git push --force-with-lease origin main main:nain
> +		git push --force-with-lease origin main main:topic
>  	) &&
>  	git ls-remote dst refs/heads/main |
> -	sed -e "s/main/nain/" >expect &&
> -	git ls-remote src refs/heads/nain >actual &&
> +	sed -e "s/main/topic/" >expect &&
> +	git ls-remote src refs/heads/topic >actual &&
>  	test_cmp expect actual
>  '
>
>

--8323328-371731460-1605277095=:18437--
