Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D357F202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdJBK06 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:26:58 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44707 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBK06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:26:58 -0400
Received: by mail-pf0-f174.google.com with SMTP id t62so1517766pfd.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2uxl/B7pDay9Ywzj+wshUD8YP7t0DG+puPBqahxofQE=;
        b=cTpwgba6uEh3Pdr8HPlDSb4DPhEppk7pao6OUCssY3Mm7jpFyo0N3hKj2FwxzeM/4P
         iV7qyzmdJnWQTXiLvJQlXPEEb4FLvnVhcOvXpik303UsA4g6yWuZ2f0RIVE/IukgZxZB
         WM471KbZqM9Psa+GtVWYrOzrpxAdtWk6zVrzKOjZn0A2IHOcWWGgxE7HTNthNQAHs+Xp
         4ufddnTnx1VAkiGo7SI3omwermhzcvaZGShhx45ohK6ole1xmbe7NTflSHXLhuUNLoUG
         6vBRualAPtdCOIfsBKG407Km22VLGq/WU2DPlNja9o4YayL34oHZr3I+VD8cyrwqVOtD
         g6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2uxl/B7pDay9Ywzj+wshUD8YP7t0DG+puPBqahxofQE=;
        b=eTkkRGHbnSSN3IK57z7UUDXSG+7oXvIW0w0nCSjrfoVh7oefuhwSLnt/BfSThZsrxz
         VnxHAkIMZD0Nu06+ME+Uh3Xqx4lkYFo4uixGdemiQZU4jsO4h9TyUMYXvXp2ne1pIAA5
         zXvL7/VXo1btIxtNwmubn+WW5bbLdbsjCWZ28er7sZ5QPPdYQ2Ei+/GcrQpmUoDL71IX
         xABIUlHk+o59qZJ3adlAvhy12NiAcOvLsSokl+PrJXEXKPHWYajxHKsW2mZbtrZ7c5Bx
         UxA9irabGmGtukww3P59xLtSjtsyGprMcUuWckRp6ic8g+Q6/OCeeGZnOQsV4nF9H8xu
         UqJA==
X-Gm-Message-State: AMCzsaWLqXDHnQTrnuu1qao+ie5feorO3rpn8tbEmJHrXgJ/UbNTFlLI
        jkFuFTs8Z61qEi9PHLHBJlDYmRfreauoDq22M7RatN82
X-Google-Smtp-Source: AOwi7QCu6v4ft4fneuhDaQxK83s8Dy/yhakxn3hglnXAL9BUyegavoRNonLjbGq/AfpNOQx8XHxH2fLtEZDxBnHLxvg=
X-Received: by 10.99.108.7 with SMTP id h7mr3943354pgc.362.1506940017692; Mon,
 02 Oct 2017 03:26:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Mon, 2 Oct 2017 03:26:57 -0700 (PDT)
In-Reply-To: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 12:26:57 +0200
Message-ID: <CAN0heSqqKZeNQ0Je5RgmKXm2poTyfw7cCJiTYweOtOwMHqncgA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 September 2017 at 06:34, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sd/branch-copy (2017-09-24) 4 commits
>   (merged to 'next' on 2017-09-28 at a6eceefa02)
>  + branch: fix "copy" to never touch HEAD
>  + branch: add a --copy (-c) option to go with --move (-m)
>  + branch: add test for -m renaming multiple config sections
>  + config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.

s/and switch to //, I believe, after your finishing patch.
