Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3231120248
	for <e@80x24.org>; Sat,  2 Mar 2019 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCBQVp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 11:21:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40586 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfCBQVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 11:21:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so412953pfo.7
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mn1jeyaOY5moEm6h1/nBSnpU8aHzA7fysrRL0iPP/+8=;
        b=FJOVLTLk0YGExz2GL/CRJiPsZNLBUvX/PDE2wNzzOxhC7tVHLdjgwkwShey2IWWONs
         3X+gEnGxWfZ15nY3cyqZ5yDOye96uZTaMeeWkiGOjONOFmWighFVdBo+/VpwGIB1J7zr
         8qhDHMARxf2QbPGvveEDzr3gMgGkW4F0lOpBZHHVLFqKqO8YxBe+wTnMAATHHbR8dON/
         uMYcswulsx+r7Z2LPnaF8UfDJL5CCvTV/VVz3MEvU8m4AD063OsFRNA44x3UEBKXFPU5
         rMDd0XUzsrpwNtEXCR1+GVqPElit8yNRfiH1QHbGFKEw7sPEGBJ2uSZ55p6XB8uBDCZG
         gq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mn1jeyaOY5moEm6h1/nBSnpU8aHzA7fysrRL0iPP/+8=;
        b=ZXSFYyGWuH3JuN4SgEcHxF1wNECTAyTAACQNQlsgNptlaEkHCkOkqd6o+bNFuOCzyI
         DAYVN5CCo+4IkGn8hagkB0vlvl0Dc5VYsiTbHx9ltzHJBH69/0VxXCyu3EVjQnn8pH/y
         YZLRHlVOAaerIW1hd/rtSjXEwg3CHrLkeS5t+cdaM9ylYWw6NL4HzfhIawdjP1w+uPMp
         ydTaxR42YPvZlXwAi+XLP01LLipY/V2jwbJGGmPWUcPSAUszmEzI6lXEQMsDQknJHl6/
         OgdvHCGzwXzr5ykhCQ1wPZXo/hMuGwxfBI/eItTAInrcdAZoWcObYuh9Q9L865cZQSan
         kUpw==
X-Gm-Message-State: AHQUAuYIJU/KeQypOtDQqzPy5uErE8gmcB1muHu4s5H8yTJJZ5i8Hd/8
        jK65/0rBBMfyeOcsUosSxrQ=
X-Google-Smtp-Source: AHgI3IbQvg6JDIRXlo+Yt6kzckmET/ceNv+S3K+pvWlyRT3hpoJAjkRcy7rppmM3tcRZkP8fJzcWyA==
X-Received: by 2002:a62:1342:: with SMTP id b63mr11308522pfj.7.1551543704515;
        Sat, 02 Mar 2019 08:21:44 -0800 (PST)
Received: from ar135.iitr.local ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id p86sm4276181pfa.104.2019.03.02.08.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 08:21:43 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     t.gummerer@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@matthieu-moy.fr,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        pclouds@gmail.com, peff@peff.net, rohit.ashiwal265@gmail.com,
        szeder.dev@gmail.com
Subject: [GSoC] Thanking
Date:   Sat,  2 Mar 2019 21:51:09 +0530
Message-Id: <20190302162109.11172-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190302144647.GT6085@hank.intra.tgummerer.com>
References: <20190302144647.GT6085@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey! Thomas

Thank you for replying over my woes.

>
> It is up to you how far you would like to go with this.  If you want
> to add the helper, to make further cleanups in t3600, I think that
> would be a good thing to do (after double checking that it would be
> useful in other test files as well), and should be done in a separate
> patch.  Then you can use it in the same patch as using the helpers for
> "test -f" etc.
>

I guess I should work on this one first. I checked and around 18 test
files use `test -s`, it will be useful nonetheless.

>
> Yes, I think it would be good to make those changes, to try and get
> this merged.  Having the microproject merged is not a requirement (its
> main purpose is to see how students communicate on the mailing list,
> and to get them familiar with the workflow ahead of GSoC), but it can
> be a nice achievement in itself.
>

Yes, it is a nice experience to interact with people who "run" git over
which most of the open source community depends for code sharing and
collaboration.

>
> That said, I would also encourage you to start thinking about a
> project proposal, as that is another important part that should be
> done for the application.
>

That is really encouraging, I'll try to finish my work as soon as
possible and work on the proposal side by side!

Thanks
Rohit

