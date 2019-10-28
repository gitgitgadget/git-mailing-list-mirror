Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A8E1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 11:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfJ1Ls4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:48:56 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37772 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfJ1Lsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:48:55 -0400
Received: by mail-wm1-f50.google.com with SMTP id q130so8801026wme.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIntTn+sHeoHvzpDet+zdIp8N4o3MdW60f+zmnT9Sqc=;
        b=SM4Jp44ZCv/idzCDP+9mq096v9ygOcpfVMwmOrNJyjwVjfHcGHx7dqO4kIj4zAqINQ
         qp6DPU86k2YcZE3IFV73bO07zhwZwY9uEsSF12LJZS5M/sOer028J5P4y1GFCUXtJLG2
         zB3qf+U33bwK4AwjGMeYphCbijxXA8VYaxiarMsyyIGOVWqWKQujEF1LObg+jFq/E7Ou
         9Fk7wUev1CrWndFUpZHo35xvLNN4mXW+8IleC1s9EAcpYJVo1J0ePX82t2DXEsiHuFmC
         efk8nsldy4ApVWIvpcwGlQpGqTZ09d3Sbwh18m3U9qiWJHpMqnbe3OLsaSOTZ4+ZVHbn
         DLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIntTn+sHeoHvzpDet+zdIp8N4o3MdW60f+zmnT9Sqc=;
        b=CM255seoqMQ91b/v5jirhBz1RiOWAdJ39uH1Rlm9qMvU/3a+QWhMs1zDPVqtWJBY0i
         Wt9YGGWqbRFK4mwkMUVbSCwFJrMSJFi6c65kU3iJuUhVxK5vOUrg7uxESMJdVOFAKfWn
         wZb9zFh/iDtBHlAa0rGipZwg06+hDj9BKFaodukCTz4XaLBz4dQ1RlNSYc5Q3lh5EHKu
         iWypNeHUXg1a0x2G1iGkytvSig2p8EW/pfw6ga5wM9T+6p7VdMcmWHHKg8ikvAk1R8ar
         GHFaGy1OOWIiP7ip3d7tFlxUX6xBwOAwDI7lY7mctL5483ZROEqtVxuxJp2wehwMgaY4
         f5ww==
X-Gm-Message-State: APjAAAVCh5rZ7mc5NTTWgTaVcx0HdkTyXnY9qBFu297czEfv9gbewOno
        8QWIzyyqalejATuOL4FrxMhRhnas
X-Google-Smtp-Source: APXvYqwS7it/3xAEna7fOgddjMbTWnkShrCFk54+6A5WAS5o/b3Bhm3CLZ+cZKW4H8M1WE14UZUiKg==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr14745047wma.16.1572263333449;
        Mon, 28 Oct 2019 04:48:53 -0700 (PDT)
Received: from szeder.dev (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id g184sm14258852wma.8.2019.10.28.04.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:48:52 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:48:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc1 - Test Summary for NonStop
Message-ID: <20191028114850.GR4348@szeder.dev>
References: <021601d58c32$4f632a10$ee297e30$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <021601d58c32$4f632a10$ee297e30$@rogers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 26, 2019 at 03:19:37PM -0400, randall.s.becker@rogers.com wrote:
> This is the test summary for the HPE NonStop TNS/E platform for git
> 2.24.0-rc1. All tests passed except as follows:
> 
> [NEW] 1. t0500-progress-display - failed 7 out of 11. This appears to
> consistently fail when run under Jenkins but consistently succeeds when run
> from a non-disconnected real terminal. The difference from a pipe handling
> standpoint with Jenkins is that it provides a stdout opened using O_WRONLY
> rather than O_RDWR or other open() modes that might exist - we have seen
> problems resulting from differences between process initiation under Jenkins
> and connected terminals in other products. This failure was not present in
> 2.23.0.

> It would be nice to understand why t0500 is failing before we release the
> official build to our community.

Yeah, that would be nice, but I don't know how we could help, if you
don't even tell us which 7 tests failed...  The output of the failed
tests could also be quite useful.

It may or may not be conincidental, but there happens to be 7 tests
in t0500 that use 'test-tool progress --total=<N>', which was affected
by an endianness bug that got fixed in 2b6f6ea1bd (test-progress: fix
test failures on big-endian systems, 2019-10-20).  It would be
interesting to see whether t0500 failed before that fix as well.

