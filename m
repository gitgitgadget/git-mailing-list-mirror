Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB74C201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 18:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdBSSL2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 13:11:28 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35846 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdBSSL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 13:11:27 -0500
Received: by mail-vk0-f41.google.com with SMTP id t8so51693939vke.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yGImkQJj52BLewObE4erquq/3J77aJ7ow0uc4jRyMkc=;
        b=V6zogM50GZXwo9eIf5DJpVK0Lo1bMan5Z2buEWBnpfz/OsQrVgKMqq7CK+34ca7pyU
         HclnlnAcWj2c+wq7dCPE9P8DK+jsKFqb7C39sbLUvFpru/Sd7QAo7pPW7OwDiA4vkOJQ
         3CwrUBOpCaJ2Tk76R/Pyw/SEPjb5zn0tDcHh9DRirnnAMGDm3lRxhv2b4hd/TwasLbXT
         xnYBhupgNGUEHBrJ7BANEc114Uac3LGDkxBlzxg3WdJU9AQhR1C0g4/l1gOGBtui5Zqm
         0ZNMgEHZbHmYJk3l0ZgjHLROPI5fD19xi0ans5TKPiTZbvTu2q9Xb13hwvMdLq7lppAj
         o7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yGImkQJj52BLewObE4erquq/3J77aJ7ow0uc4jRyMkc=;
        b=k5tc8nBHekHRBXB+pooEOZ0kKKH92Tf5KbqX0jKqggHYfEv4p798XiCT9cb3Vu3GnP
         fnIgYOYX0vj5c/hLV/frGJqIGe4xCLOS20cDg0oYRR+TYBi8xtzO3DHaZP4kryGUTWtx
         k8v1Vt7o4FhyQRZ1owIigypVmm4gnq3SqElDyjFPgNdE6e3kG9/t2BX7euXr0V7ejaqa
         3JPNBdlQNoqcSQkS7wAXunizHMQwZMSyzYBYbf2MJj3Or9lKQhTTb/3LCksRD5vfIGnq
         KuDbGsX/ApdZAh3qJPm9zvQQDrvMqZzGZoawySLjJnDbHzqNOx47hTLguyX3gC9Kfj3u
         zliw==
X-Gm-Message-State: AMke39mn8WZNEf10orcMl3NcQR7w7Oc+aJkwh6UPz7O4a2Aw3lLiIoD3eoAlj85Pepd18+ufNxy1LOqJJCs9vg==
X-Received: by 10.31.224.194 with SMTP id x185mr8840007vkg.36.1487527842053;
 Sun, 19 Feb 2017 10:10:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.48.199 with HTTP; Sun, 19 Feb 2017 10:10:41 -0800 (PST)
In-Reply-To: <0d720395-9e92-e6e8-2f88-aff8192ae946@gmail.com>
References: <20170217174132.8816-1-ralf.thielow@gmail.com> <0d720395-9e92-e6e8-2f88-aff8192ae946@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Sun, 19 Feb 2017 19:10:41 +0100
Message-ID: <CAN0XMOJJeKxnYtFe88HQzBeJMDGTSKWvk6DFtzaUa7axiTaRXw@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 241 messages
To:     Phillip Sz <phillip.szelat@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

thanks for review!

Am 17. Februar 2017 um 22:56 schrieb Phillip Sz <phillip.szelat@gmail.com>:
>>  #: remote.c:2092
>>  #, c-format
>>  msgid "Your branch is ahead of '%s' by %d commit.\n"
>>  msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
>> -msgstr[0] "Ihr Branch ist vor '%s' um %d Commit.\n"
>> -msgstr[1] "Ihr Branch ist vor '%s' um %d Commits.\n"
>> +msgstr[0] "Ihr Branch ist %2$d Commit vor '%1$s'.\n"
>> +msgstr[1] "Ihr Branch ist %2$d Commits vor '%1$s'.\n"
>>
>
> Does this "%2$d" works and why not use '%s'?
>

With this syntax you can reorder the format specifiers.  In the orignal
message, the branch name comes first and then the number of commits.
Despite "%2$d" is the first specifier in the message, it tells that it is t=
he
second in the format arguments and therefore gets replaced with the
number of commits instead of the branch name.

>>  #: sequencer.c:840
>> -#, fuzzy
>>  msgid "could not read HEAD's commit message"
>> -msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
>> +msgstr "Konnte Commit-Beschreibung von HEAD nicht lesen"
>>
>
>>  #: sequencer.c:846
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "cannot write '%s'"
>> -msgstr "kann '%s' nicht erstellen"
>> +msgstr "kann '%s' nicht schreiben"
>
> I think we should either use "kann" or "konnte".
> We have used both and maybe we should unify it? What do you think?
>

Sure.  It's a good idea to unify the translation.  I'd prefer "kann".

>>  #: sequencer.c:1341
>> -#, fuzzy
>>  msgid "please fix this using 'git rebase --edit-todo'."
>>  msgstr "Bitte beheben Sie das, indem Sie 'git rebase --edit-todo' ausf=
=C3=BChren."
>
> Maybe: "Bitte beheben Sie dieses, indem Sie 'git rebase --edit-todo'
> ausf=C3=BChren."
>
>>  #: git-add--interactive.perl:1074
>>  #, perl-format
>>  msgid ""
>>  "---\n"
>>  "To remove '%s' lines, make them ' ' lines (context).\n"
>>  "To remove '%s' lines, delete them.\n"
>>  "Lines starting with %s will be removed.\n"
>>  msgstr ""
>> +"---\n"
>> +"Um '%s' Zeilen zu entfernen, machen Sie aus diesen ' ' Zeilen (Kontext=
).\n"
>> +"Um '%s' Zeilen zu entferenen, l=C3=B6schen Sie diese.\n"
>> +"Zeilen, die mit %s beginnen, werden entfernt.\n"
>>
>
> "Um '%s' Zeilen zu entfernen, l=C3=B6schen Sie diese.\n"
>
> Anyway thanks a lot for your awesome work!
>
>         Phillip

Ralf
