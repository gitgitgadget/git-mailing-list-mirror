Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26CCC202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdJZUvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:51:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:55533 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdJZUvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:51:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id l8so4375718wre.12
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B86QwsiZzJ3pFW0b6mEmZthKeZw3BarQYol/KidRY2E=;
        b=lrz8enAe3J7FrLRnuYV30Bnwvn1otU7gd84zCf50l2P7Q0zDpvBNblqtSe3QwdQvL2
         NAKFyxe9yyc/JanKtFVlXQcc83HgMKqECSOraiG31lLQtaSa2nRhglk3shtUzpdwFvhD
         JlRx+QRJEdOf5HHSy8sOo308qYP/pMlk8UkakPws2TO9PnPH+XBz+rOv1ILaTk067mkO
         HVtz2d9ctjT5rvUcNy/k+SMHd4RHyGxKM0Vzv/KxCbS0dsDVy1/XRlKpd+pjYynsmAkY
         UEd9Jy5YMw3ogrfNPlRUX9xcn4zBBLMwaunmuxWbxpksSyrh6Y5e+aCM5uQfi8rZmE4m
         Qgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B86QwsiZzJ3pFW0b6mEmZthKeZw3BarQYol/KidRY2E=;
        b=A/oYfzNdq8jHV8wHKohTvLO6vxpuVHQQw4B1ZQt628CiMG6SKRREz07ZyPSSPyK9G6
         O77BAv4d0Ih7qF+uFoIhfzsvaDiEEVJcnhT1QiQybeA/7nGGCtARAGF2PdFML/rNZCn5
         8w9Qq9ceT/oInCWo2f399rVC/gCe5qmIZB512HpamiqBF4KGUhRQHvQ1lZ61wwR7kUQg
         EJp/erxjq7AxLhVkxYJtodiSxwKRf1HNsYlo3IwLav5hxz3ArJDRxxWqMnGdGzMwUwhW
         C3c4mIJB/LiR6DXBxatPSe/smlAuQ/m7EGzXeO99hR5hyTqiLOls1gA+AiBoVumNJa+h
         F3wA==
X-Gm-Message-State: AMCzsaWujzggos6z6JGSnOkDfcBhpoQNcZTyNuFSompUGQPFQZbvh/n6
        h5nF5rXUPdaRw0ppi5LPz0Q=
X-Google-Smtp-Source: ABhQp+Qb8GqbCt5k/yFSs/lETmpZ7pIUICsD9jp6NmOIaLuJZXa1X33m5kDCu2t3k5+JhnEvoQT+Hw==
X-Received: by 10.223.132.135 with SMTP id 7mr6681109wrg.74.1509051113281;
        Thu, 26 Oct 2017 13:51:53 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id z192sm153999wmz.28.2017.10.26.13.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 13:51:52 -0700 (PDT)
Date:   Thu, 26 Oct 2017 21:53:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #05; Tue, 24)
Message-ID: <20171026205301.GA13767@hank>
References: <xmqqk1zlktbc.fsf@gitster.mtv.corp.google.com>
 <7b40d574-c6e3-d824-5e2f-b7cf18dadeb5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b40d574-c6e3-d824-5e2f-b7cf18dadeb5@ramsayjones.plus.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26, Ramsay Jones wrote:
> 
> 
> On 24/10/17 06:28, Junio C Hamano wrote:
> [snip]> 
> > * tg/deprecate-stash-save (2017-10-23) 3 commits
> >  - stash: remove now superfluos help for "stash push"
> >  - mark git stash push deprecated in the man page
> >  - replace git stash save with git stash push in the documentation
> > 
> >  "git stash save" has been deprecated in favour of "git stash push".
> > 
> >  Will merge to 'next'.
> 
> If you don't intend to include this in v2.15.0, when re-building
> the next branch after release (the above is now in 'next'), could
> we please remember to update one of the commit message subject line.
> 
> In particular, commit 742d6ce35b ("mark git stash push deprecated
> in the man page", 22-10-2017), is marking 'git stash *save*' as
> deprecated, not *push*.

Sorry about this.  Would indeed be great if we could still fix it.
Thanks for catching this.

> [Sorry for not spotting this earlier; I only noticed when doing an
> 'git log --oneline' display which, naturally, puts focus on the
> subject lines. ;-) ]
> 
> ATB,
> Ramsay Jones
> 
> 
