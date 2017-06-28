Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF9D1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 14:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbdF1Ou4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 10:50:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36852 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdF1Ouy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 10:50:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so8497971pgn.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=Bjqdhv/KvwDeAB46As/hvmFj1xuRktvNhAX9CJsRSwg=;
        b=jXcNWClWKwZTqrYu4SOC414JqLwreAlbYj53BGmI40NJsHmdgteSHtWBu2qNLpzerb
         4F96CTvcKthAsxVuFGNASDuUWYEeH21IbO/xL+JIeJAVuZImLPhzNYco3y1hYpRCriiR
         wKwA8L696gkCvH1yIxT64XlNZwEoaaOdnB739YqYUnl0RmSClz33OOB3Oc1ewFl9Fl/y
         +nROTVvfUC8ZhzKRP1rVjexr4hrX+9c89eNq/Q6VwogjKZPpWwGA8Z3L6R5Hf/jEYdsQ
         q0fKSuDbwdQ/3Mse47FqNg3fBudb8Zjc9mFJLki4zpF0Coc8aLPIdQQMitlvKu1Re8kl
         VCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=Bjqdhv/KvwDeAB46As/hvmFj1xuRktvNhAX9CJsRSwg=;
        b=s6u6A84//dyjAYbr/808LW4TtScU9gKpx/21hwU8lws0RjbLeI9F6bE3n9oQ3i8Pmy
         pot7bQJoIgl7sOaV6aM6fMjWi5+yiKi4/+TNRTvPnRtABC0b92QxanUI8X1F2SQ8Zcht
         BfSsA4H8os+ahXknp4aZCzk+KMZ8dQH0R69wD1lrw5zQ4eCksWDUo/fwDJxy0jqnpI6Q
         zYZT7SRFhuVj0zK+Q5Y5Ed01u5JJ1HCggDb37EzC8US+O+th8rhfTUQjYZceH/IW1xGQ
         YJiF17S1JQW+2uwSgolaI8IZEsDbFQQbIS3wGPkTxxoIBLwsDVUCcZdZAbXR2EFNUkRo
         btYA==
X-Gm-Message-State: AKS2vOxorO8DJQd5Mncs9IGXdT5m27ZndciP8EFDM60nCWe3GhjJITJA
        ef5NBNQZay8Mbd2Y6B4=
X-Received: by 10.84.224.15 with SMTP id r15mr12171849plj.78.1498661453816;
        Wed, 28 Jun 2017 07:50:53 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id n71sm5249727pfi.95.2017.06.28.07.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 07:50:53 -0700 (PDT)
Message-ID: <1498661450.10011.3.camel@gmail.com>
Subject: Re: [PATCH/RFC] commit-template: improve readability of commit
 template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 28 Jun 2017 20:20:50 +0530
In-Reply-To: <1498655062.1935.2.camel@gmail.com>
References: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
         <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
         <1498584144.2737.7.camel@gmail.com>
         <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
         <1498655062.1935.2.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I might have been ignorant about something about git in my reply in the
previous email (found below). In that case, please enlighten me.

On Wed, 2017-06-28 at 18:34 +0530, Kaartic Sivaraam wrote:
> On Tue, 2017-06-27 at 10:56 -0700, Junio C Hamano wrote:
> > Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> > > I thought it's not good to trade-off readability for vertical
> > > space
> > > as
> > > the ultimate aim of the commit template (at least to me) is to
> > > convey
> > > information to the user about the commit that he's going to make.
> > > For
> > > which, I thought it made more sense to improve it's readability
> > > by
> > > adding new lines between different sections rather than constrain
> > > the
> > > output within a few lines.
> > 
> > You have to be careful when making a trade-off argument.  It
> > depends
> > on how familiar you already are with the presentation.  Those who
> > are/got used to the order of things that come, they will know there
> > is extra information when the block of lines are longer than usual
> > without reading every character and then their eyes are guided to
> > read what is extra, without having to waste precious screen real
> > estate.  Nobody will _stay_ a new user who is not yet familiar with
> > the everyday output.
> > 
> 
> You're right. I didn't consider the fact that experienced users would
> be affected as a result of this change, sorry about that. I thought,
> making this change would help the new users who would possibly find
> the
> commit template to be congested and let experienced users to get
> accustomed to this new output format. I thought this change would be
> a
> win-win (at least after people get accustomed to the new
> formatting). 
> 
> In case screen real estate is considered more important here, no
> issues. I'll drop that part of the change, happily.
> 
> > > I actually didn't think of modifying that in order to keep it in
> > > line
> > > with the output of `git status`.
> > 
> > I was (and still am) assuming that if we make this change to "git
> > commit", we should make matching change to "git status" as a given.
> 
> I get it now. In that case, I don't think making the change would be
> a
> good choice for the following reasons,
> 
>     * I think vertical spacing matters more in the output printed to
> a
>     console.
>     * I myself find it odd to add a new line below the branch
>     information possibly because I'm too accustomed to it's current
>     output.
> 
> I tried adding the new line, it seemed to be too spacious. It might
> be
> just me in this case.
> 
> > > Further, to me, adding *this* new line
> > > before the "Changes not staged for commit" (or something in it's
> > > place)
> > > seems to be wasting some vertical space ...
> > 
> > I think it is in line with your original reasoning why you wanted
> > these extra blank lines to separate blocks of different kinds of
> > information:
> > 
> >  - "Please do this" instruction at the beginning
> >  - Make sure you know the default is --only, not --include
> >  - By the way you are committing for that person, not you
> >  - This change is being committed on that branch
> >  - Here are the changes that are already in the index
> >  - Here are the changes that are not in the index
> >  - Here are untracked files
> > 
> > Lack of a blank between the fourth block and the fifth block [*1*]
> > makes it somewhat inconsistent, doesn't it?
> > 
> 
> It does, for the given set of blocks. I didn't find it inconsistent
> as
> I thought the separate blocks as follows,
> 
>  - "Please do this" instruction at the beginning
>  - Make sure you know the default is --only, not --include
>  - By the way you are committing for that person, not you
>  - Status of repository (git status)
> 
> > [Footnote]
> > 
> > *1* Yes, we should think about removing the optional second block,
> >     as I think that it outlived its usefulness; if we are to do so,
> >     these become the third and the fourth blocks.
> 
> If I interpreted your previous email correctly, I thought we were
> doing
> it!
> 
> I'll send a "typical" patch as a follow-up of this mail.
> 

