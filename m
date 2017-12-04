Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814DD20954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdLDRZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:25:39 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:46166 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdLDRZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:25:37 -0500
Received: by mail-pg0-f47.google.com with SMTP id b11so8644624pgu.13
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=8iO6kvgcio67xJ9L2LtVM9trEHXSbN8PUiN9YhX+nF8=;
        b=bBIshtjgmEGQkVBMt6a2K8FMIlYzZqEOPkXZqP07r7ALEMAHpbU4hXR2JnPZdORbO7
         8ePIQdCVvXFX6STKF5OSIMJPsDvpreptmdPFNyLrni016uzj7RYhIfVMo14bARPLQ+aP
         u747E6gqq10yx+UwjEPPqhKuVSteF9d5UojVOkfl0kqrV1P3Q1oCE24worpGf9VvX4uF
         C85OCME6Mp6XbNUsTzfy9NC3CXJIs/VVZAICId7Ht4ReOjq9H2O9OYGAcelw8Y4lHWle
         zLw7lQqxtyQyngzjG+Kmw89qYtcK0DWSfc7d1Xiur54hoqIqXD0yKYUbKUOuwsjVVc5P
         At9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=8iO6kvgcio67xJ9L2LtVM9trEHXSbN8PUiN9YhX+nF8=;
        b=SNvKOqoo8x52iuMO+zG81oTrIp8K1YhHb8jxYxjz20KEThm9L+kDmMqwliFHPxOnyN
         G9riXl7PdCbvfDzHXx15cEnOF7jQ+h1Geq/J9DMJv54CGUIV3np51RLAsmMciYSA8Rbz
         /6ej04t74aIXA0XCuKBWOrv+LuOQ/tZ33cGbEYuCgUcJ8/ez1fWDH1E/4Ur4+X1sCXGi
         RQEYqFM6qzA5odumySlfedlZhdFlXtJUF+g6GBvyE11KyN+DgwtPFmXm/MbhxrudRh5a
         mSsLPiIk23JDyVB9pzYsePSeqpA8UCAAgvZaCgn7R9XIUI55FiDE7I+JX6pEjizWoxga
         gt/A==
X-Gm-Message-State: AJaThX6ZI+9543nEYlGSZi24jJKRgddmwBet6EINQLyFFE6dorCT1ZAc
        lyXQfkd1ymEE5tfukaquvtR/L7nn
X-Google-Smtp-Source: AGs4zMbbiizGvb1LHSTu1snDH23M18g5oWcSH9Sijn5nUuYdifXaRK4D/axmzEdNHKuDPe/SMdfteg==
X-Received: by 10.98.75.68 with SMTP id y65mr20023509pfa.78.1512408337169;
        Mon, 04 Dec 2017 09:25:37 -0800 (PST)
Received: from unique-pc ([117.209.183.214])
        by smtp.gmail.com with ESMTPSA id l4sm9045911pff.90.2017.12.04.09.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 09:25:36 -0800 (PST)
Message-ID: <1512408328.15792.5.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about
 @{-N} syntax
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <xmqqa7z0lgsd.fsf@gitster.mtv.corp.google.com>
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
         <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
         <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
         <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
         <1511880237.10193.5.camel@gmail.com>
         <xmqqa7z0lgsd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 04 Dec 2017 22:55:28 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-12-02 at 17:52 -0800, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > > I have a mild suspicion that "git checkout -B @{-1}" would want to
> > > error out instead of creating a valid new branch whose name is
> > > 40-hex that happen to be the name of the commit object you were
> > > detached at previously.
> > 
> > I thought this the other way round. Rather than letting the callers
> > error out when @{-N} didn't expand to a branch name, I thought we
> > should not be expanding @{-N} syntax for "check-ref-format --branch" at
> > all to make a "stronger guarantee" that the result is "always" a valid
> > branch name. Then I thought it might be too restrictive and didn't
> > mention it. So, I dunno.
> > 

OK. Seems I was out of mind in the above reply. I have answered the
question about whether "branch=$(git check-ref-format @{-1}) && git
checkout -B $branch" should fail or not. Sorry, for the confusion in
case you mind it.


> > 
> > > I am not sure if "check-ref-format --branch" should the same; it is
> > > more about the syntax and the 40-hex _is_ valid there, so...
> > 
> > I'm not sure what you were trying to say here, sorry.
> 
> The "am not sure if" comes from this question: should these two be
> equivalent?
> 
>     $ git check-ref-format --branch @{-1}
>     $ git check-ref-format --branch $(git rev-parse --verify @{-1})
> 

I could see how,

	$ git rev-parse --verify @{-1}
	$ git rev-parse --verify $(git check-ref-format --branch @{-1})

could be equivalent. I'm not sure how the previous two might be
equivalent except in the case when the previous thing checked out was
not a branch.

1. "git check-ref-format --branch @{-1}" returns the previous thing
checked out which might be a branch name or a commit hash

2. "git check-ref-format --branch $(git rev-parse --verify @{-1})"
returns the commit hash of the previous thing (the hash of the tip if
was a branch). IIUC, this thing never returns a branch name.


> If they should be equivalent (and I think the current implementation
> says they are), then the answer to "if ... should do the same?"
> becomes "no, we should not error out".
> 
> Stepping back a bit, the mild suspicion above says
> 
>     $ git checkout HEAD^0
>     ... do things ...
>     $ git checkout -b temp
>     ... do more things ...
>     $ git checkout -B @{-1}
> 
> that creates a new branch whose name is 40-hex of a commit that
> happens to be where we started the whole dance *is* a bug.  No sane
> user expects that to happen, and the last step "checkout -B @{-1}"
> should result in an error instead [*1*].
> 
> I was wondering if "git check-ref-format --branch @{-1}", when used
> in place of "checkout -B @{-1}" in the above sequence,

I guess you mean '... "git checkout -B $(git check-ref-format --branch
@{-1}", when used in place of "git checkout -B @{-1}" ...' ?


>  should or
> should not fail.  It really boils down to this question: what @{-1}
> expands to and what the user wants to do with it.
> 
> In the context of getting a revision (i.e. "rev-parse @{-1}") where
> we are asking what the object name is, the value of the detached
> HEAD we were on previously is a valid answer we are "expanding @{-1}
> to".  If we were on a concrete branch and @{-1} yields a concrete
> branch name, then rev-parse would turn that into an object name, and
> in the end, in either case, the object name is what we wanted to
> get.  So we do not want to error this out.
> 

Right.


> But a user of "git check-ref-format --branch" is not asking about
> the object name ("git rev-parse" would have been used otherwise).
> Which argues for erroring out "check-ref-format --branch @{-1}" if
> we were not on a branch in the previous state.
> 

Exactly what I thought.


> And that argues for erroring out "check-ref-format --branch @{-1}"
> in such a case, i.e. declaring that the first two commands in this
> message are not equivalent.
> 

As said before, IIUC, they give equivalent output to stdout only when
the previous thing checked out was not a branch.


-- 
Kaartic
