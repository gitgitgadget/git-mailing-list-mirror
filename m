Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391D71FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 01:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbdBHB4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 20:56:22 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35804 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbdBHB4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 20:56:19 -0500
Received: by mail-pg0-f45.google.com with SMTP id 194so43786911pgd.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 17:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m10KWQbKZsHDKTpi3JSeDrK1PqLKggQH7mZTij7B/1I=;
        b=vHqY1Hvha3Hw2SFCJhsDXzXqvFui4dy+3X4jtJLZTk549q0cF8bjZqm86YyF16n0qu
         48hIBjzvzqp2J+6ThydYbUJITobtQK+0XrpWZODeIkXjLdt4uVudDR5QOuH9uxefXgrj
         svCH84E1dzloSQsEko9jKoigeVN0d37NHY3fD7TQoZlSPZ5xC8QHJ9Bc8Rl1S3HNM/kK
         Y9qH6wsF88Sn20XOVQPdWQoDxZ5fwbMwtJwGbxew1o++z+SJQKtH/ihYZUfyPwpG8Pma
         IEpz6dMdbrd7fMuin+sKargC2rNIUodLAXeU9FUq6dLvpC139/IO7hV3D7hamBMdCiUu
         9hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=m10KWQbKZsHDKTpi3JSeDrK1PqLKggQH7mZTij7B/1I=;
        b=GZEdgbnv3MMrOBAORbg73s6sV3lbtYtjnJSrz1jRQZcq86VzCoL7/849GXX/o4wXAS
         oe0uytEegQFyn8+nrdVxkA9dFlXYftKB1v5dFd085IQHWfQbaFLoAwytRKxcVQqW2N9R
         NzJk2qmLZs1U+Gc1uwfEWXqbSF/j83zsgeO6HAfgUHOtX5I8QPkk3yA2Nmv3MBWcNWae
         VEwY0x1GRBRu1pSAEUirCMoZ3mJaTz8TdpCYoD9/EH/1T6ZA/DESg/1/LnODT8o1z4bZ
         ZTsslhylIT2my8dXuGk3ZXPQQ/XQssWktorVMBqQ1A5MPW9lWhvvBljmrTqyfMeAYrF3
         HyYQ==
X-Gm-Message-State: AIkVDXK66Ln7cDNvV5cFRieCVRuuYqPcIjsW8apVhMnymHCMFdh3GZEQJOtq+mo15wjEag==
X-Received: by 10.84.217.202 with SMTP id d10mr30164668plj.53.1486518507780;
        Tue, 07 Feb 2017 17:48:27 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id e13sm359614pgn.38.2017.02.07.17.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 17:48:27 -0800 (PST)
Date:   Tue, 7 Feb 2017 17:48:26 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
In-Reply-To: <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702071739060.17609@i7.lan>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com> <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, 7 Feb 2017, Linus Torvalds wrote:
> 
> [ Clarification from original message, since Junio asked: I didn't
>   actually want the semantics of '.' at all, since in a subdirectory it
>   limits to the current subdirectory. So I'd suggest that in the absence
>   of any positive pattern, there is simply no filtering at all, so
>   whenever I say '.' as a pattern, I really meant ":(top)." which is
>   even more of a cumbersom syntax that the current model really
>   encourages. Crazy. Since I tend to always work in the top directory,
>   the two are the same for me ]

So here's an RFC patch, and I'm quoting the above part of my thinking 
because it's what the patch does, but it turns out that it's probably not 
what we want, and I suspect the "." behavior (as opposed to "no filtering 
at all") is actually better.

Now _I_ don't much care, since I only work from the top level, but without 
the "." behavior, you get into an odd situation that the negative match 
will be relative to the current directory, but then the positive matches 
will be everywhere else. 

Obviously, a negative match that has "top" set would change that logic. So 
this patch is purely a request for further discussion.

When I wrote the patch, I actually also removed the now stale entries from 
the 'po' files, but I'm not including that part here because it just 
distracts from the meat of it all. So this diff was actually generated 
with the new syntax:

	git diff -p --stat -- :^po/

and the only thing even remotely subtle here is that it changes our ctype 
array to make '^' be both a regex and a pathspec magic character.

Everything else should be pretty darn obvious.

The code *could* just track all the 'relative to top or not' bits in the 
exclusion pattern, and then use whatever top-ness the exclusion patterns 
have (and maybe fall back to the old warning if it had a mixture of 
exclusionary patterns). I'll happily change it to act that way if people 
think that makes sense.

Comments?

                Linus

---
 ctype.c    |  3 ++-
 pathspec.c | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ctype.c b/ctype.c
index fc0225ceb..250e2ce15 100644
--- a/ctype.c
+++ b/ctype.c
@@ -14,6 +14,7 @@ enum {
 	P = GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
 	X = GIT_CNTRL,
 	U = GIT_PUNCT,
+	Y = GIT_REGEX_SPECIAL | GIT_PATHSPEC_MAGIC,
 	Z = GIT_CNTRL | GIT_SPACE
 };
 
@@ -23,7 +24,7 @@ const unsigned char sane_ctype[256] = {
 	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, U, R, P,		/*  80.. 95 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, U, Y, P,		/*  80.. 95 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
 	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
diff --git a/pathspec.c b/pathspec.c
index 7ababb315..ef59d080d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -72,6 +72,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_GLOB,    '\0', "glob" },
 	{ PATHSPEC_ICASE,   '\0', "icase" },
 	{ PATHSPEC_EXCLUDE,  '!', "exclude" },
+	{ PATHSPEC_EXCLUDE,  '^', "exclude" },
 };
 
 static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
@@ -516,7 +517,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	pathspec->nr = n;
-	ALLOC_ARRAY(pathspec->items, n);
+	ALLOC_ARRAY(pathspec->items, n+1);
 	item = pathspec->items;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
@@ -540,10 +541,14 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |= item[i].magic;
 	}
 
-	if (nr_exclude == n)
-		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
-		      "Perhaps you forgot to add either ':/' or '.' ?"));
-
+	/*
+	 * If everything is an exclude pattern, add one positive pattern
+	 * that matches everyting. We allocated an extra one for this.
+	 */
+	if (nr_exclude == n) {
+		init_pathspec_item(item + n, 0, "", 0, "");
+		pathspec->nr++;
+	}
 
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
