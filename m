Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33F120248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCTWF5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:05:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40065 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfCTWF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:05:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so2766444pgo.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUsfm0jlnsUts06GaAKEgiQVK8E+gs6+GqzXyzczPe0=;
        b=UB5NBizhLZNqZ4ii1dney+vHhrlTSVI5F/uGcmEDiRsdqzUtFPMmJpMulBQe2riy8U
         bI6GLAkptjUtW03tV3tCDSyiSvL/zlQEc+6ksPoR1PiiAbIeLe3ul2YE6cZ9Ne72k9eK
         g+OccX3mAT4JLuzJ+dk42ItcjpDhI8oWEpqKGmPrQFZucCtwaG3ViYkVXp7zEFM9U8Nd
         tZBPyUN3TbkYdRq4NDGkXlF2pDdLJ8ON3Se1ysVafq31nwvEHNU6sxJG+UGc8bKDgARF
         Bgvnkqs+NY3C+pD4ccAwwyLtMJsqDDStPR+XWbG460S1vhddKweKouTTjrba63/anzg2
         o+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUsfm0jlnsUts06GaAKEgiQVK8E+gs6+GqzXyzczPe0=;
        b=TYWk58FRQkTK70Ml45pzbNqpECh/Atyemorea5zQExeVDgQWnCkoQ6uC1QUHJeTL7t
         VldWFbMpKEtwBc3pacBWTXRgdqRIup9/uSyVvZ5N7IB+UjTbFeu3yL5MlGNQAmh9HhjV
         hwW1ZYPXST9qCPQU1FAguCrhAc8RfOYZhSLSuAt2q+dPeuYcVTejDZe3N3B4YaeZ37qC
         diawhxDIkKNWi+F2qeSBbQdNs0PKP6W0CD6va2CG21CctpB85vjZhUkTjbEO62pSJv69
         MhdGCTfnxpLkgQeGBizDjRg4VDNanvAvSJCe8jogV6mkeT1KZfLfHOWSuK5RN1r7nBCT
         tVcw==
X-Gm-Message-State: APjAAAVGWDH5gVmDC4kyEKbjN3i6zJmgdP+nknQ7vQubVzlOX6XVreRF
        nI2tooDCG+NkPBqxMRDpNSo=
X-Google-Smtp-Source: APXvYqxNn0NJwNrAQuUfTZDei6IAif5wUywaoXlpSQgqA8S0MAXwRU8QgS5sK3s/JS5SUFErJ1UQ6w==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr43421pla.259.1553119556173;
        Wed, 20 Mar 2019 15:05:56 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id m3sm3388769pgp.85.2019.03.20.15.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:05:55 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
Date:   Thu, 21 Mar 2019 03:35:09 +0530
Message-Id: <20190320220509.7180-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio!

On Wed, 20 Mar 2019 12:13:47 +0900 Junio C Hamano <gitster@pobox.com> wrote:
> * ra/t3600-test-path-funcs (2019-03-08) 3 commits
>  - t3600: use helpers to replace test -d/f/e/s <path>
>  - t3600: modernize style
>  - test functions: add function `test_file_not_empty`
>
>  A GSoC micro.
>
>  Will merge to 'next'.
>  cf. <20190304120801.28763-1-rohit.ashiwal265@gmail.com> (v3)

If we are going to merge these in next revision, I say there are some
minor changes that Eric suggested, basically there were some extra spaces
in commit messages and a small change in commit message of [PATCH v3 3/3].
There will *not* be any change in code. Should I attend to them or we are
merging anyway?

Feeling ecstatic
Rohit

