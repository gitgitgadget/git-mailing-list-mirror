Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B642036D
	for <e@80x24.org>; Tue, 21 Nov 2017 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdKUOjz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 Nov 2017 09:39:55 -0500
Received: from mail.kdab.com ([176.9.126.58]:38060 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdKUOjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 09:39:54 -0500
X-Virus-Scanned: amavisd-new at kdab.com
From:   Albert Astals Cid <albert.astals.cid@kdab.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] bash completion: Add --autostash and --no-autostash to pull
Date:   Tue, 21 Nov 2017 15:39:51 +0100
Message-ID: <1951105.ys1K0KXRL2@yoga>
In-Reply-To: <CAPig+cTncgDToo0=zHsBHfCPMPTYNumNAhTgOnhceLHpse3wuw@mail.gmail.com>
References: <3893514.emzqGSqeDI@yoga> <CAPig+cTncgDToo0=zHsBHfCPMPTYNumNAhTgOnhceLHpse3wuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El dimarts, 21 de novembre de 2017, a les 0:14:24 CET, Eric Sunshine va 
escriure:
> On Mon, Nov 20, 2017 at 10:07 AM, Albert Astals Cid
> 
> <albert.astals.cid@kdab.com> wrote:
> > Ideally we should only autocomplete if pull has --rebase since
> > they only work with it but could not figure out how to do that
> > and the error message of doing git pull --autostash points out
> > that you need --rebase so i guess it's good enough
> 
> Missing Signed-off-by:. See Documentation/SubmittingPatches. Thanks.

Added.

Cheers,
  Albert

> 
> > ---
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git- completion.bash
> > index 539d7f84f..7ded58f38 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1923,6 +1923,7 @@ _git_pull ()
> > 
> >         --*)
> >         
> >                 __gitcomp "
> >                 
> >                         --rebase --no-rebase
> > 
> > +                       --autostash --no-autostash
> > 
> >                         $__git_merge_options
> >                         $__git_fetch_options
> >                 
> >                 "


-- 
Albert Astals Cid | albert.astals.cid@kdab.com | Software Engineer
Klarälvdalens Datakonsult AB, a KDAB Group company
Tel: Sweden (HQ) +46-563-540090, USA +1-866-777-KDAB(5322)
KDAB - The Qt, C++ and OpenGL Experts
