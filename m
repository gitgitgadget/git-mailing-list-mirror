Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6AA1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 22:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdFPWJt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 18:09:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34791 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFPWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 18:09:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so8290039pfe.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pb2bukf8C8vH0mSnPC5bt2Grf4DA0SInpWn1ZmwbTE4=;
        b=Vrzj4mHnF3WnH7iYndyPimtf+11el2ecvxzuY3RD42XO1TISv5B20V9hlT0DEi9p54
         fk/az4Gxv7bOJZSw2PqnDybvjMqN5NssIMf/8GO3jP6pOVHUyA2UiN8i7eQP/9PjFFqV
         +5kdNyjq/vLuRg11aXVRLLywID9ExPufEmjGy40NFxetEGUVslEDbaEsfqSHTYAddhxQ
         yJxixOYl9GYgvEYiNfzNiSKuwZF7OUXzG+hisKbJ9pVE3XwZ1PPOH7WnFrQHXNArmK3L
         y2yNGLfqG0h7gwPMMY9AEimPZR6Ie2cjA8RDwh6z4KltfepQOjxCUr39g78dGUP4HKJQ
         kC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pb2bukf8C8vH0mSnPC5bt2Grf4DA0SInpWn1ZmwbTE4=;
        b=LvRRTYY972vbXo1v5q7dbx+qAG+SRiQD7igagaJb6Czy38H9kCzDi5QQh6SJThNhYL
         0fJFXRmQLyzaH0Kbtpo2XL+kjyx60Sq102mfFNpjyNVrKWQ+IjaTM/7mw07cXPEtJjeb
         Pw1fwBLJ9gG80u0vPsT9m0F5nHWsnjzw3nw8YunQ8bJNlIGC1sV8nr4TMpmhDrl/vOFG
         sFgjRmykCKPYBadxl0ZG8vsqQ0WpWlrADu0+N4sAeExoyYaCMXn4rdImHyaFCIwQZQE6
         QN6QuccKGh0aukoQa4Y75WUt8FtIuLjtJhsgIqgwh3QnnBGvCz/b76z9x95/gQXf4Tg4
         stBQ==
X-Gm-Message-State: AKS2vOxpWp01olY7S1Diym47FVP0AJKhNLU64QaOLdSsP7iRQkq9ZjkT
        DaDiDjC0jJkQ/g==
X-Received: by 10.99.98.6 with SMTP id w6mr13842234pgb.207.1497650987985;
        Fri, 16 Jun 2017 15:09:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id t82sm6442890pfe.88.2017.06.16.15.09.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 15:09:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored configuration variables
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
        <20170616173849.8071-1-szeder.dev@gmail.com>
        <20170616173849.8071-3-szeder.dev@gmail.com>
Date:   Fri, 16 Jun 2017 15:09:46 -0700
In-Reply-To: <20170616173849.8071-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 16 Jun 2017 19:38:49 +0200")
Message-ID: <xmqq1sqjwpn9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Due to limitations/bugs in the current implementation, some
> configuration variables specified via 'git clone -c var=val' (or 'git
> -c var=val clone') are ignored during the initial fetch and checkout.
>
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Documentation/git-clone.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index ec41d3d69..5ceccb258 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -186,6 +186,11 @@ objects from the source repository into a pack in the cloned repository.
>  	values are given for the same key, each value will be written to
>  	the config file. This makes it safe, for example, to add
>  	additional fetch refspecs to the origin remote.
> ++
> +Due to limitations if the current implementation, some configuration

s/if/of/ (will squash in while queuing).

> +variables do not take effect until after the initial fetch and checkout.
> +Configuration variables known to not take effect are:
> +`remote.<name>.mirror` and `remote.<name>.tagOpt`.
>  
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
