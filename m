Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5149020C11
	for <e@80x24.org>; Wed,  6 Dec 2017 14:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdLFOgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 09:36:38 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:38066 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdLFOgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 09:36:21 -0500
Received: by mail-io0-f170.google.com with SMTP id d14so2859223ioc.5
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZyjpD6uCKbJXvDHu3LiX8j2XtsRLZdJnfpHaaCGBGHs=;
        b=Ycj2iYt1XZ3fe9TuT0A9V8amQ8DWW8pUo7phcf9QfB0X91ZvO78vlbR/LBy30NXyOW
         EyFKPxJc2u/OsmZLgE2m6pEbEH42dujn62Vkyit/dTrvYn6st34lyruxamr2LR7eaIPB
         CwJv81vg8EewjGrq2K3Oa09I3r70bhgdxQrxN3eT9kK1jQ9JDz91TPbVzbewVwZnKUqj
         dfAhg4oCU4ib1kOoEq8ZN/75DkFKXo4JyiQ9MeGaSVlWpS6+zaiKLEul+8SLtfpe+XHo
         lJzUK4eNsPv78FsccYks5M2W4l2ER/JQowmrLxzLEIRpb5hHqTuXVJrzNeiNWdnga+Vj
         PPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZyjpD6uCKbJXvDHu3LiX8j2XtsRLZdJnfpHaaCGBGHs=;
        b=LM8XC+Nyp4S67TCNWxc7mcNUgtdCQdUmXw6r7hfq1WuaByKkCcmZk7EY4TnIt5/9xO
         v8Zbk0TpHlcI7X5PYdJS5PEKXdPg0MyIg4+FVaQvLcjTNKzcLyNrEehesn3eHknMDicW
         ud9qEiw7tKEIYB0WTdcFcUZkf1tXZPg7ReZDAIj9fi52iO1MFvamZunc4YqA7MHGPxtY
         24VeXdxPtdCOoOQpzfAZqgCWPKxFvWmo6TG13tI5W91xK7LFHqbWx1Y+F9xSncTTw/vb
         taGxxQABuP2Z7Ggne1/3xKVdR1EzccPNVT6gqVykP6EZxpq+IKnbz3CpOY17k73uQnC5
         6+Mg==
X-Gm-Message-State: AJaThX7ePlkGWES472dT4Sm6PzXsHnfURc9x88gr6n+nCqQ9VdkqJcSB
        hHwjjRrZN8PKAwVulMHP+pm/CNbAc9HgJ2/BydI=
X-Google-Smtp-Source: AGs4zMZq1TDBoz6SlUzzipYha06IYD3eJ2jjXMRYMlJ0Q+E7Lcj2uKQw0e3tV5W4IrpudANOobE4IyFR9HBUfZoDr2Q=
X-Received: by 10.107.183.76 with SMTP id h73mr33783337iof.154.1512570980313;
 Wed, 06 Dec 2017 06:36:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Wed, 6 Dec 2017 06:35:58 -0800 (PST)
In-Reply-To: <CADbksagO806a=nJpQ-uUe83Ne=NdM6TvKBRu=a7OO_MzTRi68Q@mail.gmail.com>
References: <CADbksagO806a=nJpQ-uUe83Ne=NdM6TvKBRu=a7OO_MzTRi68Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 6 Dec 2017 15:35:58 +0100
Message-ID: <CACBZZX5G0Z9Tr3W63en_8SsoDOzTvBrKRktcOuMswwZVrmfatw@mail.gmail.com>
Subject: Re: Git Repository Migration
To:     Saurabh Dixit <isaurabhdixit@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 3:02 PM, Saurabh Dixit <isaurabhdixit@gmail.com> wrote:
> Hi,
>
> I am new here. I just wondered if the Merge Requests (aka., Pull
> Requests on GitHub) are also imported or cloned while
> cloning/importing a Git repository, say from GitHub to BitBucket.
> While I consider that, it may not be possible because of the URL to a
> remote is already set and cannot be altered while the Import/Clone ( I
> could be wrong at the assumption); I am curious to know what actually
> goes behind the scene.

For Github in particular you can check out the pull refs and push them
to your new hosting provider:
https://help.github.com/articles/checking-out-pull-requests-locally/

But that's just the refs, you won't get any of the discussion around
the pull requests or other "issues" etc.
