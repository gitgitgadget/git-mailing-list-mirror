Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FF31F453
	for <e@80x24.org>; Fri,  5 Oct 2018 06:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJENNI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 09:13:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46112 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeJENNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 09:13:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id a2-v6so5182617wrc.13
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=0hm5aKCdbdZAhhCw9uTnkWLjA1w6TyxlfE/0/PCzh5M=;
        b=vAWfU2jD/wxYuOe4cXkcJWh8cgP2ZHpRBpv4RsjWquaUmXYJ6PDKfDeJyIho0/NnjC
         TfVSNfOYxBkfBv/X5AOaQc8ihn9Goc9G66Dt7gQKwgg2Y8Vnfd2Ekbsgk52N9Br7ra+Q
         hLjZ67bVhsK1FtApSd86Iqs6GgpI8IVFvzlYyhBAnsdXE6ySlo/HphZWw1zLFzMP72Ur
         TYO66CALpDtBowQb37My5p/5O8Sz/X3r8JsyBSoj5crW4AB34zw/uW6VzDYPLmmaqArX
         /2fQpjXK2H/G2cZuW5y3AutzC0PtdU1KrJmqsAbOAtWSAKlUMhCPot9ddKf3UIBO8JiZ
         89KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=0hm5aKCdbdZAhhCw9uTnkWLjA1w6TyxlfE/0/PCzh5M=;
        b=CiI5tAsctmKgwj6JVEiFbcEa86HffLmSg2XRGh6BVm71h3Fq/GozdkO3DrGNbyFLlX
         sSvW+ybvnRI8KtyYZAN84wOtuhvC4DKasOHVEJc2uEG2AbHrF6HObGo+CvOlmArX19Ru
         4bSVuqIpKQgzeaTiCAYSAGJl+nuSJoU/Ai/jmG0Lq5zFjDuan6aljGy8dV+YRUaTjMzE
         RFNEm/16l7FVXF61HIrLfo3hGy0e0C+1lfpZi5LrxsjPduIGcIFZDJdfjy2lL3190l0y
         DH7f6RunEOeeZzU1Wh3kbNeSN+hPBdzndp3ccs3UlE9a7cQFuNE6yn4AyUyTwlWfbRSC
         YL0w==
X-Gm-Message-State: ABuFfojO2xb9XkzvYfSQATjM7S/4/O/myg4eI5Co70NOGKYAIsc3WY9l
        zxuqgDS/WPrAFh/qhHS0WSQ=
X-Google-Smtp-Source: ACcGV60Toq3R7Xrhupd5alhQL4lx18ZlYo5Uo3keQJos0zJHtpcQ6vCelGUURNxcu4+QEnXME6SaTQ==
X-Received: by 2002:adf:be07:: with SMTP id n7-v6mr6661479wrh.267.1538720154503;
        Thu, 04 Oct 2018 23:15:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g15-v6sm4399979wrp.56.2018.10.04.23.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:15:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrn@google.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 1/7] t/README: reformat Do, Don't, Keep in mind lists
References: <cover.1536969438.git.matvore@google.com>
        <cover.1538581868.git.matvore@google.com>
        <32f6f14f8d3323468b4255927cca028a82f64b39.1538581868.git.matvore@google.com>
Date:   Thu, 04 Oct 2018 23:15:53 -0700
Message-ID: <xmqq4le03ome.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> diff --git a/t/README b/t/README
> index 9028b47d9..85024aba6 100644
> --- a/t/README
> +++ b/t/README
> @@ -393,13 +393,13 @@ This test harness library does the following things:
>     consistently when command line arguments --verbose (or -v),
>     --debug (or -d), and --immediate (or -i) is given.
>  
> -Do's, don'ts & things to keep in mind
> +Do's & don'ts
>  -------------------------------------

We may not format this with AsciiDoc, but please shorten the
underline so that it aligns with the line above that it applies to.

>  Here are a few examples of things you probably should and shouldn't do
>  when writing tests.
