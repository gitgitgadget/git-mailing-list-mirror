Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34851F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJ2Unf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:43:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:33569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Unf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572381811;
        bh=zrbXFnDJ+8bntT8dNvOMIlDGIok983bZJC93Nv1sSyo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WPm7KqJ1wFC3iuqgFv9vx9PXISYWIYYAVfYRQaXvb3Q1hcHIDocEdAZ0Ub0qhC2/Z
         f3CMp31mkanfWIQCxX7R2R8mPILCXjGdnsr8U015jGyWXAj6fmruBuQtCUpPN7ASs8
         XdcnVlPVuERJiWZqF4lN1Fphpz94zswWcXLpjKdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1iAhHl2IGY-00G3Cq; Tue, 29
 Oct 2019 21:43:31 +0100
Date:   Tue, 29 Oct 2019 21:43:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] myfirstcontrib: hint to find gitgitgadget allower
In-Reply-To: <20191026011459.GC39574@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910292141340.46@tvgsbejvaqbjf.bet>
References: <20191026005159.98405-1-emilyshaffer@google.com> <20191026005159.98405-4-emilyshaffer@google.com> <20191026011459.GC39574@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bCRQcl8I0StKyI5VF8bAz/EbK9apmzG5/TnfgmlelmedtkOmPbL
 7pP1kxYBu0BXipDzELSqEf+1ldVf2DH3GDgwZd3JSax7AM7uV34Ksc0IYAFo3Z84pBcrDsT
 9x1EIRqa00yLlUrhDZY+cDM1nYcrNjoNqqoXdxgMGx/3Wqg83RlvaitbCIJ2xE3N+FKJPTm
 frPpaeEyiuualELOmKvVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeSDXW739fQ=:hzOONtTGO2k88fBnSREfVn
 KvpBx3pm43F/0UcsopjqFJyvSRsgobCPStQMjUvkr2grzDCF6BMpK3B/HU4AMyv+feK24btvR
 CcS4Oq6T+/g0a//rdjyorWxLazyX97xzF83EHytt/Y44Bd6TMw9eFIUQGnyuDceqaM5q/2xt/
 kgDZ4E/7FU1wTYgZly84exN+xb185MxLNeYftJupYl2uaB4JMyUsUcSgGwquUK73x2oS6T6qf
 H8YRpepET0Fd31zL79fl+mKcVaGooQDb8ANtr9UqF3DIBU7M5ky9Aw3OofuKCg7r/trAaLueB
 SNkqY8b1ZfY9fX+uJ0rpyHQDPD73h9vjVjWKvmcTkMKdKpL87EQx47f2clivpdzhKFnaEk2RR
 U6PCV9qSl+1C1Xs8Ll8IcRp8IOQBp8QeVLjvg+JWQzJnOijxpOtBxmocfwYtNaYy2hdG96+Ap
 d9RU/NqilS8rs6V1PBkXM4pdqMOCgWa5Ztm7WmU4I4pjNFk3cE1iwvJXPBYf9SfgS/A7IzXgg
 O/yHmclLuTbu6dC+1jVQ4wymi4vx9jenmI7D9RoieDo5fMFQVJDIePLlzGrOr50JgyxPoKjHJ
 sFVFwJK5w9mHZnbtKCXOCNKV0z+wPsfLHTOq9IGrLmZpumxUPWqb4jb3QiguCiOVxIlrm0YwL
 J1vtAjUrm6lnp97Dz9p+AAPulJvzuaMjAzk2o5S3mohfAeNiZcxZvnqQTmTq4GVwMDVlmhCfD
 OXvbkOJkWAEZXy7eaNu2Y1Vf2St4A6HKqx5rLbatGl6lnxs/JxN14zqr6ejwVGx07loFnB1JE
 nAyCuEhLszJp5Z1v8ObR6FSmfhImYk5mOmPCCcP5h52MQLvl36Z36T1VmiJAvWZN9Ump8bRXW
 UGYm9Lby7Gm1Bma5+IWaRG3L9zA7gi3jT+IC3zrEeRrvZ87UIHL8WFWZOXrhl5MBlX5HEDTrQ
 6FtxxgFx1sbEbCzmuVT3+i3EREK79TsQb9oMU0ZYQyTilWlXHP3c7Q7I3tRFriR5cgyDYG6h8
 BZvFlDtaGOUkFnmROwesX40JlZcq9IYagyKTDZ4oGzkKxoR8BHN4MwcIspoBQkIaqta/gc/YY
 1/aV5mO6CWGq81tIwX0xng8FK6lp+JtVKWqiABG+7XspfeO7R15S5Lg5mlSG+c3iBZqKEXOCx
 GnRrwCdmyid9KHlGImyiSsfWlz+ad6H0cCTvdzOfg+UpUPI42T1/7fYKnjqgr7+cLtAxokFoL
 kd7peEdbwGcI1WHZH41naD4k7uwFUEL3zV2JvIHzl4cEixWotfS2XWCet8Rk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 25 Oct 2019, Jonathan Nieder wrote:

> Emily Shaffer wrote:
>
> > GitGitGadget, a handy tool for converting pull requests against Git in=
to
> > Git-mailing-list-friendly-patch-emails, requires as anti-spam that all
> > new users be "/allow"ed by an existing user once before it will do
> > anything for that new user. While this tutorial explained that
> > mechanism, it did not give much hint on how to go about finding someon=
e
> > to allow your new pull request. So, teach our new GitGitGadget user
> > where to look for someone who can add their name to the list.
> >
> > The advice in this patch is based on the advice proposed for
> > GitGitGadget: https://github.com/gitgitgadget/gitgitgadget/pull/138
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/MyFirstContribution.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Though I'd appreciate an ack from a gitgitgadget specialist too, so
> cc-ing Dscho.

Seeing as the suggestions from gitgitgadget/gitgitgadget#138 partially
came from me (and that I merged that PR after reviewing it), this comes
very easily:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho
>
> > diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyF=
irstContribution.txt
> > index b8ffeda07e..2de06de026 100644
> > --- a/Documentation/MyFirstContribution.txt
> > +++ b/Documentation/MyFirstContribution.txt
> > @@ -789,6 +789,14 @@ will automatically run your PRs through the CI ev=
en without the permission given
> >  but you will not be able to `/submit` your changes until someone allo=
ws you to
> >  use the tool.
> >
> > +NOTE: You can typically find someone who can `/allow` you on GitGitGa=
dget by
> > +either examining recent pull requests where someone has been granted =
`/allow`
> > +(https://github.com/gitgitgadget/git/pulls?utf8=3D%E2%9C%93&q=3Dis%3A=
pr+is%3Aopen+%22%2Fallow%22[Search:
> > +is:pr is:open "/allow"]), in which case both the author and the perso=
n who
> > +granted the `/allow` can now `/allow` you, or by inquiring on the
> > +https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Fr=
eenode
> > +linking your pull request and asking for someone to `/allow` you.
> > +
> >  If the CI fails, you can update your changes with `git rebase -i` and=
 push your
> >  branch again:
> >
>
