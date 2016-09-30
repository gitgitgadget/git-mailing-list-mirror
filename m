Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D9A207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 20:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbcI3UXb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 16:23:31 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34441 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcI3UXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 16:23:31 -0400
Received: by mail-pf0-f175.google.com with SMTP id u78so18121442pfa.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KgifhP4I21weBgkNI9cp0PQlnDGuBYRlOXoUWmYAIH8=;
        b=OrHd1uJjF0jCwN9c1suqDmSxmcuZpvVOzG0IuEAqUua1etoNqA4B3NLUYEFJyH7XgZ
         +pUM33wzaM/GdSNiJGy0DDKQMr9V2O/wmCHIR4QLBjzjNR9bJDYx7yeFxU+n7QEZaRNr
         E8aV2zHUwmp7nWwascaDL5In3y/h/YP5K8i2favlZ89kVstDCH5mwjlt1nhrTGSFIcB+
         1AYM50euT7DVJyQeC3tOcIHriDvCHqj7YusJGalIHOFKxCIsb3yGDadZnkdRxUqjxX+D
         TdHJD+Dexxaa9DJnTfRc2LdZv01/34+bC+YVfabT4/BbD4Xl/keE2lu3JYp+olt/snJS
         pHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KgifhP4I21weBgkNI9cp0PQlnDGuBYRlOXoUWmYAIH8=;
        b=O9l6EHdwL8msyJJh5naGyJw6Utq5YkoaC+iFlnMABYeHl8hjb4ddu8kL7vELeI4fj6
         ESczo/8ipubjXzqfV/u6U1qUXz65B7o6fjB3KMFGfEkSXup+nAhfh4BzxgFzwqXwjSSz
         3Fe/4Km42pTiASABvxIfwxGWkaSHNI4DCcn3P4avaXtRcu5pGCMyiEztkoeE6oTDv0Ex
         w4qWA0DpietznISti2jcWpwbN43xuCN6ZTi6Q9Nxburxtv/U0uFRbO0mKVhlsZ2M2DIW
         AIYBDeg8MdctcbHvsGeoNu+k8Vel2kuyKYmqv7CLTcqjklEZ7js1uHd13SnRShDkMnEo
         Ca6g==
X-Gm-Message-State: AA6/9RmJWObWhUOeRhBWG90MYzueI7MDPwwgDA0wAO+ltyWz0o1MGVO62cllnJo2dtow5ill
X-Received: by 10.98.20.137 with SMTP id 131mr14712918pfu.11.1475267010194;
        Fri, 30 Sep 2016 13:23:30 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:35e6:5cc4:12d6:7ce1])
        by smtp.gmail.com with ESMTPSA id x66sm29832656pfb.86.2016.09.30.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 13:23:29 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <42332581-e47a-0fc8-ed5c-44e7e1c19341@google.com>
Date:   Fri, 30 Sep 2016 13:23:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/30/2016 12:34 PM, Junio C Hamano wrote:
>> 2) The Linux kernel's repository has some "commit ... upstream." lines
>> in this position (below the commit title) - for example, in commit
>> dacc0987fd2e.
>
> "A group of people seem to prefer it there" does not lead to
> "therefore let's move it there for everybody".  It does open a
> possibility that we may want to add a new option to put it there,
> but does not justify changing what existing "-x" option does.

To clarify, my patch adds the new option you described (to place it 
below the title instead of at the bottom of the commit message). The 
default is still the current behavior.
