Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682361F404
	for <e@80x24.org>; Sun, 25 Mar 2018 04:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeCYEN6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 00:13:58 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37640 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeCYEN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 00:13:58 -0400
Received: by mail-qt0-f179.google.com with SMTP id w12so8898687qti.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o3RR6ZCK6HS0GDVcSBU0cy07jxr5b/TqGKRpgQn7HLI=;
        b=gDDSEIrdJas6u2nCnczXxX+gPkSvNzb1euJtjff5K7lGS28FFTSOZMmw4h/Khy6lOM
         p9sED47mvGUzx7A+XXPYQsef8BIMWjLdttaNfwqdgiZbrMk0vfFK9V4+wNW6R6EQ8u20
         q4iXj6BrKCSb9sAzy3IWKI+n8mIXJMV9eZm8qfJ9TGPYg1IDkGaf1zFHJO5pGXYvfi+l
         iL9Tv8qO1DIIfA6uWXebTJHMCMvyN0U8anPf+SUpkwq6kKCK/Ic5i6RPJ/6YuH6T1nRS
         O6UAinO+k+K7x6SbluyyZvEAvq/EWwKoxb3Z2jo+E6qNDqId25YDNkXAH8fqLRhHjekU
         5b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o3RR6ZCK6HS0GDVcSBU0cy07jxr5b/TqGKRpgQn7HLI=;
        b=LLkdh5RL7T6qpZpHnNw+xlNY2n3zp71PzBzbaLmhtwiJ+m85+KTuQ8FdRVAuDdMj6A
         jLj9ySegVaf0ovi3HPk62HhZAg+6XqgihS8m+cGkYhXkMbl8phO7fbeJSJvqueYkHGV1
         fsE5Qh8dCjH+6NlWXcbtngNMPTTWP6S+3uOCnv8wbVbF19n1A01uXHJX1kHV1gnJ4fPF
         B5AzZ20iwLePnOQDNQIqlRkANgqVnomIUc8gvg2iBB8RUjdUmcscV7c5zb4380eY9izv
         s/yjBvnlFudQXES+kjuDgdKS99KmeE0g+Rx8PjkwYEEiRuuGif9sXxlixHJkXr5JaCdA
         O8fA==
X-Gm-Message-State: AElRT7FAkslBfqseumyctUFTHjrBuUiltXT+eZJn7QS374UvzntViXnj
        jc547dDWteKrEN30r4ccIRL6JZs4P59/VYiX+HQ=
X-Google-Smtp-Source: AG47ELua7xidwZrIHX5sQZH/m02TzmyRGN4zUlce0MS8SowuvzSg30nNxCzq9l1SDJPoR2BEqyW/q3HYIN5SOoSAskk=
X-Received: by 10.237.49.195 with SMTP id 61mr49082265qth.77.1521951237395;
 Sat, 24 Mar 2018 21:13:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 21:13:56 -0700 (PDT)
In-Reply-To: <20180325041056.GA22321@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com> <20180325041056.GA22321@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 00:13:56 -0400
X-Google-Sender-Auth: Hwr6v6_qkQQ-xa2dPMJIYaybiXA
Message-ID: <CAPig+cSSy2AFc22EOFWLOE1MszHdeA3ijDPbFVNGK70AmHUg_w@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10 AM, Jeff King <peff@peff.net> wrote:
> So:
>
>   git branch -l
>
> _looks_ like it works, but only because list mode is the default. If you
> did:
>
>   git branch -l foo
>
> you would find that it does list "foo" at all, but instead creates a new
> branch "foo" with reflog.

s/does/doesn't/
