Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95011F428
	for <e@80x24.org>; Sat, 28 Apr 2018 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeD1P2R (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 11:28:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36467 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeD1P2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 11:28:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id o14-v6so1732122ybq.3
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7c7xvXJ1R3oob+8Lr+tXld3n8i1+T5cQeNBX3b/crl8=;
        b=G6i+4n2VubFh/sdruNwaHVPYuTwYTJ24g7ZssIT4vou0sSSH6FwX7wPeHxl1OCQ5PY
         OQGOrZg3WEclGSRLEuaelu8IsUhL9cwbdj9rY2/EWJfLCvH1001U9PQETNVi9nRZALyF
         sghE3b/h03c34NTcj/qozhzcY+w2bNj0DSxpcUYu3JlfvLxeGO1h+GzwkJ5LwKIvY+3I
         13xLcfYaPArOXqXPlew/eA+HWs+VgLOI7mO+qyg3FgB862ekz8jh6IF0fhDmjwDggiwd
         B8BCsKm/cE/2IhE1bfsFEFaY+bEzArbvqiw+cRVlJyEFtOOOOyWDTIi8OIwBstpMLxpT
         g2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7c7xvXJ1R3oob+8Lr+tXld3n8i1+T5cQeNBX3b/crl8=;
        b=T2eXzPWmORbULXF+q45DHHi86FrMDuBFglrgRRFA+ICfCRexFhG/vYcknm6qLpqHvG
         DEn5WghWFK2lwN/rr8QxyEGxHRFzrkerVqsm4fkYtIYCUX4j2N4N/Sd8isvYW5eEs/W1
         xglsmReWd9CyMBC+CXd3230ka2LcVr3AoWk6F1DCLxXsGAGiGfQMEcFPe2I05Y8njbBG
         CGvorkNX7kvgZx7s9mLOCuX7WMH7FHtTf6Isismu6mLmgdPOsQddpyTkroDkvvVX7STa
         8Gfb6m9Mbf/+WcedUYigNv4gKN76r9EvrxwrK3qRZYXqNh05gYVH4+gNOJbhb7e44KV/
         iP6w==
X-Gm-Message-State: ALQs6tCNTwScTWyFpaoxAqZoMKOkIAdhp4ZT5YT1IxMWw5QjYnbuhzY6
        vN4/TBa82YSXKvSjNWSQMR5XCNOS4NzF9SnHfotDULq7aZQ=
X-Google-Smtp-Source: AB8JxZr4Sw+2oTyCiehGlN/7+S6NSjG+EltuFev3oBBLkMY28RJrA69QWuCzRnt67MtagUUE5t1LZDrtk2Iq+50gPFo=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr3380085ybn.167.1524929295373;
 Sat, 28 Apr 2018 08:28:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 08:28:14
 -0700 (PDT)
In-Reply-To: <ad31aab8e735f7de813860cacb32abbc406f43d1.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <ad31aab8e735f7de813860cacb32abbc406f43d1.1524868165.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Apr 2018 08:28:14 -0700
Message-ID: <CAGZ79kZbdkNPngcuQe-VWMRCkaHpcGFBa+DGkhU-91FqyhPbrg@mail.gmail.com>
Subject: Re: [PATCH 1/6] sequencer: extract helper to update active_cache_tree
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Apr 27, 2018 at 3:30 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This patch extracts the code from is_index_unchanged() to initialize or
> update the index' cache tree (i.e. a tree object reflecting the current
> index' top-level tree).
>
> The new helper will be used in the upcoming code to support `git rebase
> -i --root` via the sequencer.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e2f83942843..90c8218aa9a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -562,9 +562,23 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>         return !clean;
>  }
>
> +static struct object_id *get_cache_tree_oid(void)
> +{
> +       if (!active_cache_tree)
> +               active_cache_tree = cache_tree();
> +
> +       if (!cache_tree_fully_valid(active_cache_tree))
> +               if (cache_tree_update(&the_index, 0)) {
> +                       error(_("unable to update cache tree"));
> +                       return NULL;
> +               }

This move is a verbatim move of the code below, except that
we need to add braces. For some reason I fantasize of using
the comma operator in C eventually (which we do not use in
our code base AFAICT), then we could leave out the braces
and have a

    return error(...), NULL;

Anyway, this patch is
Reviewed-by: Stefan Beller <sbeller@google.com>
