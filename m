Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07C0209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcITT2x (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:28:53 -0400
Received: from sdaoden.eu ([217.144.132.164]:39274 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbcITT2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:28:53 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id DF78E1604A; Tue, 20 Sep 2016 21:28:49 +0200 (CEST)
Date:   Tue, 20 Sep 2016 21:29:44 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch
 name
Message-ID: <20160920192944.hGZZKLLwD%steffen@sdaoden.eu>
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
 <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
In-Reply-To: <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Git Users <git@vger.kernel.org>, Bryan Turner <bturner@atlassian.com>
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey.

Bryan Turner <bturner@atlassian.com> wrote:
 |On Tue, Sep 20, 2016 at 9:23 AM, Steffen Nurpmeso <steffen@sdaoden.eu> \
 |wrote:
 |> yah, sorry, i'm back again..
 |> I try to find a way to find the name of the current branch in an
 |> automated way, because i need to ensure that a commit happens on
 |> it and no other branch.  Now the problem arises that the commit
 |> ref at the time of that commit maybe shared in between several
 |> different branches, but no more thereafter, of course:
 |>
 |>   ?0[steffen@wales ]$ git branch|grep '^*'
 |>   * stable/v14.9
 |>   ?0[steffen@wales ]$ git name-rev --name-only HEAD
 |>   stable/v14.8
 |>
 |> Is there another way except looking into .git/HEAD or using sed(1)
 |> on the output of `branch' to find the right name?
 |
 |Have you tried "git symbolic-ref HEAD"?

Not until now.

 |$ git symbolic-ref HEAD
 |refs/heads/master

Works.

 |If you don't want the fully-qualified ref, you can add --short:
 |
 |$ git symbolic-ref --short HEAD
 |master

Yep, works even better.  Fantastic.  Thank you.  And that command
was already existing when i have learned to use git(1), it is even
in the progit-09.markdown as of 2011-09-22 that i have laying
around.  Five years, and anything forgotten.  That is what you get
from working with blinkers on.  Shame!

Thank you Bryan.

--steffen
