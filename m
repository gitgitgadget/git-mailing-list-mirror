Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8446320C33
	for <e@80x24.org>; Thu,  7 Dec 2017 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbdLGUNu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:13:50 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:42917 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdLGUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:13:49 -0500
Received: by mail-qt0-f169.google.com with SMTP id g9so20778643qth.9
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VEyycFtmbfxfADkNBQ0a8nohkNFQKcsKK2XjtHQCa6g=;
        b=T6jxdYzjsyrmP8yVCyD/qdZ9QeUPsPjJEuBkck33bTvTBjWbFcdiFadnjIB2J+ZAN7
         tMdWzHeomG94ajsAwwiz9IccZgb46ZdwKDKNXxgIqUU93SVqY/xfxidXUfLB0QpbXf0e
         7yAiHxyxl87NhRaCq/8AcHDUPqBQ7bkyuORv29Y0K8YGr3q6nq5jm/rMKbAAaJCW2yfE
         DW/JKeQcfYhM9OkGFVWaRQcPhRX3fFNnyHHAZ6Uo1fTVUzIBLVlySoLh4UNEpC911nmp
         rzl5sBpNRME9ka/eJHaZ3OvTMytAXa4gLEVfZC6Fb3TORf9vSbcvIb6Zx465riaGQJDv
         LPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VEyycFtmbfxfADkNBQ0a8nohkNFQKcsKK2XjtHQCa6g=;
        b=PIJ+ReFt7IR4JT6pr3ZTzG8C6tniqrRDrWdNMXahXFJmFWbulw1Toonj63pCcuPq6n
         M3O7xPzSLqNuyQqSHBvm00+gjRWbG6z+4LLWzaFM2MaQXEnNZrP0cU/zPf8xjUiftj8l
         2HgTN4EDfHx47yXgWysRzvC8A4XKzSR/7VWWwqK1WiaOhHALHkyApVFNWq4Gwf92FPZC
         V3es1EzTd7kQrX/B2i9pG4BAW7ZSOTENlvgGWf9DgufwrjX/n44SOhzGxbHRA2s+eF/k
         wvdyrQNQvRB5a0jGEtLp3iBhi4UrWeyrbR5iZKwf5Gz2Rc+ZGYVkj7PygknB3gxYelzD
         WUOQ==
X-Gm-Message-State: AKGB3mIqsH8rZcowZ04xUa7Fun8uMifZfxxVHMFy+JX9cpYW162TmmZi
        K5UNmjYIUsaA3JpLaO9tbRFU0b42QdriWeG8WjSlrQ==
X-Google-Smtp-Source: AGs4zMZY8s9v125XUHGB8ppXzloKSqpQP46WcQ/PReFcGYeuBDuhHj5VXD671YXAVvi80CzTp6ccTAXpgZMzM1zUDTA=
X-Received: by 10.200.44.251 with SMTP id 56mr11717630qtx.87.1512677628293;
 Thu, 07 Dec 2017 12:13:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 7 Dec 2017 12:13:47 -0800 (PST)
In-Reply-To: <372261511885370@web21o.yandex.ru>
References: <372261511885370@web21o.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Dec 2017 12:13:47 -0800
Message-ID: <CAGZ79kZt7hysp9Yzj8==nz9FAu3V4KduG9kH2KxhdEK5CTBiqA@mail.gmail.com>
Subject: Re: Feature request: Reduce amount of diff in patch
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 8:09 AM, KES <kes-kes@yandex.ru> wrote:
> Hi.
>
> I get often patches which can be minimized:
>
> @@ -60,11 +64,8 @@ sub _get_filter {
>          address    =>  { -like => \[ '?',  "%$search%" ] },
>          company    =>  { -like => \[ '?',  "%$search%" ] },
>          country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
> -    ]);
>
> -    $users =  $users->search( $filter, {
> -        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
> -    });
> +    ]);
>
>
>      return $users;
>
> This patch can be minimized to:
>
> @@ -60,11 +64,8 @@ sub _get_filter {
>          address    =>  { -like => \[ '?',  "%$search%" ] },
>          company    =>  { -like => \[ '?',  "%$search%" ] },
>          country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
>      ]);
>
> -    $users =  $users->search( $filter, {
> -        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
> -    });
>
>
>      return $users;
>
> May you please fix the git to generate minimized patches?

You can use a different diff algorithm.

       --diff-algorithm={patience|minimal|histogram|myers}
           Choose a diff algorithm. The variants are as follows:

           default, myers
               The basic greedy diff algorithm. Currently, this is the
               default.

           minimal
               Spend extra time to make sure the smallest possible diff is
               produced.

           patience
               Use "patience diff" algorithm when generating patches.

           histogram
               This algorithm extends the patience algorithm to "support
               low-occurrence common elements".

           For instance, if you configured diff.algorithm variable to a
           non-default value and want to use the default one, then you have to
           use --diff-algorithm=default option.

Soon we'll have another diff algorithm "anchor" that tries to
keep a given line out of the +/- but rather move other lines around
the line to give equal results.
