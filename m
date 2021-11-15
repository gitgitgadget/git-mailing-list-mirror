Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEB4C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AA661AFF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbhKOXpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349007AbhKOXlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:51 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62954C079786
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:40:54 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mmk61-001odz-PT; Mon, 15 Nov 2021 22:05:04 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mmk5v-009AVN-AX; Tue, 16 Nov 2021 07:04:55 +0900
Date:   Tue, 16 Nov 2021 07:04:55 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Message-ID: <20211115220455.xse7mhbwabrheej4@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 12:30:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
> +hook.sp hook.s hook.o: hook-list.h
> +
> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX

hook-list.h is only included from buitin/bugreport.c, so
builtin/bugreport.o should be the one with the hook-list.h dependency,
shouldn't it?

Mike
