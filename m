Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0509C1F859
	for <e@80x24.org>; Sat, 27 Aug 2016 10:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbcH0KwZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 06:52:25 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:34353 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcH0KwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 06:52:25 -0400
Received: by mail-yb0-f174.google.com with SMTP id d10so34770322ybi.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jOrgB2VDMZo0riWzxbsZk/wDaUiWarE+Raim8KAy+ME=;
        b=pwNpnAigATyP+4+SXF0QWur9Qy0tSxhYlFZphcJwOBSHCnYQ4QKnnuOmcfWlHcix9e
         AOHFQckH5qfjsTAUN1XDbfwbjA3VfRGJep1EeBw3DEQEyKe9D2vq8NNiFcpPwVwnxWes
         fUVzq07wXCQqFTcGSshCSjtW3USOa46UMskr/YWDqnJgYmAJRHurXnQnz065UvAPNKEl
         AMVsKnZGafNACyzCJyHedIbe9rBeA0D0wCBMEZY5rh5HXoRk545s4MNI0kggUHyx2EnP
         8R8poaW3VxsdZrs+L0pOc0XtMWvf9f3wlx09usWkdonEEwoh9sPbowHAzOiFQFhKuTRy
         QvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jOrgB2VDMZo0riWzxbsZk/wDaUiWarE+Raim8KAy+ME=;
        b=XJGBQVOvLfe2oKLajQ9+jWQuTXcTO2IDt4leDBd6LdPB+X4p/4ZddWoALqiA4CHaBV
         k495h2PQtYGsymTcpzq9o35Wd72Se5kKhoBi3C+NWfXQP+DpEPy6vQJ4cL5cBS6jYj1g
         PA0YV5Mt/oSsvfQ89xwnEBZtLDEoNCK2P/2S0WLPIY9vX8oxD2VPM9pYvAULxGLE1+X/
         07Nx8tpWwW0rPFFVvm28+3igpCUhg9Bk1aWXgKB9BlKHAdlb5dPa8E5szqWLyK8jH8FI
         JjORr1QvDVQg+xXgscuaovcLVz+HDQ+CtKzBPfZOd0RQiKVpCCH6uJzLAjxFJsasR+BX
         GK5w==
X-Gm-Message-State: AE9vXwNbPPUznbE5WWROTbpgFBqlC1Q3U48P9JVnK5YuqY/qgwh7yMVJpCkX0g7bGMO8DnReMHFKS8Qmf2aWhg==
X-Received: by 10.37.215.211 with SMTP id o202mr6732878ybg.154.1472295143803;
 Sat, 27 Aug 2016 03:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 03:52:23 -0700 (PDT)
In-Reply-To: <xmqqshtrijdn.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
 <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com> <CAFZEwPPfXvLUtcBR6cYAP2dT8FAePFPjDSnVm8BhpLN9cfR1uw@mail.gmail.com>
 <xmqqshtrijdn.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 27 Aug 2016 16:22:23 +0530
Message-ID: <CAFZEwPMBy0Ovcq-pUJkhoLiVF+uvm5fC0PD0RGPKobZ83Ciy3A@mail.gmail.com>
Subject: Re: [PATCH v14 07/27] bisect--helper: `bisect_reset` shell function
 in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Fri, Aug 26, 2016 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>> Also this version fails to catch "bisect reset a b c" as an error, I
>>> suspect.
>>
>> It didn't when I tried it right now. Could you please elaborate on why
>> you think it can fail? There might be a thing which I haven't tested.
>
> My bad.  I just compared your bisect_reset() implementation that had
>
>     if (no specific commit) {
>         reset to the branch
>     } else {
>         reset to the commit
>     }
>
> with the original
>
>     case $# in
>     0)  reset to the branch ;;
>     1)  reset to the commit ;;
>     *)  give usage and die ;;
>     esac
>
> and took the difference and reacted "ah, excess parameters are not
> diagnosed in this function".
>
> Your caller does complain about excess parameters without giving
> usage, and that is what I missed.
>
> I am not sure if you intended to change the behaviour in this case
> to avoid giving the usage string; I tend to think it is a good
> change, but I didn't see it mentioned in the proposed commit log,
> which also contributed to my not noticing the test in the caller.

I could include this in the commit message. Its not really something
which we would want to test in the function because to the function,
we are not passing the raw arguments. Since we are removing that check
from the function but including it in cmd_bisect__helper(), I will
talk about it in the commit message.

Regards,
Pranit Bauva
