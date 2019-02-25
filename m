Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E99B20248
	for <e@80x24.org>; Mon, 25 Feb 2019 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfBYWmP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 17:42:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40279 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbfBYWmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 17:42:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so9048703eds.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XDQFxufpcTadjILnnrVMkFnGEPPpF/1208MnNTPj8lQ=;
        b=Ayrw2hLEZOwNbIUpbL4aWttKNpLzcb2sjXHme2vZ5k692ejouQaqkzAtlquuu9l9n6
         1863AUPF7gAlJ4ufhBiYSMH6Zz7ubcbSGi9jw8Vgw8X/jFPZxHeWU36rA3/WYZNwO973
         CUCHumTgDRrvFmy8cGWB8gaYctO1b4WZ5eXCH+5mCUukwUQh71hqm2+GCCf6saMLnUYV
         /d+HdnwICpAwUD3R6svzmGwyV0QfasLgLL1+SrBf00YxLIO7p2SvkYPGCeabqbVRt2Hu
         ntcB4V7L5sCt+aCREvTt6aRVZAyCEIgvZxKmhoPxyWSprAqNhjwrl8HWaH2Woz05USDh
         pq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XDQFxufpcTadjILnnrVMkFnGEPPpF/1208MnNTPj8lQ=;
        b=E3gHHHFpGurwy6m06dK3+mV5y9D2sqfKcEIRzytEt6CuO9db2oxsFYWs3yRajJq5YW
         niICjvqyULxVJe0KKiME6Do/I/ntDdbnsajzkBaac3lSgXasfr1rfvpOyEmI3Em6gc4v
         a0x287yDU8fQVu5wVZ1qDDEXwtz3Q7ZviqcjlhSa4BhoB5BAsoRdniwBcG6Mv4/eI9AX
         Aw0jSf7/4ZLEKIhc9lUS4jjdvtEBtbpF7e+vOK7UTaCkpnMQcvF4jUcKEQNbMBiE2AW6
         xJjXBnKvJRgXGtxzdjlv0SNLSOUHugYuhACJnZZf3PR/anX5yTDDygG6lU92XtAK+fYr
         FOtA==
X-Gm-Message-State: AHQUAubeS9ZXqge5oyT2OhhPSYRpzWSxti/mWXOzZKu6Ibs9caRpZFeQ
        PHZMfX6QcfXrvtHbqhRx7kA=
X-Google-Smtp-Source: AHgI3IYojiWT8l7WZst13/84PpbNcSsEth0oC8tQbop8pyFOcgUpMgCPnrT2ou7QLQWRLRr/ifhBQw==
X-Received: by 2002:a17:906:2a9b:: with SMTP id l27mr14704278eje.89.1551134533113;
        Mon, 25 Feb 2019 14:42:13 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id t19sm1038934ejd.53.2019.02.25.14.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 14:42:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] l10n: fr.po unfuzzy commented entries
References: <874l8rwrh2.fsf@evledraar.gmail.com> <20190225211453.28300-1-jn.avila@free.fr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190225211453.28300-1-jn.avila@free.fr>
Date:   Mon, 25 Feb 2019 23:42:11 +0100
Message-ID: <871s3vwkvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 25 2019, Jean-No=C3=ABl Avila wrote:

> The 0.14.4 gettext release was back in 2005, so presumably this is due
> to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
> released a couple of years ago.

So this one pargaraph of commit message is just a paragraph from my
E-Mail upthread, but out of context it's just confusing.

> -#, fuzzy
> +#
>  #~| msgid "git archive [<options>] <tree-ish> [<path>...]"
>  #~ msgid "git diff --no-index [<options>] <path> <path>"
>  #~ msgstr "git archive [<options>] <arbre ou apparent=C3=A9> [<chemin>..=
.]"

This still results in the same issue. Sorry, by "unfuzzying" I thought
you meant change these translations so they'd no longer be commented out
and would actually have a translation.

The problem is that there's two msgid lines, so e.g. this on top of
yours "fixes" it:

     #
    -#~| msgid "git archive [<options>] <tree-ish> [<path>...]"
     #~ msgid "git diff --no-index [<options>] <path> <path>"
     #~ msgstr "git archive [<options>] <arbre ou apparent=C3=A9> [<chemin>=
...]"

But isn't a better fix on top of master just:

    sed -i '22477,$ d' po/fr.po

That results in 1500 lines removed from the end. I.e. what's the point
of keeping those old now-unused translations around?
