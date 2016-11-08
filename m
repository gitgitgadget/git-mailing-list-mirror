Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2CE2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 02:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbcKHC2j (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 21:28:39 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34310 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbcKHC2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 21:28:39 -0500
Received: by mail-yw0-f180.google.com with SMTP id t125so162487798ywc.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E8CY7ZszhbA6t5ov11LOubpfYXiL43Pq9tsYuXJLxjM=;
        b=ju8Rth5226gLx4hdk12/vxouE0RWVOEBS5/O/aowAkjqOQAD94QjKz71IxN5dqtYV7
         m1AwKO85ZXXnO4oVd1QPxlyNFekSRNZBtvhmN5b6oci1Npx6OHcJduriVjLawI8FH1fq
         MMWeJeRZBHPyKdPEsGkhKc0yBrwAuXHX46+BmNWWbYk48vhrmuIMYnj+mjUJLH+5gpry
         GDrRN0kB5U/sZvXveIVug+IdJptM9kvgOFzFozEmAE+2+KmbcELfEkNU//xJZ8do7l3w
         BSRz5xz5stv3bGkYaAtwdbJKHSiLwXpMxCGksD7fUI17nByc0E3uTJ8Jq8YeM1PTsZeQ
         Kdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E8CY7ZszhbA6t5ov11LOubpfYXiL43Pq9tsYuXJLxjM=;
        b=lgH68COTjVnExlV/szotF6o6SmMVbqSt+VkQe+DqmwprEr6vQdXioQ1lzsUs1AroEu
         c+En7rs6ZYLbrvB9l4Cg9IpFvK42ugACWqakuTgjqw0xPjy/uUpD5ccOHOsT1KH2/gpR
         RaTIs7fgC5HyuvJp6e/WXR5gBSQuijvrWXFFW1TsvBDBiIG0Zc70KiyI5TQhI/c3r4No
         ttWeGT0IM5n3pS18vYDRss0vEITDmnXsktJoin2dVjOFRHFyJK0q0JeBD9GeLFUORYIZ
         XN1Y7Nmy+/mWYP2D33SKwAlbJBMCjvGreF2aMBpoSjQwyFmXwHtaEXwNF6D2prO5cTBh
         S62w==
X-Gm-Message-State: ABUngvcwVC2M6uwi20bIrecS8/OI3Ox6PtSOJ15sf9IULBVr8wgJk4ChZaQdZyFirhvqc+q3NTHl2/5xI3eRfQ==
X-Received: by 10.129.102.132 with SMTP id a126mr8803550ywc.160.1478572118269;
 Mon, 07 Nov 2016 18:28:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 7 Nov 2016 18:28:17 -0800 (PST)
In-Reply-To: <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk> <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 7 Nov 2016 18:28:17 -0800
Message-ID: <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not
 to abbreviate
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 4:52 PM, Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
> +log.noAbbrevTags::
> +       Each value is a glob pattern, specifying tag nammes which
> +       should always be displayed in full, even when other tags may
> +       be omitted or abbreviated (for example, by linkgit:gitk[1]).
> +       Values starting with `^` specify tags which should be
> +       abbreviated.  The order is important: the last match, in the
> +       most-local configuration, wins.
> +

It seems weird that this description implies some sort of behavior
change in core git itself, but in fact is only used as a reference for
other tools that may or may not honor it. I guess the reasoning here
is to try to get other external tools that abbreviate tags to also
honor this? But it still seems pretty weird to have a documented
config that has no code in core git to honor it...

Thanks,
Jake
