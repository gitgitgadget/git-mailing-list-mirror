Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2532207F8
	for <e@80x24.org>; Sat,  6 May 2017 21:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdEFVKp (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 17:10:45 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35757 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdEFVKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 17:10:44 -0400
Received: by mail-it0-f43.google.com with SMTP id c15so47821430ith.0
        for <git@vger.kernel.org>; Sat, 06 May 2017 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Na411SfZgG3KKbP70wya+o9H/pJz0jNYtGNMT7gaw9g=;
        b=jX+QY0Grxus0jZTOYyxk5lXzbeZXdsRm4EkBBnaVqOa7Zs79U4cxZKVWqhifwhCiG/
         laFAqZsuIc4TqJm6lUnZH2E/ezUVXSXSwgeHdPFpHobDzetuExORRQO2HI43CUtyr/8m
         xi+6umg3jrGHHMTEzLgBH4hLnPAPNaurrEhrvxhHSsaqvXLb2d2NdefcMgQ9tq4VNx7+
         rUCIn11EbceVNiC69FP8jRTbNf2kwvM45vJph0ZL+UdYLduFE3k6KJbiHE1IythUR0gZ
         HnI95wXS57kY09KcwpyW4cXptBLMGPwKVg1g68nTlEtiWJnUfIey/3tFKXqfFthKNmCN
         Hruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Na411SfZgG3KKbP70wya+o9H/pJz0jNYtGNMT7gaw9g=;
        b=R+fBUuakesfJZsNmnRoB/veTR1NGmPTd2bVRBFxWwhkFBiucS9o6w3aUTpVFjYE+J0
         6HAbJhcrI96awjjSxBDRsNOcicyihJSAS23dZjXLBA6APBlwA9g+Kp4+4MNI2xuDaVrj
         7NG4/i5c/j+zg3v4B8qZ2bTJYbbMqo0a/2H9LEPx09kjHkTIJ0zexf+QnV9/gIOpxD+k
         SCUKzNte4oz3LbUnB3yem2Odl1rwMaySR/su5tR97PKmr9CCCz7Z82heKrVkkWt60upx
         hs9cP3AeFvqH4p3a58dYTJ7lBhBHuCC5pOkWBrloQ78PEpDu+KESIqiOp0edjswcc8+I
         oH1A==
X-Gm-Message-State: AN3rC/6eC3jPHDmjx2yCv3Q8ThmWk+VYLGyrEd3lC0wdQJnFWcx/ISX+
        Bpy9ffKqhnmqiHtNzcDXwwBWofIrA/4Zh3A=
X-Received: by 10.36.46.193 with SMTP id i184mr15562014ita.51.1494105043423;
 Sat, 06 May 2017 14:10:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Sat, 6 May 2017 14:10:02 -0700 (PDT)
In-Reply-To: <20170506205041.GA26189@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com> <20170506205041.GA26189@starla>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 6 May 2017 16:10:02 -0500
Message-ID: <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
Subject: Re: vger not relaying some of Junio's messages today?
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 3:50 PM, Eric Wong <e@80x24.org> wrote:
> (I have no idea what Jonathan Tirado wrote; it was encrypted (but
>  sent to a public list).
>
> Samuel Lijin <sxlijin@gmail.com> wrote:
>> Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:
>
> Hi Samuel, check your Spam box (and move it to a normal inbox so
> they can train it).  Gmail filters are known to trigger happy
> and incorrectly flag messages.  It's been a problem on LKML,
> too.

Sorry, should've been clearer - I did check my spambox in my original
message. Some old patches from Brandon were in there, but the ones I
mentioned in my original message just seem to have been dropped.
