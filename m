Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256031F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBKUbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:31:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42080 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKUbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:31:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id l7-v6so189239ljg.9
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pD4Fh+4H4eqZgrpke1ILmmHUQn92uYkvbBzQrmLvoyc=;
        b=DQJgkDRLU2cKjMFZ8oIl/Qq5byBfNJKQL9qeu3Jbijl7HTMt+Gxbz/KNDmENzYw1Bk
         I07bx8NCJ5FcGl/f2tM+UeoIZwv3SMgH8/SkVxtl/ngKl+qLwfvM8CE5vi6RTakfsnUY
         rhAU2fiE0XKTDxD+js0LLs3UVezVEZUzNWvYibbMW7wUuvVoNexpST2J569iReNPcIV1
         UlPkn24sbLl4X+U2D6HORsWDQFefsFcZ8xq7OeaijP4xsmDvImmzaljCDC06+V7BjeMh
         Eo//e6naGukiR99uu2thYquLOrqgWnXe9wt2VNmSw+CZiRkMNHSv0yerS3HNsMRAc2Bw
         fTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD4Fh+4H4eqZgrpke1ILmmHUQn92uYkvbBzQrmLvoyc=;
        b=QmLKEtupbfI2xlLg6gS3XtYnL3+0Ht0w+9iAm8wacrbmlMaaG1jqz8sJLWi607vvaJ
         9TzkrGSiwGHfb8Uytea6qA/kUzdbwW4Ws8qGrG3nHdOZ596rymNt7Dwk1CEEm4nsqyla
         NFJ9R0wImlMD4h+BC6BZ18EW2O2TCjP5L1fsliPi4IzhrLudGXqbpT0QeiUA7aTIvHuV
         XCv2MFwzpa0Z1hO5LAkAU80QhILn2J+jK5qn/v9u5d3wWIU+pk5vGsa4rW7jPHyH1Fii
         mjViRGKM4E4uI0mYB7NFlrwawrjdQ6GReQTwnCtJ05KNrpcAsdRDfBH8KbZmLTCOyWN4
         GH1g==
X-Gm-Message-State: AHQUAuYlw8BIOKBhxIM2hbBe/wwra0hqnX14IqbQOxsUx2OTQHwMI8EN
        1KJ/S3fFjkpQM9EM39QKMXjaL35HD1nWRS3glpk=
X-Google-Smtp-Source: AHgI3IY3u2TGVe7+6LSEpxiBtwhiMbDPbr9ZfdA5yTdYay2cjzzoATn5t3DfO28Dd8G6Il2nSnSkirD+IhRLMXV5lyo=
X-Received: by 2002:a2e:9f49:: with SMTP id v9mr27015ljk.77.1549917105917;
 Mon, 11 Feb 2019 12:31:45 -0800 (PST)
MIME-Version: 1.0
References: <1549834867.5977.4.camel@libero.it>
In-Reply-To: <1549834867.5977.4.camel@libero.it>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Mon, 11 Feb 2019 16:31:35 -0400
Message-ID: <CAETBDP4TqVas3dUajQLY8bfcs+NrDqJP83uWT4ft_w8OiPr7tg@mail.gmail.com>
Subject: Re: Am a newby and I cannot compile git!!!!
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the community!

Here are some documents that can help you get started:
- INSTALL
- Documentation/CodingGuidelines
- Documentation/howto/maintain-git.txt
- t/README
- Documentation/SubmittingPatches

On Sun, 10 Feb 2019 at 17:52, Fabio Aiuto <polinice83@libero.it> wrote:
>
> Hallo to the whole git community,
> I'm Fabio and I'm approaching the open source world. I'd like to join
> somehow the git experience so I cloned the whole  git repository of git
> itself on my machine. Could yu give me some useful hints to start
> following you in developing/maintaining this technology? A nice hello
> to you :-)
> Fabio.

Brandon
