Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D4D1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbcHCXN6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:13:58 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35101 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895AbcHCXN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:13:57 -0400
Received: by mail-it0-f44.google.com with SMTP id u186so310539767ita.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 16:12:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wJdHEpPv0jZX2VCjyToGQlW1Nuoh7m+S8UauDJjEXgM=;
        b=n5hBGR7kH7PnjWZw7FF19jATY6pquZY1VClGvh+ZVHlODatTe9PghKSfNudsHe78V2
         JL7ofC9i2CEhvAP6a+w/OKqESkZTdFcGuhhOV2igkBQ+ZHjxZs81IpOou4Yvx65ndNR8
         96W9D792wdTDsvk4yl8dX9iTCl8A8p6xEsB0QAZSqOs0GiIqgY5M9TAOwBQ2Ea8+ViGH
         bNgGcXt0OYrTbbo+GVcmlg0+vmY4xl/zEFMQ/D19mJkBgynRCzh1gv/1CL0p5IZNh6wb
         3KwH0C/oKTkJI5wawOdt8LNnV3Z3Bob3/gSmICLlyF8V/WqRxALQbu2rDN1y8OyjOM7C
         Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wJdHEpPv0jZX2VCjyToGQlW1Nuoh7m+S8UauDJjEXgM=;
        b=W0lgcN+39SZrRNl5pBcQjRYc+xY7TQSsvOzEL7T2akWa9zjqeUO6+l4AgReLZQ6Qeb
         wduWXkeqVbC0yMSbpOxa/sKdK5HUbJaUNVvZy/SUKm+yZ8E8ha9X6wwX5fWavbk0uljs
         lMKY0TNCBHWOPkIRU/BpxBdDZO1vjmXTsFSX7XdGpjLkyKFOsAWzUrgUIhM+G8YbI3EI
         VjBh0gG4YMPJveoDFvCxTy7fToF1OHnHoElWq5mpcPXsiFgJzsokpzo6KFDHsyi1BuSq
         MraMfsI4n9TyaCMFlY8AnVAOfTnfnU+XZt3gqW9+RE/dRqlGFmwEAiA/XzBivxbCzWF9
         Sgwg==
X-Gm-Message-State: AEkoouuzWvlQLzwRK8i6rPtrxvwkqRtIkTOVI3r8Ndsy4AgprsmMkz1X457eq9lPJJUCuAcapnry1pGNk8/e20QI
X-Received: by 10.36.29.15 with SMTP id 15mr26749740itj.97.1470265926927; Wed,
 03 Aug 2016 16:12:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 16:12:06 -0700 (PDT)
In-Reply-To: <xmqqd1lp78r7.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1lp78r7.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 16:12:06 -0700
Message-ID: <CAGZ79kZb=F7k-Qs=U6aC-vbOPYoW0D9B11750t8b5uFTgX7nTg@mail.gmail.com>
Subject: Re: What's cooking (interim report)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-update-dot-branch (2016-08-01) 7 commits
>  - submodule update: allow '.' for branch value
>  - submodule--helper: add remote-branch helper
>  - submodule-config: keep configured branch around
>  - submodule--helper: fix usage string for relative-path
>  - submodule update: narrow scope of local variable
>  - submodule update: respect depth in subsequent fetches
>  - t7406: future proof tests with hard coded depth
>
>  A few updates to "git submodule update".
>
>  Will merge to 'next'.

I sent out replacements for the two tip most commits
about 2 hours ago, hopefully they make it in before the merge to next,
otherwise I'll resend on top of these.

Thanks,
Stefan
