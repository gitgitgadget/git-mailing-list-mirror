Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3585F1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 22:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbcIIWD3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 18:03:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36266 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbcIIWD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 18:03:28 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so81709454qkc.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+W0/BWr+3QoyBxn3RGvExnc2hGOCGQA3t6x1rv98o7A=;
        b=NkCZOjC7uwc2s4VqaDXwYHbJoag4IqG5UcLIwk1FqRxlgWfMizA4nIVB2xAowrjn2J
         vQxUYVB3I0/AxXjPx306j2mLnp31KZUKGuF5OoyS06So64ra1eMmHhch/i4kmGIaHmsx
         5QSR0mi+mTlX1qOGYT54K/OKeL+F2lb+MzQYX/fxMWTENjUGQ4ScqFR7KlBJpxteq1Xw
         OLwuZF2RiOk8jv1x8Ka9WsV/nP4i6VuxJU9Maszl7QwjTNoypsSIV9yr/bnGlOvV4Qut
         CQFN9jCdl+sIwbJzVJDRTPmMwVPZFMc/8xvxuBUEbk7gnTNeifdP+COGKBlbn8NVxCK0
         9VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+W0/BWr+3QoyBxn3RGvExnc2hGOCGQA3t6x1rv98o7A=;
        b=HqzZcfQFnh0XZj8IpMkaC4Upwfm5+wet0m+C7PIKMtP5nzKpBWG2tkLwGGMZNI6ts3
         IPqCDGqNZLwEU8i+3IBIBX9kJhLeqyCMU6unoNlFTCKBt9BnElCNboj6ImACAgoS/Jtt
         LBkIa8V2D3zvQfdsw4ntAGfUW+/+5gxLwguL1Lw+HBl34581XbBwZ1q8zFGV9r5X9Oq1
         6F+ykElNzGzHgYAxZFc4VRk49hvXT/35FxPToRG0dP0g4o/EVAS7LQgLZGqtNwYIk5QJ
         xyZYX6cSinZjLjLV1zLeYeglo5sWdV1MvRlT/ftcKHnMDVohrEaSrh4SFAoxZXGOQick
         FFXg==
X-Gm-Message-State: AE9vXwNi08U5d+Mu9iX7PbJatcd/DXlrrWiAjoI6TORwcZTX9vrseDWm1FgUtmUWEeReGQv53VxZ36k2vK9ARg==
X-Received: by 10.55.5.13 with SMTP id 13mr6410778qkf.112.1473458607144; Fri,
 09 Sep 2016 15:03:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.49.227 with HTTP; Fri, 9 Sep 2016 15:03:26 -0700 (PDT)
In-Reply-To: <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de> <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
 <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
From:   john smith <wempwer@gmail.com>
Date:   Sat, 10 Sep 2016 00:03:26 +0200
Message-ID: <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/16, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> W dniu 06.09.2016 o 23:01, john smith pisze:
>
>> I'd prefer smudge/clean filters instead of `make' scripts etc. to
>> convert template dotfiles into something usable and back because
>> filters:
>>
>> 1. could be run automatically
>>
>> 2. do not modify files as shown by `git show HEAD:<file>' and
>> therefore no files are reported as modified by git status and also
>> there are not conflicts when merging master into work/home branch.
>>
>> I have problems because with point 1 because apparently smudge filter
>> is not run automatically every time when branch is changed if files
>> listed in .gitattributes do not change. As the last resort I could
>> force smudge/clean filter to run just to keep advantage specified in
>> point 2.
>
> Couldn't you use post-checkout hook plus clean filter instead of
> clean/smudge filter pair, if the smudge part depends on the branch?
>
> Or make post-checkout hook invoke smudge filter... though
> `git cat-file --filters` is not in any released version, I think...

I moved smudge-filter functionality to post-checkout hook and only
left clean filter. Now post-checkout hooks is called every time when
changing branches but it's not working together with clean filter when
changing branches.  For example, when I have this on master in
bash/.bashrc:

export EMAIL=3D"@EMAIL@"

After moving to `work' it becomes this thanks to post-checkout hook
which replaces @EMAIL@ with correct definition:

export EMAIL=3D"work@address.com"

But when I move to `home' branch from `work' I still get this:

export EMAIL=3D"work@address.com"

post-checkout didn't work here because it can't see @EMAIL@ part in
bash/.bashrc because clean filter has not been run. I need to run this
single command to force `clean' filter to run to replace
work@address.com with @EMAIL@ and let post-checkout replace it with
correct value:

git checkout .

And now I get the correct definition:

export EMAIL=3D"home@address.com"

So it seems that clean filter is only run when checking out paths but
not when checking out branches.  Is my thinking correct?
--=20
<wempwer@gmail.com>
