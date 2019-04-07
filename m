Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8B020248
	for <e@80x24.org>; Sun,  7 Apr 2019 03:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDGDUz (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 23:20:55 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:35236 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfDGDUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 23:20:55 -0400
Received: by mail-it1-f170.google.com with SMTP id w15so15829592itc.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLXWwpQwYURU5+COtUTyccFDPgh5wb/1cctDaOtb7XQ=;
        b=khxw6jfCVP8YAC1hnK0k6AhPZhEmfrzE640GOhZ0nKV8qtts7Cft5fF+l/61H1/ygt
         U3fWNiE6FXfze/bWSjYINvKnHmHBfkDUj927mOIwtm15YFtuDHP4snD6o4ZyTw8D9Ae2
         iMQUHyyfA1tlXA7sPUg7bYYeIuZy8zygF+EvMceJhVhde/+ynBgpNBaAFmEP4w6lJqvS
         PsOlsc6Jxeon5bV8WR3cMF7/On5tjRtsYAAXEI8XDfhmAwm30qx7ogqRLZuEG8JC8R0w
         8Vt4BEl0jM4YsU/bUTiOH3dXcQc1Rq3On9J9Akf0FdOCv4vSF+3n/swC/Oy07unoGF3U
         +/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLXWwpQwYURU5+COtUTyccFDPgh5wb/1cctDaOtb7XQ=;
        b=ogDY1oBKoRpgWP1bwA8jxzqyfyDGUKr7aPHI6C/BjsRzowlKanai99ZJNOtqrtJBcm
         jM0f8xjNI+LrGWh/rqlXgTHkZkVdGH1ZaDZ9faBUUmLviNwyQn3R30TOM83MJRxHIEDi
         D8HIaELdGmMRNAsKSNmsh2H4oN9XmmbJa0Si1FdMGS7PzsSg/wPHHVGAg7pbVlyV1s+x
         mz5mpFM7eMOyvggxIveA/PzJJQamunSbl3FRz8C4u2QFSaF3bIszwyAocusit2dAzdju
         2xOeaJO4pNNDH/ctGSuQJmxqKK4da0YBzJWf9zElwe8UUqXVimic5/XMpIMs+soNIz92
         BLCQ==
X-Gm-Message-State: APjAAAX/58jGTFkkdwWfcbilykjwAXbGnQniS0vlSt63RTQsYCTntfOs
        H0eIrtYWUiQVZTKyV8QP7uA1woC2KgU6W5CDDg0=
X-Google-Smtp-Source: APXvYqzRfBwcr5G8jj32gQ9xYA5UeaXah8AjVL2dvcUy7TbnlNMV2fF7F55aFuvVhrpazwRGxSAzX/3GiH7IVi97mp4=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr7936148ith.72.1554607254227;
 Sat, 06 Apr 2019 20:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
In-Reply-To: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 7 Apr 2019 10:20:28 +0700
Message-ID: <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
Subject: Re: git glossary --help ?
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 7, 2019 at 12:31 AM Philip Oakley <philipoakley@iee.org> wrote:
>
> Following the discussions about the tag peeling issue, I thought to have
> a look at what the git glossary says.
>
> I had it in my head that when the git guides were linked to the help
> system, that the --help option provided a short circuit direct to help
> item. However this did not happen.
>
> I found that the capability had been lost, which given that a lot of the
> underpinning knowledge is in the guides this would appear to be a loss.
>
> I don't have an older version to test, but I thought I remember the
> capability from about the time of my 65f98358c0 ("builtin/help.c: add
> --guide option", 2013-04-02).
>
> Have I misremembered the --help capability?
>
> cc'ing Duy in case he remembers something from the recent update

Phew... I didn't break anything!

That behavior has been gone since 2c6b6d9f7d (help: make option --help
open man pages only for Git commands, 2016-08-26). Ralf did not
mention why he thought "git <concept> --help" was a bad idea. But it
was considered a bug by Junio [1]

[1] https://public-inbox.org/git/CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com/
-- 
Duy
