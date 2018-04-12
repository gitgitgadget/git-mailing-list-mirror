Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB4C1F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeDLSr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 14:47:26 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41243 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDLSrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 14:47:25 -0400
Received: by mail-wr0-f175.google.com with SMTP id s12so6052844wrc.8
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:afrom:user-agent:in-reply-to:from:date
         :message-id:mime-version;
        bh=mGvDLYBtUZFUIkiRQGm2x2nxACdNdGxHdTYhZpDnsK8=;
        b=f6N7gcMCif6MRBjfpIcG2WGnibKl0qZk2p264HKlIcLfZL+hnHjLj9bcKafPYwuIeL
         c2ESLfxzAFotmLlHlKmM19ysUGuoUwmSKagW0+YMzGUzW7gBSrIK8ZVuaZouA06LQwBW
         WjJkrGocOLHZFMMVx8d5GMqocfEmQmaCEf9MUUUkzLeonjPkmGe/5dhacw7z5Kys817W
         zrU2n6VOlB3K+Md2tCERnZbiwu6GX1IasYRpROeWFn2Kp+DAiNFZH7RpeIZ5pnLQVfpI
         n/4WRAp57DrI5/e2l+iH82yqT+WKUHqHsF17I7skk9hT/GiFj+1TXVO203Axqdh1Vk6I
         o9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:afrom:user-agent
         :in-reply-to:from:date:message-id:mime-version;
        bh=mGvDLYBtUZFUIkiRQGm2x2nxACdNdGxHdTYhZpDnsK8=;
        b=UN9+OsTpjhMS5qXrb7GXfl+WotfFoDvIuTNZ4lc/g587YHg85OgPr489loCmZ6reSN
         wdG7cMS4xxbD/5d/2K/ZNPmBLy2bGtaKaLtNKzWjcvSPyGQlmrv3AXB68ndRjYMilivH
         lmtJ/fEdoTpbKvzB56jRPKjKQ/7susEJCacfRAaguXkqOtLg6pVX7SuHSm2seghOyCEZ
         +UZ4WQb6Ma0GP/XGEn0jplOgBgg7xFz6tQz3PExciqRReAGb04PInfvCRlcsgywS1bDi
         M8HxO01Dv/YTyQ1w29z07L0uJ/BYOCsjczaRW7UyjSNPNOARF/KooLU2nBkGG4elCvPk
         CbDA==
X-Gm-Message-State: ALQs6tCls0eqOjAl19m1mvz5T0f/NfkWnVoVutBZ7SCgcDcHUrtbBF6N
        vWquljV6TAPriVfkrjiGrt90kUxN
X-Google-Smtp-Source: AIpwx4/iU7bCVAaT1ZRs0A/ZcZvcFRkpM2EtjmqTEnvl9z/t9Rs5Lq7YXnvTZjHFUl6GLAFOB682gQ==
X-Received: by 10.223.144.110 with SMTP id h101mr1611507wrh.167.1523558844215;
        Thu, 12 Apr 2018 11:47:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c130sm49421wmh.33.2018.04.12.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 11:47:22 -0700 (PDT)
To:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Cc:     git@vger.kernel.org
Subject: Re: File versioning based on shallow Git repositories?
References: <hbf.20180412fvfi@bombur.uio.no>
aFrom:  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <hbf.20180412fvfi@bombur.uio.no>
From:   avarab@gmail.com (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Date:   Thu, 12 Apr 2018 20:47:21 +0200
Message-ID: <87d0z4b6ti.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 12 2018, Hallvard Breien Furuseth wrote:

> Can I use a shallow Git repo for file versioning, and regularly purge
> history older than e.g. 2 weeks?  Purged data MUST NOT be recoverable.
>
> Or is there a backup tool based on shallow Git cloning which does this?
> Push/pull to another shallow repo would be nice but is not required.
> The files are text files up to 1/4 Gb, usually with few changes.
>
>
> If using Git - I see "git fetch --depth" can shorten history now.
> How do I do that without 'fetch', in the origin repo?
> Also Documentation/technical/shallow.txt describes some caveats, I'm
> not sure how relevant they are.
>
> To purge old data -
>   git config core.logallrefupdates false
>   git gc --prune=now --aggressive
> Anything else?
>
> I'm guessing that without --aggressive, some expired info might be
> deduced from studying the packing of the remaining objects.  Don't
> know if we'll be required to be that paranoid.

The shallow feature is not for this use-case, but there's a much easier
solution that I've used for exactly this use-case, e.g. taking backups
of SQL dumps that delta-compress well, and then throwing out old
backups.

You:

1. Create a backup.git repo
2. Each time you make a backup, checkout a new orphan branch, see "git
   checkout --orphan"
3. You copy the files over, commit them, "git log" at this point shows
   one commit no matter if you've done this before.
4. You create a tag for this backup, e.g. one named after the current
   time, delete the branch.
5. You then have a retention period for the tags, e.g. only keep the
   last 30 tags if you do daily backups for 30 days of backups.

Then as soon as you delete the tags the old commit will be unreferenced,
and you can make git-gc delete the data.

You'll still be able to `git diff` between tags, even though they have
unrelated histories, and the files will still delta-compress.
