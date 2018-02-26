Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1801F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeBZUte (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:49:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:41491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeBZUtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:49:32 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1WHV-1ebMpn1Gu1-00tXV6; Mon, 26
 Feb 2018 21:49:22 +0100
Date:   Mon, 26 Feb 2018 21:49:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/12] rebase -i: offer to recreate merge commits
In-Reply-To: <CA+P7+xpr1Ho4+xi4QhADP6sWRMP49yqvVRkcHkCY2QUZWkUz5Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802262148560.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de> <CA+P7+xpr1Ho4+xi4QhADP6sWRMP49yqvVRkcHkCY2QUZWkUz5Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cXTWmzJqoBewtQ5kuQnpS1mIgitYnelEzT4dWjjIa3wK8puYsWb
 VbJyWLiBlJjSGfbVC6aop40/pRT2nhTZlG7PX7ffrXuVrV37EdhrCRQjHuOZqJ4EFfY/cXU
 w3O9A2qOtCpwWRddvDMHw1pfJKX/B2WZ1GbTfub02vXvsNVmr0NYdxzoLvFBDRa2unY9oAY
 L+EHTYBgGKZ3jEdgubL9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b5hvmCrVAr4=:4RUWabmQeDQD81Kec2XS3y
 CdEtNiB9dHWZ9OrCU2g+9bs/Y9uYEo3ip/iT7RwUerJEzuBgHCnjIghwVrq8x48Ef1k32gBUB
 QXwa3jEoKPYgkHxuvOvZuXCXMwkUWO3rgaDwpzbVy1abaionjfOmFgRFf8evKq3mI4z0ypQbf
 0G5YCilLYIW269OL4LVfbmy5Se72YlpsrrdwtGDRoW9dnWDn78UKtGAR0+SQJ/sJ+8xPoBYNd
 JX6s3/hESV4xo8sCAodR5nHRmS3OUXDd4OKOdUr19jLo2i6VYJKfE3QPDGombiNxmgzSbRuDI
 BwZOYBuUVKz+ajUyZHhxQkTryeZIeRL7RQZauQ98atdWkjbHXhBPElX4LXKEEWBK8HZeJbTXJ
 y1I9zsEniuS1yu1+PzGtwlCSqjaNDiR+PKPcrSrp7HM7ibDEZVM5i+up+WEqIQa78Iq8PHTbw
 /DolSiidzC7OJb1PTnPu5zW4wHbX5rvtDudD57a9FHouh73Pq54OoE1isqyk7cBdv99WwgxIV
 dLmCM6M9TK2EbG/aJ3XBvQvRxlJT653nALMVwcKhqmCkeV4mICVAIdIMBg7Oe6Ufx8VHUQdTp
 QuB14ZlP67Cg7YD+IU/8IYDp6fnrA+3qrlO/abILGSmQYYKnOwJdhfAvPJHHbfG1rpRADHmy6
 yFJ+cUygq/eD1b874VHkoqopq8NmHhCZyIuEXEE718e5WAFPk/AbpfcgpG3FF67ZOYrg1xy+G
 I0ZtmUvk5SzW27UFX6kVSfcSvsQyQ43ry2eWf6WFH0pAtMexxSZH13BinMml590VI5ZZHYbmC
 TOE4ACon6Jc2p3wwxPEHFGD0j9RbSjiIM9sKLG+xawdQwJLKVRVh5GfXvYnZL4tAmRVO1qJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Sun, 25 Feb 2018, Jacob Keller wrote:

> On Fri, Feb 23, 2018 at 4:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Changes since v3:
> >
> > - fixed a grammar error in "introduce the `merge` command"'s commit message.
> >
> > - fixed a couple of resource leaks in safe_append() and do_reset(), pointed
> >   out by Eric Sunshine.
> >
> 
> The interdiff seems incorrect for such a small list of changes, it
> appears like large sections of code added by this series appear in the
> interdiff without subtractions from the previous versions? Is all that
> code new to v3? If not, I'd suspect you accidentally diffed between
> the wrong points.

Indeed, it seems that I messed this iteration up rather well. Will redo.

Ciao,
Dscho
