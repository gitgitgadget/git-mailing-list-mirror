Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCC11F453
	for <e@80x24.org>; Sun, 23 Sep 2018 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeIWTEs (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 15:04:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37477 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTEs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 15:04:48 -0400
Received: by mail-io1-f65.google.com with SMTP id v14-v6so15709870iob.4
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0X45yJcaWxyscWF0eU9mE7lMBGePf7kgrOWob8sdn+o=;
        b=DZHtCy+ajQMjuSYyHK9z/An4md9a1jIZLQoyR7v4dwpFZofJPRfZkcNgm/jtFEb7Ys
         ViXp78amIKl+/wsP+1iCgeMzaj3dtXEUcGE25lYnFAJVDppJtLbErMsrGaRVgMJw4QMR
         3QqAL/Y5LOGfpYHV0JgD80j6cuq064IeY9D7uYtBiVvtUYsr7j3suMykLYeBexoXstlf
         PkeDdD2VpREIq1f/t/zZiMdjFiQltxhuS9W6zDVCVsfvwpR9ZUe/zWTstcKF1tFUzKer
         LlmYt6nQqD8xfkXgNTpxL1EVLh7ibcv37EHNqQegSQ/o2hwgfDTCK4WbwNEEV8ZlxqjY
         F0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0X45yJcaWxyscWF0eU9mE7lMBGePf7kgrOWob8sdn+o=;
        b=qKwS6xgVLd0OdRLkVj16yrQSoc38JVpgMBoCcCLjjreOibilNexMate8cULeJa1YXD
         PozrLjWn7LhOoImauBSWOP5ps4IFFMyDY9tVk532llrUQQ9Z9Jwn8+qqoIOUjYRXfs1e
         TuV4AztytrqD/3xUZx4OyYel6oxupLJTGUzudd/SIoBC12Poudsex0a6G6m+6/U6at45
         IRFr0sLeriAg7rPMeey/ofd8wVsAsHZ7v3ihgG5sUU1vM5X3RSjrAJUJiEdjkPSDZPhT
         eygLESVE8dcrtcc6gUyWtmmRkXYCgJPgqH8/m1Ne2jT+E1AbAclnjLHErNBHs4lxYrEB
         uHQA==
X-Gm-Message-State: ABuFfohP5ZCb6Kwn1cjFKFEaywhNB6QFmfIvalowKVjAOoKEYS/lnIub
        i3OfcEl2rtpQaXts2qAROM1q/FvluH/nhaLnKqk=
X-Google-Smtp-Source: ACcGV62IMX9QYflbJ3oMMKan9fvS78+v1aUjWP2JhFqQLSKnFU662tXrCxRjGoL7b5Zq9lZevDP3VZdjmpJMog4MlmU=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr4286550iok.236.1537708042344;
 Sun, 23 Sep 2018 06:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <315083291.15466.1537536854535@privateemail.com>
 <20180921222454.GD11177@sigill.intra.peff.net> <87musajun7.fsf@evledraar.gmail.com>
In-Reply-To: <87musajun7.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Sep 2018 15:06:56 +0200
Message-ID: <CACsJy8C5-kFivA5eEJu7pKA5=PajW5rLB6V4tVEueMtr58QC=A@mail.gmail.com>
Subject: Re: Very simple popen() code request, ground-shaking functionality
 openned by it
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, psprint@zdharma.org,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 1:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Duy's
> https://public-inbox.org/git/20180920161928.GA13379@duynguyen.home/ is
> another recent thing that reminded me of this, i.e. that suggested
> "\\|/-" spinner could be made much neater with non-ASCII.
>
> >   1. Add a trace_key for sending machine-readable progress output to a
> >      descriptor or file. E.g., via setting GIT_TRACE_PROGRESS=3D2 in th=
e
> >      environment.
> >
> >   2. Teach the trace code to open a command for piping, so that you
> >      could do something like GIT_TRACE_PROGRESS=3D'|mygauge'.
> >
> > That would make your use case work, and I think many other use cases
> > would benefit from both of those features independently.
>
> Yup, that's all sensible, and would be great both for this and other
> stuff if we wanted true extensibility for this sort of thing.
>
> I'll just add that a 3rd thing that would also make sense would be to
> add a feature to configure the value of these GIT_TRACE_*=3D* variables
> via the .gitconfig, that's been suggested before (too lazy to dig up a
> ML archive reference), and would make this as easy to configure as
> Sebastian's suggestion.

I'm less concern about prettiness than showing numbers that are hard
to interpret. My other option was just showing ".", "..", "..."
sequence, which achieves the same thing.

I'm not opposed to having core.progressor or something like that. We
already have core.pager and this new config serves more or less the
same purpose. But I don't think I'll put time into implementing it.

--=20
Duy
