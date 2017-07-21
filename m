Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E4920288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbdGUQcb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:32:31 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37027 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbdGUQc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:32:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id 33so27920941wrz.4
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZ3e4OKPzFCnIkMJagGEAnmM3P5/YmYkRkl9Ym9Sdi4=;
        b=J0hfzFEihroWb8OJRCj/bSYnr5i5ZX4LCaXrkS4TKSecjg5iowEr+qamJpH4/aNhzJ
         0PXMXfteFBeSD4V3Mqel4eQoHSPt00V1XJn82wFqRKF1ujxZu9RqLsO3XlMbZc0RT+4P
         j2qLBPZdk4QOJG+dNqeZ/cl67SkQfNI6MtCiDMcGONn5hvW+T1DMPc2q46OIsypCFFJn
         7gp0a8ynl4rJhUOYMdJmi+CZrheMwFut0HEP21F1Q7ONhcg7ROTPzwYjkgG9QhB2Sy0t
         vkQ35659N1rlinK0JxCHXUen3d4XERSqGmN3394YDdZrxmhBwEAmBwDioD+pfxlfbHMV
         PKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZ3e4OKPzFCnIkMJagGEAnmM3P5/YmYkRkl9Ym9Sdi4=;
        b=AuTTxl8z9RGueY0BrbYoHZRV8+3QdDjaHHF4nqfGer2T5PrU6FQnVJ80TtFwlRaTFD
         bdmo/vkQDPMVgxbehLDNa7StWR1w6s/c6Csz7AWfUgqB1J9xGyDoV9gbnpZEgRCul9nO
         BNwn7MzTrD4y+BUIF3mBh1Zy1VkyFSqmC8LbNI92LcqmMJek+GuhpcEe9Wa9x7oz6CW/
         TQHivF29q9rYr4BBjX5h/pX1tgwhyTuEKWVT85/lR93EUOKkRv+jbSXvZGRSXQ6dXChC
         tsGi9CG2pgGqZNn+HzxPWy+XLcOLgJ5LoD+THzvdkHdBZySmC2boaTgQDHcQsU3NNX7R
         qJYA==
X-Gm-Message-State: AIVw112xF9fN4xtSTe2PP0npH49PtDSIHb++cT+a8O88obZDD92dvJPo
        V52deqlO2dXx5p9wr1y2QJxv/M3mJw==
X-Received: by 10.223.157.7 with SMTP id k7mr7754871wre.43.1500654747867; Fri,
 21 Jul 2017 09:32:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.193.66 with HTTP; Fri, 21 Jul 2017 09:32:27 -0700 (PDT)
In-Reply-To: <xmqqshhphitv.fsf@gitster.mtv.corp.google.com>
References: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
 <20170721151144.4410-1-ralf.thielow@gmail.com> <xmqqshhphitv.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 21 Jul 2017 18:32:27 +0200
Message-ID: <CAN0XMOL2E3+raBkH3LHg15ZYP8zH4Qv8oh1Zn+G6C6LZxJerdA@mail.gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: update German translation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

after applying the patch, entries in date.c turned into this

-#: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156 date.c:167
-#: date.c:175 date.c:180
-msgid "%"
-msgid_plural "%"
-msgstr[0] "%"
-msgstr[1] "%"
+#: date.c:122
+#, fuzzy, c-format
+msgid "%<PRIuMAX> second ago"
+msgid_plural "%<PRIuMAX> seconds ago"
+msgstr[0] "vor %lu Sekunde"
+msgstr[1] "vor %lu Sekunden"
...

which seems to be OK. A full diff after updating de.po after this
patch can be found at https://pastebin.com/5yeSnGQj.

Ralf

2017-07-21 18:10 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>  #: date.c:116
>>  msgid "in the future"
>>  msgstr "in der Zukunft"
>>
>>  #: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156 date.c:167
>>  #: date.c:175 date.c:180
>>  msgid "%"
>>  msgid_plural "%"
>> -msgstr[0] ""
>> -msgstr[1] ""
>> +msgstr[0] "%"
>> +msgstr[1] "%"
>
> Sorry, but I think these need re-translation after -rc1 because the po/git.pot
> is generated incorrectly.  See the discussion:
>
>   https://public-inbox.org/git/%3Cxmqqk233klvd.fsf@gitster.mtv.corp.google.com%3E/#t
>
> Also, if you can, please try the patch in
>
>     <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
>
> like so:
>
>     $ git reset --hard origin/master
>     $ git am <that message>
>     $ make pot
>     $ git commit -m 'update po/git.pot' -a
>     $ cd po
>     $ msgmerge --add-location --backup-off -U de.po git.pot
>
> to make sure you get corrected entries for date.c.  If it works out
> correctly, I'd want to ship -rc1 with that Makefile fix so that
> Jiang can do the first four commands above to give translators a
> correct po/git.pot to base their work on.
>
> Thanks.
>
