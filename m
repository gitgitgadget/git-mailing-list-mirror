Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304581FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdJ3Mkl (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:40:41 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:45968 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdJ3Mkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:40:40 -0400
Received: by mail-qt0-f170.google.com with SMTP id p1so16101451qtg.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SXhmlsj+knRdjdVWbToZFOs2Im2x0icuFLXOwsDBVrA=;
        b=EtmseGXr6Y/sIhdJE3kVsgmiBbgTgvfZsiFDjM9o8hu5TsO5feWW7+kdSJZHPPX3iE
         7lrPV7YrfrTm8hyE4JY9SrEypj/cwQbvsOLQDNKT6N5HFkinVlbkyWJXCl/sR0fax9q+
         BVOssxKEC1kEIX7WKNX4g/yWejZMx5DxJMXW+RpgdT54u1JgFXB2mQ1BR4AT6fcC6yy8
         oj/YWWsgrXcesbzk4xbvWdeQfqX8KD463ANix/KaoMSVY40F7WqZDFnwkeIiBrq9zb5h
         3XtfO9sJPa75FF3W2Db8d6RjyBuGEPd6j39shgzlS2qz+ajJhzBMOZULwtSUKiV32j8n
         8jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXhmlsj+knRdjdVWbToZFOs2Im2x0icuFLXOwsDBVrA=;
        b=R5OlEQEOD4bn7yKUTXTDo5WpI2oEzUFlhHuNJDhkr4jvllWU/ff0wG6VeSkjAqtEre
         S+LIeFV8I/N3DTY9ejRvlkrPDHweJj4GYtU1pOJTtGyC3zRpcoGXqAWmh024sZApGH5w
         Yig+FWkjAszZyi7txhvIbMxrt6iLdVuIj/ZXNZjSGoARRr6g54Su7dNZJ7tpX+SaOuQ4
         tbA+X8c5V8wfdE9gytFLH8G2GghZ0siHkHQwuvpNJgxjfYgPlnR8Uoma6XMIlsI1JdAq
         apaCj3YXNcuZtMWtFBRuGl6mGR2mNUGnJwhnHv8CGflUSQCYqn3cfFg6CxRA4DFnN2DU
         NTvQ==
X-Gm-Message-State: AMCzsaUNxh1ZNJJ/cWQA9MTwmz3Y7J8QpWJ8mo+Je6GwwcFSQASJsaVh
        RBXArtT52vLUG1p1mXGfk+tDhN0Z
X-Google-Smtp-Source: ABhQp+TwRPS6Xp3KT/0nixCQO1O7ULQORrkpUJC3rzWGrA7p9Kv7NZjARYWt4pRCgux3urhd8WNzSQ==
X-Received: by 10.200.35.173 with SMTP id q42mr13542288qtq.199.1509367239806;
        Mon, 30 Oct 2017 05:40:39 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d145sm5337250qkb.0.2017.10.30.05.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2017 05:40:39 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <aa7b33a8-4110-39e4-f722-f87f6b0a8ea5@gmail.com>
Date:   Mon, 30 Oct 2017 08:40:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> * av/fsmonitor (2017-10-30) 5 commits
>   - SQUASH???
>   - fsmonitor: delay updating state until after split index is merged
>   - fsmonitor: document GIT_TRACE_FSMONITOR
>   - fsmonitor: don't bother pretty-printing JSON from watchman
>   - fsmonitor: set the PWD to the top of the working tree
>   (this branch uses bp/fsmonitor.)
> 
>   Various fixes to bp/fsmonitor topic.
> 
>   What's the status of this one?  I recall that I saw Dscho's "looks
>   good" respose to the cover letter, and Ben sounded positive on most
>   of the patches in the previous series.  Except for the SQUASH??? I
>   had to add to squelch compiler warnings, is this good to go?
> 

This looks good to go from my perspective.
