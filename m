Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87393C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C86064EAC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBIThL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 14:37:11 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36232 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhBIT0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:26:05 -0500
Received: by mail-ed1-f41.google.com with SMTP id l12so25376573edt.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 11:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Q620ACJi8eVG61UlVGjB427Py+UoMv+YudW0QvC+o=;
        b=tITch2XhF9g1NQHkXTMwiCWezP40Bd9wR199k9j+T3iIRUQo40HQ9EgL8EbmudC+VR
         fpsz97xyRnI+Cfxnt8n7OTO5t+7y3Hb1E/nGQN3imMjRjvxMJ6liPWUQqxk/E4T7+7FN
         6ygVWWKyKW3sRySnkQZd2f2L+/HUJE9bcKoAN+GNTDbC/SFBuDAZ5mM8tcZd81XKxbHT
         ZMydX9NHYuvKbpgYjvY6h51wmqAq2l0nPlGSErOC4sFYdE5F87xyTDStOMyq+Jsn+BZv
         pB4G0q6HUE82DyzG3dOqcpnQ5loMfuiAzCVOXWnUeYSgVyv/PAuiUwZ5RwLDvyciYl7G
         2DKg==
X-Gm-Message-State: AOAM531JuX4lJY/hs8B5fj+3vRaDkpNJWIrfrbolfAG8oXxXQM0VvJeZ
        1NSPVgjeJuoKPHzoNspRBHQvuinw8gOAAmxECUrKJNaXNoGJWA==
X-Google-Smtp-Source: ABdhPJyW2DDXbb7iNjWbH6v+i/H/B7xzGcMWusjVBSTZJkplGEY/WZWO3XkXK3sCSL2964AkXtQ6ZinOOQjbBJEx81k=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr24448436edt.221.1612898693296;
 Tue, 09 Feb 2021 11:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20210209173254.17712-1-shubhunic@gmail.com>
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Feb 2021 14:24:42 -0500
Message-ID: <CAPig+cREkd2rdDzETBzwYFgra4WV7PdM6expXRrC=kdFnZMk5A@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 12:35 PM shubham verma <shubhunic@gmail.com> wrote:
> In this patch series modernize the t7001 test script by changing the
> style of its tests from an old one to the modern one and by cleaning
> up the test script.
>
> Changes since v1:
>
> - Change commit messages and added brief explanation about commit.
> - Modernize subshell formatting
> - Use ': >' rather than '>'

For readers new to this series, v1 is here:
https://lore.kernel.org/git/20200925170256.11490-1-shubhunic@gmail.com/T/
