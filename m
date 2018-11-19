Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E261F1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 11:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeKSWQF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 17:16:05 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45770 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbeKSWQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 17:16:04 -0500
Received: by mail-ed1-f54.google.com with SMTP id d39so21819331edb.12
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Gh6OvG2hpWjGlFod3EvWg0WXFMcXYb0lubgoYzH4Rl4=;
        b=aN1bwrHDkXHCVxARDks23zO98iqVD0ca8wvCzuk+oWyA58SHOKBiqFFFaRQa9FEqtG
         LQQRwsx8QD/7JNnI5r4oMkeG+L+G/JPiX/YU+nGkZorU0rUP3RcKKJs7MdNBzfi4Kqyw
         rF7EAlq0ZG193xvmPy3STxSnbrqcFt8ZYeATiU+M74UzauwaFal1BjRz6bGbu36hD2WT
         97OwWR57IKTvEe7qUm2gzBRQr+eAQUcUOJ4nlgpjqr7idiy3odj8IpufANesBzivMdu/
         a7V0EcfXkE6G6TsO3ZtE3lxXOWgcmW9YqN3IUnT1waHWryxLcxoZc9lkaXeG3ZhbcINr
         /T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Gh6OvG2hpWjGlFod3EvWg0WXFMcXYb0lubgoYzH4Rl4=;
        b=QEYCMcLtwMWLGjawZs6dLIbjzv8vUdUo/XrGenngaGpk6/RkElQ2ghslve6myvmCRG
         QrGHrgL3+uBHkE8q50zpavGodXtIzJJkFQlUBUlCTcscc1mQgFg27HOGSSi5ud6VttP6
         iqMrwtHTpXxrfWB8ETujxK39FBilutFr5GQaRgPSM68ioW7mCuCLduvXudAylEY0xE7b
         s/b6azBixIpqx2bMAJN+oytCnT40QRAH7GmKPYU4pjUnpyPbL1c21dFMLeiux3mY15d8
         Slw6lde/g3E272mtkUF6aFiX4th0Pdb9BuHZa+sWT6LwXI05Ll46gLPB+7v5Dmi4gX2+
         z0nQ==
X-Gm-Message-State: AGRZ1gL2yFwEYc9C+jKiiDRSa7Q2NtxUkjSw0ESn8UqR0rnwkeCatMYr
        Ycn2Q52MsLmLl37vrg8EDx0=
X-Google-Smtp-Source: AJdET5dcengHJ3avXFeDhCO9gUxd96hQ1ebDt74SBldLCd3ys3LQpWin9Qv7J5VeP+koXkdNNhJWWw==
X-Received: by 2002:a50:be4c:: with SMTP id b12-v6mr19672564edi.46.1542628359633;
        Mon, 19 Nov 2018 03:52:39 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id m13sm8783296edd.2.2018.11.19.03.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 03:52:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mgr Georg Black <georg.black@seznam.cz>
Cc:     git@vger.kernel.org
Subject: Re: Big repository on Aix
References: <BWV.5ClX.tnCYjSNZAD.1RyfaC@seznam.cz>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <BWV.5ClX.tnCYjSNZAD.1RyfaC@seznam.cz>
Date:   Mon, 19 Nov 2018 12:52:38 +0100
Message-ID: <875zwt1dyx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Mgr Georg Black wrote:

> Hello everyone,
> We have source codes in many files of 20 years development. It's approx 800mb. There are many programs. Every has about 100-200 modules.
> Company has 40 developers. They all works via terminal on aix.
> At this time we have three folders for three versions. Everybody send changes to them via script blocking parallel work.
> It's possible migrate to the Git version system. We are afraid of big local copies for every developer. We have not enough space for 40 x 800MB plus history etc. Exist some less dramatic way?
> Thanks for your info.

The first thing you should do is import what you have into git. Then run
"git gc --prune=now'.

Then see how big your checked-out directory is (everything except .git)
and the history (the .git folder).

If it's say 1GB for the working tree and 2GB for the history maybe you
can just use git the simplest of modes. You'd have 3GB of data for each
developer, you have 40 so 3*40=120GB. Let's add RAID 1 to that and end
up at 50% usage, you're still below 500GB of disk space. Is that really
that big of an investment for 40 devs?

If it is there's still things you can do. E.g. shallow clones, or using
altrenates on-disk to de-dupe space. See my
https://public-inbox.org/git/87muwzc2kv.fsf@evledraar.gmail.com/ and
https://public-inbox.org/git/87in7nbi5b.fsf@evledraar.gmail.com/ for
some details. That needs to be managed very carefully least you
introduce repository corruption, but it would bring the disk space down
to something closer to 40GB for these 40 developers in this example.
