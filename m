Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED0C20372
	for <e@80x24.org>; Sun,  8 Oct 2017 10:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdJHK07 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 06:26:59 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:43415 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdJHK06 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 06:26:58 -0400
Received: by mail-pg0-f49.google.com with SMTP id s184so10202982pgc.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iukm/wWL2mIz3F2J64L0yvahAt4x9gLEHleW/JEwrm4=;
        b=hx5yKH2ojjoFNUFQIsb0fISKKgLhvTEC6bH3BIn1bIvJr+CMXU6blLiBU+rL9B3x9V
         NK1/VO4RtYoEsaG8Hz8S0sfo5+vzDOxAzFD8IO9YJ3sAG75CtIQims/0RzQ5uP+XJWuG
         p+cDjS1zU18Y50m1oH8P9uBuDtlixr3PftBBklD5x1X8glNzRx9pe7Z2XuIkB+Murj91
         rXaan/uFW2RVynEeSLy05rxYzochKTjhOA1MuIzDZ4jqQFKEvlR/+zv530JJesgr4lIN
         D4s9BHu3msYUF8ZIRVTTObmsda38628IdOht64bkhei6aj1RSSeN76saM2zn/PwzIJFV
         QMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iukm/wWL2mIz3F2J64L0yvahAt4x9gLEHleW/JEwrm4=;
        b=MIs8erNRBQ79DNaBe0CXs4V3U+P88WI1PBYOFJKk1nvtps7WE+WxyuyzCCSB1A/wHY
         GOC4LOhJarFD8Kqg15zMhTk0yaIyw8d7X0NprzdDcodHbwa54FHk+RYsZsZRv8MUB2ep
         oBv9q6zfWOdCbdfUZshJ1z7Fnlm3A1WjAV0eQpe6FMYjOaMLvq2gWTwwyyff2IQeScQf
         FZKJhkmTYgerasxkLXTK0eLBPtdjOA/ozrsUV7to6WH4NHAOae7IL3rDK+Ugxh40aYgV
         3Agm6TrSV+0ueWAR62421LtfTofaDgTWpi+2i3w3oSXmeUARi38TJMAImsueafPm+9WI
         HEoQ==
X-Gm-Message-State: AMCzsaWsIBVSvH9gejfmOUBKq9vs635qwVugO/vKp5AX3wn9AFADIYJy
        A7jcjbZpDO1wLQ9Koh2chR5XEkwZqOGqr43PTUzI5D3kXLs=
X-Google-Smtp-Source: AOwi7QBQOrheDpT4FM1YpHXonuaOoDFC0frFKoBFc95m4vg7XacjlkALnm3QK0zmQ0L6dEdOyraph+3MA5y4dOMzv1w=
X-Received: by 10.98.35.194 with SMTP id q63mr7025669pfj.15.1507458418286;
 Sun, 08 Oct 2017 03:26:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 8 Oct 2017 03:26:57 -0700 (PDT)
In-Reply-To: <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <20171008084824.5331-1-martin.agren@gmail.com> <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 8 Oct 2017 12:26:57 +0200
Message-ID: <CAN0heSpP1xxnUt8nVMXBdh1ynQUTH3Jo4C34F7=9TNFSb-k1ZQ@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 October 2017 at 11:32, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Martin =C3=85gren" <martin.agren@gmail.com>
>
>> We currently build an error message like "entry is a %s, not a commit",
>> where the placeholder will be replaced with "blob", "tag" or "tree".
>> Apart from those three placeholder words not being translated, in some
>> languages it might be awkward or impossible to ensure a grammatically
>> correct end result.
...
>>  default:
>> - die(_("submodule entry '%s' (%s) is a %s, not a commit"),
>> -     cb->path, oid_to_hex(oid), typename(type));
>> + die(_("submodule entry '%s' (%s) is not a commit"),
>> +     cb->path, oid_to_hex(oid));
>
> Bikeshed,
> maybe:
> "submodule entry '%s' (%s) is not a commit. It is a %s"
> This puts the two parts in separate sentences?

I'm not doing the Swedish translation, but if I did, I would find this
just as hard to translate as the original. There are two problems here.
The first is "blob"/"tag"/"tree". "Blob" is already used in the Swedish
translation, but "tag" should be "tagg" and "tree" should be "tr=C3=A4d"
(IMHO).

The second problem is that even if all three words were valid Swedish
words, then (IMHO) using "en %s" instead of "a %s" would be needed to
make sense with "en blob" and "en tag", but it wouldn't work with "en
tree" which should arguably be "ett tree". (But to be clear, seeing any
of "en tree" and "ett tree" makes me shiver.)

I should perhaps have been clearer that grammatical problems might arise
from the "a". (It's more or less by chance that it works in English in
the first place. Luckily there is no type "aardvark", "index" or
"other".) But I wouldn't be surprised if there's a language out there
where "a" is not a problem, but something else is.

It just occurred to me that one approach would be something like "... is
of type '%s', not 'commit'" where "commit" should not be translated and
%s would be one of "blob", "tag" and "tree". That would be sort of in
line with what `git cat-file` does, but not quite. In cat-file it seems
natural because it's about the command-line argument, here it's in an
error string and seems a bit awkward.

Martin
