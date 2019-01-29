Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04ED1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA2B0f (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:26:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36737 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA2B0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 20:26:35 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so15225495ioh.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 17:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC89rwTJDGV8Vlm9VFK17bJ8Uv2qNwyqIiEW+Ubt8Uw=;
        b=HO1/nO3vip6VnH9vBuIK3h3dp3/3rQi0tlGtKfqgJ4uXdzNIiiicecvipH62bwEUjD
         0k9jj1sPmrIA1qfSlAUHHEPu+4ImtUQdqcRKXc01MIB/XG9wJj5Iiok6YuqQQby5r85a
         RIeiKFf8FL/gr90iRX46v1hkCqh4qIf5nTFSEzhreLBhtH1iP4ZYK4iPXbWrGqTsiiS0
         iD94sn+kW6M2o6YdkVBMZQvoOcuxfykTzJL5z6mdX2JYDyXpOgKisCEzkfTyZKUwCy8n
         PlkJSa2EHB7eEa7rbBPILqk/GwtSzI9NViRnC36jks4xCKEYwBCmq9oZFbt22oa8s4hc
         +9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC89rwTJDGV8Vlm9VFK17bJ8Uv2qNwyqIiEW+Ubt8Uw=;
        b=WHWfDzl7nplCnud3pNfeu6AB96FGJMLdsnYyUxBMAY9a2pCm9FnRwmphCgbBsWXlcc
         XTenUIvZan6zcknHT3c50qfcD92U+LV6AvNelY+bSYjy8CQULzKSsVLo+8i2vEk4cA0R
         K+fExgL7pxgSsSv+Jkc0JlOOyIDiIlLl88BxvPJFiuOHz0PNlrhx2CeSv223krtGWiaD
         XC02vkgHxfh28nnAqLRuQkm02HlAQt7Dwnk7TB2wFYthdZI2LX7u6rMNA+J8grno3VDz
         rDHRrihvMrN8zUSU27MQJ/shattzz/E/rHVL1bgp5LoMLAcWSEdQYU6iId+AvQq+8yzJ
         1wRQ==
X-Gm-Message-State: AHQUAuYQjgaeOvLL16dgQNE8LY1y18VEe1gejg/ndxOEmU0uqbQq24Al
        +aH13nnYYzaL+Fo6mAZiWYRoa38UZGHGpzHDWT4I/A==
X-Google-Smtp-Source: AHgI3Ia0VwHV6Vmsdlowx1fD4siCwF9FGxmOE/n4CWHm8XS/sV11J9v0Hz4ucHOrAv4YerPJBxOO9TrN8AiCk9kf9AQ=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr11709065iol.236.1548725194469;
 Mon, 28 Jan 2019 17:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <20181113182800.26984-1-pclouds@gmail.com>
 <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Jan 2019 08:26:07 +0700
Message-ID: <CACsJy8B9W3XcD4ucAt7roA9grJppYK+uTH35xvafaTbkMNPAGw@mail.gmail.com>
Subject: Re: [PATCH v2] checkout: print something when checking out paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 4:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> One small bug I saw since this was merged is that the message that
> is given when unmerging, i.e.
>
>         git merge other-branch   ;# conflicts
>         git checkout --m <path>
>
> is misleading.  It gives the same "checked out ... out of the index",
> but it should be made a lot more distinct, perhaps "unmerged N paths".

Right, I missed this. How about "re-created %d merge conflicts"? It's
a bit clearer, I think.
-- 
Duy
