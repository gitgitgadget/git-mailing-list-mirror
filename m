Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995421F597
	for <e@80x24.org>; Thu, 26 Jul 2018 08:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeGZJsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 05:48:41 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43451 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeGZJsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 05:48:41 -0400
Received: by mail-qk0-f172.google.com with SMTP id z74-v6so486400qkb.10
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGNO/X1guOdKd0O/Q4sWfcmMwtCEgxn7NMPr75u14EQ=;
        b=cDZMgR9ohedKIvTDbiFqbhmsnMO7Fn8Ps91HaGV6yqXya0BzQxZU5MB64GnpJ3+Q18
         4qxPY3JM2zCK5SgtqsiMcXPF8kL0uZzXkx2vpJ8mfcvtjV1NfSIwn3JMd7cRK9zUHdDB
         TbRs+YL6fDqek4z2S/RWdhSqlwYlWxNbR86eMyW2HxB5qpqv7xI0Jl+YQLe9ujrO3JyF
         cnsoCF6gKJ4cUhGEaaLp4AgT452i44R7n2d8UBK61VXUb9izqIe1fR0b4qDtmvI3rg0H
         iO0ayufPu4/UR/ONSuh+cZz24zDbJ+2XrGfpR6sCVzHGXXdhFsP4Z6Hp671LXUI3ltSD
         CxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGNO/X1guOdKd0O/Q4sWfcmMwtCEgxn7NMPr75u14EQ=;
        b=VHRrJsyLDQB2zbL0SnXnawYvYG1XyXZ1/4C4vnTbq7ddKATkXHj2n+/ZsnK266ej1j
         kZmqN9rmpvgp2jjBjkKfOP8Z944L744CCgrmLcTfd8AMjD8A33afYUhi1tQRtwzv6Wh4
         /qabbGl9lpFn5oUUh8F8B+Z7u3bzAS+vORMJENBOpUJvrm7KvHKuuLrUCXWsMNXiMESq
         gu5B0MLk/az7dpYSs7svE2X5IBFExX7wlQZVPx/FUtd3zwMCP7Ms3CSTePpcN+W/zeyr
         FmJIRz1QAjz3XGaxiApUBMe18jAnGg7+SE/oAtFXaigVMiB01ktak/LZKF/YTKsZrjIJ
         S8Nw==
X-Gm-Message-State: AOUpUlGJQjJzZ+C1AOijT4kkTL80doREKi87GcwE4hDUTJvg150SbYIm
        9Jd1mj+x2JJjV9DkfujeCnC5VfKoZzcerBqhS6ptvQ==
X-Google-Smtp-Source: AAOMgpepDeQhNE1jHqBRAboHZ6oO4uFibzOuYX5rbOgm132GwoBnNoip5E0KhfDUGf2lwsoC8WIukiNixe1/ClL5Yq4=
X-Received: by 2002:a37:6b84:: with SMTP id g126-v6mr777243qkc.231.1532593974594;
 Thu, 26 Jul 2018 01:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhF8Cok2sN4jv4K4PCPk2_Fyc6BHaLbdAvEOuFwg4EdN7Y3Yw@mail.gmail.com>
 <CAJhF8CqxqVts9weOgPfEzb=LJXRPHZc80r3ewWFa_dkA8mxXRA@mail.gmail.com> <CAPig+cT_cSjwpwxA_WMVV06=3BnYA9i1Lg6KzHbU9nb1_fF7vA@mail.gmail.com>
In-Reply-To: <CAPig+cT_cSjwpwxA_WMVV06=3BnYA9i1Lg6KzHbU9nb1_fF7vA@mail.gmail.com>
From:   Vishwas Kamath <vkamath2018@gmail.com>
Date:   Thu, 26 Jul 2018 14:02:42 +0530
Message-ID: <CAJhF8CqnC0XY96dNEinyh1Nn1dn4KMT=PSnkH3sDJunDwKWQqw@mail.gmail.com>
Subject: Re: Git Help !!!
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: multipart/alternative; boundary="00000000000070d2380571e2d719"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000070d2380571e2d719
Content-Type: text/plain; charset="UTF-8"

Awesome, thanks!

On Thu, 26 Jul 2018, 2:00 p.m. Eric Sunshine, <sunshine@sunshineco.com>
wrote:

> On Thu, Jul 26, 2018 at 1:01 AM Vishwas Kamath <vkamath2018@gmail.com>
> wrote:
> > I am unable to use Git (version 2.18 latest). Since i couldnt find any
> help/support/contact email on https://git-scm.com and i couldnt find the
> solution using Google as well i am directly contacting you as i need to get
> git working. Hope you can help me.
>
> It looks like you're experiencing a problem specific to Windows or the
> to Windows version of Git which is maintained as a separate
> project[1]. You may be able to get help for this specific problem on
> the project's mailing list[2] or by submitting a bug report[3].
>
> [1]: https://gitforwindows.org
> [2]: https://groups.google.com/forum/#!forum/git-for-windows
> [3]: https://github.com/git-for-windows/git/issues
>

--00000000000070d2380571e2d719
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Awesome, thanks!=C2=A0</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Thu, 26 Jul 2018, 2:00 p.m. Eric Sunshine, &lt;<a hre=
f=3D"mailto:sunshine@sunshineco.com">sunshine@sunshineco.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Thu, Jul 26, 2018 at 1:01 AM Vi=
shwas Kamath &lt;<a href=3D"mailto:vkamath2018@gmail.com" target=3D"_blank"=
 rel=3D"noreferrer">vkamath2018@gmail.com</a>&gt; wrote:<br>
&gt; I am unable to use Git (version 2.18 latest). Since i couldnt find any=
 help/support/contact email on <a href=3D"https://git-scm.com" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://git-scm.com</a> and i couldnt f=
ind the solution using Google as well i am directly contacting you as i nee=
d to get git working. Hope you can help me.<br>
<br>
It looks like you&#39;re experiencing a problem specific to Windows or the<=
br>
to Windows version of Git which is maintained as a separate<br>
project[1]. You may be able to get help for this specific problem on<br>
the project&#39;s mailing list[2] or by submitting a bug report[3].<br>
<br>
[1]: <a href=3D"https://gitforwindows.org" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">https://gitforwindows.org</a><br>
[2]: <a href=3D"https://groups.google.com/forum/#!forum/git-for-windows" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://groups.google.com/for=
um/#!forum/git-for-windows</a><br>
[3]: <a href=3D"https://github.com/git-for-windows/git/issues" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/git-for-windows/git/=
issues</a><br>
</blockquote></div>

--00000000000070d2380571e2d719--
