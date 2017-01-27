Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB5B1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 21:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdA0VK1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 16:10:27 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36015 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdA0VK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 16:10:26 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so159098628itd.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oTZ0XhxqEygrGobmZY/UAoMkemgKpKjSbMQLLY8FNek=;
        b=tBse5dv/jMNxao2reVLaI0zPm0/4P+U4rLMdO0r2uliAZ0CL6IGwZ53eByHcYxTOQH
         L9UfEgQZmDC5/NYiJxSUe8U9iHTEKlnQQPRHYZ8j9GUDIytiYXoBxltC68vfymw6rHjJ
         CI2jotjSg8Yu6MDEKHAre+1Q1Yfq20aCFY4kw9uOdBumxOn7BelVknvMK4dGl7lho/cH
         rUWjycJO26+VCKB9KbWF+cNwAMVfxMZxuRyTKkyi7NXG3pS7WOxK7Wga0oh77C3MsetQ
         Vnb3C/Dp5EH6ypkFqrNx1ttaGjaKlggawe1MaEXjOPM2Nc79sBxqQk2mKGfyOvLMR0QP
         3+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oTZ0XhxqEygrGobmZY/UAoMkemgKpKjSbMQLLY8FNek=;
        b=sCa7VjvPc10iCdSvEPcw1FVHbBmpRJ2RCJqefMHaZ1ku1C6fM2WanJ9J/AjGJUM8zD
         l605P5va4Dep827J/WiiZoWSU82/Co56W3dtfYol8XPzSiOGRb2PvTAmzTiRzPBVxB65
         MzEgaZjrjuHHAtZfscQAy5uOickMjEsPPDbFJ/PveJC5KNYcQ3zd/b3Ac3/tL02cYN+Q
         smzW3aIxU1NO2Oqo5QNZqokGWOeGIXPjVbSKYw4MTdLrRqYsh0nOnf0qjhEAK7dKmEga
         U56xA1LToP6sKDPUev8tyeWsQBr5/5VbTKRiMYjBMN6cE1CV7fuEytwCuySG67Szj0bj
         i55g==
X-Gm-Message-State: AIkVDXKh+ISyxyiVU9NbkGgFVcMdPOpwX2bGWX7Z6UrXWNEJP5YYGjwaTq4XPsB/30ptC7VZERPjCm7Zt7wWgivx
X-Received: by 10.36.88.143 with SMTP id f137mr4684672itb.116.1485550881402;
 Fri, 27 Jan 2017 13:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 27 Jan 2017 13:01:21 -0800 (PST)
In-Reply-To: <01fc4c33-2d4e-e19f-d447-6a187e15d2ed@tngtech.com>
References: <20170127200136.29949-1-cornelius.weig@tngtech.com>
 <CAGZ79kb29usw4WyMdy3c5-rGH1nEcQ1gUabzdAtGgOW9zfTCDA@mail.gmail.com> <01fc4c33-2d4e-e19f-d447-6a187e15d2ed@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jan 2017 13:01:21 -0800
Message-ID: <CAGZ79kZHLyFJ-OWd9R=g3hZs6mhRfGGe_=zG+ZiBkR5B-L-iqA@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 12:48 PM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
>>
>> So maybe s/signed-off-by/helped-by/?
>>
>
> This is getting real complex :-/

uh; sorry for that. I do not mind the patch as posted,
just in case you reroll for another reason, this is worth thinking about.

In fact, as said before I like that patch.

>
> As I said in the notes for the patch:
>
>>>     As I don't know what is appropriate, I took the liberty to add everybody's
>>>     sign-off who was involved in the discussion in alphabetic order.
>
> With your explanation, I guess the most accurate sign-off chain would be:
>
> Signed-off-by: Stefan Beller <sbeller@google.com> (as you sent a patch)

...and here we could continue arguing. ;)
Is the patch I sent note-worthy enough to be deriving work from?
My gut reaction would be "no".

> Helped-by: Philip Oakley <philipoakley@iee.org> (no patch, but helpful)
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com> (this patch)
> Signed-off-by: Junio C Hamano <gitster@pobox.com> (once he decides it's good)
