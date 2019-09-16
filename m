Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B781F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfIPRT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:19:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38103 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfIPRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:19:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so372348pgi.5
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6+HkIwVuMC6wvVBzuEUkjpNLRrmen9S46iLkGrAwx0=;
        b=mEiRw5yFU6j5EFzrKQsxpxRLpLvQPdX6L8yAX57n03cku9djxKeB4rpAqTXQILs1+G
         JvWdd5dKi0U9HtDpfZHd3P3i1IvQx4y90/rPPMbpESUs5FJxnbH8Cid3Cp3FCXbubLT/
         +yMRMHvCf1umhfjEx0G9ELrZKSBsjAAsltq8vPmmGf0naTen7JBYu70VZq8bsmHcskZo
         Rt5p1u5j28pw72h7V9KlXl3KiqOXM6Cdbdac8EZmd1LLzinO5JJIdFQWmNsJ0xORqoXU
         r9riJHcjKya29uTcMrgxeNS0Wj6X/f7S5uFyR/G3Sv2CNmOhwl7l7XfO3LUSeyb13g12
         atNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6+HkIwVuMC6wvVBzuEUkjpNLRrmen9S46iLkGrAwx0=;
        b=lKl2zcqiR6W3dMI+GWOTXPBIsoiKymUQUhawY9ziHej5iMxRTN+GR2Qft/nwgSuh47
         pc0yuZxj+zPHZm7rRf4Bc5MgdDG8X52o6a792jQnXjOm0Rf+e+soVluY55fjnTKznLvQ
         woADStyRIv8XU0htXeYMyKvnmyNSRJsIt+/uz4NcclcqtvTsvUHZrJw7du4YDz0jAoqA
         uVOeFH2ghT9W5E4OKwoMwp14aDcwnoe4jAr7AStNLx4SJqsE9m9ciFAjnhETXG10L6E+
         l86Geo8TOivlgsW3xaaxYLei8Etrw75ESb5jLRYbgZMsHj9sqqA8ODJlWiIiodoRY9G5
         8EyQ==
X-Gm-Message-State: APjAAAWZZ+BF4uRvNo9roCGtKuElRpnVkF197ZVKUmaMwwqa3ntSVvh6
        8I3uJGfa4y3BKStH7sCm4Iw5x+QtV93wcEZrsSQmOkjt
X-Google-Smtp-Source: APXvYqx2kLdShN+UQ0e5rw6JkR9xNywT5obFOTg4jWycL/Q1e1VJnxYfJH0e1+5M0uWqLlwJb6KsaWXrnSZTnbYyjhE=
X-Received: by 2002:a65:4841:: with SMTP id i1mr214724pgs.316.1568654395627;
 Mon, 16 Sep 2019 10:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
In-Reply-To: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 16 Sep 2019 19:19:44 +0200
Message-ID: <CAN0heSoaYf0_2FhKQNnswLvFppu=dyBcKGYB_Jd=uF70yjNiCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff, log doc: say "patch text" instead of "patches"
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Sep 2019 at 21:26, Johannes Sixt <j6t@kdbg.org> wrote:
>  I do not have the toolchain to check that a correct result is produced.

But I do. I've tested this patch and 2/2 with AsciiDoc 8.6.10 and
Asciidoctor 1.5.5, as well as with Asciidoctor 2.0.10 (on top of brian's
recent patch so that it builds to begin with). They all render this
nicely.

Both of these patches seem like good changes to me.

Martin
