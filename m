Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7681F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDJVWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:22:33 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41265 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:22:32 -0400
Received: by mail-wr0-f178.google.com with SMTP id s12so14160653wrc.8
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kwi/3FdJj+enrhiYP0NasI7w4PHYGvB2NzNy1jUP6mU=;
        b=t32EDZD2fXLmyD2lEuEGJuc/RRNzPIJfJzqRrJbxUNjEyduMPcbBbujcITOhkH589o
         aNCx0FZLWxTHNuMxyWNmChOKKWGgLXXMvrDtS12PohxZ/uiSN791crvdSAC6MXsPOQVD
         z6DMs5JQWL70iBPZ7gPsrTP4MInfzW6fyRLmILh2zKk6NjNW/mqIfR3TynlAA3zPN0O5
         ptyzr7oOSymZ9ztCWtf+ZGoP2w7Jvaq7C8rG/AvSRSe2SiTvOQc7RFpajGsyNi+zuMAz
         Wt4pmYowLJ9HTlxsHFFgMhv6q5nFdsGbh5c35JNar7ihelp1Y0EWk++oZ8rwBw8jrD/P
         CyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kwi/3FdJj+enrhiYP0NasI7w4PHYGvB2NzNy1jUP6mU=;
        b=h9ehb7ovQYVqN5ZkbmrUVbRHHPfDO8tcuH4iPZnFgdO9INgWR61XTM79Zj8lT4MBOu
         r9YmwIp22X2S9fxm61GuUI6gvyIG+eLBEuP8rWGAdRQdgV6u5pZIckyh5nfPcnUzAvNL
         qV/RVXF0dBaP8sdw8HbMLzbCDbHCbfCwkWxv41X7S5F+BpIFCXKrxZBZxnIbuhrbfuC5
         Mn7F+8TAqovhTyAYgLJUBVwBOglCcIxEUmokgmwgQ5utEDnkJrvwOasqH7gwkJRPzAgu
         ZxIBGM5R73SE5IpWnUJGOsQauOmyao/CpHBvblgIfgv9UcoY3mQ3C1V+1i5uzeXiDUoF
         E/Fg==
X-Gm-Message-State: ALQs6tBC/gDiJDAmdLhCgmZHbb5fKeT5cTWIpw/EngeCFO6z0aZUmSv8
        4yU0JTyUvtaU0SJ73yX9gAQ=
X-Google-Smtp-Source: AIpwx481l6FnU3Qg9CZlQqfbgr9LEA7KsHIkDsQZdYT7ZV78CFs2NfNWslrahtykytFDuL9M4m6zuA==
X-Received: by 10.223.171.213 with SMTP id s79mr1436073wrc.52.1523395350575;
        Tue, 10 Apr 2018 14:22:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k82sm1537964wmf.7.2018.04.10.14.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:22:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] doc: align 'diff --no-index' in text with synopsis
References: <20180410183224.10780-1-asheiduk@gmail.com>
        <20180410183224.10780-3-asheiduk@gmail.com>
Date:   Wed, 11 Apr 2018 06:22:29 +0900
In-Reply-To: <20180410183224.10780-3-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Tue, 10 Apr 2018 20:32:20 +0200")
Message-ID: <xmqq7epe3gfe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

>  
> -'git diff' --no-index [--options] [--] [<path>...]::
> +'git diff' [--options] [--no-index] [--] <path> <path>::
>  
>  	This form is to compare the given two paths on the
>  	filesystem.  You can omit the `--no-index` option when

It definitely is a good change to show two (and only two) <path> on
the command line as non-optional arguments.

I however find the change to mark that -"-no-index" is optional is
inviting more confusion in the form presented in this patch.  It is
optional under specific conditions, and that is not conveyed with
these two path arguments named very genericly (as opposed to making
it clear that they are paths that are not managed by Git) on the
example command line.

I have a suspicion that it would be safer to have the description
say under what condition "--no-index" becomes optional (which our
text already does), without marking it as if it is always optional
like this patch does (i.e. do not lose [] around it from this line).
I dunno.

