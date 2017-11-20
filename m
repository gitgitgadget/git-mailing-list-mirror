Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C855C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 15:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdKTPIT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Nov 2017 10:08:19 -0500
Received: from mail.kdab.com ([176.9.126.58]:56296 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdKTPIT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 10:08:19 -0500
X-Virus-Scanned: amavisd-new at kdab.com
From:   Albert Astals Cid <albert.astals.cid@kdab.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Bug/Wish: bash completion for git pull --rebase doesn't include --autostash
Date:   Mon, 20 Nov 2017 16:08:16 +0100
Message-ID: <2531561.GdBCVJbi7q@yoga>
In-Reply-To: <CAGZ79kacD1Gw0tyPWv+1_PtFW-wM8SAjFTg_i2bk7ogPBvYn7Q@mail.gmail.com>
References: <5829116.cWPNik6EL4@yoga> <CAGZ79kacD1Gw0tyPWv+1_PtFW-wM8SAjFTg_i2bk7ogPBvYn7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch sent, please still CC me as i'm not on the list.

Cheers,
  Albert

El dimarts, 31 d’octubre de 2017, a les 18:56:22 CET, Stefan Beller va 
escriure:
> On Tue, Oct 31, 2017 at 8:21 AM, Albert Astals Cid
> 
> <albert.astals.cid@kdab.com> wrote:
> > git pull --rebase --autostash
> > 
> > is a valid command but the --autostash autocompletion is not suggested
> > after typing
> > 
> > git pul<TAB> --reb<TAB --au<TAB
> > 
> > Would be great if that could be added.
> > 
> > Thanks :)
> > 
> > Albert
> > 
> > P.S: I'm not subscribed CC me if need me to test something
> 
> Maybe you can propose a patch for this?
> 
> Rough steps to success:
> 
>   git clone git://git.kernel.org/pub/scm/git/git.git/
>   cd git
>   $EDIT contrib/completion/git-completion.bash
>    (look for _git_pull)
>   git commit -m "my first commit to git"
>   (This is paraphrased, see Documentation/SubmittingPatches
>    for a better idea how to craft commit messages)
>   git format-patch HEAD^
>   git send-email 0001-xxx.patch
> 
> > --
> > Albert Astals Cid | albert.astals.cid@kdab.com | Software Engineer
> > Klarälvdalens Datakonsult AB, a KDAB Group company
> > Tel: Sweden (HQ) +46-563-540090, USA +1-866-777-KDAB(5322)
> > KDAB - The Qt, C++ and OpenGL Experts


-- 
Albert Astals Cid | albert.astals.cid@kdab.com | Software Engineer
Klarälvdalens Datakonsult AB, a KDAB Group company
Tel: Sweden (HQ) +46-563-540090, USA +1-866-777-KDAB(5322)
KDAB - The Qt, C++ and OpenGL Experts
