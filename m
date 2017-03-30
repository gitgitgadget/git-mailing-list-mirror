Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7338D20966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbdC3U2l (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:28:41 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34823 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbdC3U2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:28:40 -0400
Received: by mail-oi0-f54.google.com with SMTP id f193so42606839oib.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RP321gVLhObcKg1CY7UXuqkKjl1DZTBHaOGRe6k5iFM=;
        b=lu0ubFX5v1/W3yjpHK7xdUvsFjIkg5lgimsDy9Hx7+I9IKxiR1bbr9U9ZbK3+71Xh1
         0Hp0CHjtirnTPHLKdLd4JltU4gCcfer0aZq5Wdi5cd+yYDfjQrwi+a8Rz/uEk6YVV2Wz
         jYMiicbPrF1JRJOgd3LFvTnxHcPBk8xozkXnf+aoQU1SZ9yJPTkFZt0YVvo7im48aRq2
         t4YQh8QCXOrJ/OppGyR6Ue6FQa7G/ejWy7bD9ZoP/3dyUFI66awLStFKA+qBpN9GmMLt
         NTI6GiCsZLHuetx/0VIwR0kIu6DusHer9eNrKCxWGmLZeLoAZZ7XDHMjhtDBDhG3/tK3
         BBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=RP321gVLhObcKg1CY7UXuqkKjl1DZTBHaOGRe6k5iFM=;
        b=rmR82R9fYz6BrSx+01sDGcZzYxIL2anwU7FDxuZmEjvhZvZV5VNziARFF7zgHpgZn2
         mdOHJVZBN0uXhSmdKtrNb2ETYP5LrXoYj2fTSXWNtd7rMZmo4l//l3UhEffEDTgAl/xu
         RbP7Fu92+pDXumnQJRptpK58uClGFgzGqQZfVF5DpfTH4ctemL+bUe3+5Y19EU+4f3Yg
         wjuKlGmEzUozvUDh73Nc/Tx5vc7s6UPGly1ivqZMW9FPhTMFK9g0MZLW2W6VcfHVGjiY
         v1H0i0hsycsTS8ze7F+t0RsQMg7/u9tWPl3Hh35wjZrSPPHRzEBrTiph1r2cLl2DXNyP
         xlww==
X-Gm-Message-State: AFeK/H0eUfMlH9Tvprq40hm/hOGbRLVG5CLBIlsZwxcU6HS2VtIUiOGnb9zeIJe+9fsBJ06J6U3ihGseFUalzQ==
X-Received: by 10.202.206.149 with SMTP id e143mr1174803oig.158.1490905718685;
 Thu, 30 Mar 2017 13:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Thu, 30 Mar 2017 13:28:38 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CAH8yC8mMzZGebmZ23dsgY6Zkxk3w_Kpt7O6Z-0CwRQyTBF5uvg@mail.gmail.com>
References: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
 <xmqqbmskatz3.fsf@gitster.mtv.corp.google.com> <CAH8yC8mMzZGebmZ23dsgY6Zkxk3w_Kpt7O6Z-0CwRQyTBF5uvg@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 30 Mar 2017 16:28:38 -0400
Message-ID: <CAH8yC8kJdcV+cFPTN5WXAtvB4fpbRXUR3v45YSiY0=acgguwBw@mail.gmail.com>
Subject: Re: git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 4:06 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> On Wed, Mar 29, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Walton <noloader@gmail.com> writes:
>>
>>> Some more 2.12.2 testing on Solaris 11.3 x86_64:
>>>
>>> $ make V=1
>>> gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
>>> credential-store.o -MMD -MP -I/usr/local/include -m64 -m64 -I.
>>> -D__EXTENSIONS__ -D__sun__ -DUSE_LIBPCRE -I/usr/local/include
>>> -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
>>> -I/usr/local/include -I/usr/local/include -DNO_D_TYPE_IN_DIRENT
>>> -DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H
>>
>> Looking at config.mak.uname, nothing in SunOS section seems to set
>> NO_INET_NTOP or NO_INET_PTON.  Why is your build setting them?
>
> Thanks. It looks like the following is the culprit (from config.log).
> Am I supposed to specify the socket library, or is Autotools supposed
> to specify it?
>
> To date, I've been specify the libraries I request, like IDN2, PCRE,
> cURL and OpenSSL.
>
> I don't recall specifying a socket library in the past, so I'm not
> sure what is supposed to happen here.

It looks like adding -lnsl and -lsocket clears the issue.

Maybe Git on Solaris should test with both of the libraries, and not
just -lsockets.

Jeff
