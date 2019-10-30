Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D5B1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ3Jx4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 05:53:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46777 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3Jx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 05:53:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so2306939qtq.13
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBrd6RBszFoB/LpSsC2unUw2W5BDtCS5iXA7jVuq1fM=;
        b=h002i3Y/dij0+9Fkqiy6/MqmMkcE8WHsSc2ViQ8GpLxnHZTZrkhrIyrmGEN2GjU3zx
         2Y1E3SE4904I65858S2Bq88aRzgRkjZ2zJtS0dBjxPq/HPJhp7nMRtbauLBmRN9tD9aG
         xRy8kOrWJXQB4lR14xGKTNMxLdFLc5WqyhnICSaWe77BONue6C8DVrbzkynjN/urVY/t
         PrXBs7jvhwfUwPJH6IyiERC5TWUNMZvJt9DvhO9atnAvQ9SMlfrcAMq58PIpIjPfDxnB
         e7QqiYnB1tWUEd7m+Pb0/cdyY5B4q3kls1BZBUMKFZVS4j7pLtoWkvlg1s4Wxoyclq8p
         OtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBrd6RBszFoB/LpSsC2unUw2W5BDtCS5iXA7jVuq1fM=;
        b=AEP1Z1SEKmKIINJhhlj1di54qlAfJfyP/5QrmYGHLN33G8fe5kWTrPLkQ9sMFJ5xng
         reQ68zk4/QwG53O3VuNjF8aQ6St8JAmWNQW3LlScZnsPPhKUoK6DvnKc8rgLn+ji+Nua
         2mzKfkhcpJfmpgsRWQVy2CcrCUIGzP2K5Itm2E0cWrYOllG7SwWp1dHgiNlp7QrsmJVt
         mKsFs1Ge3ptMKlSFcIxkh3fDHrVE34LtRzXilmwNTQcJouEsYLzvJ3eiXp4wzBuURPXK
         pFNapQTp5Dcr6YW0xSaS3hKWrNVmSmK73NIVoWTXeSAbjnIXf5CYoXURrB6poiHta3pA
         uN5Q==
X-Gm-Message-State: APjAAAUMeWs8Xxe3QoqoUpM9jMG1utIW5Dy/QEYtRYhIikeHXDc6VVC3
        M6Wiyfeo5mzpnhUXVRTKIbQL/ybZd+nxYh84bCw=
X-Google-Smtp-Source: APXvYqx9HQba3Rg/JJTB38ngdMm01FLL4wy2eSxHXrqbMlCaK2VOE7+uAdGTTKp/+TxxSvyVs/yFTdRAWCkyB3o7d64=
X-Received: by 2002:aed:31e7:: with SMTP id 94mr3123891qth.71.1572429235048;
 Wed, 30 Oct 2019 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
 <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
 <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
From:   George Espinoza <gespinoz2019@gmail.com>
Date:   Wed, 30 Oct 2019 02:53:43 -0700
Message-ID: <CAP_ANimgFVuq1U6xB=UMQZ-uQp2PayuD82EBAup20eZK3Fv8AA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 7:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: george espinoza <gespinoz2019@gmail.com>
> >
> > Teach this command which currently handles its own argv to use
> > parse-options instead because parse-options helps make sure we handle
> > user input like -h in a standardized way across the project.
>
> Sorry, but why do we even want to do this?  merge-ours is an
> implementation detail of "git merge" and is never run directly by
> end-users.
>

Hello Junio, this is my mistake. I am a first time contributor.
I'm currently working on Micro Project #3 as an Outreachy applicant
that states, "Teach a command which currently handles its own argv
how to use parse-options instead."

I was under the impression that all commands with the NOPARSE_OPT
flag in git.c needed parse-options added. I now see that I should take into
account for commands that are only ran by end-users :)

> I am not sure why it even needs "-h" in the first place, but that is
> already there, so letting sleeping dog lie would be what I would
> prefer.
>
> Is there a plan to add some -Xmerge-backend-option to this program,
> and would use of parse-options API make it easier?  That would be a
> good reason to start using it in this program, but otherwise...
>

I will look into finding another command to contribute to instead after
your feedback so I can fulfill Micro Project #3 since I had not thought of
further plans past the parse-option replacement. Thank you for your input!
