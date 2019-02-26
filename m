Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8E820248
	for <e@80x24.org>; Tue, 26 Feb 2019 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfBZVpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 16:45:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33272 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfBZVpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 16:45:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so12149221edb.0
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5HwS/UfACpzAIiMXHoEUjgRweYN/nmWcO7RjkhvjUEs=;
        b=gKrl81wfTImYLbFQfZh5p08XF3nlNkG6zMqIzKZLmiQ9EDloBP5NmT+/PYyGLlN3jf
         9m8k/7l3HbfNGWmmV/VBT9SFD/9XTPJx1XUkpRbkg5NSzoMd7jKKLdYcCiY7wDepomrj
         M80GrOofzm0KMGf5UBbM5m7HJC+Q8EUPa9oJzffglj/Gj+CzwKBkyC+hBShDWi01R1bq
         XMygJtmDlKe/X4+oORSLTSZgzVju3n+9TpOp40T0SXKe3V1PtEWX8d5fgZrWymTOmie7
         fc2KuCkNLpjeZ/8EAR89xMIpnMoHybXhly4R5k/KQKwoBlpxCAHpmxnPBimlL7ueIzZJ
         +65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5HwS/UfACpzAIiMXHoEUjgRweYN/nmWcO7RjkhvjUEs=;
        b=ioCkAgKQGW/gAPV2S2T/wjj/j7g3PnaJZ+KPiEekHkjiZ4RXsbrzWQDv758nd+2uSO
         GmC567PiWWKAbf1wAuZqNEknF6ox7jsxouObVZrTXE6nKAvCYMMYSe6Jvb2A1t2aWqn8
         QKbe3pNFa5vtb7TZZnKATaiTB0v98NE6CwEO9wd7xAu3KFi4cFUugb+WLR7+6Eh48t9q
         Pg9XGBGOoxEjZRMGB1ru45ck3tIihjkehdK1GEIlax3rpUmdxyzP1kar1RGHrjVaLPKe
         u/ccbWmHMrb7U6MoXLEgt2lzzJV9VJDfUacQBWgs/uTBSaEw8CWGtkmkEonMRgNWgHGJ
         t/Tw==
X-Gm-Message-State: AHQUAubFXR0mh1/SJqjE7uMZHW5qxlBAbJWv+strsTZfe2z3kkkyUmAX
        Bi7HPDPWb5192Bye1W72ZnG7sQh6+C0=
X-Google-Smtp-Source: AHgI3IbueSXmGC3xAozBAuNFNLSrtBamX9GK7UuYznvD5Pjtp1A5CLA/fkKCc37xoMgxarmwRejdUQ==
X-Received: by 2002:a05:6402:124a:: with SMTP id l10mr21140763edw.62.1551217532132;
        Tue, 26 Feb 2019 13:45:32 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v15sm3829361edl.40.2019.02.26.13.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 13:45:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190225231631.30507-1-t.gummerer@gmail.com>
Date:   Tue, 26 Feb 2019 22:45:30 +0100
Message-ID: <87r2buusud.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Thomas Gummerer wrote:

> As I was advocating for this series to go into 'next' without a large
> refactor of this series, I'll put my money were my mouth is and try to
> make the cleanups and fixes required, though without trying to avoid
> further external process calls, or changing the series around too
> much.
>
> One thing to consider here is that we have a GSoC project planned
> based on 'git stash'.  If we can't get this to 'next' soon, I'd vote
> for taking that project out of this years GSoC, and maybe try again
> next year, if nobody implemented the feature in the meantime.

FWIW I'd like to +1 getting it into "next" so this can be given thorough
testing in the 2.22

If there's still bugs or other regressions I think it's better sorted
out without the cognitive load of reviewing it all again.

Worst case we can always add something on top to flip the default of
stash.useBuiltin.
