Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849F2200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 17:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbcL0RsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:48:21 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34418 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbcL0RsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 12:48:19 -0500
Received: by mail-vk0-f49.google.com with SMTP id x186so212213901vkd.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UD4ui0NspbVgngf8pQRHCtqSjf7wsr3/SI/J/0bpsXA=;
        b=ot0WFxf0tvLHPvUUymnew97fQNeeKgtZ4MWux7dFtbpNFKE1MJFD3FGQD6otNnBL0j
         G/GmJIzFZJZYpXQkypysEhb9UcUOuBSUBmGOASIr9yBJor7ivmHm4+YPSVia9EHigXPD
         1gMvSckkZUYlleiyR4H+AZr/VuGo3Dj//G6H9y/cwNhWcLMnhK6hKR+e33rxUjKlp6V9
         E3HxfsIKuN6FtTYNHpl7PSHe0g7pKbQhkCDY5cBH8T3i/q/eiLqEIQthd0C2YKmRRoFX
         iQfiKCfg5wgURacrjPgAWsDrp2aSqKcJGGxWux3s/z44z1fMwWVJ6kQeQ3Unl4kM4wnY
         q6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UD4ui0NspbVgngf8pQRHCtqSjf7wsr3/SI/J/0bpsXA=;
        b=rlWYzvfeUmZGoXfU6K+SKOTncx5EphNbLqyakMKlhwVxeha06Q3gMUyNAR6WtNs779
         mZ+jFNoJthaCwCG2QnxUgpdFYshPOTvWx2NAp6cP2Chx8GbnKXO3emX+Lcu0unqxJXgJ
         10Cf1KrRogTQggZfLgv7I/Q23wcdZqF+2K3j19YaDNP63ILwp7qwWJ/MrtP0DggqLWmi
         JKSSDGuXzn2NxT8QJIoZ4BIU87QXxNPClu9SvtEcnya6uiP6LPC1gw2J9ByjagOKJBPd
         EoZd5hEjGpiFGhYMcNu1HmoCvqa0KPqBimb7TMR2aCqD58j9j3RlzykvIsZaeaMrFSWF
         Ge5w==
X-Gm-Message-State: AIkVDXK7Ff9gUMR+5/xSYwWkIOdIzWdNSCwvKYTIWgx8R//C9N+yazKqyI8zeKB0oP9F8R71rNNZ/WczplsiVw==
X-Received: by 10.31.183.144 with SMTP id h138mr9982331vkf.48.1482860898694;
 Tue, 27 Dec 2016 09:48:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.45.11 with HTTP; Tue, 27 Dec 2016 09:47:58 -0800 (PST)
In-Reply-To: <CA+P7+xpdKEoNY_cgY4g3bMVZe0p-2bYT4Y-3nYyd0O03iD1nZg@mail.gmail.com>
References: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
 <CA+P7+xpdKEoNY_cgY4g3bMVZe0p-2bYT4Y-3nYyd0O03iD1nZg@mail.gmail.com>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Tue, 27 Dec 2016 19:47:58 +0200
Message-ID: <CAJtFkWvE7_owqH0KET++Oxv9pDmygwnmDMnOE2r14hQN6BxFgw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Making_it_possible_to_do_=E2=80=9Cgit_push_origin=E2=80=9D_i?=
        =?UTF-8?Q?nstead_of_=E2=80=9Cgit_push_origin_=3Cbranch=3E=E2=80=9D=2C_without_having_to_?=
        =?UTF-8?Q?one=2Dtime_prepare_each_branch_for_it?=
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks guys!
