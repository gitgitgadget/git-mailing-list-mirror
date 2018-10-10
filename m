Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585711F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 02:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeJJKIF (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 06:08:05 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35278 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeJJKIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 06:08:05 -0400
Received: by mail-wr1-f42.google.com with SMTP id w5-v6so3913715wrt.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b4Myj/Lsbdsx8nBEmMx04orYHdrRayZ+wSsiRRQEZGE=;
        b=ilMvzwKA7QVvNOgAR0LXOefLMteZEKvuw9wiMVp4T2aCz9BZTwjPLDeowq58xnGE3U
         76rx9U2kn5y7GfaYnxgd4non2W+X4Xf00TbmFMQJF4JvVZqjrtd/0xl3lqIQ3JY4h3At
         MKgcu2Qxk/WrIGm3+nBJl6XohMt9wUTVgMFc4Oo1pJSRUufsmz9wnLjp91tlG9M3f9IB
         FBTP5AebKVa27XpSs2u0BtWgXiNm7QKg0NIoXAlzBwr4b9PFi1LoFKDkRGSM9q16l1nO
         t60TSVPbjb+q4XaVwWL/hyo19dFJIG5uGYLd+BZ9o1D4K6d1gHPidtzGBo7nQ7s2zkfh
         z7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b4Myj/Lsbdsx8nBEmMx04orYHdrRayZ+wSsiRRQEZGE=;
        b=GRfx8Uw6FNcrK77FMA8cDXFt8WA3Vw+zNULiZwectzMmtbleiGYGu8xR1lKVArNvxJ
         jT9e7QrVaiW/UrUIAedsiTEwbBAEO4glZTgQl/r+iYDecH0stZ4GT+ujTjL45szB6CNJ
         CoTAm7uB3BfWgCWOSLbeg4vclhC54KBs1u7UFhmmIxUcGz4ibIlYipkLbMrrCgW/PaqX
         ib/CvrN39n/xNXZlmrdD85XPYA89xVk48kgRZslJdL7wPSQbKxFbTw4a1LYYZgtWDmRP
         FLoHk6B/2owLijuvot2n74Z4UE64z9PGe3EkdDg/UUYkZxzqgqRpv3X4zLjnmfyusW5A
         d0gA==
X-Gm-Message-State: ABuFfoiWdqZuJYYq84U3KdqlsJtTIXFGtupv2y4tVTfK6+biMv8cixn1
        a5D6s1ipJT5NXP23fiUFstA=
X-Google-Smtp-Source: ACcGV63a1Yr/PYcfTY8m9TCpNATcTCSZ64Mrht9EuVcq6HBZu+nSmXNSyXw3ozwFcCiDLRnB4cgyug==
X-Received: by 2002:a5d:53c3:: with SMTP id a3-v6mr21881856wrw.191.1539139686671;
        Tue, 09 Oct 2018 19:48:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j203-v6sm23954965wmd.46.2018.10.09.19.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 19:48:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/git-branch: Document the --current option
References: <20181009183114.16477-1-daniels@umanovskis.se>
        <20181009183114.16477-2-daniels@umanovskis.se>
Date:   Wed, 10 Oct 2018 11:48:05 +0900
In-Reply-To: <20181009183114.16477-2-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Tue, 9 Oct 2018 20:31:14 +0200")
Message-ID: <xmqqh8hums9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> +--current::
> +	Print the name of the current branch. In detached HEAD state,
> +	or if otherwise impossible to resolve the branch name, print
> +	"HEAD".

Where does "if otherwise impossible to resolve" come from?  In the
code in [PATCH 1/2], we see this bit

+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	char *shortname = shorten_unambiguous_ref(refname, 0);

and the output phase would become puts(shortname).

 * Under what condition resolve_ref_unsafe(HEAD) fail to resolve,
   and when that happens what does it return?  "HEAD"?  Can the
   caller tell the case in which .git/HEAD is a symref that points
   at refs/heads/HEAD (i.e. we are on a branch whose name is "HEAD")
   and the case in which .git/HEAD fails to resolve and you get
   "HEAD" back?

 * Or does the function return NULL in "otherwise impossible" case?
   Does shorten_unambiguous_ref() deal with refname==NULL
   gracefully?

 * Under what condition shorten_unambiguous_ref() fail to compute
   the branch name discovered by resolve_ref_unsafe()?

Also, I do not think the implementation is correct.  When you are on
the 'frotz' branch, and if you happen to have a tag whose name also
is 'frotz', then

 - Your .git/HEAD points at refs/heads/frotz, and refs/heads/frotz
   is what resolve_ref_unsafe() gives you.

 - You have refs/heads/frotz and refs/tags/frotz in the repository.
   Asking to shorten the ref refs/heads/frotz unambiguously will
   *not* yield 'frotz'.  It will give you something like 'heads/frotz'
   to avoid getting it confused with tags/frotz

 - Still "git branch --list" would show 'frotz' in such a case, and
   your "--current" would definitely want to match the behaviour.

I think the correct implementation should be more like:

 - Ask resolve-ref-unsafe about HEAD; if it is not a symbolic ref,
   then we are on a detached HEAD.  Silently exit with status 0.

 - If it is a symbolic ref, see if the target of the symblic ref
   (i.e. returned refname) begins with "refs/heads/".  Otherwise, we
   have a repository corruption.  Diagnose it as an error and die().

 - Otherwise, strip that leading "refs/heads/"; the remainder is the
   name of the "current branch".

I already said "current" by itself is an unacceptable name for this
option, so I won't be repeating myself.

