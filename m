Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C8620248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKDCe (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:02:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44550 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfCKDCe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:02:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so3340102wrt.11
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PdyybWCCm8Uad/6ezUgtWYdGa35m3mVCF67IKAXR92U=;
        b=spvUigbgJ/kUEFeyddz8Mz30IUWupO8rHMPBbOXUZUtPgum7JtAEW7Aw4ix2QniF4V
         5b9m7qwm28q9+l5Itdh8nl9Qm8+EpZFU1qN2SmKS+/xBVQxE3qVSmulxcodpru+uabRx
         l02HBwpEybaikUDrwLJ0ooduAu7MirJRxadwIlzMAX1rGHVQ6MmEyGtN9xnwPdFrVXFM
         1A7M7ri/7sX78tLQlzVKJuh+HoMNkkfkVniPC+lA6tq+6HTjAPcs5K3VCVDFiu/THiCo
         03fWfLHM3UK1aRpGpQ9xtjESn8SLNc6bt7CWfYwCNdB/SihqNSRIOPiIu+ePONtKSX/c
         KTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PdyybWCCm8Uad/6ezUgtWYdGa35m3mVCF67IKAXR92U=;
        b=l/VZi6uuTjmvpBY3XjMct12VJpVBtmE2HNefQAgZZakMWg38eAcW4BSqeWXUArTZMY
         o12Le4lcPFZDwWRtiIhpaD+RfUgMWDKKbpaiCTjo8tKqCytLBwu3cpVuY0Q077gQ0ZRL
         v9DVDaND80ToxmDCSfFIX1TW5W7/krIo6PVS07uEqr32wyGfPG6oZZm14zFqflkOlvVH
         pmxgFMF+MsfmBFxk8s0E01qtwDRDLDKAu0wmQaTlgpRLEuURULqKVtTJQM91HVOfWtGV
         AYWjnl5vfH3tl5P62FR9e5wbaK8Mv2dHngPuM8BnWkH/lcnByx3P6YxW5wjIjVjRDRx/
         8WGA==
X-Gm-Message-State: APjAAAWP1iOYjX/icjkMCdoaIA4qOOY17/r8ZTYZL5UyNZ51TErwfoLZ
        vl1alTJfrFYCUW2ptJNgAsobRQG5p+U=
X-Google-Smtp-Source: APXvYqxcEFN/NxyBHaQ9x9bjkK0U0gGYt02wwUtHeP7ni7N1oNcr/4gSdhfvZbLqYfriqaNMaYDtOQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr18009804wrx.134.1552273352907;
        Sun, 10 Mar 2019 20:02:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b195sm33412934wmg.36.2019.03.10.20.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:02:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
        <cover.1552230490.git.martin.agren@gmail.com>
Date:   Mon, 11 Mar 2019 12:02:32 +0900
In-Reply-To: <cover.1552230490.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 10 Mar 2019 16:14:22 +0100")
Message-ID: <xmqqk1h6kt9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Bleh. For some reason [1] I thought the html-files were exempt from this
> "extra space after linkgit" problem. They're not, as I just noticed. To
> add insult to injury, my original patch 2 which adds a missing
> dependency to the xml targets fails to add the exact same dependency for
> a few other targets. So of the three patches discussed above, at least
> two were incomplete.
>
> Since this has hit "next", here are two patches on top to address this.
>
> Sorry about this.

Thanks.  

If it makes it easier, we can eject ma/asciidoctor-fixes out of
'next' when we rebuild 'next'.  I actually am tempted to start
'next' from empty for this round after merging some obviously
correct ones that are there to the 'master' branch.
