Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46891C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EB823447
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbhAGWL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:11:59 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:39882 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbhAGWL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 17:11:59 -0500
Date:   Thu, 07 Jan 2021 22:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610057436;
        bh=+Ux8BjO6gjEXYPC71FKZkeWGBLv7q10ziONreExPgLA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=grGllxPqdqlElh74a3yKa3sLp/OyzbSRLhbpftu2g5i32bEJm6HK1D5qlVx9kQWER
         OfUzAU3qSZPBFkMl+RiuTG8FObqPSLvuJgW17btXO9luOPCbWYA0QSbLCZam87vLWL
         aCWZT7xw8TwlOAHM7N1l0zoegR9ebK7UyGoiwTAs=
To:     Richard Sharpe <realrichardsharpe@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [Wireshark-dev] [Outreachy] Internship blog 2020 post #3
Message-ID: <cF5FePFVqe50PlPOkh4100u774XTAelFPO-RjC6ZnmFRHNq_R03ZXYYsUFWjigd-YO48osHZVFz4ebAPM5Mpsfdle_XTVeykS8d43nA35ho=@protonmail.com>
In-Reply-To: <CACyXjPwv5kWUKEZNxdpk8+9d3KhAzoDsbwqVZFPVxcbg7Y0JRA@mail.gmail.com>
References: <QQErW2YH2_v43WSO9XiMRaCcUglTY1szDusYI-xtSSMgw6K8pgLYX-SN09qAyvRYAj6Q9Jf_yKUQm-EgY_rLXUWkyrNhJEkBlJuBkoj6b0s=@protonmail.com> <CACyXjPwv5kWUKEZNxdpk8+9d3KhAzoDsbwqVZFPVxcbg7Y0JRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, January 7, 2021 11:35 AM, Richard Sharpe wrote:

> On Thu, Jan 7, 2021 at 8:13 AM Joey Salazar via Wireshark-dev
> wireshark-dev@wireshark.org wrote:
>
> > Hi all,
> > A new blog entry talking a bit about both Git and Wireshark here [1].
> > Check it out! Due to Xmas holidays last week, the next post will be the=
re next week (as opposed to the 2-week break in between posts as usual).
>
> Hi Joey,
>
> Is there any code we can look at?

Hi Richard,

No new code as of right now, but the accepted change is in MR !1313 [1] and=
 upcoming changes building on the patch you shared with us for https suppor=
t are Coming Soon(tm) : )) I'm also working on the other ideas from issue #=
17093 [2] and I've updated the blog post [3] to mention your pointers and t=
he previous Git Version parsing MR !805 here [4].

I'll share new code asap, very looking forward to your feedback!

--
Joey

[1] gitlab.com/wireshark/wireshark/-/merge_requests/1313
[2] gitlab.com/wireshark/wireshark/-/issues/17093
[3] www.jsal.home.blog/2021/01/06/think-about-your-audience/
[4] gitlab.com/wireshark/wireshark/-/merge_requests/805
