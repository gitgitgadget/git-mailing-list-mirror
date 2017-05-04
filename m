Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CF6207D6
	for <e@80x24.org>; Thu,  4 May 2017 12:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbdEDMxz (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 08:53:55 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34313 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdEDMxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 08:53:54 -0400
Received: by mail-wr0-f176.google.com with SMTP id l9so7332888wre.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E4bQ5mnBvjeqCU2CuSMCJyCJ6pxI0EDTbCFMGelFcVk=;
        b=QwXHRJ/HEredCJeiFykNdQYY4DyDDUd16+sYSY7cguDotujaebGxY6dkTfMe2kFTJG
         yLxeA/7zF0zTUhfNdun9x8GETVnKe8Ev5Z81LiaN+5AAYMKNZUAUVaR8MVJ7Rqab83Of
         6uvAaBWCt5Emui7G8kN261IN3wNsKKXD0/6URpoupbFex7IsATxkitAHvcZls3UI14jL
         Ydh9GBjSbVTCtEaze0OquRD3s5YzF8M1vUjvYc2m2iTfliQYQAgdgm/zIZ/Fn5CqiEhq
         kWGcIJInhvHKcVXFN+qINZGZoIXVLjz517T3hnyPFl5+mrOxWhwurq/sLsFd5++7cQz7
         6g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E4bQ5mnBvjeqCU2CuSMCJyCJ6pxI0EDTbCFMGelFcVk=;
        b=U+74IDQkYx3hk6jlWNw68YndlLDdqMKtL6TQ2tzfXreRv8A9W4s/wgcJdr5smuIUMo
         OgskFwDiMz88UfTHLcPgPLCH43rX12SLgUbklCCYnxMW+unAjHkvWRLNS0NeUcLInIh+
         CLdwPy/Ulq3Eas32b1f8m0A8+62ZLRot3A5jUkglBGv3kuUsZICNSndKZYk134pAzaWr
         dBzVhogOtLeS+mYGlGoz+jXmxEOD6h/1cvAN56C28UrLICvIKqu4nSCdQxG2F2Z0xtY4
         eCdJ+NX/MiTFDFEBBNPWT0FbBgv5gC8EUb3qi7FmV2UiVoY4YPTDi6oOhbHd5lCSNBcb
         yTRQ==
X-Gm-Message-State: AN3rC/6EZCvJ5A2lxtbi+2Mn/F8I8qJkNNPvF3D0ofrkNEQYsibw/z3M
        kQ0EEadVWLseLMFaCP5gamVaHD+GpA==
X-Received: by 10.223.146.193 with SMTP id 59mr26308615wrn.165.1493902432546;
 Thu, 04 May 2017 05:53:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.28.146 with HTTP; Thu, 4 May 2017 05:53:51 -0700 (PDT)
In-Reply-To: <aa5f6d4b-8e8f-19c1-cd7f-25978368d359@gmail.com>
References: <20170502163612.3381-1-ralf.thielow@gmail.com> <20170503164009.5366-1-ralf.thielow@gmail.com>
 <aa5f6d4b-8e8f-19c1-cd7f-25978368d359@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 4 May 2017 14:53:51 +0200
Message-ID: <CAN0XMOLb9y47odMcR45pn_tv+P7O0mrJ6s0Rpnx_ZeZ8wktTxw@mail.gmail.com>
Subject: Re: [PATCH v4] l10n: de.po: update German translation
To:     =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Christian Brabandt <cb@256bit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-03 19:29 GMT+02:00 Matthias R=C3=BCster <matthias.ruester@gmail.com=
>:
> Hi Ralf,
>
> thanks again for your work!
>
>
>>
>>  #: ref-filter.c:565
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "format: %%(then) atom used after %%(else)"
>> -msgstr "Format: %%(end) Atom fehlt"
>> +msgstr "format: %%(then) nach %%(else) verwendet"
>>
>
> Is there a "Atom" missing?
> "format: %%(then) Atom nach %%(else) verwendet"
>
>
>>
>>  #: submodule.c:1332
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "could not start 'git status' in submodule '%s'"
>>  msgstr "Konnte 'git status' in Submodul '%s' nicht starten."
>>
>>  #: submodule.c:1345
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "could not run 'git status' in submodule '%s'"
>>  msgstr "konnte 'git status' in Submodul '%s' nicht ausf=C3=BChren"
>>
>
> Maybe "Konnte 'git status' nicht in Submodul starten/ausf=C3=BChren" woul=
d
> sound better?
>
> In general: sometimes there is a sentence (starts with a uppercase
> letter and ends with a dot) and sometimes not.
>
> So for example also here:
>
>  #: fetch-pack.c:1150
>  #, c-format
>  msgid "Server does not allow request for unadvertised object %s"
> -msgstr ""
> +msgstr "Der Server lehnt Anfrage nach nicht angebotenem Objekt %s ab."
>
> I have not looked up the exact circumstances when this would show up,
> though.
>
>
>>  #: submodule.c:1421
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "submodule '%s' has dirty index"
>> -msgstr "Submodul '%s' kann Alternative nicht hinzuf=C3=BCgen: %s"
>> +msgstr "Submodul '%s' hat ge=C3=A4nderten Index"
>>
>
> I would suggest:
> "Submodul '%s' hat einen ge=C3=A4nderten Index"
>
>
>>
>>  #: builtin/tag.c:493
>> -#, fuzzy
>>  msgid "--contains option is only allowed in list mode"
>> -msgstr "--contains Option ist nur erlaubt mit -l."
>> +msgstr "--contains Option ist nur im Listenmodus erlaubt"
>>
>>  #: builtin/tag.c:495
>> -#, fuzzy
>>  msgid "--no-contains option is only allowed in list mode"
>> -msgstr "--contains Option ist nur erlaubt mit -l."
>> +msgstr "Option --no-contains ist nur im Listenmodus erlaubt"
>>
>
> Is "Option --contains ist nur im Listenmodus erlaubt" possible there? So
> it would be like the second one...
>
>

Thanks!

>
> Kind regards,
> Matthias
