Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADC920248
	for <e@80x24.org>; Wed, 10 Apr 2019 22:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDJWPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 18:15:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:54815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 18:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554934524;
        bh=ae3LX8vy+WmRsrNif2G2G3pWpjIYhz8T156JKIzAcZc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eMcnM4ey/RK/DnwCDi2S1AnTfyKhfa1Bgh9XnRhQXbHOalmpJtbaiEuDXUdcsXEbe
         0clCGVsdKWkdIWX/83kcNI+VGMQeemWRkE3u51ypK3LLCv8P4LSha8QWlNA7BM3UD9
         BuzQnqnVF5OcWDlEGv/8X4WeTYZI7RpMDyLEs3uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuKHz-1gmbpj0hHT-011lIz; Thu, 11
 Apr 2019 00:15:24 +0200
Date:   Thu, 11 Apr 2019 00:15:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
In-Reply-To: <2a91a971-24fa-9cc7-5159-14c0771838f6@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904110014460.41@tvgsbejvaqbjf.bet>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com> <2a91a971-24fa-9cc7-5159-14c0771838f6@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TPbMBiY9Hu+k07PuAiXobRNNPHG5STu8FYVBG5szbq9jVzAt+F4
 0AquXz+Ei/1R0LALYWZakvDt6PhiWf/RhwZk77AWDoa0/1Og7JcW95Xd+aoezkefMD9LDjp
 TEAsCi5MkN10Tv37AQoU2k5qklRakpt79Uv46KzVw3pv2BMUWxV788K/u7W3RfQZTkFV1Ru
 06+jM1rJQ4OThXoSSkZEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8ijr7srk+4=:P412fQu4z/24HgZDtSBlFO
 APXsdIuVAA8JqQ5bffp2B6+sJIh8k7lJbVEz0c0rjwG/I/6a6gEi7rCNSIYci4bD+L0r39aq6
 JN7acWi2MBC1PrF0fW+DWHZoI7u7NQlD/Gabwywf4RWCYCW+dFGmYICGY3KwyvejHHnVNMr51
 M60+lwyDvECEE9dfjCPq66Ga/YMqZZTk5DVlqzeD5Tl1U7bmsnHP+IdJYNH2js3lGvT39oCLl
 VcXJRIlTPDjk4p0D9o7fXVFiDabi2k85LmHUf28Lh/ws/ZPah7L277dlKnffrQl0xLUtN9CSa
 F8g+eUB4aeSTDz96BC652UmEG3F/l3/l+cIcCHsWZSeJYzVxd1PNY2ST7lRLQBDDKqayHFHEa
 xr56gcLxFLEcae1VJOfNcZ6QJVG6BS+3QjXmzIYoozrJUrN88OcFwFpUgilbKG193tUxpNbRz
 Jdl4QHWPQIg7D3K62krIbEFpOFQ6FxXRaqs0kJgOLBCfj9UxsUooljWIHqd9CieICTPxpSeSY
 MySCYAd5S6P6VW7TEIKlGwkw7dCjy/xMxhjORjp+ieBwmAeTN5aVBLcIWppn7MlomQbTxeN09
 BlaxsYzPKxfZHmgH2mHMfxzl62LZYhVM231zFs9OFHDN2SY/vZGqT/b8n8A/G2xak9t7Rtryq
 3Cklf+VQ07C77GlgM/6cyd4tta/ar+p9eMHCpQEoyznTmiZkCATsgf/XkrDWlvwCXpq22at7j
 6GGZUViLzzMoNxrCtzoPsJ1gys7ZFyPcbVFCs6J3IWr/exoDDsjKzLI+F6f7a6Eu3wAEE5dyR
 RaDRuOalui/4wC7MTruUa2QJgaEyV/GvJz5kKx2buJDciRJS6fbluTScOXYMhc08DuxZqVPqn
 dwpE+FjRc6ECd/DPYKmub7/pJZAI0sCfbH0YQeF3UJ/5XJmjAAy7VSrWNxsmsMhobe56xSMrS
 rDUgguMJUng==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 10 Apr 2019, Phillip Wood wrote:

> On 09/04/2019 19:08, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> >
> > * pw/rebase-i-internal-rfc (2019-03-21) 12 commits
> >   - rebase -i: run without forking rebase--interactive
> >   - rebase: use a common action enum
> >   - rebase -i: use struct rebase_options in do_interactive_rebase()
> >   - rebase -i: use struct rebase_options to parse args
> >   - rebase -i: use struct object_id for squash_onto
> >   - rebase -i: use struct commit when parsing options
> >   - rebase -i: remove duplication
> >   - rebase -i: combine rebase--interactive.c with rebase.c
> >   - rebase: use OPT_RERERE_AUTOUPDATE()
> >   - rebase: rename write_basic_state()
> >   - sequencer: always discard index after checkout
> >   - Merge branch 'ag/sequencer-reduce-rewriting-todo' into
> >   pw/rebase-i-internal-rfc
> >   (this branch uses ag/sequencer-reduce-rewriting-todo.)
> >
> >   The internal implementation of "git rebase -i" has been updated to
> >   avoid forking a separate "rebase--interactive" process.
> >
> >   Comments?  Is this ready?
>
> It is more or less ready, there weren't many comments. I'm planning to s=
end a
> re-roll but am waiting to see what happens with dl/merge-cleanup-scissor=
s-fix
> and [1] (which you don't seem to have picked up yet) as we discussed reb=
asing
> this series on top of a merge of the current base with
> dl/merge-cleanup-scissors-fix which currently conflicts with [1].
>
> Also now ab/drop-scripted-rebase is going to be in master I could add a =
patch
> to this series that drops a bunch of unneeded options from rebase--inter=
active
> as it will only be called by git-rebase--preserve-merges.sh which only u=
ses a
> subset of the current options but that could always come separately late=
r.

Or we wait with this until we can drop preserve-merges altogether?

Ciao,
Dscho
