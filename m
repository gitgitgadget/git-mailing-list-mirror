Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC2C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 09:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiBLJOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 04:14:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLJOP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 04:14:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2926562
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 01:14:12 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v63so4524538ybv.10
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IdoeLogZyTlnyVsHkFDU/i1TnM46ZjQHr4UuKEbqDg=;
        b=ltI8uKOU6GEoADne0gMDPJ0jVMu5xentRAhDA8i90yp2GcHyNV6w9emqk2JrybgyB7
         zEfR4Mim+GdbvC3ZHc1yLkp/WLNCSwo+AOMO9b3jQtzv4aKA050dV7DZgh4uB5nhB3WU
         fFJo9+JiESukWY7sGVMEVF3m/M3WAeIzog3iUv3fqqvH4BFUAMQpMMsNlzBoisye9uh4
         7p4ogOuIggzEk9AAbAwWtfILd5bispajnaHJCgkIwkqJX6fqIrY5nXOjbyBjs6/OzLNt
         EgZzTdzsbX3nhCgsjUAgLTmlucnEWElIyzJ88OzU3pMfUg7XS9jO3qLEMTzcdTVUnRqe
         sJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IdoeLogZyTlnyVsHkFDU/i1TnM46ZjQHr4UuKEbqDg=;
        b=MBFxz4m6ntXVFqxYtIGL4cCxeG5DuF/j4UJ/GTWf/LQyk5m+cKyVzcktOjRHfbhpkg
         ULeBnNc8+dju8VD65PrnIvVxgfWh+d200cB7XS9jLizmF9pIHTE5pipG1CdIsMOSe0NA
         CxeOS93qh4uVEZK2/pHGUTTRh/iylryu5COr3fqUTeWFl2xEaMqaTxXsTFWev6q/tGc2
         hKNESHuks17kM8HRtKa/R+RCc7lEnILVC5/O8/xTXJSv2VZx/1sfCCTNyx/wyEsq/6+x
         sfo+R3CNnRCT7w0v18I455GRqVOvDp9QGHNC25E74MJoHaYG2T72C82EwtH39R55j/t1
         tewQ==
X-Gm-Message-State: AOAM5328TEWRmjOBTjPw8TBKKwNsA/xyoGDWMRDrxO7hUERF2SWJQJVy
        +g7RYCoP+qHe/z8afxBlmMLyn41qgzparE8lhlY=
X-Google-Smtp-Source: ABdhPJwnj7OilA3J4hGD5Y8mB5E+QRQaRj1ZNxQB1PZGy8SnPCGoJosp8y8ZsIhX/r0PHMXZErC+jmuyJegraSDBxvM=
X-Received: by 2002:a05:6902:920:: with SMTP id bu32mr5058359ybb.693.1644657251267;
 Sat, 12 Feb 2022 01:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20220210024138.157327-1-bagasdotme@gmail.com>
In-Reply-To: <20220210024138.157327-1-bagasdotme@gmail.com>
From:   Patrick Marlier <patrick.marlier@gmail.com>
Date:   Sat, 12 Feb 2022 10:14:00 +0100
Message-ID: <CAKQMxzRE515dAu5a=g6pLMEf3EWu7XUX41XkyAca+1ewCzXNGw@mail.gmail.com>
Subject: Re: [PATCH] clean: Use past tense for msg_remove, msg_skip_git_dir,
 and msg_skip_cwd
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, zoltan.klinger@gmail.com,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 3:42 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Use past tense form of "to remove" and "to skip". This is especially
> true when we had already removed an entry.

Looks good to me.
Thanks Bagas!
--
Patrick Marlier
