Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D2E20899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdG0SAJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:00:09 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34287 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0SAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:00:08 -0400
Received: by mail-pg0-f53.google.com with SMTP id 123so100915206pgj.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B4on83BMn3oof+8ULCShxkvcw5ZSMEVdVZkuDzxS29M=;
        b=lgY19ZKuqnr027cK9LSV4qoXD9ga2h+A4vf+SNJmEq99USoHFb7ZSI5G2ymilEL066
         8qROdU4miLpsgpiobq/y9muyPSDb6ysG+v2F3wFp5BIHnDtz0axMh2HqclbIFOkeFISc
         zobPmOwMQcpRXWB2d4aEBWkwW9TpGR1Sv7R+gVFGdg/kB0HuOeAMhbgBIZnd6V8pXm2A
         wl7wkeGrneZKtHniOClNt0SDqQKjY6uLW0QOB1taf2nf5bmbZnz5LqeSBJv/BzqmCFfy
         OfTZZlqNzqf1FZGl8kzjQssTryUAWpbexjaO4TeeRoYHSIYQhOx1nPQiGgxr0hDgP0Ni
         vo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B4on83BMn3oof+8ULCShxkvcw5ZSMEVdVZkuDzxS29M=;
        b=gIsx3qiReAgcm4Gf0pQzdifQd7Aiqq0mgSxK5IJO+zTxZZKClfEEQWppG+k82V/9hp
         OhCXMQafxMPBNg7FE1yqBv0apQ8YifkHleLRrFrDmMteR7NK5/UmJNxI+yQQNuWS+WGH
         9GOIwF5SXPih0XvFH83uoQVnJgU+yCtoUim3Ro+lq+LUsd4wHxk7BX8H2ikNxtdxrUbf
         42dId3DJL6WdBU7Xw62PSX/IYoKxsXe/fEy71r1D672+0OlfWWXdQcnsU4KN8zHp/8Wa
         jV1G5IHEHifiQLmTlA3IzGDNCfba2/6KClqbhDVCVX1ZGqA+kDt3yBlDO0bMxRNi7rNd
         znag==
X-Gm-Message-State: AIVw113EhqZMZKJdN5mYzJ7jhe/s2sTfTk/YBz4zADn/qX+YLAwOeZm0
        997ymd9wW9T5WebLCvsNFgkThXsPJtofwDA=
X-Received: by 10.98.224.73 with SMTP id f70mr4744845pfh.12.1501178407768;
 Thu, 27 Jul 2017 11:00:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Thu, 27 Jul 2017 11:00:07 -0700 (PDT)
In-Reply-To: <20170727173028.8863-1-ralf.thielow@gmail.com>
References: <20170727173028.8863-1-ralf.thielow@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Jul 2017 11:00:07 -0700
Message-ID: <CAGZ79kYWhaUUWviq2Kx4h+dEEfRkE8JjGa=JUq6b1Vd8ZUWa9w@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: various fixes in German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Hartmut Henkel <henkel@vh-s.de>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch looks good to me, but some unrelated comments
that I feel would improve the translation even more.

Thanks,
Stefan

> @@ -1465,7 +1465,7 @@ msgstr "Konnte '%s' nicht aufheben."
>
>  #: connect.c:50
>  msgid "The remote end hung up upon initial contact"
> -msgstr "Die Gegenseite hat sich nach dem erstmaligen Kontakt aufgehangen=
."
> +msgstr "Die Gegenseite hat nach dem erstmaligen Kontakt abgebrochen."

erstmalig reads funny here. Maybe "ersten" instead?


> @@ -3360,7 +3360,7 @@ msgstr "gespeicherte \"pre-cherry-pick\" HEAD Datei=
 '%s' ist besch=C3=A4digt"
>  #: sequencer.c:1658
>  msgid "You seem to have moved HEAD. Not rewinding, check your HEAD!"
>  msgstr ""
> -"Sie scheinen HEAD verschoben zu haben. Keine Zur=C3=BCcksetzung, pr=C3=
=BCfen Sie HEAD."
> +"Sie scheinen HEAD verschoben zu haben. Keine R=C3=BCckspulung, pr=C3=BC=
fen Sie HEAD."

Maybe "Sie scheinen HEAD veraendert zu haben" here?
This could also be reflected in the code and we put "changed HEAD" ,
but in English it seems to fit "moving " HEAD.

> @@ -11258,7 +11258,7 @@ msgstr "Fortschrittsanzeige anzeigen"
>  #: builtin/pack-objects.c:2881
>  msgid "show progress meter during object writing phase"
>  msgstr ""
> -"Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens der Objekte an=
zeigen"
> +"Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens von Objekten a=
nzeigen"

Maybe elide "der Phase" here?
