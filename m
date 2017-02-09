Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7E11FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 10:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdBIK3S (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 05:29:18 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34685 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdBIK3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 05:29:17 -0500
Received: by mail-qt0-f173.google.com with SMTP id w20so186886268qtb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7KLLJ/Uur7Z4Nc6UI0OoIWmnl2J2QZukPjU9cmWLZdc=;
        b=dumLoTox0qQMiQkbc91W7ujQ9vbXM59WuBWLkBbkHjT5ChBHewOpP9ks4yMY7B4mLA
         NbTTHKoTxoMiym/PtU9vLtZ6lqq3OLaOufBLuFWfh99pLAN0qJu8AGBn7WpUMGt++wvz
         /aZ2BpyOfTi3Km/mvKjmkd3WdTdyNYsx2kRvSzSBQd01Gtu6K13prAGFH0jEUvPHkylX
         fVeA02Im5nKtqmnrZ9KUZSXfUhkS6MUxx2gMgFp67Zv6FN8CPrZ/w1cVYwLRa0lxXXQs
         LHsclKyGTfUFixXgh4IbgRCfog46q0/DnbjJyxY/zzVPmrnyhNSNByd5H31spJgJ8MZm
         m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7KLLJ/Uur7Z4Nc6UI0OoIWmnl2J2QZukPjU9cmWLZdc=;
        b=HkMbLCOXg7Nvk3D5DCDLt3qsyzl7e4HxPrgpWCSLqetEN1O5//tRtipTsFrfEhB2oz
         PsVtRixYtw26PUlwpNNRHpaSPY7VIG7XDCP/IRNy3zLBLIKwAb7xjyBYDxbI7r/3y6A+
         PkRy0vCSpO87byiG6H0nYPpTnE2xgLLZwEeP+DqQzZkBjvXfs4fXQUz8vfsEJiq1eHjg
         4fX+EO0ykW+CLiqeEBYJ/5+uD7bleScIYmDwfjFP/ixSNWnpDjlk3VJR2EjugD1UvMJz
         BKCdsCESbtx75MBSPEKXYcKuQGOi8+IIHqEDL47vzFRop7Xj2V7bOhkweOhp8D8REqQ6
         obLw==
X-Gm-Message-State: AMke39ndphUHfKajw7jMBqSwakn4qriAJOE1zg9fvLypugmeb5GBew7fIYB2uMeZ92J/VEjX7betEHJg+b3Nbg==
X-Received: by 10.237.42.69 with SMTP id k5mr1943341qtf.214.1486636156272;
 Thu, 09 Feb 2017 02:29:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Thu, 9 Feb 2017 02:28:35 -0800 (PST)
In-Reply-To: <vpqzihvpt41.fsf@anie.imag.fr>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
 <vpqzihvpt41.fsf@anie.imag.fr>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Thu, 9 Feb 2017 15:58:35 +0530
Message-ID: <CAN-3QhotVm-LmOJ4cuKCa2txYxFJMHY1aqbX1GznieQx57AR+A@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 February 2017 at 15:45, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
> A non-quoted but yet important part of my initial email was:
>
> | So, as much as possible, I'd like to avoid being an org admin this
> | year. It's not a lot of work (much, much less than being a mentor!),
> | but if I manage to get some time to work for Git, I'd rather do that
> | on coding and reviewing this year.
>
> and for now, no one stepped in to admin.

I would like to point everyone to this reply from Jeff King on the
original post: [1]
(In case this was lost in the midst of other emails) It sounds like
Jeff King is okay
with taking up the "admin" role.

    I do not mind doing the administrative stuff.  But the real work is in
    polishing up the ideas list and microprojects page. So I think the first
    step, if people are interested in GSoC, is not just to say "yes, let's
    do it", but to actually flesh out these pages:

>
>> Someone steps in to do what exactly?
>
> First we need an admin. Then as you said a bit of janitoring work on
> the web pages.


[1]: https://public-inbox.org/git/20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net/

-- 

Best Regards,

- Siddharth.
