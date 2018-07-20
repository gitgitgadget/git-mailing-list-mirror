Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7731F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeGTWVG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:21:06 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38294 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeGTWVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:21:06 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so5168209ybo.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AvL5ZZ9AQDWqfXs7r2mhhHiYcIFqJ+FtVCU7IkrLsBE=;
        b=F3vQTsXTorjCBKnomNiGwZgG9IKgyxf/tGlp7Rm8LTRJ1HBIKyj6XBBmi786VQr8fv
         QHkBk309AqOqfHbBPJUOy0T2r+pO37ToOsRq4S1iKKYDFUtu+xs8xWC2r+CJor+pm3Su
         Aaw0+RNjYZeKlLjzJirfdbBMIDQTk4WpQ3kMQQ17SIRzy+v0odBQ++UcGM0uJyX+jANE
         qo8sEXOeMMGawTLZGmnKc/5HjCW7ncem5/1PkpR8ZjVdmWnjqjpCCYeggUMPTgN5SPn/
         PYkhPauTz8B+r5lTNUNxHlvwEr/qhh0AQe54OncrKJHAtGhgvpfY2Rsxu2QXOKfm73C6
         8/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AvL5ZZ9AQDWqfXs7r2mhhHiYcIFqJ+FtVCU7IkrLsBE=;
        b=c6cJAlWs7MOzIvuZfQMnrnHfjLePOmPEvp0NmqFneUIe/ANX59iPkXVMN4gWiTujZB
         /QYLxi08qRD2NS9Xk3ZwwmqWO7QNwbAG/Lye8xkmPJxoO7YNfw0jDfDIzxck1P+SmVgV
         YdiQYFNspl/YEKWxE1oV12gUcuWLg4ndkWbMiqk76fZMGQwfz6EuXHo7nOYsv7pPFwV3
         56jfWibdC1RJTGFxHUzEOkQXjSGiSzSAr5kagi01y0DPSkTMaUtAAajwFBB+DIQR0+eW
         7UV9cYRVMN3mGbuO89N3N/7GHqQoRVP3jHjA6VsfJf4HnZ8j/rv97wYn6oxFUeGCQJ0c
         vVNw==
X-Gm-Message-State: AOUpUlHYYu6EgnKR2rPLHbwG177ez6is9ijnb9Ct6fFGKRq364PFGasD
        zcq8vVD8k3yCzUBkoh9XVrh3hI6GNqcwo0CIqInFQ7GsgWg=
X-Google-Smtp-Source: AAOMgpedKyHZeawBDxzSUhg8HwJNYQR6IBUzLT8/pwok7AUsO9WuvEuR8Q9zBzrNQOX4rPyHnSvpJErd9/4+Alw2tsg=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr1984917ybp.352.1532122260862;
 Fri, 20 Jul 2018 14:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
 <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
 <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
 <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com> <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet> <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kaLTJDmWhS8Y8R1cQh9TRXLawdoWHEzVC6PLHBN+VQekg@mail.gmail.com>
 <xmqqo9f1a9ct.fsf@gitster-ct.c.googlers.com> <CAPc5daW-KoyUX3i7M5YbdQC2mFKAmVBS42-XT84hpm30VFcZ1g@mail.gmail.com>
In-Reply-To: <CAPc5daW-KoyUX3i7M5YbdQC2mFKAmVBS42-XT84hpm30VFcZ1g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 14:30:50 -0700
Message-ID: <CAGZ79kYBRj-YLM-eCkHF1oMmBfTAeOQk6hTAD47HuoLa4QZjvA@mail.gmail.com>
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20]
 linear-assignment: a function to solve least-cost assignment problems
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc list
On Fri, Jul 20, 2018 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> ... which means that it does not matter if I have an elaborate rewrite hook
> that constantly updates the reverse mapping or if the reverse mapping is
> made immediately before I push out. You wouldn't even be able to tell any
> difference.
>
> And for that matter, it could even be made on the receiving end by you
> after you fetch from me before you need the reverse map information.
