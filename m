Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183802035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbdGKRjK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:39:10 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35365 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbdGKRjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:39:10 -0400
Received: by mail-wr0-f178.google.com with SMTP id k67so8692128wrc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05WpNvMnt1PLotOmBWDgt2shjIW0oJa5b3RHyqXxr3E=;
        b=MVYnDcoKCddho4JGUvTaJUrz5ZI6ekS1dCuOsHMF9YmP+0tArr0AFI3+OD67lxlbq2
         tZTP1NX9y4cBTcqG6Fq17FGsea9nXvQRdR3mBNFMOvmk6S+434u0A1njk8WxfbxFKES6
         mth3y6Dx5Ujh4cATAmtEjWUWEgd67bh2uvYHXhMXpjosFNufW8pLlON2SyvQPfdMit3T
         pWw05jFSfUIYUJljcU5HhGOObw+dutzd0Wu/1u5BskX7lljqyaeyD1a4gDEgOcqCoT+Q
         Eyi6HL+jYxrsZTGsyJzGu1AVIDfN4g+/Fp63sOpzceh1BtKw70d/Z+STtVtK8FGqg9Bb
         NP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05WpNvMnt1PLotOmBWDgt2shjIW0oJa5b3RHyqXxr3E=;
        b=aPJuRU8eRxQjXgjkCVN3Av21wjO0A3ATFmVr1KT7rRuUfovFnEIhIG7j8o6Ku6CPSK
         BV+kck6aHEDgyjdcLaqf+/0lpmlbSxKMgje658FmzdCLlO/5dgwHGw7VGIbk2YPsYlQy
         8GtVybhrkffTKl0eqgP/mmoR6z+tcz2Y3T4w9T4LlP8oxErafoAkBMMP0sY0EroiHhgc
         KY5cnb/+2AQ6znxuhIwRbzNthKd0mR/DGxdTeol0SoCaK8sOxMQ3e267sVcT/+JsnIFm
         QvxcTMNEzHZVcf3cSWCBp6xxSF6qkZHH1DFzhC/fb3lvoP4G5kMj8ZMM9NAeiGhCRUFh
         iwrw==
X-Gm-Message-State: AIVw110NT+OtFZX2kxdoX6pGfXWNPUZ5vr6Z+B2Il7mer86NMyMbmlSs
        98+RV5jF/CHA5YIBPXE=
X-Received: by 10.223.154.206 with SMTP id a72mr632098wrc.47.1499794748322;
        Tue, 11 Jul 2017 10:39:08 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p27sm3187929wmf.23.2017.07.11.10.39.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 10:39:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "groups of files" in Git?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Date:   Tue, 11 Jul 2017 19:39:04 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Jul 2017, at 17:45, Nikolay Shustov <nikolay.shustov@gmail.com> =
wrote:
>=20
> Hi,
> I have been recently struggling with migrating my development workflow
> from Perforce to Git, all because of the following thing:
>=20
> I have to work on several features in the same code tree parallel, in
> the same Perforce workspace. The major reason why I cannot work on one
> feature then on another is just because I have to make sure that the
> changes in the related areas of the product play together well.
>=20
> With Perforce, I can have multiple changelists opened, that group the
> changed files as needed.
>=20
> With Git I cannot seem to finding the possibility to figure out how to
> achieve the same result. And the problem is that putting change sets
> on different Git branches (or workdirs, or whatever Git offers that
> makes the changes to be NOT in the same source tree) is not a viable
> option from me as I would have to re-build code as I re-integrate the
> changes between the branches (or whatever changes separation Git
> feature is used).
> Build takes time and resources and considering that I have to do it on
> multiple platforms (I do cross-platform development) it really
> denominates the option of not having multiple changes in the same code
> tree.
>=20
> Am I ignorant about some Git feature/way of using Git that would help?
> Is it worth considering adding to Git a feature like "group of files"
> that would offer some virtutal grouping of the locally changed files
> in the checked-out branch?

Interesting question that came up at my workplace, too.

Here is what I suggested:
1. Keep working on a single branch and make commits for all features
2. If you make a commit, prefix the commit message with the feature name
3. After you are done with a feature create a new feature branch based =
on
   your combined feature branch. Use `git rebase -i` [1] to remove all
   commits that are not relevant for the feature. Alternatively you =
could
   cherry pick the relevant commits [2] if this is faster.

I wonder what others think about this solution. Maybe there is a better
solution that I overlooked?

- Lars

[1] =
https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewritin=
g-history
[2] =
http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-pick=
ing-explained.html

