Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0751FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757584AbdJKTUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:20:17 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53619 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdJKTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:20:16 -0400
Received: by mail-wm0-f54.google.com with SMTP id q132so7631426wmd.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Leizf3QnCY7oIEsQajJ135aSEFpmY3k7WCzQ2hmNxzQ=;
        b=bFraR+A8MmQehtiCKuI0ARkeVEK8QaZEqbOU/1ov7MOl3vMrfGbDu2iCSmY3w9SISq
         aMC34hNwqPPn3MYABt6ae/yS5XhdQUGPfhokGL+747uNaDlnMWez8hL571/lxe1tqp/O
         +NFru/dEiTSDGTiYiYuNFpZtmOlJI5stAPRHCOl05HVkNQGvgVwoXSrJELVeDaIhP+k4
         vxcdrqEFl3StaM9qAAiB955Zw9mONsQRku59YR0zBmt6XvxF4Qr/0iA6AItjbl1XBVQj
         8VL/Dz3iEiCYjJNQfMlboIa0FGPHGpqaOEtQseaN1TLl0qHuwVFFgB63ws2izLcrkp5T
         zAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Leizf3QnCY7oIEsQajJ135aSEFpmY3k7WCzQ2hmNxzQ=;
        b=gNRxEcPB4EqgsJ+uR87iKBF2XXFBKb9HytxVA1ORmyaQtDo7ZRs8Q993Dq1f+RU+5M
         B07b84+7SVz7smFLRizg43kvp9HUnfKbEwdqtIUBDMGuLGupplEyVn1Cb3Q//VqX+7Hm
         e9aZ9qdgc6bKj63Z5BTvaDSOBJgJzWko+GesmEBRfEFD6eYuOIFaPV3HEeAl1lHmDbs2
         nGQtriKuEY6Ei/Rbp19tFjbhfD/c2bn1VRdBh4zsSoiOmCKRUwC/JfX+yTjLTYrsrEjQ
         WZtimC4R4uN40SybLiRuMOjCVnDAWDZfKXMIOOKk9wunzKRgHL6gt1Jxkd1ghV570Hl1
         v0yg==
X-Gm-Message-State: AMCzsaVy8ky2uQUaogUaVcPbNlaTKTBeIcluALlQvpXMIC4cmtaTeR4D
        vBZ2jSp0eBQ8f5urdyNeS3WhMh86
X-Google-Smtp-Source: AOwi7QAsapi2ofXjLMbI6ogNogLY9HcM4VnC0wiLyq+bcKIb9iEX1Hmg0WbXEzcnVEwqNq4t6Qkurw==
X-Received: by 10.28.37.195 with SMTP id l186mr388wml.144.1507749615148;
        Wed, 11 Oct 2017 12:20:15 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m48sm7978334wrf.51.2017.10.11.12.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 12:20:14 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:21:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: slight addition to t.gummerer's proposed "git stash" patch
Message-ID: <20171011192109.GC15399@hank>
References: <alpine.LFD.2.21.1710110454240.11490@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710110454240.11490@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Robert P. J. Day wrote:
> 
>   was perusing thomas gummerer's proposed "git stash" patch here:
> 
> https://www.spinics.net/lists/git/msg313993.html
> 
> and i'd make one more change -- i'd separate the OPTIONS entries for
> "git stash push" and "git stash save" so they don't end up being
> rendered all crushed together when displaying the man page:

I for one would like that.  I sent a patch recently [1] that would
show git stash push first on the man page, which didn't seem to get
much traction.  This goes a bit further than that, which I'd be happy
with.

[1]: https://public-inbox.org/git/20171005201029.4173-1-t.gummerer@gmail.com/

> OPTIONS
>    save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet]
>    [<message>], push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all]
>    [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]
>        Save your local modifications to a new stash and roll them back to HEAD (in the working
>        tree and in the index). The <message> part is optional and gives the description along
>        with the stashed state.
>        ... snip ...
> 
> so rather than:
> 
> OPTIONS
> -------
> 
> push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
> [-a|--all] [-q|--quiet] [-m|--message <message>] [--]
> [<pathspec>...]::
> save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
> [-a|--all] [-q|--quiet] [<message>]::
> 
>     Save your local modifications to a new 'stash entry' and roll them
>     back to HEAD (in the working tree and in the index).
>     The <message> part is optional and gives
>     the description along with the stashed state.
>     ...
> 
> i'd suggest:
> 
> push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
> [-a|--all] [-q|--quiet] [-m|--message <message>] [--]
> [<pathspec>...]::
> 
>     Save your local modifications to a new 'stash entry' and roll them
>     back to HEAD (in the working tree and in the index).
>     The <message> part is optional and gives
>     the description along with the stashed state.
>     ...
> 
> save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
> [-a|--all] [-q|--quiet] [<message>]::
> 
>     This option is deprecated in favour of 'git stash push'.

This sounds good to me.  This can probably be done at the same time
(or after) something like my patch [2], which removes the mentions of
'git stash save' from the man pages, and replaces them with 'git stash
push'.  I guess it would be a bit confusing to see a deprecated
command in the man pages, especially since there is a good (almost
drop-in) replacement :)

[2]: https://public-inbox.org/git/20171005200049.GF30301@hank/#t

> or something like that.
> 
> rday
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
> 
