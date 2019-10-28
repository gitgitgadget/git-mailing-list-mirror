Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FF11F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 11:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfJ1LZh (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:25:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52227 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfJ1LZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:25:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so9030625wmg.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IhSeT8bDJ5vPMw2tYFIgP+IlnE7qvxnoQMRk+saC+bk=;
        b=Tyv9CYscyfINWr6VC9ju820YGRFjnv+49uFp2UJqZc7t/2ERMyP3VGvMW4ID1NxDY8
         1gTKGWxmQj3pakh2Kbcn6dANWmxNiKcKpnbwIsS//8z2L/cT65bmWZz5VS51flHHLKNO
         jMjeN+7qN1CanfH1YMpqO+eyStcva3wLV71q8hfDWduz5sRXH/yxXqsQmGFgQ6V09EWd
         k/NfheDNxuBXgSjHe5FfSuaIPJ2RZSlKgdWc0/lIklRA7dKs3hhly9jpoOfX9mACXbEe
         EaM4JVWIFb16re7WgDw3Ly9uMK5iR3Kx+DSOd3g3rRtNNsjhBRdim/h6wx+BzDGOKxAC
         awXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IhSeT8bDJ5vPMw2tYFIgP+IlnE7qvxnoQMRk+saC+bk=;
        b=WzGH9YKHRA81YgTCtmDcKBWGg7iB6B0I1+TjkowuAaDIG2SM8o8yPU7lDjacgObhWR
         t/z9HN8crxuSNNhHMxIkr12JNAHLJu+Ub7NEgByXGlD+a5slMP445FF1WAgOxGLg+2Tz
         VqDmiAwsL1/FjPh+jWuMAl1rdbTQRUR5pfNIb01BVCIvffKk73CJo+QyCkGio8MrDDqT
         1hB/8JDJr7hDG5pf2+PiFxmBBL/kBAl/jJ8dbNZi45eMTQ48VxLBFshlqrMgPflSXx08
         Zq+C0CMA2I3Kgr20sryEWoM0LuAd9975ukV+AOcLFvbU1LefoDwETByWqfa2Znds1r02
         gFFQ==
X-Gm-Message-State: APjAAAVLqZnkC602DOtJdWHrjdGAWrOu14xpI+i10XEMGZOqh93yyhYg
        WK6g6iK6VpCCS7ZAwAyLGjY=
X-Google-Smtp-Source: APXvYqw4owFW1yHhWGY7fcOo+WtOe5ViexGS9mQZdoEyG7miX0fxkc/7IUJ1E2kXGOFY5eZeMrM68Q==
X-Received: by 2002:a1c:20c9:: with SMTP id g192mr14044961wmg.74.1572261933659;
        Mon, 28 Oct 2019 04:25:33 -0700 (PDT)
Received: from szeder.dev (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id b1sm11387489wru.83.2019.10.28.04.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:25:32 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:25:30 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
Message-ID: <20191028112530.GQ4348@szeder.dev>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-2-emilyshaffer@google.com>
 <20191026010857.GA39574@google.com>
 <20191026080057.GP4348@szeder.dev>
 <xmqqmudlbr1s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmudlbr1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 10:24:31AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > See that last "no link: git-bisect" line?  That's what happened to
> > catch my eyes when Derrick forgot to add his new 'sparse-checkout'
> > builtin to 'command-list.txt'.  I still haven't looked up what that
> > 'no link' is supposed to mean, but if it were an error, then we would
> 
> Build procedure for the Documentation uses ../command-list.txt as
> its input to produce cmds-<class>.txt files, that are included in
> git.txt (hence resulting git.1 and git.html).  While it works, it
> tries to make sure that a command that has its own documentation
> page at Documentation/git-<command>.txt is listed; otherwise we have
> a page for <command> to which there is no link from git.{1,html}.

Oh, then it doesn't quite do what I thought it does.

> I think "make check-builtins" might also want to sanity check
> command-list.txt.

I haven't noticed that we have something like that.  FWIW, our
documentation CI job runs it already.

And indeed it can be easily extended to check 'command-list.txt' as
well, but then it will find some other builtins not included in
'command-list.txt', namely:

  bisect--helper env--helper fsck-objects init-db merge-ours
  merge-recursive merge-subtree remote-ext remote-fd submodule--helper

I think it makes sense not to include the '*--helper' commands, or
'fsck-objects' and 'init-db', but I'm not sure about the others.

OTOH, it won't help if we add a new git-foo script and forgot to
include it in 'command-list.txt'.

