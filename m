Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BBA20357
	for <e@80x24.org>; Mon, 10 Jul 2017 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbdGJSbN (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 14:31:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33630 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbdGJSbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 14:31:06 -0400
Received: by mail-wr0-f182.google.com with SMTP id r103so150167666wrb.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2zExnUzmAMsd6FE+XfTNxfOzoIZ1W5iyGn8pQK3uePA=;
        b=Sz+sssJrHgpvo9PaD5mO6IJ9MHZuW9FKD+ia7bOZ8CUwkAAIDhwq/eYCPF7K3EsV3S
         42yIKDb35Ay35Jc9Uyb41JKnNCy60TMfij35YWO4EVtIUrEDnVG0Oit7zarycNfIRCKX
         uyEsA2A2eDxJJ5E/fjFC8jwStr7QXIpX9YahC4KZOmiUMRMemRt+qRwcyBfxuwakXhsq
         fB4xlMZdECgXj2r7huXi1bRp0NRuRzEl9HS2Nr6QXUwlWnHcz97xJk1NfaIl3XSZl0WN
         QOhOKjLBbim8Bwd0VvyjatggygqNJQNVJAnhV872/bfbT3PFV9XYDf3vY2N6sLOY36fR
         yUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zExnUzmAMsd6FE+XfTNxfOzoIZ1W5iyGn8pQK3uePA=;
        b=czPBtv8NQB1efzorN0UkjGmvNCcpR59yqGQFFWI8N6WwJknVsNZpPLO1BMVnYGA/n1
         YUFYRqyuIaqVGzm6KOpeiWagYXMvgo84K1JDgg8HrwCfpVG4pQVRdYKsrCcUUVsKGIAF
         +XGTJeFXDtZXVz++iPByYMjOufiU2D6pcFyTXZyW/Q8PMIjdrRlIgC45kzIfcx2R8lF7
         d3IvNDfLdfubdQm7MXYrovmQ4KkXGvE+sookGxsiIk+eS2foBi1TUrhYW/3IDkseKwVJ
         HA8N+UHeE6M9hm0D4dB4NzWpKKReHni+2ojhLeCRx6HMZGva0r2g98NaVYzWe9s9T5ID
         ba4A==
X-Gm-Message-State: AIVw1106eEaQfW8l7+oZVxlzSQP9gFN0kbCDjhta8UvNg+mObushkc1f
        SB139TAz7OxOjNLq
X-Received: by 10.223.170.7 with SMTP id p7mr7621008wrd.79.1499711465445;
        Mon, 10 Jul 2017 11:31:05 -0700 (PDT)
Received: from Haydn (vil93-6-82-233-248-1.fbx.proxad.net. [82.233.248.1])
        by smtp.gmail.com with ESMTPSA id u135sm543197wmu.12.2017.07.10.11.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2017 11:31:04 -0700 (PDT)
Date:   Mon, 10 Jul 2017 20:31:01 +0200
From:   William Duclot <william.duclot@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for
 inexperienced users
Message-ID: <20170710183101.GA13122@Haydn>
References: <20170709202520.21739-1-william.duclot@gmail.com>
 <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:
> William Duclot <william.duclot@gmail.com> writes:
> 
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 2cf73b88e..50457f687 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -55,9 +55,10 @@ LF='
> >  '
> >  ok_to_skip_pre_rebase=
> >  resolvemsg="
> > -$(gettext 'When you have resolved this problem, run "git rebase --continue".
> > -If you prefer to skip this patch, run "git rebase --skip" instead.
> > -To check out the original branch and stop rebasing, run "git rebase --abort".')
> > +$(gettext 'Resolve this conflict manually, mark it as resolved with "git add <conflicted_file>",
> > +then run "git rebase --continue".
> > +You can instead skip this commit: run "git rebase --skip".
> > +To stop the whole rebasing and get back to your pre-rebase state, run "git rebase --abort".')
> >  "
> 
> I find the updated one easier to follow in general.
> Disecting the phrases in the above:
> 
>  - The original said "When you have resolved this problem", without
>    giving a guidance how to resolve, and without saying what the
>    problem is.  The updated one says "conflict" to clarify the
>    "problem", and suggests "git add" as the tool to use after a
>    manual resolition.  
> 
>    Modulo that there are cases where "git rm" is the right tool, the
>    updated one is strict improvement.

I also wrote "<conflicted_file>" when there could be several. Maybe
'mark it as resolved with "git add/rm"' would be a better (and shorter)
formulation?

>  - The original said "to check out the original branch and stop
>    rebasing", and the updated one says "to stop and get back to",
>    which is in a more logical order.  
> 
>    "the whole rebasing" used as a noun feels something is missing
>    there, though.  I wonder if "To get back to the state before you
>    started 'rebase -i', run 'git rebase --abort'" is sufficient,
>    without saying anything further about abandoning the rebase in
>    progress (i.e. "and stop rebasing" or "stop the whole rebasing").

Definitely seems clearer to me: straight to the point.

> Thanks.

Happy to see this patch seems interesting to you. I feel like a lot of
git messages could be improved this way to offer a UI more welcoming to
inexperienced user (which is a *broad* segment of users). But I am not
aware of the cost of translation of this kind of patch: would several
patches like this one be welcomed?
