Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B351F453
	for <e@80x24.org>; Thu,  1 Nov 2018 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeKBCRS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 22:17:18 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54048 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKBCRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 22:17:18 -0400
Received: by mail-it1-f196.google.com with SMTP id y73-v6so3136470itc.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yw/uHi/94Qcet5vZE/8fySuq1auyvQqqqsQA4R+7S+U=;
        b=TwsI90yCPclDQgeEo2nv0HxRcEy8wF7+m/K63/uvTqCOaB2qjSOolanu+HWX9r/WvT
         7DOXZELP540eE9+2yON2YAoLa0FJzAmRTNZkCgdcPc69MVR4dH409f0+jdZFl4b9wgh7
         PJZ/lnsoXJHo++daHEIg+x6lnahF/BXLmpMGdMw+Sjr1QPgjGeJyJH1v0ye9hGVmvp5T
         dAk0G7LNny3pj2WB2STcd5khewjuSsOWuQEeE9FDlTrT6hIh2KLHvFpIVvC1YqhpMbIw
         a7rCHC2I1Ku6Il8SN0W+4F0eAuYaR1xfNd2wV2JW2Bc5BIyxsZOJAK46xnE9ZDV4Ljva
         H+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yw/uHi/94Qcet5vZE/8fySuq1auyvQqqqsQA4R+7S+U=;
        b=p9BIPD6+2gRga8hKlSwNq/a+1oXgpg7gDt6sznHIVWF3fcOTFWpE6r2fwIlnsXqLNP
         sufbJx3kOFBMtOcTltp8oPCCz3vza/Ok9jZExRt6XRW6LCmT7L8pvke6myzE7niyAPFX
         WZLRoWVS10NO6G28s4r5uqrXThMKwWdqhOq6LxlUIxrEcnJpHf9GL8qYGHkY4vu9M1WH
         mwlGu+3hkhkz+cU2k9hZ4Apvt5YqmfvFWiixdzOGNTO3Dn2SpJN0BrsFdQs9+3MfB/Sq
         IUePoZztqWDYJVH8lQVW+WQTi1yrcuZ2AA7ENz6rfV52aMSlBmJTPMJS3J2ZSIQbwilg
         C+xQ==
X-Gm-Message-State: AGRZ1gJa+IRBmQnboE4rpXDeEDMAqiZqWS/Q3Yeh52mHYXeWNT/a7q3l
        iwYqxbg6pYqn1MZJBgpNwev8RNFTJynkkgY8WE+h6Q==
X-Google-Smtp-Source: AJdET5c4GriZN1yJ0Wz5K0R0CV6g82344H4Tf//7+BIKiWVWpsGn0GNho5TDSUE0F+uM/jMHlLiqGkrNfVLakUunuYM=
X-Received: by 2002:a02:958a:: with SMTP id b10-v6mr7099536jai.130.1541092406435;
 Thu, 01 Nov 2018 10:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181011183350.14584-1-daniels@umanovskis.se>
In-Reply-To: <20181011183350.14584-1-daniels@umanovskis.se>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Nov 2018 18:13:00 +0100
Message-ID: <CACsJy8AVGbS_NTZsUj_hD9D+t4YV1_S4KTD25Kda85syvoowyg@mail.gmail.com>
Subject: Re: [PATCH] doc: move git-cherry to plumbing
To:     daniels@umanovskis.se
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 9:38 PM Daniels Umanovskis
<daniels@umanovskis.se> wrote:
>
> Also remove git-cherry from Bash completion because plumbing
> commands do not belong there.

Er.. why?

>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
>
> Up to discussion whether cherry should be considered plumbing.
> I lean towards considering it a rarely-used porcelain command, but
> a case could be made either way so let's see what the list thinks.
>
>  command-list.txt                       |  2 +-
>  contrib/completion/git-completion.bash | 11 -----------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/command-list.txt b/command-list.txt
> index c36ea3c18..bdca6e3d3 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -62,7 +62,7 @@ git-check-mailmap                       purehelpers
>  git-checkout                            mainporcelain           history
>  git-checkout-index                      plumbingmanipulators
>  git-check-ref-format                    purehelpers
> -git-cherry                              ancillaryinterrogators          complete
> +git-cherry                              plumbinginterrogators          complete
>  git-cherry-pick                         mainporcelain
>  git-citool                              mainporcelain
>  git-clean                               mainporcelain
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d63d2dffd..12f7ce0c5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1340,17 +1340,6 @@ _git_checkout ()
>         esac
>  }
>
> -_git_cherry ()
> -{
> -       case "$cur" in
> -       --*)
> -               __gitcomp_builtin cherry
> -               return
> -       esac
> -
> -       __git_complete_refs

I think this is a regression. Because now "git cherry <tab>" will not
complete refs (the default completer can still complete "git cherry
--<tab>" fine). We support option completion of all commands no matter
what categeory they are. The category is mostly to hide them from "git
<tab>".

If you just want to hide "git cherry" from the "git <tab>" list, then
you could remove the "complete" tag in command-list.txt above.

> -}
> -
>  __git_cherry_pick_inprogress_options="--continue --quit --abort"
>
>  _git_cherry_pick ()
> --
> 2.19.1.330.g93276587c.dirty
>


-- 
Duy
