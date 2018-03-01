Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34AB31F404
	for <e@80x24.org>; Thu,  1 Mar 2018 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162050AbeCAVnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 16:43:35 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33921 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161761AbeCAVne (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 16:43:34 -0500
Received: by mail-wr0-f177.google.com with SMTP id m5so8107142wrg.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fN5WGYLuVJSci9iDCvMNpWKyL9zCm3AeY9T0Twk3H7o=;
        b=lyRPkjyvvEb+W8blnohHK4TEn0ZWcU8QvR5eJpFVaXBY8V8GguCXltVWt09RZtZDIR
         vlgrv+jXEGyOOCDh67X0QGEHYr0dpjpKRSw0uy9KnCqQ3+hSv/1ldb51Zabweo5uDhik
         vs0DwiajsT+XxUwtwYYQjGGxoA0mXwgjpzY0MTKmHEwFrZCU/bkdOkmD/6VI1LBRYRkI
         uL9+C7H3kyVHEnFu28QnLZ+HHOtXISB7lLVtPBV4B5TKynXnMCvgg05QDhxy8Rg0A+zm
         a3lT95cSbI7D+4QvdoEGno4koZFy4pLf22F98nR+EuhfX0qMQn0kcJrH7wRbCZaHRhU3
         jYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fN5WGYLuVJSci9iDCvMNpWKyL9zCm3AeY9T0Twk3H7o=;
        b=qZQt6CGAkEubG+AsKubB0NNDtqQggPrr1dUGZJRePcUV6cFN9YJOsKNKH8qwoxktKj
         IjpbBumKJZBDCmTdhJDigZqGu20sce2gaCsYYMZRg34hMh9/cEL1e687YdK+V3cfXfAv
         m8onDLnLyK28xih1JS9Ws7ep/u6nhCxoWzTnJGHxlYX2mcDwknztZOcyH/33OGpcMGoR
         QKkN03HvE7epAe2di8TqQqjWWOOHOcuKvu4bLB5cLyJyYODF6ryFrIzIISrjHxz93XQy
         zX0+39rlATsrVGNt3iNtfYxBZ73lbmIQq/Sw7Xrl4yWWWejDF8RBS7YQMNcyfJAcDnKZ
         ltOw==
X-Gm-Message-State: APf1xPB7FgKHmoivFJDT7IzNaQXHq/oryojSxa//eToe1DSoy3BNI3C5
        ZDnPi6n/r0B0K7PdnsO91+c=
X-Google-Smtp-Source: AG47ELsssTUjlpEoEJXedvVotYHazEy3aIyZ4IkHin/lWfY5u3IhtnCVoxcLeFPSqfaKbg/GVuAaHw==
X-Received: by 10.223.156.206 with SMTP id h14mr2831189wre.281.1519940612751;
        Thu, 01 Mar 2018 13:43:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm5144521wrf.24.2018.03.01.13.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 13:43:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Obsolete instruction in SubmittingPatches?
References: <48b5c506-6882-81e2-35f6-7d040bfc6017@gmail.com>
        <xmqqd10okcfu.fsf@gitster-ct.c.googlers.com>
        <927e3166-9c60-fca5-ab41-f6d38380c1b1@gmail.com>
Date:   Thu, 01 Mar 2018 13:43:31 -0800
In-Reply-To: <927e3166-9c60-fca5-ab41-f6d38380c1b1@gmail.com> (Andrei Rybak's
        message of "Thu, 1 Mar 2018 20:29:34 +0300")
Message-ID: <xmqqtvtzeakc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 01.03.2018 0:54, Junio C Hamano wrote:
>> Andrei Rybak <rybak.a.v@gmail.com> writes:
>> 
>>> Is this part of guidelines obsolete, or am I not understanding this
>>> correctly?
>> 
>> I am merely being nice (but only on "time-permitting" basis).
>
> Does that mean that the integration of a series is easier, when there is
> a re-send?

When I am not interested in a topic, or there are other reviewers
who are more qualified and are interested in the topic than I am,
the protocol to require the final "Here is a verbatim final resend,
the only difference from what was reviewed is the reviewed-by's from
the reviewers." will let me completely ignore the topic while it is
being discussed (as long as I trust the judgment of these reviewers).

Otherwise I'd need to keep track of the progress of the discussion
on each and every topic, which is often impossible.
