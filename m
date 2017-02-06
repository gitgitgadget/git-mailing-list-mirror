Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65801FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 17:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdBFRIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 12:08:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:62641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbdBFRIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 12:08:35 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lugbo-1cRsoJ1aYS-00zpEi; Mon, 06
 Feb 2017 18:08:31 +0100
Date:   Mon, 6 Feb 2017 18:08:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stavros Liaskos <st.liaskos@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: subtree merging fails
In-Reply-To: <CAEXhnEDW_s5vGKmLA8ie63FivFYwtCASyaD_Sowjj3e5U9wp_Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702061804360.3496@virtualbox>
References: <CAEXhnEDW_s5vGKmLA8ie63FivFYwtCASyaD_Sowjj3e5U9wp_Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:npJQj4wXzevoFYNXYkxtwLIAgUNZJuj1JTWsRqJUl6o8YRUm3Um
 xCDhizzFQ7yfJ2hQVWZH5ejZ13m49e48Y3vqqzqmmpU0bTq9jFyaG4muy4mx/EKtNXDRaL0
 4C7fv7VbY8gd+8J1b4ly7g2xCwE2NlVH2bZd/VKdQZOMtNHT5PJ6mF9tqZd/Nq88LFFPoYQ
 RK4GK8ICwK4AwwSdyh8wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Spcsg7aSwZs=:X3cYJmS2mdekfrnb14SE53
 GGMcqVG6qsyitcYMJzWOCKJRfCs6Fd1ks9EgdIwo86+FmBZ1jzLf3JKSbgwI41WOCZoSHrfGp
 FXlH/LsplCPRKJCyWpVtROJEO/YnEzqMXoOG5xChO1AqpF5GcdAlOLg7etZh5rJylU0ktVH4W
 4t5knNdvx0EcihU+5tMLcXpWqH0/VCT9Adc/CGOthKjhfO8jWfZKoRB+Lo5vg8+sl1J8jgqbb
 9DChecATKycBu2n8Mu/UH6rPxobHIcg9/1XQ+Rw+FLu1YXioxNFUef7fgn9zkTCSc7bVQQor2
 703tnulmOFQIQd/CstkeBKusL+Z8m7p8uuLY9Ycg8OpaA9EImybhPp83diqZnyDW+WWJqNkn5
 cU/F/1QV8gykOh6ZK0pUsf3jMKFEIvX1FY7HtpRj5gEHZD00BNzwo19WGJ3wlfE7zkg/p2Fct
 XD4/7HXVYu3QT4laUEaaHs0aQHoO8qv6cJ/FF55vAs/zryxs1K21Tqayfh++Db5XSlSFYZNA7
 cZ1zxArYIIlwAmHBQQgoaA4OCpvKeAzjciTi26hERiUcrP9N9IgySIs0zUz5DKAkQksXpqPhD
 omdpvB9W4hMJl5VrXDkSyhdiybzOwMV1qv1uclYpUuL5/GEIzQn3epKS43UKSiK2Zp/C4aT1C
 ZmKtyVE//HBHh+UQuu3ecbKVi4qPeK22xiliNimPJj/7TwxF9ebqy23P3kS6akZvhe/egapBD
 Dlsrh3jH16MUQFD0qOBDm15rBI2b/KBsaIb+ifnwkC+ts6maQwFED4+6uslf6ILJlyN0jS17I
 rIdea39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stavros,


On Mon, 6 Feb 2017, Stavros Liaskos wrote:

> Please check this issue for a description of the bug:
> https://github.com/git/git-scm.com/issues/896#issuecomment-277587626

Just an observation from my side: if I see a request for help on this
mailing list where the sender merely pastes a link and does not bother to
condense and summarize the information in the linked page, to help
potential helpers, I am highly unlikely to even click on that link, let
alone to try to help.

Maybe you would want to spend as much effort on a request for help as you
would like to ask people to spend on a reply?

Ciao,
Johannes
