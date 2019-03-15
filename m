Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70C320248
	for <e@80x24.org>; Fri, 15 Mar 2019 23:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfCOXK5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 19:10:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38653 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCOXK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 19:10:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so7481098wmf.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FoImcua0mI/v5k8XKXB8vrisJb2K32KKPeQwDYTIFec=;
        b=cB2UZ05TO6ZHRGf7W7M6N71TG47lm5M7lWavRbXUDoV3ENpyRh5/Pgn5ZWyI8OrflF
         GqdL4pqz0GB49BTS6Wb5+/sZXlR0Vq4mR3b3nbUfclhSPrika6aphNJ9cwAVB/7Jqyc6
         snuRTEcbMV0YdhhssuSS9AOKMCZVsHjP5nLJulgjO8vi3cLj7I4IBqEv27ZKEQMft0tr
         PI7iWZ6sUDJwpq8A1R7S5u9vRoR1JZ3z7KE6hyz6CU2XG/B0wfA3cuMH7BUjPlsFdx3t
         MLSs1Y5u8zj/Ab7MLoi/7hj5TKjG85e58RGK7hOtRJtHIyziizSsqcqScYFQQnZ6PM6e
         ImXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FoImcua0mI/v5k8XKXB8vrisJb2K32KKPeQwDYTIFec=;
        b=FCrVW7S/FD9GiBKNeGFVKlsiyxC9aJ6deUD468LyLvccUuHPP0hXJUiqKfBHhpcV60
         XbUmNjZn6BrhuOivXT9fdXRhYPsT2GdQSnQLx3+B8jZ4XsEaWgL0dpfB3ZPNRqn4udEm
         LjHBIf9tR6fHJcX94IjxnpIIyQ12F9mYhmNpJrw3ymj4BWv4Vd33TrGqgL6fChciMNTl
         MFxn5ne964jpxmDPXEkCKKOKmsiVAvGdE88jYx8bXH5oZHKCpTsPn+oTC/VwaQgAsjRL
         RiTqHbYY3uxLhm/kGt8XaRR32LGRSDRLm4AUB9DVoB4EPIDPUr+lQowKQ2wxMl0hNnQR
         zPrQ==
X-Gm-Message-State: APjAAAXrBZ5vsoepd1B9vbxU6yfNxCz3tmcxlW3qV/aKaYPEd7b094RL
        hPy3ObuQm658RueEtb/zOkE=
X-Google-Smtp-Source: APXvYqwlCSo0gm7z5K/9hRACUJB6arWaehBLbWPZ87ays8FBjyFCihNbBX481hLPK3dG6b6QICsMRw==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr3490260wmg.81.1552691455723;
        Fri, 15 Mar 2019 16:10:55 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id 6sm2390975wmf.6.2019.03.15.16.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:10:54 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:10:54 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] glossary: add definition for overlay
Message-ID: <20190315231054.GK16414@hank.intra.tgummerer.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <20190312233040.GE16414@hank.intra.tgummerer.com>
 <xmqq5zsnh7my.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zsnh7my.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> > index 023ca95e7c..53df6ecb0a 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -287,6 +287,13 @@ This commit is referred to as a "merge commit", or sometimes just a
> >  	origin/name-of-upstream-branch, which you can see using
> >  	`git branch -r`.
> >  
> > +[[def_overlay]]overlay::
> > +	Only update and add files to the working directory, but don't
> > +	delete them, similar to how 'cp -R' would work.  This is the
> > +	default mode in a <<def_checkout,checkout>>.  In contrast,
> > +	no-overlay mode will also delete tracked files not present in
> > +	the source, similar to 'rsync --delete'.
> > +
> 
> At least the mention of "checkout" needs to be a lot tightened to
> clarify that it is talking about "checkout <pathspec>", aka
> "checking out files out of the index or a tree-ish", as opposed to
> "checking out a branch to work on it", as checking out a branch will
> not work in the overlay fashion.  What's not in the newly checked
> out branch will disappear from the working tree.

Good point, I'll fix that in v3.

> If readers happen to be not paying close attention to the fact that
> the difference between overlay and non-overlay is about the
> destination, "similar to how 'cp -R' would work" may not click to
> their minds.  "similar to how 'cp -R' updates the contents in the
> destination directory" may avoid such a risk, albeit it might be a
> bit too verbose.  I dunno.

I feel like it's okay to be a bit more verbose in the glossary.  I
think your suggestion above is better than what I had, I'll use that
in v3, thanks!
