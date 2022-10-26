Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A862C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 09:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiJZJgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiJZJgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 05:36:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472FB7F58
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 02:36:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y13so10176250pfp.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hPsAxpqrr2kf31bIqNxHPe3Z8YxPlZh0+vid/HRxbOE=;
        b=GcLLKMW+7+r7vaA2gUYU3PdJLfmcTtrIyqeSSnU3q1YUeCK9jA3j7vskimqZaJztl1
         F4cdQunl76Rg/Tu+1D+cj/c+ABSl7huocvJu4zMaC5GjMrfUJ2Z0MwwOb5cerTD3RTzu
         Yn2cOS8fySSIay/gfflkA2x+fa7Lufr4KWhpyhBtc8GycxjckVvnH3KBc5fLfAMWBmKp
         ZmhG6/aV3oZEElUg/iRZUhG0JkB47c/6uphZA8OXMlJl9aKTGuAxH7Xgwn0L5PSdd3yo
         mUfXWlJrUlY0Kk2RbyQp20iBvrcbFVGzr+URSLOFA57evjfEDzkELt1M/x2UeoLaTM2b
         yLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPsAxpqrr2kf31bIqNxHPe3Z8YxPlZh0+vid/HRxbOE=;
        b=aee+JHwZoxLxAA/RLvBFS/Oqa26V9dIQFJ/LZ7+IFUhqlw0k/J+FUb7Rril11m9W1F
         9jXZtWi/PImJhUP1yd98NskugwvQdNJ+zykHiLRhgMLiRVDqnBAUQso2UZPslzGIaRqc
         YkGPMe5EfDxSb5zbqIfzCCp5w7o+UozkThIjScFtgslc/ZpvgiSyHmAuebU2PQ0BK2Tr
         wvLzD/wlxg+TgQp0953xBXAp0oOSKPNeAnYUY4iDsPEoxrnWivvHiEG/DSdBSPghKPfO
         1gELaEhf2ZAUWOV+5DMgQpbVDvFl3Zrqq0Q6JYJwz1hvoBUUcmsqFAfwuMVatzJw/GK8
         EqKA==
X-Gm-Message-State: ACrzQf1cDfjJtA/i+0eKLTm3ccfrTKmCMcKzMWsCox53UOWt/nPJNPZa
        KVhjfBES6fD7CRW9cn/JMvJoA4UCbX8=
X-Google-Smtp-Source: AMsMyM5YIaGP0BcEqoV1YMHpdB1XGyKAKEKWwbBfX+oqV7PZyNa0OjoVHnIymP8DQ8ho1gXqJnaWxw==
X-Received: by 2002:a63:4b5f:0:b0:43c:428d:507c with SMTP id k31-20020a634b5f000000b0043c428d507cmr35302944pgl.607.1666777005946;
        Wed, 26 Oct 2022 02:36:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id bw6-20020a17090af60600b0020ad26fa65dsm813251pjb.56.2022.10.26.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 02:36:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     bagasdotme@gmail.com, git@vger.kernel.org
Subject: Re: Thanks
References: <84143b0c-139b-63c5-519f-8d4a44254976@gmail.com>
        <20221026043905.1654-1-mirth.hickford@gmail.com>
Date:   Wed, 26 Oct 2022 02:36:45 -0700
Message-ID: <xmqqeduvkjte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

>> > (first message using git send-email, hopefully I followed the instructions correctly)
>>
>> You messed up the thread (you broke it).
>
> Curious. The thread overview "5+ messages" at
> https://lore.kernel.org/git/20221025015116.4730-1-mirth.hickford@gmail.com/#related
> looks okay to me. I followed the git send-email instructions
> setting the In-Reply-To header. I changed the subject -- maybe
> that confused some clients? Thanks for the tips.

Your In-Reply-To: header looked OK to me.  Some webmail platforms
break the thread when Subject: is edited, but that is their bug.  As
long as you keep the In-Reply-To: chain correct, retitling the
message as necessary is indeed encouraged practice.

