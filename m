Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BD31F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdAYAwN (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:52:13 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35833 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdAYAwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:52:13 -0500
Received: by mail-io0-f176.google.com with SMTP id j18so2465307ioe.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LtdPKSEq9eC2OwpwzHjVI1eInqBcZq0nBe/qab1vhns=;
        b=eSvAu6Q26pVJQSd9C4+M6hdQ0WRvtH89iF5LNo2fIaZgsoVarItjh5Y5+QK+F/yK3Y
         sd3UmnpmGZAyp5brk5HM2X1HBR4Ar7mtAcsg+SxYSvO6u6NuAPjtAvev7CxPSncfzfKi
         ySY30Ql6TDeKvlDWOGPCC0pHMxWFjfvPyv89bi9zTXUZyGLNrnWOgm4tIWK7L26krhVd
         M46cU0UwpMm9dAklTOfl0iRk+fyQ1JLN5LqFIcI33CInCisQ9/5v/dBpxIq0KYm35OCY
         DuiJg1nOudpWd9PlTjqdi75oxiVBeUes0CijIWv9L/BbkLFwroeLudr3PX3sORPaEoz6
         JzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LtdPKSEq9eC2OwpwzHjVI1eInqBcZq0nBe/qab1vhns=;
        b=rg5Y0XC/tZvEFQnG/K9bfpeqIRiXa0ckV8LWU5OjZPuEFFBh+AY90Vs6Kdj7c5H/Um
         srOjQGNrgd7PTMAEoH3XNCNqMnUN5HRvKnrHf9KvsaTpE47WtjWuZ8XvRghEusnyGmyE
         WkN8mgvbQTyYlc8QzgIEafQctKX7m/uMOIstnno4zObajFBQJg8s7liQM6M1rfLmDLOA
         /GZZ2MaEtADsRtgP+VsdSZ9LLFT2VoQYTHaB8h0SuQhrFJi8N+ga7mFRnzHvvTYBpJwP
         HWBBUOy6bLE3CGbQ/NxArj/zFsHh2u6lUwm1lPHnsKXFOgEWGABU9yYcP/Dvivz2LE8L
         yxQg==
X-Gm-Message-State: AIkVDXIkzdZWAoVe+8TM+c9sShGPZ6U3WQApgEtKL1mrZBNYX38vwaOfqnxwm+8w5tTIPtILnOjhGqRqitJa6xCw
X-Received: by 10.107.3.160 with SMTP id e32mr32096481ioi.52.1485305532193;
 Tue, 24 Jan 2017 16:52:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 24 Jan 2017 16:52:11 -0800 (PST)
In-Reply-To: <ec2a198e-edf5-68a1-523c-12a9d1333c58@tngtech.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com> <ec2a198e-edf5-68a1-523c-12a9d1333c58@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jan 2017 16:52:11 -0800
Message-ID: <CAGZ79ka2b4BxYXEou6QrvxwbTjTdd7BRqhA1ZEw8e-gjB3cDDQ@mail.gmail.com>
Subject: Re:
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 4:43 PM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:

> -(5) Sign your work
> +(5) Certify your work by signing off.

That sounds better than what I proposed.

Thanks,
Stefan
