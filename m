Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FC71F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI1Bla (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:41:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41625 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeI1Bla (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:41:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so2575442pfi.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkKOXk+l5Bvl+VFr1eqttXU5azV71VbY+yZlnVxWgaY=;
        b=KxFu3aS2KCeAi2HAO1zkTbB8h85wRSU/wUGKOSG6UP/Xf0BniV16xXtZa0A668d9BF
         kAIeGYvdeq+t/AEQ23/656ZpRFjkF6HUdIgNeAKCaZRtrT7g0rYWOUPyp59ianPo4ZhO
         MvVa3bJcII+ep9sIGrpw9ZEl5p8O09+jyCYo2vU23hzVhrKFwjOIBJNE046TJ/gWuJEW
         P6x1yeC1m3/O6gdXDZvsz05GLVMQiUrUFXc6dydn5sLWkS1op41uU9E4/rOcUZHnBT5s
         GYl3eTxK9jy+ITIDmcNX5OtZpnGoKe1Vd5P3TwVVKtJUM5XBUj9yNVLORfFY8cSMF88q
         dScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkKOXk+l5Bvl+VFr1eqttXU5azV71VbY+yZlnVxWgaY=;
        b=XY16xFMMrujtvoAo+mVCaBMBMybiY6C2vhWfQxa1xuv3M/t40RjyYPyx9FC1WzDy/j
         2VUAtnT0nigmlifDVoLermvk3eybxSBXYVl01cDw2rTNEKloHNKG6BjyY3FXSQeFCmxs
         1nTE6hViSBMunsHM45shr7xryFyF2ojl4JtIBZq5GNRbxQPm1j4x5okivGQxOUDx3BPi
         c7rvR7cl8+XWNucyMcmVfIiEbnGT50yRLhxBBxQWB5//n5amAu7jlKOnormQwUIyQ2J/
         R2qcTB74UTgIryB21nhVtkAB77qo7bvK/UKQWol2EN5KflGb5P8LysqPESK7GipE71Cp
         ilMw==
X-Gm-Message-State: ABuFfojlOHWTrvM4Zt1oYn3VpOpMQbWJsCmIGhG8gyTFYE6KmU5T39C3
        RJjwklfl2YYeSmxw7qtgjEJp9jvQ03KxtyH2QYVLzxI9
X-Google-Smtp-Source: ACcGV63Q09PGCdp+fRvaCYlCmNKkx0jZkGtYzm0bKEAOFuGOuB5hCsEwsTag+b2v7W6h2FpZUpGOlv40bdJCqHh3Qaw=
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr12573649plp.130.1538076103421;
 Thu, 27 Sep 2018 12:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com>
 <cover.1538075326.git.martin.agren@gmail.com> <31d467b9-1ffd-5c1d-2ff2-f4cb76854f0a@gmail.com>
In-Reply-To: <31d467b9-1ffd-5c1d-2ff2-f4cb76854f0a@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 27 Sep 2018 21:21:31 +0200
Message-ID: <CAN0heSpih+eMrbar29q6g7-aHD8SmufZvDTe97Me2hF6CJb3Qg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git-commit-graph.txt: various cleanups
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick

On Thu, 27 Sep 2018 at 21:16, Derrick Stolee <stolee@gmail.com> wrote:
> Thanks! This version satisfies my concerns and looks good to me.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks for the spectacularly snappy review. I don't expect commit graphs
to help my use cases a lot, but I still wanted to try them out a little
and stumbled on the `*` lists. Thanks for doing this work!

Martin
