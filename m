Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1AC1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdBFQjI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 11:39:08 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36175 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdBFQjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:39:07 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so128004456wmi.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PcQ1EE/WoMo2GAcBd1QLkuBPjMKK+ONrJEnbPBsaNDQ=;
        b=QeikFy+zv780AJkaWT9qt7NJ5sqsLzOZeGxrwwgTLMwNGmZazFyAWg5g4kJnvG9sJV
         pAGY6LvH75y8LPn/lvsFM4ct64QsL0lrl3ENZnREsC8lBYbXn8G44l3ks+QQU9M65+uG
         Zz5Ss51yyIXxxhFQRwUQuGnYAQNP37pzZLl44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PcQ1EE/WoMo2GAcBd1QLkuBPjMKK+ONrJEnbPBsaNDQ=;
        b=E3kL57WL6QoY1Kjd9mZahjfB2E52Cuijv7V3TCJH9ljE+feULrqpII3edDpzv6OMai
         LzahDEV7xFfVuQC1OWltL18AUZWy3BikJfHxTpwc4SNhbyoEXxAASrYzeM1gxwwS2LNs
         8G+Xy8Fpl27DOULkJSkVujXWVs5GDrEyctfJu6NdHgnRTXa6UTQbSm0nl3NvRScGnxJT
         GDHvOtk2FFhhuWrMg3th5Of2Et8vUd51j8mS3aVpJcXPYvUSHnv3N4AJb2KjoYq1Wc+W
         MmYfQgUYmPnSL3F6PbUfd4LRByCqiwsVwWildjkkKjYKZ5HaXetnPAiex+xRmvWOFsd9
         nmyA==
X-Gm-Message-State: AMke39kgkfGIvZz6zdHjELJ7qMg0lBw5N00U1aQ7f9PJ8rIpegQpUNz4I2anqpeRYtOdR2y5ecYee+bsP/q9G0Ge
X-Received: by 10.28.92.193 with SMTP id q184mr9991469wmb.139.1486399146126;
 Mon, 06 Feb 2017 08:39:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.76.1 with HTTP; Mon, 6 Feb 2017 08:39:05 -0800 (PST)
In-Reply-To: <CAFZEwPPyAxeU2i-OL62O749GaTdL7H19jbbAj8R6fipVnUjt=Q@mail.gmail.com>
References: <CAGSZTjLmYCyKZ1BBRv+JVYq4oX7EQcNzyxAnS_3NBUPjr3g8zQ@mail.gmail.com>
 <CAFZEwPOFDT7=1qhg4ygJpVUnfQo3XUjDoNtZ4LJvG5V9+RDNwA@mail.gmail.com> <CAFZEwPPyAxeU2i-OL62O749GaTdL7H19jbbAj8R6fipVnUjt=Q@mail.gmail.com>
From:   Kevin Layer <layer@known.net>
Date:   Mon, 6 Feb 2017 08:39:05 -0800
Message-ID: <CAGSZTjLx5ftVYkO31U1NrGAdw-LGHjKU7=gtqaoe3VbQX+Bwrw@mail.gmail.com>
Subject: Re: feature request: add -q to "git branch"
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I got my git versions (old and new) mixed up.  Sorry for the noise.

On Sat, Feb 4, 2017 at 1:17 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Kevin,
>
> Sorry for the previous message.
>
> On Sun, Feb 5, 2017 at 2:47 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Hey Kevin,
>>
>> On Fri, Feb 3, 2017 at 11:59 PM, Kevin Layer <layer@known.net> wrote:
>>> It should be possible to quietly create a branch.
>
> I think `git branch` is already quiet. Are you seeing something else?
>
> Regards,
> Pranit Bauva
