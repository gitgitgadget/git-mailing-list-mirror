Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31461FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 00:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdBFAIH (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 19:08:07 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34075 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdBFAIH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 19:08:07 -0500
Received: by mail-io0-f193.google.com with SMTP id c80so7743125iod.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/ITTY3IAQ6+uwNAP64cozaQFMKIQnXVtomL2Dls52lg=;
        b=Ba4PeosFh900qivwwgAjr+u7vVrkRoHf2yvTSyi3O4s8m6rRPQKC3AaujvKirA2wno
         qCloEeO1fOeMVyDgITqbzCsQ7W+/2hN17zX68e4hzMnuBRiZJafBQNM/cb9PSR3fzzZR
         tRoKRhqMgKI9LYIwcUPOKVnqC2196XkmGLgsj43Cqk5j6rCauUFZvS0FWnSRf5lkrQmS
         TPwc/qFT5A3D77B9OnB06oIQhRUewMRh+E6S/dMDrCj9gBgwOHzIMYkQL1m2QLjmWeHD
         M85uJ7n8i86CpQWAZZAEb0dpLhqJM5m315l5MKFz2UVWvO8FIQ3ax51o6w6QCh67Hi/S
         bB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/ITTY3IAQ6+uwNAP64cozaQFMKIQnXVtomL2Dls52lg=;
        b=bzLzn/PvELrLIZdUfV8wddZchFCV0pIJI0IhIQUtD2qSpumxZW49JSv8DWmKzY8ZpY
         TQW9x9weLx29ou9EqziRxgUXlz964ivK0BaNfGK7b2sVGX+V5enmPIKPdjb3fX2dSvSE
         0SmmCYVopoOxJSGWH6lFZou9mpCvlD+d7nLh58zeSGEg6zhC6xjJ14CNL8BwNb/WHe/8
         /Xibndmg4opuA8V3WvNal0/9nn7Ok57fpPlxF0R5+fxe0Au/oVAmalES3HhFa9hfoBUn
         aMtcxldacasmPvegTELGcs61GnxtrdlMEIOvo7EVDRo2SDNVOubpn2bXrrLOn1T+VxHv
         6vng==
X-Gm-Message-State: AMke39mfWUc+O/vIegALWsNMRt204HKzBUDptW8KWzB4XNGvcOOQpZKScloZa5APmqzVgLTyyy0o6QlfJhbqfQ==
X-Received: by 10.107.55.70 with SMTP id e67mr4899735ioa.142.1486339686184;
 Sun, 05 Feb 2017 16:08:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.75 with HTTP; Sun, 5 Feb 2017 16:08:05 -0800 (PST)
In-Reply-To: <xmqqa8a0431z.fsf@gitster.mtv.corp.google.com>
References: <CAKvHMgQLKccm2LcL4LGhz0afVthaS2gvEcLtoHX2TcDnr1npbw@mail.gmail.com>
 <xmqqa8a0431z.fsf@gitster.mtv.corp.google.com>
From:   Liam Breck <liam@networkimprov.net>
Date:   Sun, 5 Feb 2017 16:08:05 -0800
X-Google-Sender-Auth: 6AXf6sE0wiRWQKy5OF44cMPcZQE
Message-ID: <CAKvHMgTDVU+=uq7_oQzfnSNxhFPd75-Ah4BXOcRnZCgUwytPWA@mail.gmail.com>
Subject: Re: In-body from headers ignored
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2017 at 3:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Liam Breck <liam@networkimprov.net> writes:
>
>> git format-patch & send-email generate the in-body From header.
>>
>> git am recognizes it.
>>
>> git commit & format-patch & send-email ignore it. (The latter two will
>> add a new header above an extant one.) Is there a rationale for this?
>
> I may be misunderstanding you, but I am guessing that you are
> expecting
>...
> and seeing that the real author is still you, the title is "The real
> title of the patch", and the first paragraph of the body consists of
> these two lines that begin with "From: and "Subject:".
>
> This is very much deliberate.  "git commit" does not care if the
> second paragraph in the body of the message resembles e-mail
> headers, because it is a command that can be used by people who do
> not even e-mail patches.
> ...

Hi, thanks for the detailed reply :-)

OK, that resolves my Q about git commit.

But should not git format-patch & send-email detect an extant in-body
From or Subject header?

Suppose I need to forward a patchset and cannot amend the commits in
git? Or that a patchset author is not the copyright holder, whom I
want to be logged as the author upstream?

There is a workaround: delete the From headers in the patches, but I
was looking for a command-line option or alternate default behavior
:-)
