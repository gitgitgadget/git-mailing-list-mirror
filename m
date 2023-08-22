Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A1EE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 16:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjHVQnj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Aug 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjHVQni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 12:43:38 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35ECC7
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 09:43:35 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1cc87405650so1424486fac.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 09:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722614; x=1693327414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAFS8TIKIUk7NtHOWFNjDPZwebcHm72R7FqQdcch49U=;
        b=lk2gXm7AgiYKwaHyjWk1yAtqXCRPQRrLmfHcBvEb1EOvv8JwxN4mQsQxp/ybikBN4M
         wGaFD9hqV4j66yToKxyqwi8vh5PQXqHjfhjKpJsYf2YIdO6kEWfC6ycI7HnlXBZNotFo
         QB3Nyp1LVXpWPt2HCurAympfnWWjAB3/Z40jzJvYJkW8+Ep54yzuTw25c6M4CH0xTFTQ
         I+IYVwtWHrchIbBqvNJM3lXvOJrFoFKuiRKWBSw8fkIYSz5C/av11gOTPtDZJv3c6Izn
         ITDYSSTJj4zbbhxkSQ0FTbp8+d7LP9onSb7gjv2xCxumLimNC6nGC79Wm6b+cs2cakDl
         29Ig==
X-Gm-Message-State: AOJu0Yx+PrvhTiyUMeLQ+1Q+047EIQQTgc2I2hGt3lYqQsLsh0/ZBnEM
        4Ju9qjp7j2HPWqRrUI10csDtRjaSeRUp8JoXz9I=
X-Google-Smtp-Source: AGHT+IElup3To8NAUBIUe3cgmNqZzPdDhKpgtzkJc5/rXgcJ3hz9DgI92g0zgowapLEpd9W2jwfbYrflGu9jIM/Pg3s=
X-Received: by 2002:a05:6871:5227:b0:1bf:5096:7dbb with SMTP id
 ht39-20020a056871522700b001bf50967dbbmr13506316oac.44.1692722614504; Tue, 22
 Aug 2023 09:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822150149.541ccb35@leda.eworm.net> <20230822130315.71259-1-list@eworm.de>
 <20230822130315.71259-2-list@eworm.de>
In-Reply-To: <20230822130315.71259-2-list@eworm.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Aug 2023 12:43:22 -0400
Message-ID: <CAPig+cTFrroZGo=KOXu0aCxeJvNz7eaHAK++HXELZ0ZheJhw9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] t/t6300: drop magic filtering
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Hesse <mail@eworm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 9:03 AM Christian Hesse <list@eworm.de> wrote:
> Now that we ran a trustdb check forcibly it does no longer pullute the
> output. Filtering is no longer required...

s/pullute/pollute/

> Signed-off-by: Christian Hesse <mail@eworm.de>
