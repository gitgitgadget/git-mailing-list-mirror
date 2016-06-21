Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CD51FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbcFUOoa (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 10:44:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36009 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbcFUOo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 10:44:27 -0400
Received: by mail-io0-f196.google.com with SMTP id s63so2505184ioi.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 07:44:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6jxaWgJBX8nIPjB2WNlmE+AnLXUWttQe70Ee0lP5oU=;
        b=NMvYogfTKj4o6OLVVHjiJxgMS2ey869IS2cigG0e8aLPc0ITx0UVQS3u9s7eU91MYR
         djek92u5SQzFOHWNgQpfY3aYkzLU65/yvJ8TclN2WDHh2yxYNIPYugNwLoPBlUpfuHxS
         hWZNbNF+epVGDpTV3eB/cmE3PIdOyEKaQDFU5dRrPkK0Pjg6d8tsJsPdTxDXR8aU437J
         +Ccs76HOV3j54sDwWh5fciqWIjUc90M5J5QmWnjfbpSX5bte+7HdUEFjpTatyi4upZDf
         nkOp3XYL2scLVaYidWt/70I5d4Wb6qLcqJ0NF5GlaQrHwbz3R4+Tx5X6tHPwsqOGdk/v
         CEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6jxaWgJBX8nIPjB2WNlmE+AnLXUWttQe70Ee0lP5oU=;
        b=UILfhjyFFIHk5v8ovMMNk63pCnRNsh/mCV6V33/bY+jI4KkuiEBwA7JsrhBM7gVGxJ
         ZuKF8gLwzTQCqK9qNG1zGrh1s86P+XaUPBaNd2jRqHjaZOryIaTyqU+XOBpV9mGwIHmU
         UM322FV4O0RcbHxZ3GAfw6OdrJBGdjo5FEVTxI2puyEqT6kZdbfA206yxzvv5RA4Hceg
         BlIBEk8N1LwCwMQ+ywoSmWwQJvwTGlWRi0wRLY0amyTNYK5zZ1GB6jAl6Iq3RXET2hms
         fiDFv8fMIZclac4ru36gdggS7JiK9/mzjlD7EdLRMmItRB3gfOJ6FEfSUK8TADwO5oOd
         HjxQ==
X-Gm-Message-State: ALyK8tJWbAQAwSd3n85LZr2LjX36DpLU9agDXQiAANWhkqW+f77+hDD+Glac81U5/1jFy2Ikrn1d9iVh+YhblA==
X-Received: by 10.107.6.149 with SMTP id f21mr32883158ioi.14.1466520246871;
 Tue, 21 Jun 2016 07:44:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.149.76 with HTTP; Tue, 21 Jun 2016 07:44:06 -0700 (PDT)
In-Reply-To: <xmqqzir67p1y.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
 <vpqk2ijs8p2.fsf@anie.imag.fr> <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
 <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
 <xmqqfut75peg.fsf@gitster.mtv.corp.google.com> <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
 <20160527041944.GA17438@gmail.com> <574CDA24.1020906@googlemail.com>
 <574D1BEA.5020409@web.de> <xmqqzir67p1y.fsf@gitster.mtv.corp.google.com>
From:	Armin Kunaschik <megabreit@googlemail.com>
Date:	Tue, 21 Jun 2016 16:44:06 +0200
Message-ID: <CALR6jEgAtvuecJ4OPOAcDGh3o02oM_WP5_CM8Y52eW2hjuLDNg@mail.gmail.com>
Subject: Re: [PATCH] t7800 readlink not found
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, May 31, 2016 at 7:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>>> index 7ce4cd7..905035c 100755
>>> --- a/t/t7800-difftool.sh
>>> +++ b/t/t7800-difftool.sh
>>> @@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
>>>   for f in file file2 sub/sub
>>>   do
>>>      echo "$f"
>>> -    readlink "$2/$f"
>>> +    ls -ld "$2/$f" | sed -e 's/.* -> //'
>>>   done >actual
>>>   EOF
>>>
>> I don't know how portable #ls -ld" really is.
>
> The parts with mode bits, nlinks, uid, gid, size, and date part do
> have some variations.  For example, we have been burned on ACL
> enabled systems having some funny suffix after the usual mode bits
> stuff.
>
> However, as far as this test is concerned, I do not think "how
> portable is the output from ls -ld" is an especially relevant
> question.  None of the things we expect early in the output (the
> fields I enumerated in the previous paragraph) would contain " -> ".
> And we know that we do not use a filename that has " -> " (or "->")
> as a substring in our tests.
>
> We don't have to use readlink, even on platforms where we do have
> readlink.  Building the conditional to be checked at runtime and
> providing a shell function read_link that uses "ls -ld | sed" or
> "readlink" depending on the runtime check is wasteful.
>

Just a short, curious question: Is this patch to be accepted/included some time?
I didn't see it in 2.8.4 nor 2.9.0. Maybe it just fell off the table...

Armin
