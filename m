Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B8A1F78F
	for <e@80x24.org>; Mon,  1 May 2017 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997107AbdEAN1D (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 09:27:03 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36043 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950857AbdEAN1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 09:27:02 -0400
Received: by mail-wm0-f45.google.com with SMTP id u65so87784749wmu.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a0mJ7nGKOMTaTJt5ROQRnTsDuVD5DC+HBLh/W1zkTxk=;
        b=qapMEfXgwP251emEAi3fNovZa89/EAhu4JnntcnTF+VyIuYHk+LldhfzJUzQIts2sC
         hxtz2HGDLLmgCti80BL8rzarqrI/vTfhuW292HTcQ1SXEsvdsPenHLH2z929+i6PsBbZ
         a/3HEamPZf1HbT3LrusqcByQckt5kDiL6V/wP7WM5xoMvy915KIg17tT/5JgbU9LwPBl
         axe7aojfdhIWyEHhfM/nzukrwhw1oe2gOQ4smh5MrCZFwFVSSXwnqHCEb2tl2HypW8d5
         dIv5Q5uYhQGNFwdZ4kYT0RU4ImTwzf9tpo6t2+d9M0ElGfAnJrodx0wc/MH1po9qhkQ3
         cMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a0mJ7nGKOMTaTJt5ROQRnTsDuVD5DC+HBLh/W1zkTxk=;
        b=dotDgEdey8SHqHUclehIq93eoX3idSR6ddW/y3lk3P6c3BhFfo0/VEykI3gm8kGrPu
         F0xFN1b4eNNaqli9Yh2O89j8ozjne1ZtoLIMzVQdDJ4NDs0izl4sE7Qiou5KoEKOiWjl
         TFoGD54dKbEo23rPbeRHzjoiw+jVHimm8J4zNXyJknD0WAwZjFsiuCzL5jNi85lQqwLx
         yNsc52gW7lpftunURsuwMBStbyo2KkDgJ5yJQYzow54s95zCNc6o/V6slDjySJ1vspVN
         4du14J3BdCT8NSlhYAAo3lS63kmmidGVlpPpTuwyIoa5sVbsB18vp2q9YkG7QH3KawIe
         BgnQ==
X-Gm-Message-State: AN3rC/7A+8HEnNF/StOrE7UmyJWQgzEF69sMZ2/aLr6tOdIKauJA7w+g
        42ngerDovQmozbGK+xJhR0JOPNNtLQ==
X-Received: by 10.28.229.81 with SMTP id c78mr36111wmh.66.1493645220626; Mon,
 01 May 2017 06:27:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.160.6 with HTTP; Mon, 1 May 2017 06:26:30 -0700 (PDT)
In-Reply-To: <874lx68abt.fsf@linux-m68k.org>
References: <CACUV5oeKoVdncK3RjtusiqrACj1xLiS--z8vC+Rsvy5TF09Lsw@mail.gmail.com>
 <874lx68abt.fsf@linux-m68k.org>
From:   Tomi Belan <tomi.belan@gmail.com>
Date:   Mon, 1 May 2017 15:26:30 +0200
Message-ID: <CACUV5ocdADaXYpcQG6kJ0CaR+d+EwyaSFFReaO2ni+1CnJMvyw@mail.gmail.com>
Subject: Re: Bug: wrong documentation for git-fast-import's option command
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 12:21 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Unless <option> starts with 'git', as you have seen.  Other importers
> may recognize other options, eg 'option hg ...'.

Hmm? Are you disagreeing with how I described the issue, or saying
there is no issue at all? I'm not sure.

I know the syntax is meant for other importers, which might accept
different options. My point is that the man page doesn't say anything
about that. If a frontend follows the man page and just prints e.g.
"option quiet", git-fast-import will silently ignore it.

If you dislike my suggested fix "'option' SP 'git' SP ...", then how about
'option' SP <program> SP <option> ('=' <argument>)? LF
and saying that for options supported by Git, <program> must be 'git'?

Cheers,

Tomi
