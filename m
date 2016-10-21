Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5092520987
	for <e@80x24.org>; Fri, 21 Oct 2016 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935117AbcJUP2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:28:42 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35498 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935104AbcJUP2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:28:41 -0400
Received: by mail-it0-f49.google.com with SMTP id 4so245193614itv.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y6VrRcRJlW/VTFjDi7RC8vC8/d5hSm4X+KM3zBNUE0k=;
        b=qxrI371tx8ZuPVCzcdLK+WIf8W5XXmNW00AUEIA4w2E1Ma+iU6aIXpzlrgqbUq97O5
         NWcfWqW/ReGW0Zpu3aEfd7LIcUnbjO/ymLILoiZtTM45sXlcBc5AH0hvoZZ+aGOwEFsM
         J1ZY/0R+QJ9hH9qMfJ9spYe0sWFJsa8AM9PYI7TD88qdCthl1dzRNBDNQbz5ZDh0K8+V
         RpriNKtnG84BJlzjN2/s68Kvmw6Fk6c5iRMIclo1H3gzFOMz+P6rjdgrVu80vzmeBEt5
         7DyZgLxSKyL2399lfSM+Ls6My0MjME3owp1ZjWPc/nlQNNJI9CFHTUfHVE626R0U1Fi5
         sR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y6VrRcRJlW/VTFjDi7RC8vC8/d5hSm4X+KM3zBNUE0k=;
        b=duKX1fatm9TlYIFDJyI5U2dUZAicH8AmzV0DH5EtuJLVmJaaYwYbwgYTQFQ2fS0qoy
         hgUz9mJF+936F4UNxUHTKrFoz7bvhIRGHXNMM1n+asCBQvmPmYMJeiu21UxIPY56Whfb
         /Vj55AvfCenrhhrwzenvRuTa2xoyfv2D2zv2V3LKL7m53cnV1CuOXMSf5U4DdDQOsifu
         6cfPhLzDwQNKOubPUqxAim89zWpBLg9m5nmCW9UaoeRykalL0QZSJm73kCHeD0wbviyT
         CX0rx0s2qQ2vc7U62dLaKMokB2uhatR3BjcO45zn7gjJfcTQhJSIptyUg7hZ51Npyg9q
         auXA==
X-Gm-Message-State: AA6/9RlLsg1i7oR8WTn4KvpDv7jc0g9NF3WbD4DY0zgUc0rZYXdcUglgmw+tSX0B6UXwncc1mR7gcKqfN9vKoA==
X-Received: by 10.36.112.199 with SMTP id f190mr15314363itc.60.1477063720262;
 Fri, 21 Oct 2016 08:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Fri, 21 Oct 2016 08:28:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610211457030.3264@virtualbox>
References: <xmqqk2d2ein7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610211457030.3264@virtualbox>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 21 Oct 2016 20:58:39 +0530
Message-ID: <CAFZEwPPDcL_DLHiFpxYW+Pk71Hu7kjqVN3jcL7_jvceCyLLmHg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #05; Thu, 20)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes,

On Fri, Oct 21, 2016 at 6:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I am unfortunately still busy with trying to figure out what exactly makes
> t6030 hang on `pu` (seems it thinks stdin is a tty and just waits for an
> answer), and then trying to reduce that insane amount of time wasted on
> running, and waiting for, the test suite, and for unrelated reasons I'll
> have to go offline for the rest of the day, so I will most likely be
> unable to assist further with this.

My patch series [1] is recently merged into pu which changed a lot of
things around "git bisect next" which I remember that you mention it
somewhere else too but don't exactly recollect where. There were some
*really* drastic changes and they are evident with my conversation
with Junio. Maybe you could tell a little bit more about what's
happening with t6030 so that even I could dig further.

Heads up: The changes in "git bisect next" were related to revision
walking so you might want to check it out.

Sorry for any inconvenience caused by this series.

Regards,
Pranit Bauva
