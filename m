Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DDC1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDQXcp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 19:32:45 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:45280 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQXco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 19:32:44 -0400
Received: by mail-ua0-f181.google.com with SMTP id j18so13767949uae.12
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MWGgvziz8MyNM8Cvka99H/Tcx04x84zJ4/rE4ZgaxjE=;
        b=dMHZ82mhdb31nfu1D/O6W1In76UoCdafKJBM/EpIUIipOJcc7WNDsXRZAvrlLZ1SzT
         Bg4k4Wn0soBt6hBNlaWmb4CKnPGCguNgyeivlZvCZIgRMIctMFYfoqSMweWdPvF6xqxv
         bkhIVnm85bFrsQei2m+NshCNA5iv22aGKyIax1lyIscrg/OPI3ect5VASocdOS39qvFZ
         +d6DsTkdx2ZIV7Bn+468u91Ps5e6pdNVbumZX8DF7Bh88bzDoOesMLHF3HTuMj8O8J5F
         Ao5yfbP4tZG0EAB9NM1yieL7Xwc0RD3ThfofXP/K3zYj/nkRF4MQSq1M42KaHJqNMoxG
         KsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MWGgvziz8MyNM8Cvka99H/Tcx04x84zJ4/rE4ZgaxjE=;
        b=bQf8yfQkqiw7O5mpaYgs8efYljxUY6U7cfOo6x1AfKbvWFAnBDEB/tQPROH56+iiMR
         cSaJfdIx4oXW+NIW+5xU7pQ6cDwMGvGtiR0Y1fzjM+8S4VeZJTQrZVlc1wywvA+v/12K
         2RtrBeemCrOg0wWHPjQA4LD9r0romrhDdsYsLNkOCkqw4J6WaQ8kY3H1pcJtFWRVAJQm
         6qKXAjt1FURXF7im/fOZ9kT3GbpXxLSAsYzCyfdlJDkmOYrSd+3xRtP+mMiwRPYcpOg4
         4Su7LsYVXcr4qHXmiDajkQi2NbFl1dUvEblQIBUXVPQpgj59tZ4bnIXUxcCh6f5wIl61
         0xzA==
X-Gm-Message-State: ALQs6tBAr7VhY9YpuTuNPFFVablgmOvdUUEbrPsoWNE2DbJB1NUXnb2u
        8lbL3U2NQlPfCRs0nWGuuY1ospzZpRdcBKc1vwY=
X-Google-Smtp-Source: AIpwx4+BNztKHQaiQKfZsZ4Gih1J1rstdK9HHiFBLz0sv+TWRJ2PuMZv7CKR6MMYwLJaeci5XSfiSs+Sv2pBZ229xMM=
X-Received: by 10.176.80.182 with SMTP id c51mr27307uaa.149.1524007964068;
 Tue, 17 Apr 2018 16:32:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Tue, 17 Apr 2018 16:32:43 -0700 (PDT)
In-Reply-To: <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com> <20180416224113.16993-1-szeder.dev@gmail.com>
 <20180416224113.16993-2-szeder.dev@gmail.com> <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 18 Apr 2018 01:32:43 +0200
Message-ID: <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues
 with quoted pathnames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 5:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>     Do any more new tests need FUNNYNAMES* prereq?
>
> Hmph, all of these look like they involve some funnynames ;-)

Well, I can' create a directory with a '|' in its name on FAT32 (on
Linux), so this needs FUNNYNAMES prereq, too.

>> +test_expect_failure 'complete files - escaped characters on cmdline' '
>> +     test_when_finished "rm -rf \"New|Dir\"" &&
>> +     mkdir "New|Dir" &&
>> +     >"New|Dir/New&File.c" &&
>> +
>> +     test_completion "git test-path-comp N" \
>> +                     "New|Dir" &&    # Bash will turn this into "New\|D=
ir/"
>> +     test_completion "git test-path-comp New\\|D" \
>> +                     "New|Dir" &&
>> +     test_completion "git test-path-comp New\\|Dir/N" \
>> +                     "New|Dir/New&File.c" && # Bash will turn this into
>> +                                             # "New\|Dir/New\&File.c "
>> +     test_completion "git test-path-comp New\\|Dir/New\\&F" \
>> +                     "New|Dir/New&File.c"
>> +'
>> +
>> +test_expect_failure 'complete files - quoted characters on cmdline' '
>> +     test_when_finished "rm -r \"New(Dir\"" &&
>
> This does not use -rf unlike the previous one?

Noted.

The lack of '-f' is leftover from early versions of these tests, when I
had a hard time getting the quoting-escaping right.  Without the '-f'
'rm' errored out when I messed up, and the error message helpfully
contained the path it wasn't able to delete.

>> +     mkdir "New(Dir" &&
>> +     >"New(Dir/New)File.c" &&
>> +
>> +     test_completion "git test-path-comp \"New(D" "New(Dir" &&
>> +     test_completion "git test-path-comp \"New(Dir/New)F" \
>> +                     "New(Dir/New)File.c"
>> +'
>
> OK.
>
>> +test_expect_failure 'complete files - UTF-8 in ls-files output' '
>> +     test_when_finished "rm -r =C3=A1rv=C3=ADzt=C5=B1r=C5=91" &&
>> +     mkdir =C3=A1rv=C3=ADzt=C5=B1r=C5=91 &&
>> +     >"=C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=D0=BD =D1=8F=D0=
=B2=D0=B0=D0=B0=D1=80=D0=B0=D0=B9" &&
>> +
>> +     test_completion "git test-path-comp =C3=A1" "=C3=A1rv=C3=ADzt=C5=
=B1r=C5=91" &&
>> +     test_completion "git test-path-comp =C3=A1rv=C3=ADzt=C5=B1r=C5=91/=
=D0=A1" \
>> +                     "=C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=
=D0=BD =D1=8F=D0=B2=D0=B0=D0=B0=D1=80=D0=B0=D0=B9"
>> +'
>> +
>> +if test_have_prereq !MINGW &&
>> +   mkdir 'New\Dir' 2>/dev/null &&
>> +   touch 'New\Dir/New"File.c' 2>/dev/null
>> +then
>> +     test_set_prereq FUNNYNAMES_BS_DQ
>> +else
>> +     say "Your filesystem does not allow \\ and \" in filenames."
>> +     rm -rf 'New\Dir'
>> +fi
>> +test_expect_failure FUNNYNAMES_BS_DQ \
>> +    'complete files - C-style escapes in ls-files output' '
>> +     test_when_finished "rm -r \"New\\\\Dir\"" &&
>> +
>> +     test_completion "git test-path-comp N" "New\\Dir" &&
>> +     test_completion "git test-path-comp New\\\\D" "New\\Dir" &&
>> +     test_completion "git test-path-comp New\\\\Dir/N" \
>> +                     "New\\Dir/New\"File.c" &&
>> +     test_completion "git test-path-comp New\\\\Dir/New\\\"F" \
>> +                     "New\\Dir/New\"File.c"
>> +'
>> +
>> +if test_have_prereq !MINGW &&
>> +   mkdir $'New\034Special\035Dir' 2>/dev/null &&
>> +   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null
>
> The $'...' quote is bash-ism, but this is about testing bash
> completion, so as long as we make sure non-bash shells won't touch
> this part of the test, it is OK.
>
> Do we want to test a more common case of a filename that is two
> words with SP in between, i.e.
>
>         $ >'hello world' && git add hel<TAB>
>
> or is it known to work just fine without quoting/escaping (because
> the funny we care about is output from ls-files and SP is not special
> in its one-item-at-a-time-on-a-line output) and not worth checking?

This particular case already works, even without this patch series.

The problems start when you want to complete the filename after a space,
e.g. 'hello\ w<TAB', as discussed in detail in patch 5.  Actually, this
was the first thing I tried to write a test for, but it didn't work out:
inside the 'test_completion' helper function the space acts as
separator, and the completion script then sees 'hello\' and 'w' as two
separate words.
