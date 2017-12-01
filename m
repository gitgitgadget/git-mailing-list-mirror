Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9A320954
	for <e@80x24.org>; Fri,  1 Dec 2017 21:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdLAVh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 16:37:27 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:38548 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdLAVhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 16:37:24 -0500
Received: by mail-io0-f194.google.com with SMTP id d14so12742570ioc.5
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=4XQfaBcITlZSrh1hmcVpBbM9ka/+fq8SPtRe+zR1G7o=;
        b=tujnBqjlMh2txHxYGdshIjRyajTovr5CwUtchlC7jdtTE/pd4AEXjSYRdH9TqXeWgM
         lfYHm8ksl/ZDgQ9j0u/8LF+yt7+bIWZJ2h2hEvxyepCTzI9w6ieZ2hfaHQPDs7VVVetG
         EtxzYVS7lLuE+/GB8i1Pp5A7wacvTZHjU+iIZPDXOJxmRQJHXXwpI9vmvUMSMfKhCCO5
         RZS9htq2WmcyRKbC0cIT7Og7JjsIOOUhP//akDlKXZbyIS3QZ1Z1G+WGRQhKghtCBq+7
         JyXTrKvqrwf2qvh8RyNTJfUn8lgF+O2nuOB6R6/eVIlFyIzAF0i+oaH1LqOMda0sm8ui
         3lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=4XQfaBcITlZSrh1hmcVpBbM9ka/+fq8SPtRe+zR1G7o=;
        b=WPo+8ioeMImcu4p8euCp2kEbwBrzncp7x6iICBhMDRvsZGB/tV729I+kLXodjWM+Rx
         DYTV0rlxRQm4+dRbcqw8w/Gql5UQhnewy1/YXts58Kg2JDTvf76jXyE8oHOGVHGLeeY7
         Ga6P4mAwQz4cmRIqCVQOKIwaRrYB3juUtY6VsROYbkcgpHKVrqDrgFHSHyZglOMPmKVU
         0sIcdsp4q6Ds+GeG/gaUrwavaeTszA6p+S0hTdh9wNjsmDJbUP8wTNf/GEHU5MiYN9jw
         sdT54crTx+S+HqcCwXmcvKJMIlErpqEc+T92IwTPfHKZaQ76CvsJ+tbvOkkZDuFvNchU
         Ve9Q==
X-Gm-Message-State: AJaThX7Boyuh9JTCH7MpqQBtx5Ztm+2PQYL4ml4jTJbVznHWQVvSA2aP
        w/NJEllkrWJToAKTK0jXB4F8IZr3qgrc809Kj0k=
X-Google-Smtp-Source: AGs4zMZuwh2AbSizc8nqtsJRS6ibDk6bdTm392BLKqn3bOtXgEFO9rRiQOQ1UyQ+7ZrfrVOPw6Zz+/0Ibe482SP0Kgk=
X-Received: by 10.107.201.78 with SMTP id z75mr14860200iof.123.1512164243749;
 Fri, 01 Dec 2017 13:37:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.26.207 with HTTP; Fri, 1 Dec 2017 13:37:22 -0800 (PST)
In-Reply-To: <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
 <20161204204057.32dnkjx6ixv3swez@gmail.com> <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
From:   Timon <timon37@gmail.com>
Date:   Fri, 1 Dec 2017 22:37:22 +0100
Message-ID: <CANtxn9KjTToqXKeO1mM8c6kD+jLf8QcAVXF46tX61uQB7YdKYA@mail.gmail.com>
Subject: Re: [BUG] git gui can't commit multiple files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally I had this problem in gentoo and assumed in the end it's
likely due to my specific configuration.
However recently I switched to nixos and am still experiencing it.

I've search again if I can find anything and lo and behold, it's
already fixed in the *windows* version of git-gui...

issue thread: https://github.com/git-for-windows/git/issues/1012
commit: https://github.com/git-for-windows/git/commit/1c4d4e7cbcf404c168df5537d55e9afd57f2b01b

I applied it locally to git-2.15.0 and can confirm it fixed the problem for me.
If you need any more info/help from me, or would like me to test
anything, feel free to ask.

On 12/5/16, Timon <timon37@gmail.com> wrote:
> On 12/4/16, David Aguilar <davvid@gmail.com> wrote:
>> On Sun, Dec 04, 2016 at 05:36:46PM +0100, Timon wrote:
>>> This is a regression in git 2.11.0 (version 2.10.2 is fine).
>>>
>>> In git-gui I select multiple files in the Unstaged Changes (using
>>> shift+click) and press ctrl+t to stage them. Then only one files gets
>>> staged instead of all of the selected files.
>>> The same happens when unstaging files.
>>>
>>> Git-cola also exhibits the same behavior. Although there I could stage
>>> multiple files if I used a popup menu instead of the keyboard shortcut
>>> (I'm guessing it goes through a different code path?).
>>
>> Can you elaborate a bit?
>>
>> I just tested git-cola with Git 2.11 and it worked fine for me.
>> I selected several files and used the Ctrl+s hotkey to stage the
>> selected files.  They all got staged.
>>
>> If you have a test repo, or reproduction recipe, I'd be curious
>> to try it out.
>> --
>> David
>>
>
> Can you try with git gui?
> Though I guess it's probably specific to my distro or configuration.
> I'm running 64bit gentoo with:
> linux 4.8.12
> gcc 5.4.0
> glibc 2.23-r3
> tk 8.6.6
> gettext 0.19.8.1
> openssl 1.0.2j
> Not sure if that's helpful though.
>
