Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B59D20966
	for <e@80x24.org>; Mon, 27 Mar 2017 09:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbdC0JbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 05:31:09 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38458 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdC0JbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 05:31:07 -0400
Received: by mail-it0-f42.google.com with SMTP id y18so45948995itc.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEBXVW523dy4jiF0r7+Pkvf4CtL47QrLw/rnlW7fQg0=;
        b=alsJlqLvWMKlLPuGhPYluhIGJkLKeCcPYE1Qw/U9xWFGzDvztKeNbPhAdTk2/k4uTM
         eH8CT4CTYYc/DgvZ/H/UQsVObdj/QPR96QVjv3zWVbNTkvYYPJ0qq3YirFgmLJsv36Mi
         xr1hS6QS53h3T0vWNAGSXbG/Nc4ntWqq3dqF67X69ei0w9uJtGqMg68k9dhL70bb//NL
         XQsjvXbBPZyg5YeJ3+JhvLc60EhbRwi5F/ajWtcu7IRZ7MZbagY24CpLNGz1ouAdjxNo
         PezRWNDRsXDMY+q0gQj+khm++lVHAvUzC2PadgCVBF3nlie8ub8JQLReC9HslzIyy9FE
         tUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEBXVW523dy4jiF0r7+Pkvf4CtL47QrLw/rnlW7fQg0=;
        b=HCjvkapvJ/JfiI4qrcaWLFC5Cvy8PMvGElYcm6g0jz4aK2rTFBZvY7BQN/rVLQgcHL
         MqkPolnOyRirxaYO7zcF6/2PAY8HH8Y6/HT1PuXhrzYuc/HDqscD7VaSSyct7B0kE+j3
         z4lm+ZiDzh54sVgjIz2m7bocFQuJCV10M0YARdslCQDsmhUsWMxF1Gc1DXZXeY5w9Bgu
         BEnEum/yAPCkvp1BnT8a4yQ7E4TrvoGUAODn2ByXZg6rzM/IjEzNahQ9T7E7Pbpv4fdO
         I+llwPeJ2v51FB03E4u0kPPGHZidqKZQgauoHjxvWX/Yo0vIAfHfzyQR/OOKplCQorSr
         RpqQ==
X-Gm-Message-State: AFeK/H2HKXO7x99ghf9oHvA8vSankFf3TiHzJq3H1j8zpnGFgecflP3XihxXVRIz+wzqkSXUNvXnfE6NCeoBMA==
X-Received: by 10.36.90.144 with SMTP id v138mr9486389ita.24.1490607042322;
 Mon, 27 Mar 2017 02:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 02:30:21 -0700 (PDT)
In-Reply-To: <1490375874.745.227.camel@locke.gandi.net>
References: <1490375874.745.227.camel@locke.gandi.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 11:30:21 +0200
Message-ID: <CACBZZX5buDHBy+aHWYVugdg=jyPgHOmgjuRx6NQTQ67k4_WU5w@mail.gmail.com>
Subject: Re: [PATCH] push: allow atomic flag via configuration
To:     Romuald Brunet <romuald@chivil.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 6:17 PM, Romuald Brunet <romuald@chivil.com> wrote:
> +push.atomic::
> +       If set to true enable `--atomic` option by default.  You
> +       may override this configuration at time of push by specifying
> +       `--no-atomic`.
> +

This should also be mentioned in the --atomic documentation in
git-push.txt itself. See e.g. the documentation for pull --rebase for
an example of this.
