Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8B820248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBXKGB (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:06:01 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42688 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfBXKGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:06:01 -0500
Received: by mail-lf1-f47.google.com with SMTP id p1so4722830lfk.9
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vjpIMmqtWdOVHsD5NvyjmfvwfufyhXBa3Mn9VKrrKec=;
        b=hTr/kYyF2sxQBTbojWV/oUpaxs9M11ifbDExl7pKM2cBXsnreeOeoZ7p+LI3VfK9Ug
         b1mLFH7q03UZcQDuRy6tSatz7d7PDD1toHBfm/FYWTaYjG2X1tRKHBSMNhwrF1Z0lVzm
         DqfG9HrfJBNoklCGK9H45XKRCKvzHhdS4Hg5LGXGZrjKrCy1xpUFgzeSi9TuqgINw/pJ
         jL0I0Tg5A+pQ+hgq5/D7A2ooR4SKJlvdZeKvTiIklGq7hDkPpBBdLcGKm4z2O9gyzGed
         kNBMJScpDzBd83r6RAW7QIy0sn5Ia8jEdkVOYBQkZ+5/eMaWPmVAqJRT34U0yRehyZGB
         X/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vjpIMmqtWdOVHsD5NvyjmfvwfufyhXBa3Mn9VKrrKec=;
        b=tw0619jXua5TiuIiKdGdolWu6nNS/5TK2d5atBl8xBuAICsSAjF4l+P/VFTuv7NUL5
         YyN/vWvbpvV3rz/kJEtRyN//X53EgUhxNqDSODpZRZVv88DzVRRBlmm4rjYHel96k7ME
         MXc8m/tjydUvv+VWJ3CzFdaNTcVBS+M37EJM4EUcV6eHiW0EpqyMuByCXizfCZTxC00f
         Dr+S5c/bw09uklo5xBjV9oYv0pzSNV/eB9+Oj9tBOfFqnFpdOhL03KtKg+jgxr0JnGIX
         JAIZXdzOU3iaUnl4bnL9+0lS8wiaPCpmIIqHHsGs9JyBKw3AKtDA3qrk/T/Kj5MC2djE
         5+8Q==
X-Gm-Message-State: AHQUAuZS1SSO81iRf7MLoU+BUO8q44JW389VxA05Py1Pd2yTzm2W+m4W
        5Tzr3zPyduk+C9m0FWGAuQX6dOPzEZ6DqVQf5dpQRfII
X-Google-Smtp-Source: AHgI3Ibqf7usoDrGcCPGYIgLNZJdn3yGCa/aXTLT35qqRt4fguNNUrLVhepQxlpMXDvcT5Vq5DToCqOwTN+PxldprlQ=
X-Received: by 2002:a19:9112:: with SMTP id t18mr2961265lfd.19.1551002758458;
 Sun, 24 Feb 2019 02:05:58 -0800 (PST)
MIME-Version: 1.0
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Sun, 24 Feb 2019 15:35:01 +0530
Message-ID: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
Subject: [GSoC] Introduction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello
I am Rohit Ashiwal, a computer science and engineering student from
IIT Roorkee. I am a git user for 2 years now and want to contribute
towards its development.
I have read the microproject list available [here](1) and project
titled `Use test_path_is_*  functions in test scripts` caught my eye.
I want to work on this one if anyone is not working on it (I was not
able to find related threads on public-inbox).
I am somewhat familiar with git's code as I was previously working on
git-for-windows and I have solved 1 [issue](2), which is a reason for
my concern. Should this count as a microproject? As the webpage
instructs us to work only on 1 microproject.
If you disregard that contribution, here is my approach to solving
this microproject: search for `test -f` in `t/**` and replace all
occurrences with `test_path_is_file` and similarly for other mentioned
commands. Is it correct?

Regards
Rohit Ashiwal

[1]: https://git.github.io/SoC-2019-Microprojects/
[2]: https://github.com/git-for-windows/git/issues/1970
