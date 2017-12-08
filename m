Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B3220C32
	for <e@80x24.org>; Fri,  8 Dec 2017 08:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdLHIKg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 03:10:36 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36590 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdLHIKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 03:10:35 -0500
Received: by mail-qt0-f193.google.com with SMTP id a16so24205932qtj.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bvmkx17l983DlRZLdqRL/B8suxz9CqK9BCh7qcuvZ4M=;
        b=Rk67VY7wRIjU5ICMBzrjrxn27mvmyqA0vXsFYDsudtVCCB5wGDOL+6ol+Hq0F8vIoo
         qa0nwvIKtSbiHqYR/s9lg+gu5Gi0MillbbiP4TlRl+62ihC8XQuHnWsoSKoXULcAzY3x
         LR+kzZM7LNfW537uVe0oOyEcX4uuhC9vB483KGECegggPpGvis/YFbt5yTmMa0xZwRun
         AdAUqwS66sJMC/tlEhVosJ55xgh0QjIa4INLijp+2XTQ93ys2XEQoh55Bu3hq6cbZkII
         VqmfQGnzQo0nQRog9BROZ86dFYDfvHoCspSqEHn7lX0P0Yylh6apWjR0Zmz8mhtnfIkS
         xEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bvmkx17l983DlRZLdqRL/B8suxz9CqK9BCh7qcuvZ4M=;
        b=jGau95f9I8xKXqK4ea0aZ7P/EWJcqp5EAuElxXTyAxT0Y2Whc8KfSPFQ9Wf3d0Mx+O
         kKPJ/3VkXW2LXMAicH9CN9AWry3vcLlJna80nZGnt4nZsMHyitFMCXeIk5f2aa6Kw1tH
         6Mbb/0cUY1n1RlZXNveg7DnyWgO6W5VWBGNeq4PbfSgsFd0ewYVUKFd4yt7mNXIIoxwU
         DoqwcHNClfN/NqppURzXKYg4mq2AmbmR26cPT9RS2dOQX8/65Lx7VkTp6WXNWApWDL7m
         G/ONxr0WjiOOD0qxZjhNokAuxNMsXuhqUkND++tx9RXSpUj6CShxKaV7vAuz+E33Un7T
         Rx+w==
X-Gm-Message-State: AKGB3mKHt37+oDEPJcksOnLMy+qbx/rBgmSqXZ55GsCZqkeQwDzhIWpC
        khR6ntCmNaYlV5SXuhoqndQkLgQmol07OReRBKY=
X-Google-Smtp-Source: AGs4zMZ7tzYuemOFgmWTNP92w0QOWOYRe5oagrZx3UPfj0pWTu5F33/sFBoWKaHzUQ1aBUClLIsSn2x1f0Y1cXEODxI=
X-Received: by 10.237.37.47 with SMTP id v44mr14908739qtc.55.1512720634811;
 Fri, 08 Dec 2017 00:10:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 00:10:34 -0800 (PST)
In-Reply-To: <20171208051636.GA24693@sigill.intra.peff.net>
References: <20171208051636.GA24693@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 03:10:34 -0500
X-Google-Sender-Auth: JSwZnxyTdYi0ltaXPDm6FYLlDnA
Message-ID: <CAPig+cTdFSZziq9Mi7HHa+UcG3V9AwvWy1EpFoCLfT_9Fi+eKQ@mail.gmail.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 12:16 AM, Jeff King <peff@peff.net> wrote:
> Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
> with ",", 2017-10-01) switched the syntax of the trailers
> placeholder, but forgot to update the documentation in
> pretty-formats.txt.
>
> There's need to mention the old syntax; it was never in a

I suppose you mean: s/need/no need/

> released version of Git.
>
> Signed-off-by: Jeff King <peff@peff.net>
