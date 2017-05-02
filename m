Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27371F790
	for <e@80x24.org>; Tue,  2 May 2017 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdEBQel (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:34:41 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34030 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdEBQej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:34:39 -0400
Received: by mail-wr0-f172.google.com with SMTP id l9so86019441wre.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aOzm0BtNH2bra2YdU4TU1/9FZRa7MX/5QmCxlrJrW8M=;
        b=Fzgmg2lJNkEYLzIOabDdpXxHAeSuL+uWAvfdDyOzQGnHag+RdQXkulgE0mHk6PLoR/
         Bdp6mxpa/fiFZH8ccA+73tQLgCuT/GMrTVhHKIXapk8RnCLqzXXE1U6gxfnwXPLxSab6
         cMuXjuoNS8H91GCVVLxIkulGupkTRDhyYXygvLn6u/fRKMdfdBkWatBdO2BpVRowo3pH
         aymIA7kRiBUcWNNvA7jVbLqFWHU0YsQotJXKlJ/bpKisAZefCQvUyEUJDCfdcM8puHy/
         QMXyN8JG3OvIivomu1SpzLoZnjooT+bf05asBcZ6lJcoGfe12Wi96USDgXexwhTNn+qY
         tRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aOzm0BtNH2bra2YdU4TU1/9FZRa7MX/5QmCxlrJrW8M=;
        b=mv+4H2OaQ80n+J+uJZY9U+6JC0e6Khe9mfwStw3SRLg1Df3avPoYatr545tazJe26X
         hPsaO5nqWOviErjAOp1Tfb30tj+lecTYfR2cP3ZjwJvfDDLxWZgFOhxgJCtTzIUabmqW
         DWc+zAmby0V5W4iEKQ2nIYuHQafXrRTkIeBzXPM2EYRn5YUF3+Orc1P1cpQZWb+ezsoD
         KsXov49DwXBoVXruDvyTj7exWlWBxn3IwfZ1mSWtY1TWF8wZPFem2yUVFN+z6t6tKaf0
         HkgRcc9xOQ8L3pIqywX80e9Mtse4MMPZZt3C1OcxU00lH6FeQZuiNo9Z97854br+Ny+B
         8COw==
X-Gm-Message-State: AN3rC/71VFx+bpoRv+6/pPahtoK4plb3qU31VUTXxvRKyWRdDdu/cgSC
        NSO/tIGqFNwCABv+NRY4E7lW8ShTrA==
X-Received: by 10.223.146.193 with SMTP id 59mr19080300wrn.165.1493742867498;
 Tue, 02 May 2017 09:34:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.28.146 with HTTP; Tue, 2 May 2017 09:34:26 -0700 (PDT)
In-Reply-To: <20170501121930.jsbooranvc2il7s2@ruderich.org>
References: <20170430184702.17351-1-ralf.thielow@gmail.com>
 <20170430191149.19290-1-ralf.thielow@gmail.com> <20170501121930.jsbooranvc2il7s2@ruderich.org>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 2 May 2017 18:34:26 +0200
Message-ID: <CAN0XMOLW8J9vYWY8wgMPwZoDX6FHJQZqpwHf6VA-uBeN-00PwQ@mail.gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: update German translation
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-01 14:19 GMT+02:00 Simon Ruderich <simon@ruderich.org>:
> On Sun, Apr 30, 2017 at 09:11:49PM +0200, Ralf Thielow wrote:
>>  #: config.c:1952
>>  #, c-format
>>  msgid "unknown core.untrackedCache value '%s'; using 'keep' default value"
>> -msgstr ""
>> +msgstr "Unbekannter Wert '%s' in core.untrackedCache; benutze Stardardwert 'keep'"
>                                                                  ^^^^^^^^^^^^
> Standardwert
>
>>  #: entry.c:280
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "could not stat file '%s'"
>> -msgstr "konnte Datei '%s' nicht erstellen"
>> +msgstr "konnte Datei '%s' nicht lesen"
>
> Read is not quite stat (there are situations where you can stat
> but not read a file), but I can't think of a better translation.
>
>>  #: builtin/describe.c:551
>> -#, fuzzy
>>  msgid "--broken is incompatible with commit-ishes"
>> -msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
>> +msgstr "Die Option --broken kann nicht nit Commits verwendet werden."
>                                           ^^^
> mit
>
>>  #: builtin/tag.c:312
>>  msgid "tag: tagging "
>> -msgstr ""
>> +msgstr "Tag: tagge "
>
> Lowercase Tag because it's used as command prefix? In other
> places in this patch the lowercase version was used for commands.
>
> Regards
> Simon
> --

Thanks!

> + privacy is necessary
> + using gnupg http://gnupg.org
> + public key id: 0x92FEFDB7E44C32F9
