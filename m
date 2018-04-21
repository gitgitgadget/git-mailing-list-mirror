Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B111F424
	for <e@80x24.org>; Sat, 21 Apr 2018 06:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeDUGnW (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:43:22 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34207 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeDUGnW (ORCPT <rfc822;Git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:43:22 -0400
Received: by mail-it0-f52.google.com with SMTP id t192-v6so4802893itc.1
        for <Git@vger.kernel.org>; Fri, 20 Apr 2018 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sD5SjoEEgu1ZzsvzOcpdv19MSmWexrPa1/ygzQaF2T4=;
        b=DTMcKD4mZFZvDrPT0SQ4dUWXtEGI52wMAGtl8kSREvZlpzTI+tBKlrUTZyk0hh1GiL
         E4x+DdE0/seljjaXHwowaaIpBX0YQWbV6gumVlNOEnJnx3W6NMVLsXELMCXYhruo7MBz
         up8d7PjYx5Q1J+V74p8LcjvD3bn73fOl04K+E+k6cho8y5DHWVMFPbISR5VyMdaso02+
         5UAJvg8GOa6ldK5WlAAzIg49N+gH9KB79Hba+Kn2woPWHS96in6zp5P5N6g9wNKaMUHP
         Ns5h4GTMGHHo3R9BZEYVkcOHBTqEPu/7TG7A+RLZ504GhrN6ibm0siJYDW9YHoZe904w
         5wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sD5SjoEEgu1ZzsvzOcpdv19MSmWexrPa1/ygzQaF2T4=;
        b=UbWQgVjKG9NfgX0aE+X2Cdk7kDa/02c6BuSGfpI0t4lLcKY+5iOKjoYwwkgN0Hmkgq
         +xXxv9QEH26ljnjzps1Urf2whpIvS4XVghhcOkGAorh7zSCve+4I9SPCz0y6cjhgZ2mH
         B8Ookhnc8pQBBoJEPFVrbANm1nNsyQBAl96gIttVXd/RI5quf1ElfxnpMAGYNY5hkXx/
         jR+sIN0FMBiw2bz7Hy2C9Hxj7JCUM38MJGVJpr/4Ya+n1eQxKe3VGRdiHFX0Lo/9RdES
         VLK6Y1vE034QkRjzogwWS3EddO4r7WmB9wu7uZOXL9LUpipSvVZb1OMQcV5pkIoiS7aH
         pfLg==
X-Gm-Message-State: ALQs6tCv7ufjVGQCuKvWuo+F+ZYwZJXHn4f8ieAqG/HqheiFceMClsn0
        HavURQaj8mZGITDyB7D+RFKZlcU9rPztk/J41aw=
X-Google-Smtp-Source: AIpwx490oVDQA2OWXDHftMcJJ27JDXzJ6Ibc603kwCigX4DoRg606quUV3G7wdDgZwfRH5eSV18YnKUIciUqr3bDfns=
X-Received: by 2002:a24:3d0d:: with SMTP id n13-v6mr5801344itn.81.1524293001308;
 Fri, 20 Apr 2018 23:43:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 23:43:20
 -0700 (PDT)
In-Reply-To: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
References: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 21 Apr 2018 08:43:20 +0200
Message-ID: <CAP8UFD1H9vUVkx2rCJ03954jZp==Wj+O06hO1YYPQcVHbSV_Zw@mail.gmail.com>
Subject: Re: Git archeology
To:     Vladimir Gorshenin <gorshenin.vladimir@googlemail.com>
Cc:     git <Git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Apr 21, 2018 at 8:19 AM, Vladimir Gorshenin
<gorshenin.vladimir@googlemail.com> wrote:
> Hi,
>
> My team and I as well as millions of other developers are excited to
> have such tool at hand as Git. It helps us a lot.
>
> Now we challenged ourselves to be even more productive with Git
> analyzing our usage history.

What kind of analysis do you want to do? Is it the same kind of
analysis as described in the "Token-based authorship information from
Git" article (https://lwn.net/Articles/698425/) on LWN.net?

> And there is a problem, which I believe is fundamental for Git (please
> prove me wrong): how to find all overlapping commits, e.g. touching
> the same lines of code?

It is not very clear what you would consider overlapping commits or
commits touching the same lines of code. If some lines of code have
been duplicated in different files, for example, are the commits
touching the original lines relevant to what happened to the
duplicated lines? And what about lines that were moved from one file
to another or in the same file?

> I played with =E2=80=9CGit diff=E2=80=9D and =E2=80=9CGit blame=E2=80=9D =
but without a reliable
> result. =E2=80=9CGit diff=E2=80=9D gives only relative number of lines an=
d it=E2=80=99s not
> easy to track these number through 1000+ commits. =E2=80=9CGit blame=E2=
=80=9D has nice
> output but without any information about deletion.

Did you try 'git log -L' as Szeder G=C3=A1bor just suggested?

> What would you advice me to do?

If 'git log -L' and other git commands are not doing what you want,
you might want to take a look at cregit
(https://github.com/cregit/cregit) and maybe at other work from the
people who developed it. The above LWN.net article is about their
early work.

There are links related to this tool in:
https://git.github.io/rev_news/2017/05/17/edition-27/
