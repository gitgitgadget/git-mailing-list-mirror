Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC5A2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 13:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdF1NE2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 09:04:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36005 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdF1NE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 09:04:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so8187505pgn.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=DbRiL6MANeQX3XOHFQVcERIoMs87KztUW3qkim1nJMU=;
        b=RTifvNpgQTZXLa4j5lDCuLmkPLK+XjkdIvmtkuDhsKfqTQYMqcBFJSqgZY0UZGWfje
         E7AnOMAvxdlnEb1uVxfQ4QT5UyO0TjLw9uI0DUK/RWviSGHU6yjp0Z7RJ2cwFw6X8luw
         RHS7jKM6z2qAQOiKdIpO+/eIkcoRt/sgOUP1zisa4A+eSnFBuvXwOHuTLBUZhRtVi7Zq
         o+Fw7yvMd30deuJ1NSyNVrlqLAIKg3eGmSsP1CBjaU8hV03jSDik5t66QKSt6nKfjpLI
         SrcqVjG8pEBy1kzC0TogXSwKV1PEX782dFJPohyyRJaRTIAKko+zi7+zLUoDLWZPmiDS
         1Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=DbRiL6MANeQX3XOHFQVcERIoMs87KztUW3qkim1nJMU=;
        b=pOdqgScIM9qO03gz2YBh4wQI16lzgU9tkGwVZAOWoa6rlU6NqXIBuAW1YOPxH6WBGt
         sefuLIcE8jpla1ljCghTJx8jTZIY4zGRBQeZUVUxEyCsD78TG6NkzJ6hTrGU3c7OAimZ
         N5V3FEklRNEiOuJhFUGmhE45kgF8+h+j9gHuUkGAw1wW28un/ElWW1F14ylWjLQj06r+
         1F63/3G4OH19p/4AGkukjn91UyzT30QyxVErEawQ6oFJngm9vOPKWBMNowXRGbSO3+Qv
         fr+0ORsO8305X42D4GkVUgdIsjdmxKznNychVAnrDvzkNKD3A1pUJ0LmGg7YCe3jmEwi
         I6NQ==
X-Gm-Message-State: AKS2vOyroE1LUovsxSnMAp/RSgXUg+mNSyuzq0nf19m8Xb+pfKUlzUQu
        8cX3R84Rq3r3gg==
X-Received: by 10.98.215.73 with SMTP id v9mr10787077pfl.103.1498655067060;
        Wed, 28 Jun 2017 06:04:27 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id b8sm5393404pfd.65.2017.06.28.06.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 06:04:26 -0700 (PDT)
Message-ID: <1498655062.1935.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] commit-template: improve readability of commit
 template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 28 Jun 2017 18:34:22 +0530
In-Reply-To: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
References: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
         <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
         <1498584144.2737.7.camel@gmail.com>
         <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
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

On Tue, 2017-06-27 at 10:56 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> > I thought it's not good to trade-off readability for vertical space
> > as
> > the ultimate aim of the commit template (at least to me) is to
> > convey
> > information to the user about the commit that he's going to make.
> > For
> > which, I thought it made more sense to improve it's readability by
> > adding new lines between different sections rather than constrain
> > the
> > output within a few lines.
> 
> You have to be careful when making a trade-off argument.  It depends
> on how familiar you already are with the presentation.  Those who
> are/got used to the order of things that come, they will know there
> is extra information when the block of lines are longer than usual
> without reading every character and then their eyes are guided to
> read what is extra, without having to waste precious screen real
> estate.  Nobody will _stay_ a new user who is not yet familiar with
> the everyday output.
> 
You're right. I didn't consider the fact that experienced users would
be affected as a result of this change, sorry about that. I thought,
making this change would help the new users who would possibly find the
commit template to be congested and let experienced users to get
accustomed to this new output format. I thought this change would be a
win-win (at least after people get accustomed to the new formatting). 

In case screen real estate is considered more important here, no
issues. I'll drop that part of the change, happily.

> > I actually didn't think of modifying that in order to keep it in
> > line
> > with the output of `git status`.
> 
> I was (and still am) assuming that if we make this change to "git
> commit", we should make matching change to "git status" as a given.
I get it now. In that case, I don't think making the change would be a
good choice for the following reasons,

    * I think vertical spacing matters more in the output printed to a
    console.
    * I myself find it odd to add a new line below the branch
    information possibly because I'm too accustomed to it's current
    output.

I tried adding the new line, it seemed to be too spacious. It might be
just me in this case.

> > Further, to me, adding *this* new line
> > before the "Changes not staged for commit" (or something in it's
> > place)
> > seems to be wasting some vertical space ...
> 
> I think it is in line with your original reasoning why you wanted
> these extra blank lines to separate blocks of different kinds of
> information:
> 
>  - "Please do this" instruction at the beginning
>  - Make sure you know the default is --only, not --include
>  - By the way you are committing for that person, not you
>  - This change is being committed on that branch
>  - Here are the changes that are already in the index
>  - Here are the changes that are not in the index
>  - Here are untracked files
> 
> Lack of a blank between the fourth block and the fifth block [*1*]
> makes it somewhat inconsistent, doesn't it?
> 
It does, for the given set of blocks. I didn't find it inconsistent as
I thought the separate blocks as follows,

 - "Please do this" instruction at the beginning
 - Make sure you know the default is --only, not --include
 - By the way you are committing for that person, not you
 - Status of repository (git status)

> [Footnote]
> 
> *1* Yes, we should think about removing the optional second block,
>     as I think that it outlived its usefulness; if we are to do so,
>     these become the third and the fourth blocks.
If I interpreted your previous email correctly, I thought we were doing
it!

I'll send a "typical" patch as a follow-up of this mail.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
