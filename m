Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADFFC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCQQPL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Mar 2023 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQQPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 12:15:09 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ADD399F4
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:15:00 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id c10so3410869pfv.13
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I6KxFhclo9U1e4TCcSSjnAJVeytjRWiEyTahDxOpCA=;
        b=e6xKSdWMLc9FD/1tj9lxjSSe8Noz5BL/KdKPizo3YU8Xv2JB9H7HyX6BxNKctPkce4
         p8VZbK7yof4eSJWJEQx2hxshp2i8gHep+N4VA+fpdUevaYDB7CNSRwkkkyYQ4z1yYbkK
         yFG/jkFUgtiwMNUrafJPT0EldelqKBPKttgaj2aslOGm4dY2XVC5s9zYrN6QKLcz7EO/
         U3pmA9/JapUsQmjlfY6X+86L00xUX0JrE9sSM6Q7U7szKfoaYRIhz+SY2FIjKAtKBPFk
         vDJTNJ85Le1ix8KVdwcfxHtmr91u/qWkt6/2lm41+EzKsJlanBKIa0wx/L9qO7UTvyWl
         V/fQ==
X-Gm-Message-State: AO0yUKV8R6C40DAua6nAdFKbm2vx1Dlg5nmafBHa8Pdhgq4mLZ3Mxa7m
        SSTL8PsmjKi9I17oSJE9eA3854FT8KFVUTnpw3c=
X-Google-Smtp-Source: AK7set8gKN6BCtTxfA2DlGbtNmzGMSf1b64t0LLaA98CB3MZkbRGpALlTZTJZAhD4RwJFIq1N5lW23ySIl/Z2UtsRcE=
X-Received: by 2002:a62:a512:0:b0:5a8:a475:918f with SMTP id
 v18-20020a62a512000000b005a8a475918fmr2828346pfm.4.1679069699944; Fri, 17 Mar
 2023 09:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-01.17-c167bde3c0c-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-01.17-c167bde3c0c-20230317T152724Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Mar 2023 12:14:49 -0400
Message-ID: <CAPig+cQigE7n6Op=8_Ky58pgXNUcGDQ7u9mJNHYF3x_TAg-i_Q@mail.gmail.com>
Subject: Re: [PATCH 01/17] cocci: remove dead rule from "the_repository.pending.cocci"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 11:42 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The "parse_commit_gently" macro went away in [1], so we don't need to
> carry his for its migration.

Nit: ECANTPARSE "carry his for its"
