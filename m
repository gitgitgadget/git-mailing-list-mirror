Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF46920A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 15:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLKPNy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 10:13:54 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:36764 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeLKPNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 10:13:54 -0500
Received: by mail-qk1-f172.google.com with SMTP id o125so8773078qkf.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxveBDfytLS/SsAI9hyMBuZ3GjlP/HWlr4Mkp0i7M34=;
        b=HQWeYz5vup2VW4BwExmkR5YmwF1cYN5gqApVnl7krjTMdjPvxS0oS3VEOQsxRv51O1
         rHhLUbm+VstOxZO2O9zzSgEQ0hhmxEprZpUfYrLQVCWaTDSVZfRfQIqDOo/3RmMxCfOW
         VbxqoA89nNqyGuZp20s3JHwbmpNdy2gtCGbwGWsvFo1106zoapXNabBVvMu1A7ldd13W
         ycVQvQCkR9qT2vn0OtxjHX3FtA0bb/FTaGEYqpkznyg8Buf5ZcUgafAFP+kzOKxJ2M84
         cBWsIjIhQyiCvHj/2xMd6Fg/BI2EsUcXqY17e9Br4OXrj4HlG6yFaTMJHYycP7RfVLCf
         lGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxveBDfytLS/SsAI9hyMBuZ3GjlP/HWlr4Mkp0i7M34=;
        b=W3hwukdMUIVAAyaCmu/LCCXI+e/pJrNlEQqqtnZTigjU0Tt+ZSswsi7UZO0a27L73W
         cCIjbUhlYSCctLH4ros9hxBsB2TKrG+EDpQpYYwyaesJ3PPkdHTgPhGhVXRoHAOkxIPY
         o2zCar/6jJJzEJ5a22iThKn4BqtfBXpnBpBiRfaiXYKkogflI3DNnhGZj4ahzWdWKB2v
         i4JjpM3NZNhbsrNvhCN9ayXfDy9yEncFqSWZHAJk5bDfppccwg2CnW1Zm61vAnTgopaE
         jXTHar5xplHrYQJ0cJUrUsKVMLzhGN+xUUwt2jEtb+62N+8T0Ku6rQSxjL0X7PEB85wX
         sAaQ==
X-Gm-Message-State: AA+aEWaSIkVHLCA905+s3qf6pGRaUAO7sLfPvfONA8ZzzH796DTk3PCr
        AfXbWnI0xyVrolbQBQvHrrlRweRsE3QTYTVCR0g=
X-Google-Smtp-Source: AFSGD/W8xVvkU1Kaa4IyAXMn53Smx9uLXWupwimuf259XM4Q9+vkKPaxeJloCIkp1+2Ln/ZjYb2a+3nF1d2xRXepoW8=
X-Received: by 2002:a37:6155:: with SMTP id v82mr14485634qkb.72.1544541233039;
 Tue, 11 Dec 2018 07:13:53 -0800 (PST)
MIME-Version: 1.0
References: <pujni2$ulb$1@blaine.gmane.org> <20181211105007.GD7233@sigill.intra.peff.net>
 <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
In-Reply-To: <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Dec 2018 16:13:42 +0100
Message-ID: <CACBZZX6g7TaxNHN=3ApV4wV91ZuVV8eoemMurS=WMt4mG8Q67g@mail.gmail.com>
Subject: Re: Announcing Pro Git Second Edition Reedited
To:     nobozo@gmail.com
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 4:02 PM Jon Forrest <nobozo@gmail.com> wrote:
> On 12/11/2018 2:50 AM, Jeff King wrote:
>
> > The content at https://git-scm.com/book is pulled regularly from
> > https://github.com/progit/progit2, which has collected a number of fixes
> > (as well as translations) since the 2nd edition was released.
> >
> > Have you considered sending some of your edits there? It sounds like
> > they may be too large to just dump as a big PR, but it might be possible
> > to grow together over time.
>
> Fair question. I had tried doing this for the first edition of Pro Git,
> but the person who was in charge of accepting changes wasn't a
> native speaker of English. As a result I had a hard time
> convincing him that my changes were necessary. Many of my changes
> were very subjective, and not technical, so this was hard to overcome.
> Things might have been different if I were correcting technical errors
> or adding significant sections to the book. But, since I'm not a Git
> expert, that's not what I was attempting to do.
>
> Things have changed for the better for the second edition of Pro Git.
> Its management seems much more willing to accept the kind of changes
> I make, as shown by their reaction to the excellent work by Robert
> Day. Even so, given the amount of changes I've made, it's unlikely
> that my changes would be accepted.
>
> I do track the changes to the second edition of Pro Git and
> incorporate that ones that still apply into my version.
>
> But I hear what you're saying. Maybe if and when the third edition
> of Pro Git comes out I'll try what you suggest.

As someone who's read neither your edit or the original edition, but I
did read your version of the intro, it would be very helpful to me /
others if there was some diff between the two so we could make up our
own mind about which one to read, and to get an idea of what sorts of
wording changes etc. these are.
