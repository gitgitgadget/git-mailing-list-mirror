Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62F11F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeICWhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:37:47 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36516 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeICWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:37:47 -0400
Received: by mail-io0-f170.google.com with SMTP id q5-v6so1009545iop.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t7PhshwKQBBKOEv8QG4475aupj1EA9mzv5W8oqOH95w=;
        b=j7o/ahw1ZWfZcHEDdLxL8fY8Cy+UjBM83i6s574vjPEYi6eQ1zeawoQNp9Xfuh6BIR
         uerpSRd5vJQWS9rs3sW7eVtPf5wyJAGbfd8Uc00XGjVHU9Q6Kf0+EkqwAwD0CvajgaMb
         pJyuzOAMcIn5Inz3TyV1wol32mcfK/ud63ccTEg1CJp0hrizWIUdgnCR6MQjg3XmvJmU
         vChouo7YtDQP9WRfXzTsVCyNV1t5rFnubtwBXEQa638I8ALrFjoys/efyv1jK4H3hiT+
         8I9enflEE90ePom0cuM3/y87jeQiRWdSl7QmLITNVDFSeDD1zUMnRHUP8FQUJpcxdExs
         7H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t7PhshwKQBBKOEv8QG4475aupj1EA9mzv5W8oqOH95w=;
        b=Er/pzQryHGeo3tqbJWsyLoK+Wykvbpfc+MdNSiwiKj52NmxAehtFqUi7agpqeqn1a3
         pchxwxu4ayA51Ot2fG6VySVs6bwT3b9MLy9W+tJYKXcgv2hr/AcdvF8fYSZ8lnpwU+GI
         5qp40uo3jYJ9gjhjY7NtSneCgs+xXVXayI3+9ayYxS9ruWs1k4zCBCacRWxX8VUGBKnO
         uRr7oKgTQ34GF0qaMg1ZO0EBYSAvq+ny7lWxgkIUX45rsOmP1OcXJpa9kYZhTpJ+PME0
         6zxwUD7FPinqXQgAJT8wwjuVUzLQaPOryuVNrzw8hxHnpM+Z0ZdFDzioBSx/6YyfreTD
         jieg==
X-Gm-Message-State: APzg51DQSdN7y1NFWivUZVx3FxuSCFzMC1jyra8/N85FUL8RcQBWzXHG
        8AOzfbx4UXYAfjdI01XhpGSDOcqyacZvuJGeTjeabamy
X-Google-Smtp-Source: ANB0VdbfLSd9W5Qw53oH1oj4ixvm2r0oB4YlQaCc1+aH1D+xo+bPXcqiV/9cKE3H6ofnioG76H1ckjrqp1Dq4HTtMfs=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr19927279iod.118.1535998586148;
 Mon, 03 Sep 2018 11:16:26 -0700 (PDT)
MIME-Version: 1.0
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 20:16:00 +0200
Message-ID: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
Subject: test files with same names?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have these test files with the same description:

t0410-partial-clone.sh
t5616-partial-clone.sh
t2000-checkout-cache-clash.sh
t2001-checkout-cache-clash.sh
t4134-apply-submodule.sh
t4137-apply-submodule.sh
t7500-commit.sh
t7501-commit.sh
t7502-commit.sh
t7509-commit.sh

partial-clone files, I can understand since they belong to different
groups. But should the remaining files have different descriptions?
Looking at this it's hard to know why one test should be in this file
and not the others.
-- 
Duy
