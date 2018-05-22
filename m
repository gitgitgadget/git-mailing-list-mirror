Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E0C1F51C
	for <e@80x24.org>; Tue, 22 May 2018 13:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeEVNpk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 09:45:40 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:43945 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVNpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 09:45:40 -0400
Received: by mail-io0-f179.google.com with SMTP id t23-v6so18524018ioc.10
        for <git@vger.kernel.org>; Tue, 22 May 2018 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f3izkwGV/QbJp0hbGibkOh3o5xutauqWGTlNm/4bkQA=;
        b=RzFRZdRv1MJfCubHocM+7hVFqoU1FVXSWsDpUh8QkBlLCtTUGkGZNk1RVGdWvbS9QL
         FNJiU0yJcRnPuCudbFGFCw/sXXFh6UY2+WObD6G1Yi5Ax9pXsFMe0SXzaPRbG39Wjo4m
         1LXIzfQR77Id9vW5WHyPAjy7+MWBVNWKuZEW34B7CNERISu8ugaSpH8iqfdOE8m9nnGQ
         enZJRFJV6gVjT1188rKI5yPXUvzVU/DUkkXAM83BEt4LFoAzVkZ2uZCfvCP/wnBNCEBP
         kJWeXz8ZyUJhGy0R5tZCrfDhvSih5+V+mhSfK8w5++PLQ45S+pnccSvAUYPjt9sLYlol
         4WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f3izkwGV/QbJp0hbGibkOh3o5xutauqWGTlNm/4bkQA=;
        b=btCo3lIxJ35AczShkqi62OtqYNId3ZaOZpJZJfN1yJMQ1bXDpk97PhkdQIAgRsu6+A
         vt+V7F8d22q65Asp0jbhywNkZpPFBK6mYpXy+4RAhnyRtSf+CtEtD/ZXH0lpMT/lJUB5
         x/owE+aMod3f8krZEvkaFRodLAuQb5jcMJ6H0KvntCcLYWtCoJe7WB2ZGrMRsOoeWN/D
         uyg9dNWy6PThrjtgclH6ICBrQMgbsBiH/t5VVvM7V74Vnj1tUqph0/JPATgpPc8oGhPU
         WWh3emBeSsf/Y5kkW/jOx6kNU4k+HyhfMKKsak5+WGaY9N9xf/omzTMNAZPChhTfmNWK
         56ow==
X-Gm-Message-State: ALKqPwfeaAFY4FiRdXI05CO8X6MyeL1nXE9YgYjX3GbAAUMQ9HVQqBse
        0Qdx/Zxyr4mxLbqY91o4CrTk6eAMn1t/4KzQTdC4Tw==
X-Google-Smtp-Source: AB8JxZpvTO8MFGG4+OVoHJ6eMFoDYKNU0NAT2hWrRmOQfvMulaEhVnc3ryvoPeIjnO5oOIM60hQCh3fr4fSOtWflXaY=
X-Received: by 2002:a6b:9690:: with SMTP id y138-v6mr24203204iod.272.1526996739306;
 Tue, 22 May 2018 06:45:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Tue, 22 May 2018 06:45:38
 -0700 (PDT)
In-Reply-To: <CAGC=61KqsBa1dUqQSSyow5Qksgtspw-4yovkmKohny9SDM5ZMA@mail.gmail.com>
References: <CAGC=61KqsBa1dUqQSSyow5Qksgtspw-4yovkmKohny9SDM5ZMA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 May 2018 15:45:38 +0200
Message-ID: <CAP8UFD0MDwtTmE=VUcUrGUzryJPLpBsUqeHgun3PwJHU1f2Tiw@mail.gmail.com>
Subject: Re: user name
To:     dpowless517@pobox.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 3:06 PM, Dennis Powless <claven123@gmail.com> wrote:
> Is it customary to use your real name or a user name when registering to GIT?

I guess you are talking about using `git config --global user.name
"XXX YYY"`. (Though maybe you are talking about github.com
registration, but in this case you should not have sent this request
to this mailing list.)

When you use git config as described above, this is not a real
registration. You just configure Git on your machine (only your
~/.gitconfig is changed), so that Git knows what to put in the
"author" field of the commits you create.

You are free to use whatever you want but some projects might ask
contributors to put their real name in the author fields of the
commits (and sometimes in other places too, like in the
"Signed-off-by" in the commit messages).
