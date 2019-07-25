Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417B01F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbfGYJkX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:40:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:52589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387533AbfGYJkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564047616;
        bh=D1SgafPnzk+epKF/hm3w+lcRZ5X5AGh6fYZUr66SgkM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jn2a/Vvqm4S9rqYajpD6kc5qxBBE4g10icZJH0WsZ5De3aMJYfHjOVoiSMiah4Ote
         IMtM1spbKF28o+mfwIhoclt7GyQFjdRgj9zqnuOOnEePB3KCd4lTg0VjXTOC4qcpDA
         A4/lAeA9TPj0lBy+O6nmJ85weri0vRjfeeByPLvI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1iZATi2082-010N64; Thu, 25
 Jul 2019 11:40:16 +0200
Date:   Thu, 25 Jul 2019 11:40:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Create 'feature.*' config area and some centralized
 config parsing
In-Reply-To: <pull.292.v2.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907251138090.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <pull.292.v2.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SSYIvto7ZK7+xRkHnzTOpfyXZImQD/gaFUcvH6FkNjKzH7pp8q+
 gqlYJeMp3+LBxWpH0DW9mFJQzgWWQH0eXgk7Hv0JPVCqseeieGs7WwHcYqjBuVBzo4Nzolp
 lmbD3WtIj2+HbXE8BfOp06w941hDtMI08GBNy+/DRIEhiuVxWelaEHL3x2Q5V4JwKiIjff3
 B1WxiVyIhO3bImocfrJPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2e04y8DW6nY=:spOzIwi/3mFYqBObDm516w
 n89FOtRhLehKOnt+dPC1LoExshOT+lN17HV+y0s/n/GSO8djitxAMG0HbSD10XASkbuVFLKU+
 HQ+br+lzZjNaj11iNbq/86KpuEwUwGJN6eWC+N9YxpEE82gI8C6QXc3k8Ts0qSR5U+L9jesdV
 jDxI9WEisYCo+t3u9vCnmXxzV2y3swLEzsYwa3KjMi1c2y+Z/e9sBHSx6V5PW0jV04EMfKsvr
 lmpUcvcKMvOa17TB4I6q1uYDVNVZlU3DZtxeP3gVTdEJukry/kHyVop33e5C4aB7pg3aW+WNA
 ERRoRcxznoBjchQuFaTqWHxn78ueoTO7KIyqkubQnuF7VFMjr7rgsgOPi8B/7pUQMUQgSxVKI
 5t0wT95nhEsAcSGztGuz2BJDSJsp8eFAefXb7sRbRGDbnFRtJzoKXu/zyBnfazkHIMkoRQC1Z
 RYoELJwIPT0J5r4CoXW76soKACBFmPU4u+SnhOdycV4/ctoQqxiQSIL5+Ln4CLmSlu3wD+NQp
 UsydLBM4C3U7XwhY0UMc/zdMRSkGBFjLmWCXiz+VXkjEUdJGfWrG649MkOxjv1VbOb92cCkpM
 238E5raRVI7jpRHRo6Wrq8KCjnzGkWIlleXkZ1eiqr47Il0GHh0As12fEvn7gi5r9DG5BBMtt
 bU8s1EMp3SmnQmt2T61GoeLVTnLqWa0zTOZkVPa9O/Hat6neWpwrFdEbMZx+JY7WazL5Ent+s
 uZVNuTAwhHHHhk1gVe2MvY8YWQ4zLU5UDODNzJKphcppX0yc0ZfYEzdVf95HG8HRePNV50n79
 rZ3w7u1GirwdOxVoZn1Mwjb3kf5vVp6DfzGnsh9I3PfK24odZlO/N7CNb6JhYRHStGeiYckDY
 yoyLkuPfmFUfRQGVEqW7EpQaa/1u3xsMQ3OnDhvxwmX82fxbDc2BjeQieY3mXKWoO4zcAcNfm
 RK7G8EczXYZjlBmCVWahcvI/aZQAbKhGcpmEkiwoV2pnTW1kJ4iG/yKKwZKWJSSlRUGNti5iD
 xtxt9KSahqbwNSz2sA1HrYs85wT6ThnyZjQ5bZk9d7DMfJZPL97k9Dclhl6pc2FtawQA0pqiE
 WK8EjoGVkN7PJMgpM8nmJ+xvWwsRfq/oXVW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 24 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> Updates in V2: I'm responding to Dscho's comments early, as they were ve=
ry
> valuable.
>
>  * Rearranged how we are checking for the feature.* settings, so if one
>    layer turns the setting on and a later layer turns it off, we do not
>    adjust the defaults.
>
>
>  * Switched to using enums for the non-boolean config options.
>
>
>  * Placed the repo_settings struct directly in the repository struct.
>
>
>  * All struct members are initialized to -1 using memset.
>
>
>  * The config changes around directory rename detection is greatly
>    simplified.

I left only a couple of comments, and quite honestly, I am really happy
with the direction this is going.

It even leaves the door open to let users define their custom feature
groups, at least I have a couple of ideas how that could be accomplished
building on top of `repo-settings.c`.

Thanks!
Dscho
