Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46A820248
	for <e@80x24.org>; Mon, 25 Feb 2019 11:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfBYLgG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 06:36:06 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43369 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBYLgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 06:36:06 -0500
Received: by mail-lf1-f48.google.com with SMTP id j1so6572637lfb.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c13fCtZgGg2wSBnoCUUAwmOxdnQtJGmQaAaHB9vbXdw=;
        b=s1d3IjpEpX6lJ5k2EobUROZOM7jGY+UkzTCod4ev4YC+hvZX1e2QDPMT3yTJk2mvw4
         ucynkr/ZXUvc203JdxQ8MZMwzOIuVP+08tVFxo5vRTqGLEg1MOHjXeb6WHRNl0tWp6dd
         b698q1j49qy8kbNikKMfkWpZ0aq7vhOPnt7hN5w0ZhE9DtM4+nKrJ4bINmeFwrBtsuWl
         1NxoVdBWVjQYQ2W9inmQW1Oue5PmCpJ12LNPywJnMab5ygsBtzs/lGFGoFKvb7TRUQiy
         mK9f5egThwfjqmrcfvyWR3kyq5Q0u1J99eOncCU0gGgtkkSkQi8jkig0deWrS0vUs/ta
         WAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c13fCtZgGg2wSBnoCUUAwmOxdnQtJGmQaAaHB9vbXdw=;
        b=WS1pNuHHXW6GFwVdiXB2rV9eIBqg3SW7oay5AxLl0LN1tIDvnqjiHsUmIilb2DLqpe
         j+kPYdXHjl77i3Ukz5nNQlPYB7ugeBVltDlygGEv0yKetrZxbr39/oA9Ec4ieDWgBGjY
         Homhtu6YtmK5fcuQ4KROtLOcFST7QldvS9bYMF4IiPUBnZl6N2PGqGC+p9V+9U9UE2nz
         3fSZpDCFzxgImnyuPCAmM5WXK+s8P0863DIVsATmnJN7zJJHl5e4IBwBVBpKBHMclj0N
         Ui+o+LkQdEJipBwk70glQQgOcdqxIuBjaVxtmi+z8hQdaI83lSOQC3/ylAz+Zx2dbUmL
         DOgA==
X-Gm-Message-State: AHQUAuYRgML5fvwIQfoVYWPGCSiJQVgnoapvpgBuc0lS9WEr3bZjiYbD
        13NUnwr5RnYGufzLZoYkDryZOPq9AvbK3WrkFe0=
X-Google-Smtp-Source: AHgI3IYOyJWvNrovvqlIcyIJIBfoGosDXksOAtF4lmx/iRMz+aRV5gDKoT53gFxCFm0WJvU3ZEJohmB2F+81Aaag0Us=
X-Received: by 2002:a19:384c:: with SMTP id d12mr9748678lfj.105.1551094563939;
 Mon, 25 Feb 2019 03:36:03 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <CAP8UFD1U+4ww8rC=TSjjH+Rt77P9w4YWA9s5yspVZ7GgPpx0pw@mail.gmail.com>
In-Reply-To: <CAP8UFD1U+4ww8rC=TSjjH+Rt77P9w4YWA9s5yspVZ7GgPpx0pw@mail.gmail.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Mon, 25 Feb 2019 17:05:06 +0530
Message-ID: <CAL7ArXqrV7qb29i6JvQdeUtLNX9A7WC0-deKMx-_6pQUpaqSJA@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Christian

On Mon, Feb 25, 2019 at 12:20 PM Christian Couder
<christian.couder@gmail.com> wrote:

> In addition to what Dscho (alias Johannes Schindelin) wrote, please
> just send one patch that replaces `test -d`, `test -d` and similar
> code in only one t/tXXXX-*.sh file. No need to do more than that.

I don't think I quite understood this. Were you asking for replacing
all `test -X` calls with `test_path_is_*` calls in only one tXXXX-*.sh
file or `test -d` calls with `test_path_is_dir` in all tXXXX-*.sh? As
of now, I've changed almost all `test -d` in all relevant tXXXX-*.sh
files.

Thanks
Rohit
