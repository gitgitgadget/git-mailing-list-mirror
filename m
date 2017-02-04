Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EBE1F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdBDVSA (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 16:18:00 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33880 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBDVR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 16:17:59 -0500
Received: by mail-io0-f173.google.com with SMTP id l66so41998148ioi.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E5t26ApZLnCWTAD8cQPyaF1eGx7kaqQwNoYcxAlptjc=;
        b=Kky6BewgfnYZpxmHTsVVqbxNcbbJ2rcQPd7RQjKZmgirj/EK/kDnlicgAwf9uaJyjt
         Pt996baUWeqCGxWQzJHmBV+56+DFYlb+nD1/koCCDcpKfw76+1pLoaqwlx+yXpHBb6V8
         Hv23IijbkKlnQkl2EcmCP5BQgq2wVmw7JbZ59HA6PJF+hfenYiaBvGXtf0YD71Z5utgS
         EBrx4tP2yPyBzxQmHGOyyZvGB6j+obDoPjeP60uNaw4Wq0GjiOMFDTCbM2y4YtnsscdZ
         +wJWnuulKnnIW2jXYtu2ItVB+peW1kg6iljx7XI0S4/EQt/7gzxrAa75muz66DNDvAC8
         M6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E5t26ApZLnCWTAD8cQPyaF1eGx7kaqQwNoYcxAlptjc=;
        b=EfdqsFqMrR+moESni/+mJVOEgFxqNtppHUpsDMnj8DnJ4bBTy1yuA3o7/QnukjcKAy
         GCX5TGdoa2YAFRTYaqKSkdT40k6YunWbbP0WcANbZJgXWXCpp+P+A6auLt1DJ67Rgrgh
         DeFie1UefSPkjpg5IVTYRXF+0D3cSkIQ+97BQhPGAAgXhwDqK2hJeelawvdzrI9eeUaj
         oOWEU7sPuuG1HKfM4wqvihwavIL2DvFePxw2sf0je4MVJihu1SEe6WaJkf3GUZiHyEYD
         mUe3r2hzcFlkPvzUZuBtNaCzmbTKj+WDmws3SDc0gb0T1azX0mymFAyTxceNnntAp3HL
         CKHA==
X-Gm-Message-State: AMke39m0S9bE3utBIT3dR1phkXBOLDih2dcnnlRozTfbnW8wC6RSN/DoPfE5ipn4TCt8qvxMmfz2faJ9PqqHxQ==
X-Received: by 10.107.63.2 with SMTP id m2mr2349187ioa.74.1486243078648; Sat,
 04 Feb 2017 13:17:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sat, 4 Feb 2017 13:17:58 -0800 (PST)
In-Reply-To: <CAFZEwPOFDT7=1qhg4ygJpVUnfQo3XUjDoNtZ4LJvG5V9+RDNwA@mail.gmail.com>
References: <CAGSZTjLmYCyKZ1BBRv+JVYq4oX7EQcNzyxAnS_3NBUPjr3g8zQ@mail.gmail.com>
 <CAFZEwPOFDT7=1qhg4ygJpVUnfQo3XUjDoNtZ4LJvG5V9+RDNwA@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 5 Feb 2017 02:47:58 +0530
Message-ID: <CAFZEwPPyAxeU2i-OL62O749GaTdL7H19jbbAj8R6fipVnUjt=Q@mail.gmail.com>
Subject: Re: feature request: add -q to "git branch"
To:     Kevin Layer <layer@known.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Kevin,

Sorry for the previous message.

On Sun, Feb 5, 2017 at 2:47 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Kevin,
>
> On Fri, Feb 3, 2017 at 11:59 PM, Kevin Layer <layer@known.net> wrote:
>> It should be possible to quietly create a branch.

I think `git branch` is already quiet. Are you seeing something else?

Regards,
Pranit Bauva
