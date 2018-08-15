Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B931F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHPACL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:02:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeHPACK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:02:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so2265088wrp.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4d5OWoD0uaPECSVptsPxCbFIFJIk0Xo3lrJ6xIWGlss=;
        b=GjflEjVw0oCaEos/sNrs1CAJomcPlzecMTzrc9gnOra5BPGY0yUy2SdhM/9RZ2svl/
         dasM7MY5qWxN0ZU2fVCWp/fY5an+cELLaWgleywmae0CxGGnYH3P0/9WqYIdK0UY7Fww
         qpirndsiAzDAKeyiEPCsQ4BHwE9sgp+iD4PJ9j1CkxRS2LjZDTcC69tBUkOeHVYMHF16
         Gsn0MCV9b6MUIzay/rHtKie16x7FgDVSglWbSy+Ad4RXLpPw7ReLJP5LsX6LGODXi++z
         fCXcKAaQYGhwBlQIg4frrfdPESOF6oQkzmB6nxj6HM7ud21rPXYni9VabTmj0ZpXItaE
         XAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4d5OWoD0uaPECSVptsPxCbFIFJIk0Xo3lrJ6xIWGlss=;
        b=I3Dn9qWl0BND6xxKflA/2/egEdHVSzHq3Eu/c+9+r5zRnTtyFAohy4eQeSsm8vVeEo
         jbzRAJW9vd1Go2c/uLDiIWC3XVeB1AH6XLB7O0LrHpzNa589vQK4ohO9RSo0lDrNFDIE
         G4WLEQuuTMNhgLEWl0hgrL2jWbut8SEJF5+q+N9+OWecnfBtxfSR6g5sKtLp+8z/mJbC
         4W/jqAtgngRNBaIZyPdBv/xBD2UiC76F4/WATCQdDKWqNnnp/0R9JPE25OeNsIbSnGWh
         Aq7ne6dlyCq/8PEI6GC7lRQZ/RvIxc3LTkBnZI0zQwZ/u0Sw5rolgN6BDAepw0z17uqj
         1bVg==
X-Gm-Message-State: AOUpUlEHsjmOxDPyQEMQHWWcsRhMNjBfFHTGEgrheDFIaNT/wWVDhCZi
        qkg1+ZRhjJWtBrCE3HIc9qu0cykK
X-Google-Smtp-Source: AA+uWPzSO3c1xP6W+4s/kaCRMslBHjC5JULueyy760XyBe5YwJ7Aw51AR/CwcwPkLnq8CzinWaJnng==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5-v6mr17722248wrt.210.1534367298798;
        Wed, 15 Aug 2018 14:08:18 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id f132-v6sm3790062wme.24.2018.08.15.14.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:08:17 -0700 (PDT)
Date:   Wed, 15 Aug 2018 22:08:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 13/26] stash: update `git stash show`
 documentation
Message-ID: <20180815210817.GO2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <46b04e256f045a53111d52439de376a5f332cb55.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b04e256f045a53111d52439de376a5f332cb55.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add in documentation about the change of behavior regarding
> the `--quiet` option, which was introduced in the last commit.
> (the `--quiet` option does not exit anymore with erorr if it

s/erorr/error/

> is given an empty stash as argument)

If we want to keep the change in behaviour here (which I'm not sure
about as mentioned in my comment on the previous patch), I think this
should be folded into the previous patch.  I don't think there's much
value in having this as a separate commit, and folding it into the
previous commit has the advantage that we can easily see that the new
behaviour is documented.

> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  Documentation/git-stash.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index e31ea7d30..d60ebdb96 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -117,6 +117,9 @@ show [<options>] [<stash>]::
>  	You can use stash.showStat and/or stash.showPatch config variables
>  	to change the default behavior.
>  
> +	It accepts any option known to `git diff`, but acts different on

I notice that we are using single quotes for git commands in some
places and backticks in other places in this man page.  We may want to
clean that up at some point.  I wouldn't want to do it in this series
though, as this is already long enough, and we've had this
inconsistency for a while already.

> +	`--quiet` option and exit with zero regardless of differences.
> +
>  pop [--index] [-q|--quiet] [<stash>]::
>  
>  	Remove a single stashed state from the stash list and apply it
> -- 
> 2.18.0.573.g56500d98f
> 
