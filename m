Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D9520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 08:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLIih (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 03:38:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55666 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeLLIih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 03:38:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4791612wmc.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 00:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hjPu2Fy2dT/5LWlam7Dx+hiXoSM6NucG3S2yEe06n70=;
        b=neuoyZdArk6uPZmP4bQx1aAmb4sWVSQOOl9PdM0s/ccMHTWaTaKqgxH2S/knhfYON8
         89HWlObltSF4HtDO21JQLJNVP7Cy/Tqe/M07z/5twYT5EwbSpk7wOrmqUoykuSwv0j41
         hrswOZD0h74ZOyPYItswvsnpDcu5us7xq4Qn8SVTvIVPDzz88YL1a/SE6GB7AFtPmTuF
         YcUjj6zZK/QamDEkOJuJhXRrqdgef48kHe/kechs9HgwzoLN7QH3mwRtJxBtAEJr7uwU
         PMsHyzkqUKPSLWoE7DQPYogO02LWPRghW3Lbm7HdAi+C5zRLdOTIFEv3xpPxfuXkt4eE
         aV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hjPu2Fy2dT/5LWlam7Dx+hiXoSM6NucG3S2yEe06n70=;
        b=OHQhkQNiHA05O9HaZry1hGI/ZFoq/IOX5kKS9U6v6xruvh4QEh2Hg1mKmoftUuDMxQ
         LcXJlkCZotteynWT9/H0CeMg81r3oZV8CCyrDeLlXf8a8ldgGNCeTRRfmnP1EUgYRECe
         nScWFPyB3WlhHX89/svQyyF03LZP+d0itkey7HhsxqTPnfC13X/cA1uUPH9SnEvz0wRC
         fy3ZDB30vlfqNa964lKP3eCWH9nUygf461EXQXwvj+H1JSE4z0WApWpT8pOqcnC+kAwm
         mQDtYHHs2KdGbx77NgfTFK8C7ETGZlfLOC/4h71d5vUHVKvuAx+iL3jQAtEis/sD9gBC
         +73Q==
X-Gm-Message-State: AA+aEWZy2zV8FiuCofhwDtrzyP8VlGzQPU2hMFOwfhzi3c7oUZzhjOqW
        DVpGDsXq2BsechF5BiNcutE=
X-Google-Smtp-Source: AFSGD/XocCVRAMaIf8JwWZH9qdEsa9OnjM3U8sMlg21nTrC3zbdWDsUeUx6woEdq5561tm1TcUUmtA==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr5144937wme.28.1544603915495;
        Wed, 12 Dec 2018 00:38:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a1sm11338968wrw.76.2018.12.12.00.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 00:38:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] .gitattributes: ensure t/oid-info/* has eol=lf
References: <pull.98.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Dec 2018 17:38:34 +0900
In-Reply-To: <pull.98.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 11 Dec 2018 12:35:45 -0800 (PST)")
Message-ID: <xmqqy38vi1h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The verbose output included these values. Note how '\r' appears in the
> variable values.
> ...
> ++ read tag rest

Interesting.  "read" does not realize that it is reading from a text
file and do whatever appropriate for the platform (i.e. treat CRLF
as the end-of-line)?

> Derrick Stolee (1):
>   .gitattributes: ensure t/oid-info/* has eol=lf
>
>  .gitattributes | 1 +
>  1 file changed, 1 insertion(+)

> base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7

Sounds good.  The base is 2.20; the problematic topic was designed
to be mergeable to 2.19.x track, but I do not forsee us merging the
bc/hash-independent-tests topic to the maintenance track, so for
this particular fix, it should be OK to base the fix there.


