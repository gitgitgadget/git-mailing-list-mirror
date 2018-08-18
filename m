Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB9F1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHROwM (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 10:52:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42304 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROwL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 10:52:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so5875082edp.9
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nyb1GTNj5mKY9ejkmE3YhbfMmOeyJ4WkjWoLmdoax3A=;
        b=rkFcvkVwxFse95pqYewvIsV87Fao7mG2udOS1SyZnYvimHH8oQaN+g4gXMS+iUGj4c
         joB7HO9eTfDJ2DI3u8FO2IwXV0Mk5uUOWhnS9dpBuhnd2rw86o9DUOJHlI5p1Z2NZCzj
         NZf8vAuEqZXzIWDUSZq3B6tY8xgNeXxqfw2rvPd1tF8obID+Q1fXzZpqNb33O/gj1bU6
         BWnALQTouPNbwB8ZrM5CvjqC31PaHXu9HjvGlbFkgfg5Exa0vOnXTZbbHceSw1EmK3P4
         8legMbwVrIzMX709FczMjfzNDvpFtqjx8GuPA6Kp2k2FaqjZ//JHiNMgnNFjYVB5U3/1
         RvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nyb1GTNj5mKY9ejkmE3YhbfMmOeyJ4WkjWoLmdoax3A=;
        b=bVQ4y9x1dm7nWyr4dfDgPZoavAuiD7RWOvLrZhi8XrTdLK6PVV7Yqg5ywFCOz8HMlj
         T+76jRwljNNliNwIE72kymwcpQt718aK9SNTxsuE3g6RmV7WPtlJbx7Exdkj/0gptVl6
         F0j7N4sC3WREOzUnuipD50hLEupZ3Rx2Egmwi9wupGPwXOQfjUcNjCyAv1+w+QD4qiPb
         edC/WPiCZsQt0/onTPUEGVotq0D0q8t50w7ldYZd/ddnbanrsazThSEVMXpxjVlMbwXF
         TuNELa1TkhXdW9/rFoImRC+5klRSiMD3vkddDZOPMGiaNgl7YD1Xg/EkVcCA60il0FY/
         Fu7w==
X-Gm-Message-State: AOUpUlG5JOwV7nbsGpGmxDMKUONFeIeByLwpAR4xFFgS3/yTSIAwVkhw
        oMXmM6eTUmdccxYQdJtBFlIochB1gJ5CvuNq9Qs=
X-Google-Smtp-Source: AA+uWPzc9xffX1U4jBvTo+P+AnrUmiuGRb65VdRvZGksU7gY8O7kvZXaAhZ984T/z7tVqZq0v7i/SSvlgwmF0blGy/w=
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr47070228edb.177.1534592687233;
 Sat, 18 Aug 2018 04:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2642:0:0:0:0 with HTTP; Sat, 18 Aug 2018 04:44:46
 -0700 (PDT)
In-Reply-To: <20180815194120.GK2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <47556d40a9944e8cc45ba3df8e12c80a1898b160.1533753605.git.ungureanupaulsebastian@gmail.com>
 <20180815194120.GK2734@hank.intra.tgummerer.com>
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Sat, 18 Aug 2018 14:44:46 +0300
Message-ID: <CADzBBBa+xCPNNyjpq43_CBEDETSmnLeeTF4ewkZ6C3tTkCzfCw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 09/26] stash: implement the "list" command in the builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 10:41 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Subject: stash: implement the "list" command in the builtin
>
> Nit: The previous commit messages all have the format "stash: convert
> <command> to builtin", maybe follow the same pattern here?

At first, the subject of the commit matched the pattern. I think I
changed it in order
to avoid any confusion with "list" as data structure. Now, I guess
that "stash:" at the
beginning of the commit message removes any doubt.
