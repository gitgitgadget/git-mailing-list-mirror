Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D146F202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760248AbdKPRB7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:01:59 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:52822 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759690AbdKPRB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:01:57 -0500
Received: by mail-qt0-f194.google.com with SMTP id 31so44394084qtz.9
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PIGZWHGCDi0YFMaixZFSb9fSCjey/dnVya8Spd9yHh8=;
        b=ogfrgRjo6XY/Zd7wD2zcfNptZuMlAxYFtyDP0cGJstbWZmrysWVTXsiPgU45N4Sb9v
         DYss/3zlGr1EAnvWtgN6KfwzMeNZiQpcJyipZlqcv/i2C5qxqhAKehBh014NCaMeRL+o
         +kIfcNyGmJEfptmdjlzzLUXZ68j0CwyEeDX+5AIgG0c3BHBV6xi4Mk116f3ZBr0zyGDl
         bkPVR3pdfmwR3aiSNrQ6uExdp2bqUECYjHzJov+ERVh5U/hRpSHBwGxNCQQX7PO3Eq6l
         qucvpLyqJEGQ3yy/X568EBcZP5ulizOZ8XuNSiV7oFDpjm7lfQQE/TX9RZv4wi2r5ChM
         IGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PIGZWHGCDi0YFMaixZFSb9fSCjey/dnVya8Spd9yHh8=;
        b=mRG1Mqn88SnlAX0rjMOz3+YjTDsfMwuNrjHwr5+CAypa5TvxcnOi/npPbKsdNhHJR8
         6kdcNw+bD+/y2Se0wAFuQnHOK/ElAl4G2Fz4viKeov6x/j2ls16DQZziPZ3cEmZBhJJh
         dbYbXpieJivU+717GA5SEWtSoSr77udB1cSNZvDhY1/iJJ0uMaolwWCLapXRrWWjz92u
         RWqHZRKGwvIfInI0Mphasa6bEgr7Lt0C7QTlPpmsLlm6X7G2n747MaI0XoKgle7CtlqL
         gOHAKp7m/9e5vsU71ZpSeFIspCR/s9/AZPIZ+OHOkuTqdlLuxNkLLfeZs6jNi9RYXI5n
         gHqA==
X-Gm-Message-State: AJaThX5hJ0pwtNl51Uh4qT+xcJASRo95gpik6dN8Kwa2XtqZv4un76BM
        mnQT5u7rrpDq7qHAOE5zdCI=
X-Google-Smtp-Source: AGs4zMZayBP1JF0i9EPbq7zVISEZ+f0qihpMp6z4ExU1NFsY79CkLjmm5m3Fa0xjqKDklPZfuGemww==
X-Received: by 10.55.154.85 with SMTP id c82mr3571619qke.327.1510851716437;
        Thu, 16 Nov 2017 09:01:56 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id p39sm1113029qta.78.2017.11.16.09.01.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 09:01:54 -0800 (PST)
Date:   Thu, 16 Nov 2017 12:01:52 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch doc: remove --set-upstream from synopsis
Message-ID: <20171116170152.GD3693@zaya.teonanacatl.net>
References: <20171116074643.19614-1-tmz@pobox.com>
 <CAN0heSpUm=U7aGVtRoUoGZCvNsOZ04wLqTOx8kMvZEa8GQUiLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpUm=U7aGVtRoUoGZCvNsOZ04wLqTOx8kMvZEa8GQUiLQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren wrote:
> On 16 November 2017 at 08:46, Todd Zullinger <tmz@pobox.com> wrote:
>> I noticed that --set-upstream was still in the synopsis for git branch.  I 
>> don't think it was left there intentionally.  I looked through the thread where 
>> support for the option was removed and didn't notice any comments suggesting 
>> otherwise[1].  With luck, I didn't miss the obvious while reading the thread.
>>
>> [1] https://public-inbox.org/git/20170807143938.5127-1-kaarticsivaraam91196@gmail.com/
>
> Actually, the first version of the series did remove it from the 
> synopsis [2]. That hunk was later dropped. Kaartic mentioned it [3] and 
> I thought out loud about it [4].

Oh my.  I'll have to hope no prospective employer finds this thread if 
I ever apply for a job as a proofreader.  ;)

Thanks for pointing out the relevant parts of the discussion, of 
course.

> I get the same initial thought now as then: It's a bit odd that we 
> pique the interest of the reader, but that when they try it out or 
> read up on it, we say "nope, this is not what you are looking for".

Indeed.  If we do want to keep the option in the synopsis, it should 
at least be moved to the same entry as --set-upstream-to, since that's 
it's effect now.

I don't think we should do that, but it would at least be accurate 
there.  Using it like it's described in the synopsis now is an error.

# git branch [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]

$ git branch --set-upstream mybranch master
fatal: the '--set-upstream' option is no longer supported. Please use 
'--track' or '--set-upstream-to' instead.

$ git branch --track mybranch master
Branch 'mybranch' set up to track local branch 'master'.

Kaartic Sivaraam wrote:
> I didn't remove it as there wasn't a "strong" consensus that this 
> should go off the "Synopsis" at that time. If removing it from the 
> synopsis seems to be better than leaving it, then lets do it.

Indeed, I'm sorry I missed that you'd removed it earlier in the patch 
history.  I'm obviously in favor of removing it now. :)

> Further, I think we should make this some kind of "guideline" in 
> this project to remain consistent. Something like,
>
>    * If you deprecate an option of a command to an extent that it's not 
>      usable at all, remove that option from the "Synopsis" of the 
>      concerned "Documentation".
>
> possibly to "Documentation/SubmittingPatches" or at least keep this as 
> some form of undocumented guideline if this might make 
> "Documentation/SubmittingPatches" unnecessarily clumsy. I dunno, was 
> just thinking out loud.

Yeah, it's probably tough to cover the many varied situations like 
this to SubmittingPatches.  In general, I would agree with the above 
guideline.  It's best to not steer people toward options which we 
would prefer them not to use.

Where that line falls with regard to documentation can certainly vary 
a lot.  It's often hard for long-time git users to step into the shoes 
of new users who may be reading the documentation for the first time. 
The right balance between enough information and not too much is 
always tricky.

[Incidentally, I ran into this because I had made some changes on a 
master branch of a repository.  Later, I wanted to move them to a 
topic branch so I could do some other comparisons between master and 
upstream.  I wondered if I could setup the remote tracking using git 
branch on the new branch in one step.  The recent branch --copy option 
does this perfectly (and easily).]

Thanks to both of you.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Whenever I feel blue, I start breathing again.

