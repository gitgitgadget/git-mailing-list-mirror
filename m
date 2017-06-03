Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092512027C
	for <e@80x24.org>; Sat,  3 Jun 2017 00:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFCABM (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:01:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35953 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFCABL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:01:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so58363678pfg.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TiS3RTv+IDBiGFhvEltSpHOmwxz1kmdbc0rQxRy0kJs=;
        b=RdonvUj6siYD+zkPds58yBmkYi3NOQYce/Fy1RKz/OOdMfHe6kJdhqB2sR93CUwZ+S
         mfpLq+KpRZZktQJ1UoSGeUwfvx/nsdRIW3jGRSaTflnyVoAEx/K+pX4/yTUSQjCyZZ1E
         gK2eIcKleWKvJCJy3gc6B/EObPiFMUj9Oq2lmJYwDGzJx0qOCv6PMVk6p2CY0y/nHNKt
         2hoWFJrdDoqF/+Ix8x0+X1oqrKruVbaCdxE2fGcOtt4oVBdvWD0Tq2Jj2NwnXYTT+uqW
         oAUiK/vzQoj9fAJTCbKOoDy+EvSUdR7/jdbfkKJvVQ6bpAgGj/Sg/DMdHi5ESlfwf5y5
         81zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TiS3RTv+IDBiGFhvEltSpHOmwxz1kmdbc0rQxRy0kJs=;
        b=SLTrlc7A04RsAIplQQ0/2OG+xSDZ5COpAZ4jP5r1XYCZefJg4p/DsXOCHXJEviOTg9
         I54DGkc8drz7+lZAYYzbgRpjHD/mj2J85jhST6EkfxwD5mkxH6bbLlpvBjX3E1tvIYt/
         n1wDfJ8zi/SicObTjhNmBRsy/yVtobrH4m3jjYtst22pcjZdl+eH0i62p796/H0lcWzH
         FM07HhyeNCLmcn+clIv5zFpkbvnRGuEZoGMS1rRZqIVdfkGIez2ENAl69G567dszFPqc
         nMJQJYu622CJ+nMkskHQsZd1jH/lFQIC7m5a5v7z8kXJWwX+l2gnkM1siI+wpx18mKYH
         cdQQ==
X-Gm-Message-State: AODbwcBbNfnWmx3aQIQSll3Ht2g8H0IZ3hxQLHr4v8FAk4JOgwFBbcUa
        kWDEgg6gSNTOxA==
X-Received: by 10.84.217.200 with SMTP id d8mr2364906plj.270.1496448070691;
        Fri, 02 Jun 2017 17:01:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id g13sm5384254pgu.54.2017.06.02.17.01.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:01:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rene Pasing <rene@pasing.net>
Cc:     git@vger.kernel.org
Subject: Re: Wrong gitattributes documentation?
References: <e7734a23-12b2-8f62-ab5c-c856d59e3010@pasing.net>
Date:   Sat, 03 Jun 2017 09:01:09 +0900
In-Reply-To: <e7734a23-12b2-8f62-ab5c-c856d59e3010@pasing.net> (Rene Pasing's
        message of "Fri, 2 Jun 2017 19:12:36 +0200")
Message-ID: <xmqq8tlax7lm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rene Pasing <rene@pasing.net> writes:

> The problem is, the documentation[1] says: "The rules how the pattern
> matches paths are the same as in .gitignore files; see gitignore[5].",
> so when I have a pattern like '/images/', it should match on all
> files+folders under /images, even the directory itself, right?
>
> Or when
> I'd use '/images/*', it should match on all files+folders under
> /images, right?

My reading of "PATTERN FORMAT" section in "git help ignore" says it
shouldn't.

 - If the pattern does not contain a slash '/', Git treats it as
   a shell glob pattern and checks for a match against the
   pathname relative to the location of the `.gitignore` file
   (relative to the toplevel of the work tree if not from a
   `.gitignore` file).

 - Otherwise, Git treats the pattern as a shell glob suitable
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
   wildcards in the pattern will not match a / in the pathname.
   For example, "Documentation/{asterisk}.html" matches
   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
   or "tools/perf/Documentation/perf.html".

Your "/images/*" is the "Otherwise" case, isn't it?
