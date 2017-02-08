Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C7B1FD6A
	for <e@80x24.org>; Wed,  8 Feb 2017 10:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdBHKHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 05:07:10 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34434 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbdBHKHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 05:07:09 -0500
Received: by mail-lf0-f43.google.com with SMTP id v186so78959354lfa.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e2A3RlRrFoEkO6Tl4TBtygmyW7UOTGEXM6FZFNyhEdg=;
        b=QXcWha3OkG4jO+cyzATqtAb28bfog1DK4WJeHecO9YLGtnmetfW2yM32yvQgKi59JB
         h3OxgqjKwEtOnJho52Gc8Oyx0gGG2nPjAVf3WqSX2tN1T6ZW7V8zOcY2BB+sQiilAElj
         M8rlb/vFniJTMBQHZIOtuRDjbtdIuBo/VlGA/w+k2TASq+oa7lwOVySXjDX6Tzfuqc7B
         y+GEkPzHXMTkboYilBc79dMNBtKfWIYr+nUfvuV90pi94I2ybetc/Fu/+PcXQp/T0EIy
         xOu7A0F/NBENOSZ3pASv0B7bZO8E3ZZ4LUynHKuMSfWpDTtGJ9xWEoBTt2bjhcwxMVNR
         nx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e2A3RlRrFoEkO6Tl4TBtygmyW7UOTGEXM6FZFNyhEdg=;
        b=p2sySPn2fiWz5G4VZCW55QoNq9nMdAGMsZupYjWwaQwqv0KTXgyDoBVljhYISS5y1y
         gh/gzu0g0GkKbqbfOe03btyIwExDr7qfamzZidWtic3AzAZb17vJnI1YOYk4YdvMXkbF
         omMpZi6/POTqGrEC64JP+8bEohvv8sRtIbqRq0rFdNwLE9VavqNg+Gd1ztwZpd6QjaCO
         8l21aVCsUpwvKnFQbKvSHdU3LpY1at9HrCsXfBWlrFfj5bdxJXWD68y7XvafH53M32WE
         FsHmU3YLOtIRy/5Tbh4MI9du67VXPQ+OdNLuIj9SPOJwJqRsF9kWqRRD5+tAq6QwSxE7
         S2yQ==
X-Gm-Message-State: AIkVDXJCyX+nonREx4w/GoCLTm2mXgisj9zK4uwGoHfJtQ3es0CTtmHRYZKXVREXjULkUP05G6rlm+S0T5eEcA==
X-Received: by 10.46.69.7 with SMTP id s7mr7946793lja.44.1486548426053; Wed,
 08 Feb 2017 02:07:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Wed, 8 Feb 2017 02:07:05 -0800 (PST)
In-Reply-To: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
References: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 8 Feb 2017 11:07:05 +0100
Message-ID: <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com>
Subject: Re: Non-zero exit code without error
To:     Serdar Sahin <serdar@peakgames.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 7, 2017 at 12:27 PM, Serdar Sahin <serdar@peakgames.net> wrote:
> Hi,
>
> When we execute the following lines, the exit code is 1, but it is
> unclear what is the reason of this exit code. Do you have any idea?
>
> git clone --mirror --depth 50 --no-single-branch
> git@github.hede.com:Casual/hodo-server.git

First, could you tell us the git version you are using on the client
and on the server, and if this a new problem with newer versions?
Also is the repos accessible publicly or is it possible to reproduce
on another repo?
And what happens using other protocols like HTTP/S?

> Cloning into bare repository 'hodo-server.git'...
> remote: Counting objects: 3371, done.
> remote: Compressing objects: 100% (1219/1219), done.
> remote: Total 3371 (delta 2344), reused 2971 (delta 2098), pack-reused 0
> Receiving objects: 100% (3371/3371), 56.77 MiB | 2.18 MiB/s, done.
> Resolving deltas: 100% (2344/2344), done.
>
> echo $?
> 0
>
> cd hodo-server.git/
>
> GIT_CURL_VERBOSE=1 GIT_TRACE=1  git fetch --depth 50 origin
> cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee
> 14:12:35.215889 git.c:350               trace: built-in: git 'fetch'
> '--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'
> 14:12:35.217273 run-command.c:336       trace: run_command: 'ssh'
> 'git@github.hede.com' 'git-upload-pack '\''Casual/hodo-server.git'\'''
> 14:12:37.301122 run-command.c:336       trace: run_command: 'gc' '--auto'
> 14:12:37.301866 exec_cmd.c:189          trace: exec: 'git' 'gc' '--auto'
> 14:12:37.304473 git.c:350               trace: built-in: git 'gc' '--auto'
>
> echo $?
> 1

What happens if you just run 'git gc --auto' after that?
