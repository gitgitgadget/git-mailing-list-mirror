Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69DDC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiKVSYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKVSYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:24:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3920F4E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:24:00 -0800 (PST)
Received: (qmail 18731 invoked by uid 109); 22 Nov 2022 18:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 18:23:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5440 invoked by uid 111); 22 Nov 2022 18:23:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 13:23:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 13:23:58 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
Message-ID: <Y30TvhkfBeUkoIVk@coredump.intra.peff.net>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
 <Y3vFpNbWswu/8gjb@coredump.intra.peff.net>
 <xmqq35abvpxm.fsf@gitster.g>
 <CAF5D8-uQ633azqUfCv0vyQzFUaQdDhOwzEc8GOGnFrgmh-c9pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF5D8-uQ633azqUfCv0vyQzFUaQdDhOwzEc8GOGnFrgmh-c9pQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 10:00:45PM +0900, Yoichi Nakayama wrote:

> > "M-x grep<RET>git jump --stdout diff<RET>" is what I would have
> > written on the second line instead of "Run grep (like this)...".
> 
> I think Junio's suggestion of  "M-x grep<RET>git jump --stdout diff<RET>"
> is concise and understandable to most Emacs users, so I'd like to adopt it.
> 
> Below are the details of what I thought:
> 
> By M-x grep<RET>, Emacs displays
>       Run grep (like this): grep --color=auto -nH --null -e
> where
> - "Run grep (like this): " is a prompt (like "$ " in bash).
> - "grep --color=auto -nH --null -e " is a part of search command (missing
>   keyword part). We can supply "keyword<RET>" to execute the search.
>   We can also remove the whole command and replace it with the command
>   like "git jump --stdout diff".

Ah, OK. I am happy with anything that emacs users will understand, and I
trust the two of you to come up with something there. :)

-Peff
