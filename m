Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AA81FD4F
	for <e@80x24.org>; Tue, 29 May 2018 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeE2SBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:01:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38018 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965391AbeE2SBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:01:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so42880014wmb.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3N3HMup+xisb2QSAE4sCqqU1o4kg9MbznIdF57p8br8=;
        b=O6UR6cp2j3aOJBFnEgHrFXW7pmgQBJZ8qFKF+ONmjW84rvSKWA6TFx165ht8sAAEA9
         twkcCqZa4FTaIMfu5QvKnMSh0LeCiQUbvEy5gctcy4xkrngOdy7QlRaU6fXArjezNpFX
         kIPLT7BVjXuHnvPJdHO/eZ7fi+04xGSrJGhVJUU9S6OhM4IKDYYZFA8YbQ/US0ov0q6U
         WBeZfs+Y9yiW7eNxEP9kmJfhN8cieZoER8dAp7NJVvskPMY5L/CCqSApK4SEJBJBl0CA
         ikFGmMdV3t5vFseg2xX1DlsJVQbE4rJ/IjdUA+XlfPLZ0pFQ8N3nsi1x+O5d+naHFvR1
         ZTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3N3HMup+xisb2QSAE4sCqqU1o4kg9MbznIdF57p8br8=;
        b=CU2LooagvzRVk31QsxeDulzQaNtrlit6Qmx4gtxnO93AlJH7AMcekhRhjAkyp6PMdZ
         7Xq2+iDbo3YhugvW1MyjnIRV5rtSQGzTPrk9QUNSayP+UbweDtwdQEhudCPLj2meWTLP
         MtAyD0Rd6aqPczUYbhUEnQhO/1PfuGWmHrIdIcl4StTlLSTPOTl6sP4nVPFqkL0Y/3Wy
         N8kFii9SXEA2AL4uddFBNFzU/U53QW+vB2yd4fbF43WVDRLbtABY94y4Ck4wCrqcFxDS
         KPgqVKXawzOcPw4ukOWhHlNxl9bxktuJ65WXC/XSH3kKg5A+hiTrbX5dLXBJ7u5enDjP
         k4KQ==
X-Gm-Message-State: ALKqPwf2C5h8hBSoID/x2bj762NHJRYbAqi31P36RoIidkMzSoGPWxKh
        xurTo2bk7/x0icJuugHhOEa0PSZD
X-Google-Smtp-Source: ADUXVKLmINYroyca/yHo1ZIWKTAK+wT3mHw7HzOUMO3wfZw5qijzn+jTZ9hAogPFfifXRnHc6qqf0Q==
X-Received: by 2002:a1c:1a49:: with SMTP id a70-v6mr13753661wma.77.1527616889896;
        Tue, 29 May 2018 11:01:29 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 64-v6sm14779136wmb.2.2018.05.29.11.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 11:01:28 -0700 (PDT)
Date:   Tue, 29 May 2018 19:02:03 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/1] SubmittingPatches: not git-security@googlegroups.com
Message-ID: <20180529180203.GC8868@hank.intra.tgummerer.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180527153418.GG207547@aiede.svl.corp.google.com>
 <20180527210822.GB8868@hank.intra.tgummerer.com>
 <xmqqbmd0lc11.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmd0lc11.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/28, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Yeah sorry, that's what I meant.
> > https://public-inbox.org/git/20180308150820.22588-1-avarab@gmail.com/
> > is the reference I meant to put there.
> >
> > How about something like the below?  This is tested with asciidoc
> > 8.6.10 and asciidoctor 1.5.6.2.  I'm also happy to squash the two
> > patches into one if that's preferred.
> >
> 
> If the discussion in the proposed log message needs to be updated
> anyway, it is a good opportunity to make them into a single patch,
> as they share exactly the same objective.

This was mostly a clarification of the note I added after the '---',
but I'm happy to just make this one patch either way.

> This is a tangent, but the use of footnote below looks a but
> curious.  How would {1} reference pick which :1: to use?  The
> closest preceding one?

Tbh I didn't look at the docs for doing this, but just used the same
syntax as we're already using and tried it with both asciidoc and
asciidoctor.  And yes it seems like it always picks the preceeding
one.

> As this appears on a page that already has other footnotes attached
> to an adjacent paragraph, I am wondering if they should be made into
> a part of the same numbering sequence.

I have now actually looked at the docs, and this numbering has nothing
to do with the footnote format, but rather is used to substitute the
attribute that's specified in the curly braces with the text that's
after :<attribute>: [1].  This initially confused me a bit.  Maybe it
would be nicer to give the attributes names instead of just numbers?
As we keep adding footnotes, that would be less likely to produce
conflicts between the different attributes I think.

I'm also adding brian to the cc list, as he first converted this to
AsciiDoc for opinions.

[1]: https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/#attributes-and-substitutions

> > @@ -264,6 +264,11 @@ people who are involved in the area you are touching (the `git
> >  contacts` command in `contrib/contacts/` can help to
> >  identify them), to solicit comments and reviews.
> >  
> > +:1: footnote:[The Git Security mailing list: git-security@googlegroups.com]
> > +
> > +Patches which are security relevant should be submitted privately to
> > +the Git Security mailing list{1}.
> > +
> >  :1: footnote:[The current maintainer: gitster@pobox.com]
> >  :2: footnote:[The mailing list: git@vger.kernel.org]
> 
> Also, the placement of this new paragraph is rather odd.  
> 
> I am guessing that the reason why you put it _before_ the normal
> list address is to make sure those with secrets that must be guarded
> won't send it to the list first without thinking, but then this
> place is too late for that, as the previous paragraph already told
> the reader that the patch should be sent to the list and others but
> not necessarily to the maintainer.  This should go one paragraph
> before that, at least.  I briefly considered suggesting to move it
> even earlier, e.g. the beginning of "Sending your patches" section,
> but then by the time readers with potential security patches may
> have forgotten it, or worse, get confused by us, when we say "Send
> your patches with To: set to the list".  So I dunno.  The most
> conservative would be to write it at the beginning of the section
> and then repeat it just before "Send to the list, Cc releavant
> people" paragraph as a reminder.

Yeah I wasn't quite sure where to best fit this in.  I'd be happy with
it appearing twice.  Will update this in v2.
