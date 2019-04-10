Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E0820248
	for <e@80x24.org>; Wed, 10 Apr 2019 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfDJO50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 10:57:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36410 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732883AbfDJO50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 10:57:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id y13so3371249wrd.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mr+dhxIgFf+9ktdOCsTlJ/3za2NZcltYOor5xX7WREs=;
        b=X6Ri1vXrlKObIeO+zHMn3ftXBAMH0cQLAlrmBABQlrEwvOi78jgiwNsv4ouhvGmHgn
         shTgQ7dyyhwNjEhRBA3joFpk/+6tr+x9SGRyYiyP/1BkbDjCJw/9RVCZdtwfuaaI75BA
         p8cMJ6xIG9b3YbNvqqTSornGupC/9+84hABG3zCbQmEBYjCcOhSBsTSaJ6aU3nLanw0X
         EESTFcQYrO74BhYoSRwOzIQdspycEkiQmof0s3fF94FzQ65bWph4sMbK3t/MjuHzRU3F
         XhWFSM9omF30whw9EuybG7k7w8ela/XvfZ1y2QP2FgGL55IUcmcGvmMBCj3d+LTyUSDQ
         bRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mr+dhxIgFf+9ktdOCsTlJ/3za2NZcltYOor5xX7WREs=;
        b=PPssjAsagG0eDoM233dnF2mXiHHv73tdOd/HbumQm1+b59J863mjV5Ic3tp8g/td0J
         iii7LolpdeHKFGxqqrQUbMQyqUAq9fDiVkdGs0RF4KhbAuOHBKpllkz/dCdpI/psi/su
         +8GJshnfDud3TQ/EzBWG30GetiXuOsuk9NfHvMYn1ZlYhliObi1wxcuap8/LFnafNx34
         ZZ2YhdBWOeG4rfhpBAMv5Fb70cAbDW4RkRSdUL+1wq2kLTfTW5A1lyt6pa5urRO6TkG0
         QY8ENJKilORsV6MVXlDUFfGgWHpoP7weWsYPtfdP6I3meBuCgIc95E+/BDKUAqDqhjE/
         t7sQ==
X-Gm-Message-State: APjAAAVFJOR8YEwaG6Omn4AQYfJOrWywBFSWyO5UkiCAs9NBajiZS+5F
        b2e18ia+wYcOAM43Y47nCiWrSi9e
X-Google-Smtp-Source: APXvYqzjnyaAjp6DgKMsMkAGGbC8nQlcdwBzPLVuVQDuPW8aQoYHuCpdR9GFrE8DvlHwDh5ZEgUBjQ==
X-Received: by 2002:adf:db05:: with SMTP id s5mr28703805wri.247.1554908244820;
        Wed, 10 Apr 2019 07:57:24 -0700 (PDT)
Received: from szeder.dev (x4db95c63.dyn.telefonica.de. [77.185.92.99])
        by smtp.gmail.com with ESMTPSA id j22sm110261368wrd.91.2019.04.10.07.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:57:24 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:57:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Kurt Ablinger <kurt.ablinger@bs-ag.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: repeated empty section in config of repository
Message-ID: <20190410145721.GI8796@szeder.dev>
References: <32db4d5189264ab791704cce91d6efaf@bs-ag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32db4d5189264ab791704cce91d6efaf@bs-ag.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 11:51:03AM +0000, Kurt Ablinger wrote:
> Hello, 
> 
> I am not sure if this can be problem - at least it is proably not correct:
> 
> when adding a key to an empty section and deleting the key so that the section is empty again,
> every add adds the section-name again - example:
> 
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
> 
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
> [gc]
> 
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
> [gc]
> [gc]
> 
> Git-version is 2.17.0
> Linux - Cent/OS: 2.6.32-754.10.1.el6.x86_64 - GNU/Linux

This was a known issue, but not a serious one, in the sense that it
didn't affect correctness of configuration parsing.

It was mostly fixed in v2.18.0.


