Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F7E1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 00:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKBATn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 20:19:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34602 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKBATn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 20:19:43 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so12713397ion.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvBZpJa99UixJ77pqtmzczjReGntW5kHWcg0D7+h4NM=;
        b=dvgN3JRucy4OBCYNcB0dqZClYwUwktaulEDCP8q4qQWQPsQWkVYlA6c63N4yxAR42K
         Hf4moEjS54izNIoOkFQENLU5p6XLasO4uv9Z0YjKSp6r1cmfVvPYGfPl+XrFaf1fWMnI
         rUHzgCQFthqEEdG15EPDoReGBPz1rx9wMnG5eOSlWVtmwrOyGpfnFtp+ZMpEsCt4XdaZ
         c2La0JeyznAPKQT0ir5vM1hCmZtfSSMpJmma+GHbg55Q8p+s8PkG4ptq53cq+8uq5tWY
         SLXZ3vq7o64B3XiBAfhssazXoINYafZVApjLB/D33mwsbyrpQp0NU9knhkz2F8lFNciL
         oDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvBZpJa99UixJ77pqtmzczjReGntW5kHWcg0D7+h4NM=;
        b=cEGQ6Y3TorUm3mhqxQ8sn+6sx/VcfqTsCIhT+4xvcyL1N9QAd+yVWeoUki/pPwjn2J
         JbKh65Jrfl92pv1EgsfHaIW0dnlwd1vSX3+tQ94qngL/pB/4D8uvr98/e+yTQvuZ0AUY
         kTitFRUqTCWIezvQDDeuW/5qlQwlKNIWjjD4Icgc3RdHFV7QwTW5z8nf43cJHF0qiSew
         vgopU7UkUt+H8i40kC7i8EKtItjft935NIVTq1LZ9fFoTMSHE+OpdNORqh6cbGYHgb5D
         ePEtZVy0mSwdCyKW9282K2eYGB6jbuVOa9FTolkq0/TpbOx2rJztxtkcn3SfPXo5tx0V
         iBAQ==
X-Gm-Message-State: APjAAAXj4/te7S2wLMoxT8yRkgkgNamSYfZWkfFSCeYBDZzFI2ZN9JhR
        Z0mjDRRW0QwHJ259GNfFdGCWuJ6pCSoEj1iwUe842JcA9fo=
X-Google-Smtp-Source: APXvYqzBKC00ORn/wGpXKZbfr4bM6XuqaXeaWapoY5RJaqblILaKhK1fkH0GbYSlMJDP4AQI6d/AQXPwWAq17cSU+4s=
X-Received: by 2002:a5d:9747:: with SMTP id c7mr12708739ioo.274.1572653982220;
 Fri, 01 Nov 2019 17:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8kGLKqKyTsndWCfGm3feT8aROyasqZA6Yj9YySe6HQHzA@mail.gmail.com>
In-Reply-To: <CAH8yC8kGLKqKyTsndWCfGm3feT8aROyasqZA6Yj9YySe6HQHzA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 1 Nov 2019 17:19:31 -0700
Message-ID: <CAGyf7-HWkmKkUp5wikThZkbdLziYZtw_b8KY+nQDSxG7-bkkSg@mail.gmail.com>
Subject: Re: Unusual output on 'git pull' on Fedora 31 server
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 1, 2019 at 4:39 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> I upgrade a server today from F30 Server to F31 Server. The server
> hosts a Git-based project over SSH.
>
> Since the upgrade I've noticed the following on a Windows machine and
> Armbian machine. All the extra 'remote:' are actually on one line.
> There does not seem to be a eol in the output in the extra 'remote:".

It's a known issue in Git 2.22.1 and 2.23.0.
Some discussion:
http://public-inbox.org/git/20190822141928.GA3163@323642-phi-gmno-clahs/
Patch series cover letter:
http://public-inbox.org/git/20190916205412.8602-1-szeder.dev@gmail.com/

Hope this helps!
Bryan
