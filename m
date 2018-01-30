Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FB81F576
	for <e@80x24.org>; Tue, 30 Jan 2018 10:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeA3KOB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 05:14:01 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:40076 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3KN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 05:13:59 -0500
Received: by mail-it0-f67.google.com with SMTP id 196so12782787iti.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HximeLp/NJEwy9sV9P768HuQ4eyNRCNowFxlMKC+2P8=;
        b=OXcjyrZWnL+8IY/tjCHmJ2SBMQ5a2jeYNlzdsO/Z35Q4CsyYQBSl1gFDWLGuorY9Ki
         X+xQo1JkQ5fGh68cncOMEJhX2Ba4fXr6kh3heyBqlsedNaDtkaQuxKZhWqD35Vc3UjVJ
         pA33UjqesdA6tmWpn+b8kDZa19ucmJSh4ht9hPqJqMsWqRO/pmoemMxYkEQraJCZO9qp
         QTY8tTfujUYVdWgB4QermQXERimdvey++Dz6u4tcXOI928AovTsaMVVXbdzrEUE46kYg
         EorEKHoRvg3Tms2LUcUCtt52uOzJj4l4DwBodSGL0LL0E3dh6sF4tKTOR+BeAvCI1zp6
         R5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HximeLp/NJEwy9sV9P768HuQ4eyNRCNowFxlMKC+2P8=;
        b=W+pIqZAQLGx9PP1J0a1dikB2J1JsL4HKh2q4A0t9u3Kk5Et02F4PwB5kAG6/ehyycG
         C9Ws9WRZU0fGRZVmffgofcVEQKjE9sDL9uRwX+TkPqwKknRgZg1iIdo241YxMl8tS2GL
         Y/astKIRRSyn/OWfi4FeKs+IaaSCxFX4+hfZRaPsHXj/NymTFma+x0eXZM/8yXl3t6a8
         V9AOUpRRUoJSZq3ecFqeOM7kcqlRw2P0hRnUOBEMAzpl/0jZ5KdU/hgbmSMf8hQ6F/f1
         nFL3aBz/HHtP+rHbNKmIH7kbK0XANSKwcemzc0lO51jDdKWi6dbc0554d9eJ23GH40LM
         Eteg==
X-Gm-Message-State: AKwxyteaAtKFqKO9P2AXxyK/cVKdxNvnjawha+x4IP34PvXrUDQr4vhC
        8EFdBynzYA2kiF2EqEKYCNCGlw==
X-Google-Smtp-Source: AH8x226HPJHZa6bgPNi3HsFg5jmfAep01lhNkJ+MXG7Oyq7GYp1CFezgjDLo/KA0w2DQVTtY3DdyUw==
X-Received: by 10.36.238.68 with SMTP id b65mr30582208iti.97.1517307239222;
        Tue, 30 Jan 2018 02:13:59 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id z62sm4687813ioe.49.2018.01.30.02.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 02:13:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 30 Jan 2018 17:13:52 +0700
Date:   Tue, 30 Jan 2018 17:13:52 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Jack F' <jack@bytes.nz>, git@vger.kernel.org
Subject: Re: Missing ? wildcard character in gitignore documentation
Message-ID: <20180130101351.GA761@ash>
References: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
 <000f01d39918$70009eb0$5001dc10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000f01d39918$70009eb0$5001dc10$@nexbridge.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 10:47:10AM -0500, Randall S. Becker wrote:
> The implication of support for ? is there through the following paragraph from the gitignore documentation:
> 
>     "Otherwise, Git treats the pattern as a shell glob suitable for
>     consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards
>     in the pattern will not match a / in the pathname. For example,
>     "Documentation/*.html" matches "Documentation/git.html" but not
>     "Documentation/ppc/ppc.html" or
>     "tools/perf/Documentation/perf.html"."
> 
> Of course you have to go read fnmatch(3), so it might be good for
> expand on this here :).

I agree. How about something like this?

-- 8< --
Subject: [PATCH] gitignore.txt: elaborate shell glob syntax

`fnmatch(3)` is a great mention if the intended audience is
programmers. For normal users it's probably better to spell out what
a shell glob is.

This paragraph is updated to roughly tell (or remind) what the main
wildcards are supposed to do. All the details are still hidden away
behind the `fnmatch(3)` wall because bringing the whole specification
here may be too much.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitignore.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 63260f0056..0f4b1360bd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -102,12 +102,11 @@ PATTERN FORMAT
    (relative to the toplevel of the work tree if not from a
    `.gitignore` file).
 
- - Otherwise, Git treats the pattern as a shell glob suitable
-   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
-   For example, "Documentation/{asterisk}.html" matches
-   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
-   or "tools/perf/Documentation/perf.html".
+ - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
+   matches anything except '/', '?' matches any one character except
+   '/' and '[]' matches one character in a selected range. See
+   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
+   description.
 
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
-- 
2.16.1.205.g271f633410

-- 8< --
