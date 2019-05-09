Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC8C1F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEIOgh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:36:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:60425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIOgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557412589;
        bh=nD8+qUZ0jBi4nSOL88pnLXlHCtp532tKf9qXhVy1XLM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Lge6YTXABABXoctekbrHVBTqIgIijxfHPjQaWHoWzRv+wVNv53zDJr9HqBqDMA9eR
         k53bg2hKE7jhBqfAL3oBwoEh0z3n/GhqavrvzrUiSOvHs/yx+VY3Bm9WbrJ4XVEiA2
         /lLmNjpCYmUzcDlI9EvIApSA0xMmgpL7OKcirfsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1guZw724Vm-00n68P; Thu, 09
 May 2019 16:36:29 +0200
Date:   Thu, 9 May 2019 16:36:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] rebase: deprecate --preserve-merges
In-Reply-To: <87imusj4cv.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905091630030.44@tvgsbejvaqbjf.bet>
References: <pull.158.git.gitgitgadget@gmail.com> <pull.158.v2.git.gitgitgadget@gmail.com> <f6990f28c028e04c5d237878d7fbb2160dd7dac9.1552334254.git.gitgitgadget@gmail.com> <87imusj4cv.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-122905875-1557412589=:44"
X-Provags-ID: V03:K1:GQK2wQkzVDieaM3JVcEPSEwd+XBcKUz3oJJ+X44R46c+Vqgf3Fd
 fHFui16xuO6ry5trnaf10aRDxaHloZJn3YkOgzfk94XNwOZ1ToSURLSlOHXHOoDweInylbd
 ZWja7ShqfZ9tolTVahbKexSI1vaZSeSsiHi6+FMxdxgHPrWLAya0UOS1skbuL32v2NvA5AW
 GKXAwqpliksEGj8cwvT3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+H3OxmfyVBY=:HxtvnT1JLKlfXXS9x/0YoR
 eVHrJeAQqLDMOQ5M8CsFfBszWv26sP3kDYzbXOZa8Q1G2B+pHyzWTJAJI17qv8tBe/RViPV99
 CFHn+JsFESDlAJz/i0/YrHiRXPRaGahbkboxjXhbD693qALPIdD2nNkqgtH5YSfm02dssxav1
 Si+oKh82xjU4fkIwmIC3DaTaGiht11J0q+kWAfRLPYZeIi0YS0W6vRazCPTUyTE1gZl7elEzA
 X0CvP6lMDpHl7SNln/RmOsheXvwlmbjc9VfBbn+PkSzT7B73Ksm/qIeFNIM1U68rZxoaSr9gS
 qKiP9PfFiQnDBwpA83YP2dy3F0w2mk4jI22ldNBZr8qLQ7pVIFq2ex0qrWckEajjILdAAB300
 5zz972IEbOpm0tCxzJvP7A4JSWMreSvE+LRa8M+SZecad5CLZBrWfU5e5l2yNXDeWPpiKhj0s
 4CL+6d8md5FphMg2Q8HsaqN6ihniHvfYfMBMvmOCNbmGPpWlNO2FN8L/1joBwGAht51Jlcu/h
 okitnQLEhQq38GUUoOGim8K0KskIhu1hfdenS1NFdRIPtNgbWlqsNQf51l2sO8rg6Q7jUgkZk
 gkvLdbKSJsWhHwwJ/RvIlo7mO/JeilYVF2h0VPu/tZakSZMudyijIN/4NUVdmJRgp8asfigV/
 FQuvgrFqNUQudrru2SDKqMR73GXORg67GGv8BlEvNDoI0BlhhsOvm9e9IveKnC6acMK20GeQa
 5b6/lXwzNSbpfv1AOhAnNj/yvQ2C8vZdrCOEHJmx9cYTRXV58o4+1lVdOV4OuOp+sm1nWhaaG
 StK1R1MyEUQSaLULFv1VfsrzfQ3IRupsZiPY6dutZQxJBgjSGz+HZnnOqNG1uPKS8+RzNMbbd
 cpgplG/mhHnLTAv0op2xSct0FRTYnGbZwz/eqYCKhMFl7WNtqCmPXD2kO2NF4ZHkOs7EcMm/K
 2ODdc0+RT/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-122905875-1557412589=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 2 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Mar 11 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > @@ -1212,6 +1212,10 @@ int cmd_rebase(int argc, const char **argv, con=
st char *prefix)
> >  		usage_with_options(builtin_rebase_usage,
> >  				   builtin_rebase_options);
> >
> > +	if (options.type =3D=3D REBASE_PRESERVE_MERGES)
> > +		warning(_("git rebase --preserve-merges is deprecated. "
> > +			  "Use --rebase-merges instead."));
> > +
> >  	if (action !=3D NO_ACTION && !in_progress)
> >  		die(_("No rebase in progress?"));
> >  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
>
> An internal user reported the following "bug" they ran into:
>
>  1. They ran "git pull --rebase=3Dpreserve"
>  2. warning: git rebase --preserve-merges is deprecated. Use --rebase-me=
rges instead.
>
> This is very confusing, since the user issued "--rebase=3Dpreserve", *no=
t*
> "--preserve-merges".
>
> We could detect that we came from "git pull" and pass down the argv we
> used blah blah, but how about just describing things a bit more in the
> warning, e.g.:
>
>     warning: the "preserve" backend for 'git rebase' has been
>     deprecated. You invoked git with "rebase --preserve-merges", either
>     directly, or via "pull --rebase=3Dpreserve".
>
>     Use the new "rebase merges" backend of "git rebase" instead, invoked
>     via "rebase --rebase-merges" or "pull --rebase=3Dmerges". Note that
>     the new backend may yield different results, see the "git rebase"
>     documentation for details.

Don't forget `pull.rebase`.

And the proposed text makes it sound as if the results of
`--rebase=3Dmerges` is wrong, while I would contend that it is actually mo=
re
correct than `--rebase=3Dpreserve`'s output.

In general, I do agree with the direction of making the description more
general rather than trying to teach `git-rebase--preserve-merges.sh` from
where it was called and showing a different deprecation message.

Do you want to take the lead on this? If so, be my guest, I still have to
prepare Git for Windows for -rc0...

Ciao,
Dscho

--8323328-122905875-1557412589=:44--
