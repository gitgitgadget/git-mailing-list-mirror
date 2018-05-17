Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7781F406
	for <e@80x24.org>; Thu, 17 May 2018 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeEQNuq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 09:50:46 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33820 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeEQNup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 09:50:45 -0400
Received: by mail-qk0-f169.google.com with SMTP id p186-v6so3641789qkd.1
        for <git@vger.kernel.org>; Thu, 17 May 2018 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bimXjet+D0LdNrHM23Xhpp4PRbCUQuBUtyAgiaX3loA=;
        b=f1yWOvdzYzbMyWPj+Z+qHeM3ovkvjV/aQXkLy4Rx9+jnSnkF9EEZFkumBhGoYNXRXW
         Zv+ByBYxyAYb0L4fsr/SoJ1trXZ19N/XpvrpXO8Z1Yd55WBJlx6uFpGBx+WmzYg/8szC
         BoCmMmGCU1GVW8+Pm+esHi549l3n3q3bvXlgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bimXjet+D0LdNrHM23Xhpp4PRbCUQuBUtyAgiaX3loA=;
        b=Gbb7aY1WW4h2YSKKgdCu3eoDd1injwL3mtmhGHhDEaGlgX/BesONOUnyehB3XHuHeM
         2adT5cTDjuolRDdCZyzgRydFit/HRg5cKUNXkqPLs4J3HMJS1yNkLiEW8sz3lI70FFre
         DU6fua65GSrdJojGV5BPxpms7HPz2WkXcG55dKs0EfcoqQkxIRNfzx4X6UBvdQbgkg5I
         11ZGnEljduVRrFy8cJlw/+CltGfZJNlqzzfk9NPfLz35X/FJ1QlCAGytgJIwKTjNvjq4
         QkUHLrGIaiZV7uC1fT7zWQvuQCdG4XLO734dux/LNAwgyKLlEv+3K6IqAio6cyLlQ6zm
         59EA==
X-Gm-Message-State: ALKqPweMeeCnuF/MZaHmkHDhRrum5TkjsFbe745T/4ake8QEc9J/B8dN
        HRGx03LXVwvWtPfOyKupdqnEDA==
X-Google-Smtp-Source: AB8JxZomOoZ89zgdxhJYClJQJk/fMnXC5scPbhrb3eatZy5wKupJlQkV1ugGy8M/pDiluWZqVsL+gg==
X-Received: by 2002:ae9:e64d:: with SMTP id x13-v6mr4921838qkl.232.1526565044667;
        Thu, 17 May 2018 06:50:44 -0700 (PDT)
Received: from chatter (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id 1-v6sm4190457qkw.12.2018.05.17.06.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 06:50:44 -0700 (PDT)
Date:   Thu, 17 May 2018 09:50:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Michal Sapozhnikov <michals@luminati.io>
Cc:     git@vger.kernel.org
Subject: Re: Generate more revenue from Git
Message-ID: <20180517135041.GA31810@chatter>
References: <c3a424c5-bc14-00e1-af7f-a74200951edf@luminati.io>
 <1524395775112-86a2bc81-14696dc9-89400ff8@luminati.io>
 <68d50093-ad42-4c37-182a-14c22a47f6b4@luminati.io>
 <1525935691167-07938f49-061f4138-3ce36d79@luminati.io>
 <44bf86cc-81b2-d15c-9ea3-794f15ac637e@luminati.io>
 <1526555270407-d8096c1e-5bca1514-fc88d714@luminati.io>
 <c637ff90-4bbf-ba5f-0014-d78980d7aa22@luminati.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <c637ff90-4bbf-ba5f-0014-d78980d7aa22@luminati.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal:

This is strictly a development list. If you would like to discuss any
and all monetization features, please feel free to reach out to me via
email.

Regards,
-K

On Thu, May 17, 2018 at 04:45:18PM +0300, Michal Sapozhnikov wrote:
>Hi,
>
>I would like to schedule a quick call this week.
>
>What's the best way to schedule a 15 minute call?
>
>Thanks,
>-- 
>Michal Sapozhnikov | Business Manager, Luminati SDK | +972-50-2826778 | Skype:
>live:michals_43
>http://luminati.io/sdk
>
>On 10-May-18 14:04, 7d (by eremind) wrote:
>>
>> Hi,
>>
>> I am writing with the hope of talking to the appropriate person who handles
>> the
>> app's monetization.
>> If it makes sense to have a call, let me know how your schedule looks.
>>
>> Best Regards,
>>
