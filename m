Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3552023D
	for <e@80x24.org>; Wed, 17 May 2017 04:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdEQE2H (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 00:28:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34971 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbdEQE2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 00:28:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so155639qtb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BU8ppCKjK0NM65htHh8qtMdgT1NRm9eqmmGXAXVnEOE=;
        b=lKQ8lLsZm5e5JvZpeJ6iOQ20llxebfhQygSYczkE6BvghEfSE6ZLMYo9d3YBjP547V
         8/THOHLXJmrN+g1LE+fit1UvEXrVP5VIJoUFit6SylNkYSi3XlnV+lfn9zZtlt18vhcp
         6z9RSWoaA6lKNr+zJqott8ASugzmawoiGkksO5j7A8iVl7t9JEvj5Fl7sIoe/Mi2yWbh
         nHzNIXPy1GKhFC6WTVRopqU4NejiPZxQUkma5wp3NbteBGBgWycSOgA7lqqiS+KgjGgn
         Xp3qOKmdkf9uco/nPpJgT/eeHwCp3SUcB2UWt3SxagF0EUHWZ8/cI1N3ZugPKPq4fMcS
         SFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BU8ppCKjK0NM65htHh8qtMdgT1NRm9eqmmGXAXVnEOE=;
        b=Xow3qV26D7Fy0dFwQZ6US3Nhs+TQfm6JmSYs/IS3uaQuaOaHpYvfAbfg3xzm+j8lsE
         mJtfBooxcndmuiM+EurmulgpVpTtQ13hixSw0cHXuPENdS7wNpfxvJgtc3Cq02ozl+pL
         tokE7vDJJDpCzehc3Fy9EMhclYLSfnADXSiBG7C8NGdM8IaelgLhZ6uw/uzos9BQ3rdJ
         cf7nD+Z3Xj3wUvSO5ni+pHvMf0RdKp5by2m2rRtjp40zgC9BCU+X8PWMNvcwJjpLfii1
         rOxSURavUF01XiKAgv8TVKybRfrIVkBMCI8b98F2DDol9kgijlduRD5C4Ln9Rui+b/U0
         oYTw==
X-Gm-Message-State: AODbwcB0xntcW/RUSVMxhVQiiFcr9VmH10eIhqcnSb9tpra1LtjFHyQJ
        rWd6VKxOIN71EA==
X-Received: by 10.237.36.3 with SMTP id r3mr1303114qtc.200.1494995284237;
        Tue, 16 May 2017 21:28:04 -0700 (PDT)
Received: from Matthews-MacBook-Pro.local (146-115-162-193.c3-0.wth-ubr1.sbo-wth.ma.cable.rcn.com. [146.115.162.193])
        by smtp.gmail.com with ESMTPSA id q200sm620635qke.64.2017.05.16.21.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 21:28:03 -0700 (PDT)
Subject: Re: [fixed] error using `git mergetool --tool=meld`
To:     Samuel Lijin <sxlijin@gmail.com>, davvid@gmail.com
References: <dbbf2f82-8ef3-2411-d51f-63f94ba7e77a@gmail.com>
 <CAJZjrdUXoa8EXYfFzHqn2yrUdidwdPSoEJ8_AFwwAX3ORr59UQ@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Matthew Groth <mgroth49@gmail.com>
Message-ID: <449621d5-c645-c9e4-afc1-ad2a1226970e@gmail.com>
Date:   Wed, 17 May 2017 00:28:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZjrdUXoa8EXYfFzHqn2yrUdidwdPSoEJ8_AFwwAX3ORr59UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



I'm on Meld 3.16.0, OSX 10.12.4, git 2.12.2 and haven't changed any git 
or meld code. Let me know when its fixed so I can turn hasOutput back 
on? Thanks and good luck.

On 5/16/17 9:05 PM, Samuel Lijin wrote:
> On Tue, May 16, 2017 at 5:55 PM, Matthew Groth <mgroth49@gmail.com> wrote:
>> I needed to use `git config mergetool.meld.hasOutput false`
>
> Hm, that's interesting - the source code snippet you quoted from meld
> implies it supports --output. What version of meld do you have?
>
> David Aguilar seems to be the one who's contributed most of the meld
> code, perhaps he might have an idea about why this is happening.
>
