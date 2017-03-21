Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DF32095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbdCUSy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:54:56 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37757 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbdCUSyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:54:23 -0400
Received: by mail-it0-f41.google.com with SMTP id 190so13915399itm.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6tobQUrxNTI55IJN+Q+yoFvhsQWf3Em3OS9W+QJKkxw=;
        b=sba11wetDQRQRLmiOB3qUXlPWiV0bce5YCA+/xY0RdsOnYksR2XjfAAch3rP3bJPXA
         9FKknXAZymbwHa71f6GAzyqcLNZvWuJASPznl9WF/tWeYwJSiHqoNbnXnnrZVlNAp53d
         d8c/cD17IjMIJfhA87HP1jqdIvUkV9Lx9UQxkiAqtfUFOpR3LqmKUU7YxXmZxKTf50e5
         VegVGqiTC5QGN8tf/xCStYt/qexyPDjrlp/b7ZEiqcib2wMfqX+2CVkB3VdpAjbHnFfa
         KvI0Ir33SWTlWgajqhwpErXda7wNhpgKmAQpG/ixQyac/4mLuvgMfC8068IjCjQesORQ
         c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6tobQUrxNTI55IJN+Q+yoFvhsQWf3Em3OS9W+QJKkxw=;
        b=q7A5R/Kyt8Q9e+2+vPvP6m2B5zK+OEkrPyiamSK74j7WuhR9fvc/IpTK4T8AfAZHM6
         7uxCM0kxJJ7DGgUuqSddwYUUZkT6pW+df2PXlyRSdVTwHMHzDIzf1Yt7M34UWpbqcGhE
         JncNL0PfWds+XdD3zG/SCLAS8N049NWFpJaDhnqNJg28NDeE5DXI4cDYW1U9w3thDLrV
         IauC/ZzXFGUY0R1Pk5F6zH85vCERg24YiB2RgkGfW33tQtfbw+MfPqrD6ukWrZKQTPC4
         iZMgp2KAMsP/wpe9AlI+aELgMhhe1jASx1EzbcmDV046B61p9hHuzggiHNqpTaTzVV3A
         J7WQ==
X-Gm-Message-State: AFeK/H3mT9N/zWRjsOdogWnJYyzf/7Z9rjoWxVh2fcnpVMz1fBUNXOsT3nwliQUL8PMCsreWbn04JfBy+uxlVA==
X-Received: by 10.36.29.66 with SMTP id 63mr3974878itj.91.1490122064089; Tue,
 21 Mar 2017 11:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 11:47:23 -0700 (PDT)
In-Reply-To: <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
References: <20170321155153.20753-1-szeder.dev@gmail.com> <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 19:47:23 +0100
Message-ID: <CACBZZX5ofE-B0AE1gDVwN=N3g-x+m=OW72BYxK8Oz7FUkBNP7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI
 commit summary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>>  The "Copy commit summary" command of gitk can be used to obtain this
>>> -format.
>>> +format, or this invocation of "git show":
>>>
>>> +    git show -s --date=3Dshort --pretty=3D'format:%h ("%s", %ad)' <com=
mit>
>>> +
>>> +To turn that into a handy alias:
>>> +
>>> +    git config --global alias.git-commit-summary "show -s --date=3Dsho=
rt --pretty=3D'format:%h (\"%s\", %ad)'"
>>> +
>>> +And then to get the commit summary:
>>> +
>>> +    git git-commit-summary <commit>
>>
>> - 'tformat:' is a better fit than 'format:' in this case, because it
>>   adds a trailing newline.
>
> That depends on what you use it for.  I most often use mine to
> insert the reference that flows in a sentence, not as a separate
> displayed material, e.g.
>
>     1f6b1afe ("Git 2.12.1", 2017-03-20)
>
> so for that purpose, not adding a trailing newline is a feature.

I agree with tformat. I didn't notice this because I've been screwing
around with my pager settings and my configuration was implicitly
adding a newline. Do you mind fixing that up Junio, or should I
re-send it?

>> - I find that the two subsequent 'git's in 'git git-<whatever>' look
>>   strange.  However, to make this point moot right away:
>>
>> - I don't think SubmittingPatches is the right place to show how to
>>   create and use a command alias.
>
> These two I do agree with.

I don't think it disturbs the flow of the document, and since someone
going through SubmittingPatches is likely about to submit a patch,
providing that one-liner is handy, not as some "here's how to add
aliases" tutorial, but so you don't need to go and copy/paste it, add
\'s for the "'s etc.
