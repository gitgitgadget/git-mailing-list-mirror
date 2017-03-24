Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D57F2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 11:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdCXLLM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 07:11:12 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33728 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdCXLLL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 07:11:11 -0400
Received: by mail-io0-f176.google.com with SMTP id f84so14577598ioj.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vXlTJYDYbgcMWfAJprWU6OQRIeymF6CeVX2jazjk/PU=;
        b=KWrIM7P8xx8JDfh5izl2GpqWkFcalqFmoBU/RRZuZG0TGsCiknPuISuIoU5abILEZH
         Tq1Fxrs+bHXINJGf6LXgbqHZ+1sEGC8Qt4yP6PkKKTfvlfWikQGnffG6jm5AzRTa1WhC
         xoIQ/F2zgqNOIa3NP2PPxdPMfeF5dN5G0MJRqlrguBgjbKoYgKEqsQ/5o0gh0GtS+x0j
         aITwC3ioRZ8B4Fz62bbXQx5DJcHnvcLCyf6VM855t8LN6qWqkdrFz5+tJZ6QWvzg3rvX
         TDBe1TleJhLJpqtHMNobBQt10rQTfcDCw7car4BRQlJkyma5A6utsQaX8v7T6DqEorUS
         ijow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vXlTJYDYbgcMWfAJprWU6OQRIeymF6CeVX2jazjk/PU=;
        b=dWWi4z60LlUPbU6cpXI7nvHMlHQoiq1pZKr0XOKhxsZMezq9QVnDW0a/L+8Nj3RvBa
         gAibcx7BKIRE7VCXlMGGxsdtqLn+VEL0GssjT9uYglK7AHUvEMs5442HxvwmaBWx9+Vw
         KaqFuvPVPEDYngKsARC/NVSUb+PY0R9u7McXSjZjr4wiZK79G5RkE3CFXyubZwrXbX9x
         65+RwgiWnCG5dXIMjG5g6Meoqx7QVlwFFgtPNQSeZi8QlzjpVtjQ377yQyev7seUxGxe
         rcRdpWv+4v+RKgraFFKQU4WDYHwQ03m+eLcdZSX0ySzuEWZ8pJzyV71UUhRLlijXf6KS
         UHuw==
X-Gm-Message-State: AFeK/H11hMKlz2cM1v/tjQD6uYJPE/kQy9bFdMQemwvebzifXQBCOjGLGawJw6nGWCy4AxYr8JKE5cj/E1gPtg==
X-Received: by 10.107.150.201 with SMTP id y192mr8490208iod.33.1490353869716;
 Fri, 24 Mar 2017 04:11:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 24 Mar 2017 04:10:49 -0700 (PDT)
In-Reply-To: <20170324005249.GF20794@aiede.mtv.corp.google.com>
References: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
 <20170324005249.GF20794@aiede.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 24 Mar 2017 12:10:49 +0100
Message-ID: <CACBZZX6U0PAAK8vJxBW2VSzbtfttFUNTZhDGk=BzLxkaTn64gw@mail.gmail.com>
Subject: Re: How do I copy a branch & its config to a new name?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 1:52 AM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> Hi,
>
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> I couldn't find any previous list discussion about this, but if not I
>> think something like:
>>
>>     git [checkout|branch] --copy src dest
>>
>> Would make sense as an interface for this.
>
> Sounds good to me. :)

Actually this is a bit confusing, but I think reversing the arguments
makes sense, i.e.:

    git branch -c dest [src]

And similarly:

    git checkout -c dest [<src>]

This is confusing in that it reverses the arguments, but more useful
in that it allows you to omit src like the other invocations of these
commands, and you can e.g. do:

    git branch -c avar/topic-2

While on avar/topic to start working on avar/topic-2, which would copy
avar/topic's state & config.

I'll put this on my TODO list, but unless someone comes up with a
compelling argument against the above I plan to make the interface
look like that.
