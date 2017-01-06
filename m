Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF901FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 19:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755906AbdAFTbr (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 14:31:47 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34440 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdAFTbp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 14:31:45 -0500
Received: by mail-vk0-f51.google.com with SMTP id x186so317746092vkd.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M/94Oj8DZPEW2qu1DXxVSLToUWvXkwDGmUYcGhLlH24=;
        b=nsb+zWnUTc6PKPi5d3kSEScYGspxJcQ0rrtHyRIoHZvREDbtTzkotfhNiEML4cOQY0
         ElSDVuH4RQb0NYYS/jA+oLPwrTo9YPHx6d9m52IHPSi97JWDkjUkUy0/RuIfSk+W70Lk
         3OWn7IeAxQG2/RjVd4MkbpgTINMl7YJ7dnsXhKgagBtnSqHJU2BcY7ChlUCjYde6jVLV
         8ZNhZyTD+PBSxCtNveIaa01b1Uf+VxJBHYJhhb3mCcm4xAtydbdnsbWpRKDEidTs4S2d
         nZXgawV3WLsDnR9UYm9cjL1NX1krN3LLbTionZDwp3crlV4VaJ+UUWxPN6QNa0Gf9K/a
         DyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M/94Oj8DZPEW2qu1DXxVSLToUWvXkwDGmUYcGhLlH24=;
        b=WM7jhFtyueJsvXCmpCRnjtRWRJoe+oDTU68inMpc66OtoZJToDbYz0fMK79ZOBXdyG
         vmwEvKFYN02fH+h4vdbUrEJn5WO8ZsraokfsUw62AafrD0xZ4C4oZ4hzkmw9E0moAFQe
         Kkusb76Gbsc8859lfTzyfa7csmEJyYMqc7NBVA/9mohvpWacil+xEIUtZs9pXciTDrKa
         9OduHBYqMZ1AEruGgRyP4Brj+xLH4pjXQPm2ogMNS9YXS7z0H7xdSs0QqjJaxfe/InzD
         a6hiTer1XRxC2xQiYn0yH94X6Zd45W40rANjMPFfDKZCaW5+SaimmxhNJKjbR6ufX/JS
         wXvA==
X-Gm-Message-State: AIkVDXIz1+rwY232K+9J9agCio7vGwSFaowGcmUxMaDIoekvrDTyxuIQ8dWMOjmemU+FNN+51qm+TpSUY48lJw==
X-Received: by 10.31.214.7 with SMTP id n7mr28291189vkg.36.1483731104596; Fri,
 06 Jan 2017 11:31:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.32.42 with HTTP; Fri, 6 Jan 2017 11:31:44 -0800 (PST)
In-Reply-To: <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com>
References: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
 <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 6 Jan 2017 20:31:44 +0100
Message-ID: <CAN0XMO+zzYOXF2gwr=0Tu-7T5BH7f_L+FhfD8RUenDeq3xFHjA@mail.gmail.com>
Subject: Re: git branch --editdescription fatal error
To:     Stefan Beller <sbeller@google.com>
Cc:     Jake Lambert <jake@onahill.co>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-01-06 18:55 GMT+01:00 Stefan Beller <sbeller@google.com>:
> On Fri, Jan 6, 2017 at 9:25 AM, Jake Lambert <jake@onahill.co> wrote:
>> Hello,
>>
>> When executing "git branch <branch> --edit-description" on a branch with=
 no description set, I get "fatal: could not unset 'branch.<branch>.descrip=
tion". It would seem that the unsetting piece should occur only after check=
ing if it was set in the first place.
>
> That seems strange. Is it possible that your config is not writable?
> (.git/config, ~/gitconfig, you'd need to find out where the <branch>
> is configured already via git config --global/--system/--local --list)
>

Have you actually tried to reproduce this issue? I'm on current next
and can reproduce the problem.

It seems Git is not happy with unsetting non-existent configs. And at
least the following piece of code
seems to be there since 10bea152a (Add functions git_config_set() and
git_config_set_multivar(), 2005-11-17).

config.c:2212
/* if nothing to unset, or too many matches, error out */
if ((store.seen =3D=3D 0 && value =3D=3D NULL) ||

I wonder why it's an error to remove something that doesn't exist
except the case we 'know' it
exists because of further actions. I don't think this is a thing, though.
Just for the record: `git config --unset branch.$branch.description`
does return with code "5" here as well.

I think removing things that don't exist should behave the same like
removing things that do exist, with
a success.

Ralf
