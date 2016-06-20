Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421F520179
	for <e@80x24.org>; Mon, 20 Jun 2016 08:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbcFTI3p (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 04:29:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35774 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcFTI3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2016 04:29:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so6979270wme.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 01:28:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0hOUnWAGKaWEjFRoqJr/VobVjqm5Hwd6XdeN1JoMcEU=;
        b=AuvESgPPj1evk6gC6mlFtIYBn2JyEX1r+YJX2wh4cLEVBcgY17arkI/O3kDqvXovIn
         MyP3nzo11kHLjZFI1Wue1BqPjEsFtOzN8BkvPRTrGbrOgw50zB3BFMxiRmZlHJp3Bnnf
         Dh+qS0Ba6RRxp2fOjRx3OR/vyCzJNWPgB+be4lPPocPTAA210dPbzhpF45OBTh//Dxv3
         Fzsciq0ii5/V0J9M+KTEdssmrHI8cCE3doNzEjRJy9xAp6vuG4QnpzDOGjiHFszcHY9O
         IItAcRmd8LGqsiQEr0VB04lm22Qmzcia4QqiayUrd9C8CTdvMtsKxjh5it1lqL/2nHLd
         Dopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0hOUnWAGKaWEjFRoqJr/VobVjqm5Hwd6XdeN1JoMcEU=;
        b=U6FhN15nEESSVxvRiEAL8Vlb7kKCmf/dGjfdD5kDu/Ksg23gSi1gVs6r+jcuh/CcEh
         3O1USozC7+KPPWEoQlyaqF+LviTGCg/YipdI/LQsX6oEmd60eCInVW/+bL+nQ0VYWplL
         Z81LtOfGA4KaPqf3V1poArVgZyC+Yo8/OKvlddGbusIYfS7q4pgIfJTJZcn+gVJreokF
         ny3fMp7OIZl5iLXeQ9+fTfr6Ai/9RZSsGT4RN8sUF44cptVucjGTQvgSWpf+oS2tclmb
         gCL20LFtHAec2Ge/kNiw241YaQ/Sv3kNtZwYW12v99omfeZFVgMp4QBQm1DRMcsuj2LB
         PqTg==
X-Gm-Message-State: ALyK8tJY2WTGciTLrBpSKow+R1skSy9SK5l1DyCQAKGBcEmrmkpOZE4EYZPXgj7EUTyEuw==
X-Received: by 10.194.47.71 with SMTP id b7mr13158298wjn.107.1466409452828;
        Mon, 20 Jun 2016 00:57:32 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id t190sm7075723wmt.24.2016.06.20.00.57.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 00:57:32 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 20 Jun 2016 09:57:30 +0200
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com> <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com> <576650E7.70107@alum.mit.edu> <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com> <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 20 Jun 2016, at 01:51, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> According to [1], something in that test seems to have been trying to run
>>> 
>>>    git update-ref -d git-p4-tmp/6
>>> 
>>> Similarly in the other failed test.
>> 
>> Ah, OK, that would try mucking with .git/git-p4-tmp/6 but that is
>> not a place to have a ref.  It will not participate in reachability
>> analysis and will end up losing the referents.
>> 
>> Perhaps placing it under refs/git-p4-tmp would fix it (both in
>> git-p4 and in tests)?
> 
> Oh, another thing.  If these refs are meant to be transient, they
> are likely to be per worktree, if "git worktree" managed multiple
> worktrees that share the same set of branches and tags are in use.
> 
> I recall we carved out one hierarchy under refs/ as "not shared
> across worktrees" (was that refs/worktree/ hierarchy?  I didn't
> check but please do so when the patch actually is written), and
> that hierarchy is the appropriate thing to use for this, I think.

Thanks for the hint. It looks like as if the "per worktree" decision
is made in "ref.c:466" "is_per_worktree_ref":
https://github.com/git/git/blob/3dc84b0c19932ec9947ca4936b6bfd6421ccb1b4/refs.c#L466-L470

In ce414b3 "refs/bisect" was added to a list of prefixes that are
per worktree. I could easily add "refs/git-p4-tmp" to this list but
I don't think that would be a good solution. I would prefer to go with 
your suggestion and add "refs/worktree" to the prefix list and then use
"refs/worktree/git-p4-tmp".

Later on we could move "refs/bisect" to "refs/worktree/bisect" and
simplify the "is_per_worktree_ref" code, too.

Thoughts?

Thanks,
Lars