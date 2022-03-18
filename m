Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76553C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiCRQDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCRQDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:03:30 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106131903C6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:02:12 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id n16so6092686ile.11
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRMOwsEbjGUVbjt95nyQ6kvJleYvrJ7Y9Y+98d89Ba0=;
        b=1vHcvsxlSulGLaLu5u9Xo/qNws2JL6UquvgMM8DkkSH0HyrSbnA40bldWxdoWDkc9I
         n9JvwWgohr0bsExjyeqEIzQKK/KjEmgUrF68VklII4o3s1Zv4hEs+RpJDV9XGfc1MdGr
         oYoK5B3lmGKTj7ma3St8xeBqoxdr7M6mCepnwJelcpCTDxiA9jd3DRNCTXez8gEzd5k8
         9yBrFYUdSv3dxhVOe9dbvd1xd4aTbOLcGxJUonpQ6u4B9Nuo/zwbMcqYR9AKJbLoI9Ff
         cG11r3AKlQ3Wcfk4A5fUGHZRo2yEVgm0kggYWBI9df8R+rCsiRt1Mc8EcjIGHXQ4ObTx
         oj5A==
X-Gm-Message-State: AOAM533WYlSBy1JdaAIfRwto3SOhnDc8XCKcbOGXHUkAdI0d5jWuk+S2
        hmzJnHYarVqd2L9TwFFSMWbiz2A2pH0dZlKMqJ8=
X-Google-Smtp-Source: ABdhPJyqGui5ySOKdGYW6nr8OgFGE1r3dhnJbSYPOWLQO8hnfsjxkY5GLaysX50qY5I5u2YORQbMmwyPz5a5kZ5AYGw=
X-Received: by 2002:a05:6e02:1949:b0:2c2:5b61:80cd with SMTP id
 x9-20020a056e02194900b002c25b6180cdmr4799899ilu.152.1647619331285; Fri, 18
 Mar 2022 09:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn> <xmqqtubvc32q.fsf@gitster.g>
In-Reply-To: <xmqqtubvc32q.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 18 Mar 2022 17:01:36 +0100
Message-ID: <CA+JQ7M-2kRnHrTCErTOY5O=4PCbRc7DWOHt1q5DxXmCu6z7K1A@mail.gmail.com>
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 18, 2022 at 4:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps take "git jump" from contrib/ and do
>
>     $ GIT_EDITOR=vi git jump merge

This looks interesting. Thanks Junio
