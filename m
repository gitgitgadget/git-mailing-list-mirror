Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2201E1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 19:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbdLZToN (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 14:44:13 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:46338 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZToN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 14:44:13 -0500
Received: by mail-it0-f53.google.com with SMTP id t1so23176046ite.5
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/BhQUDnIwpMf+hCH0SLipqRzt2pZJVNEbQlirPlryJs=;
        b=fKbbjjVw3i5doKc1dPgYDiJqHtmihGV5MoGOenVxwHWfUR7jb1KIM/Gu009i+IlsbH
         Cy3gELZ7z8IKSmA24kZq1M8KHaS/DotZ5z4jarFHRmQQ27jZhJhs6zNOLg1PloTGUZcR
         CIwIjDkY/Zc2r1WxUqZb7UblrKz0GkZouDcBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/BhQUDnIwpMf+hCH0SLipqRzt2pZJVNEbQlirPlryJs=;
        b=AjGUGG4C70XbSKltn8YQJ2XYFZuG84yN0UW1ffUTcbxrCyDZirQxahIQnZ1GDUZcjh
         lshQ+18RB3jaQR+3e8qO4HBy0OoMtBVHvJ/cZlLMzOlCIbzZ6iPWicA7DHYuj3fle8bO
         tuEZ92AhtN553j460S3e+7YYZooPB0E5YfemR20YU6xjiE9ZEkeD0Ofhs1RzV4Xwbxfh
         XoosKzZ7jM1NHS8ICt2Q+heJ4D2Ax1oWq57jIqmgb4/E3zRi8dmOEPTfu/Baaw6Dyn6s
         vf3unl5+YvlmUhRnDIjFUQku9eYy9SEELkXnO2SxiXFnoljQIepVJXw1H0zLeRJzOBBw
         isGw==
X-Gm-Message-State: AKGB3mIcCm1TdDF70nuX9+wmQ3hOSoqtYIeL1EQLzjAUrLpY8hRpCOnY
        4eSzoL6fI37JQB9pNIZho4yQ4w==
X-Google-Smtp-Source: ACJfBotTkTJ1rNBDh1H1XkdVtLWSY83BXzjdFHWGkQM/ZDKGVshqOisWph4i9QJXcpAINQSIDnpowg==
X-Received: by 10.36.118.195 with SMTP id z186mr35266039itb.106.1514317452260;
        Tue, 26 Dec 2017 11:44:12 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:59aa:140c:4d30:a473])
        by smtp.gmail.com with ESMTPSA id t23sm9765698ite.36.2017.12.26.11.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 11:44:11 -0800 (PST)
Date:   Tue, 26 Dec 2017 12:44:09 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226194408.GA22855@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <87608xrt8o.fsf@evledraar.gmail.com>
 <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
 <87vagtqszf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vagtqszf.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 06:49:56PM +0100, Ævar Arnfjörð Bjarmason wrote:
> New headers should be added after existing headers, but other than
> that it won't choke on it. See 4b2bced559 when the encoding header was
> added, this also passes most tests:
> 
>     diff --git a/commit.c b/commit.c
>     index cab8d4455b..cd2bafbaa0 100644
>     --- a/commit.c
>     +++ b/commit.c
>     @@ -1565,6 +1565,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>             if (!encoding_is_utf8)
>                     strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
> 
>     +       strbuf_addf(&buffer, "replaces 0000000000000000000000000000000000000000\n");
>     +
>             while (extra) {
>                     add_extra_header(&buffer, extra);
>                     extra = extra->next;
> 
> Only "most" since of course this changes the sha1 of every commit git
> creates from what you get now.
> 
> > Even if core git code does not simply choke on it, I would like push and
> > pull to follow these pointers and transfer the history behind them. I
> > assumed that git would not do this today. I would also like gc to
> > preserve e8aa79baf6 as if it were referenced by a parent pointer so that
> > it doesn't purge it from the history.
> 
> It won't pay any attention to them if "replaces" is something entirely
> new, what I was pointing out in my earlier reply is that you can simply
> *also* create the parent pointers to these no-op merge commits that hide
> away the previous history the "replaces" headers will be referencing.
> 
> The reason to do that is 100% backwards compatibility, and and only
> needing to make minor UI changes to have this feature (to e.g. history
> walking), as opposed to needing to hack everything that now follows
> "parent" or constructs a commit graph.

Thank you for clarifying this. I have learned something.

> Sure, it could be opt in, be a new format etc. But you haven't
> explained why you think a feature like this would need to rely on an
> entirely new parent structure and side-DAG, as opposed to just the
> more minor changes I'm pointing out above, and which I think will give
> you what you need from a UX level.

I have not wrapped my head around it enough to convince myself that it
gives what I'm after. Let me spend a little more time with it to get a
feel for it.

Carl
