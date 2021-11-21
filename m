Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744BAC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 17:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhKURqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhKURq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 12:46:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092CAC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:43:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so66581908edd.3
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:message-id
         :mime-version:content-transfer-encoding;
        bh=DkHHo4/YQ/Xwyr6mSbmeClDXBqR0Jgd4rqlKvTW9w7k=;
        b=gFDtAaiz9AkSTcfwX1k/I5/0lBvy76c6B1XJu2CgOjUZ9OmHnl+yvQYzJ+W1TXY6O6
         cTV/fKeZ/xwWXqbwO9UzDNvsBz7y3LM7rmUsiVbF20QZP3uffl6usq6z3DrY4TS6kxuF
         XcrZuxFongiobvP671PCbCrJrEMlPwj46C9lp3idT5eXNXWnVKz3UGNBjOO7wN84tIxE
         lDdQusezYeOZtj6ESqou0wVCSmz02FpKWBvjv5TUZhoTw2yEDsOupE56/SfMqvOaV32K
         zGJKbkGacvjdhrGATFrjvGNTVK3cSwoA+Z8ud00DvvfZYEBN71ziAU1oOR8roipspOFu
         HJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :message-id:mime-version:content-transfer-encoding;
        bh=DkHHo4/YQ/Xwyr6mSbmeClDXBqR0Jgd4rqlKvTW9w7k=;
        b=eJ7/1DrQzUc1EreW3LgGs44DQPgA8QKuve7OjMAnNK7QAKy4yld6CbP477MCmmMspG
         ZqeH+hhCMVHjfvqNOfC3nWwwPlpIIQK8pkQBJuXQZs4WMGlx+Iks4JHI7/744gwjhdc2
         yiTxMrWMSQz44XrWxi2hmW9EMisMAAZyet9S9fJovxLoky9JiS5FiwMcYLO5weYQCROb
         /JDZEfRUt9M5g6Ya1TH6xjbtf6posbk2mVzz0/nYD1RuayHQW+GPDT/A7ZGXXDizRz6+
         dx+ql9qtniM/jkU0/bn7MF11Y1nztKhFLOXiwe9yJNAnDc7XbYyiuSfDozX2+P2ZESWd
         fg2Q==
X-Gm-Message-State: AOAM530K6trPAqPmzfpDF7tIQtGXTHJ3g5XjHQw/G09lYJ2c6Zmy2qNx
        2NYScIH5c+Kzp2qqlkFgf/8pBh2WYOE=
X-Google-Smtp-Source: ABdhPJxhGlXcPl609elcgM+mwpLjDR/zQfJgzL2/Ah9LBJDVhg3fdDz+PzkmpfWFJSaSoDqMCI5egA==
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr53646113edw.234.1637516600414;
        Sun, 21 Nov 2021 09:43:20 -0800 (PST)
Received: from gmgdl ([109.38.153.63])
        by smtp.gmail.com with ESMTPSA id y15sm2940062eda.13.2021.11.21.09.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 09:43:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moqs2-000wMx-NJ;
        Sun, 21 Nov 2021 18:43:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>
Subject: Death of Gilles Muller
Date:   Sun, 21 Nov 2021 18:31:50 +0100
References: <alpine.DEB.2.22.394.2111191921100.18418@hadrien>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211121.86fsrp1k21.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Forwarded from the coccinelle list with Julia Lawall's permission]

On Fri, Nov 19 2021, Julia Lawall wrote:

Gilles Muller was the person behind the scenes of Coccinelle.  In 2004, he
had the original idea that led to the development of Coccinelle, he
oversaw its original development, and over the years he ensured its
continued research relevance, which facilitated its ongoing development
and maintenance.  He passed away on Wednesday, November 17.

If you are grateful for Coccinelle, please consider making a donation to
the Centre Eug=C3=A8ne Marquis (https://www.centre-eugene-marquis.fr) or to
your local center for cancer research.

thanks,
julia

