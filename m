Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804B61F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeKAXQb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 19:16:31 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:36541 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeKAXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 19:16:31 -0400
Received: by mail-it1-f173.google.com with SMTP id w7-v6so1335752itd.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYB+QHNTr0Hra5IcQzH28Dt+bnMwevMhh5iijdVXqRw=;
        b=NqJujxvSvlYR/Yt/3XXZBcuNB9+9pjrZRy7aOKm+5aQBozW/8eLU5DdjZv0c7+Zdv5
         uZe411J49l7g5ChK1JotRBtS9ds0C7+DE+LTHD4l/tpU4kQd+Yuj5+9SPrRGpPMn6VGm
         KTMM6r25mqBaO79rC44a1FRVbzGb6pEBgP3tRSwkmBw+40uMEg+qaeKhrV3z/YTBbBuC
         +tk0L5ElTlBJlDYxORTFKPzdSwK9oQblivvObbnTi2GMh67dfP/o3ddvURvWIX4miWqe
         pLXZ5KCAr/poQrm3JUV+t/I7TxKYOUx+2bqhW9UnjqvadbyWuA3TWLM4Xq82SN72WJW2
         NAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYB+QHNTr0Hra5IcQzH28Dt+bnMwevMhh5iijdVXqRw=;
        b=nu9A6phMc9mTwR72n/7Zjr37U0AxcHboT0/iFjPKBKRMeUUv8s9cqB24/1h4oIhM15
         0zgWUq5zpFtcdF0ayYSJuiPOcSdTZ+gJrSBnfSQHJVpQwJGYb8tA2eWilMj/iK2n8mh8
         xI34xWPeB6OL+CtQkAobe4ZWaRVOp35j/PV7FPPxMa7/hchfmfCi+k2VZzJlEBOJrTGc
         rWo0YKjQdBUr2oxdNgkmzf7rHtYyYdg0jTNLkwvoXqmSBOuGkO/R3rQGUZMNzM6D151d
         dwfB4AQcdcVtlV71mF8FbW/1hzNZNk7iL7Z+VVoySu/N/VsyqUI0Fb8B7KNMyB+opi5p
         zdZg==
X-Gm-Message-State: AGRZ1gIVGWcyuWiDRY+pAHHRhlSGOezKNyV8KkvXUtXG1XeYq+c3lB1U
        a7Ovbn/GEUbPNE8pfXNYfHGLvf8cY0oXsQ+wyZo=
X-Google-Smtp-Source: AJdET5div3oFqE1x9kOuwD5awC/M/gLeVWWhUPP7a1o+V1phwIDwHDPhpTFPm3Ukm5CcyG66vGygkxdPAskW/Edt/DI=
X-Received: by 2002:a24:2285:: with SMTP id o127-v6mr4347746ito.168.1541081602296;
 Thu, 01 Nov 2018 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
 <87zhutjb3t.fsf@evledraar.gmail.com> <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
In-Reply-To: <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Nov 2018 15:13:10 +0100
Message-ID: <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
Subject: Re: [RFE] Please add name and email to git credentials
To:     nicolas.mailhot@laposte.net
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 2:31 PM Nicolas Mailhot
<nicolas.mailhot@laposte.net> wrote:
>
> Le jeudi 01 novembre 2018 =C3=A0 12:22 +0100, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason a
> =C3=A9crit :
> >
> > Where would we get an E-Mail to lookup to pass to the helper? Are you
> > just asking that the helper git the result of $(git config user.name
> > &&
> > git config user.email)? If so why can't it just look this up itself?
>
> So, just in case it was not clear enough, allow things in .gitconfig
> like
>
> [credential "https://pkgs.fedoraproject.org/"]
> username =3D doe4ever
> name =3D John Doe
> email =3D doe4ever@fedoraproject.org
> [credential "https://gitlab.corp.com/"]
> username =3D jdoe56874
> name =3D John Doe, Snr Engineer
> email =3D john.doe@corp.com
>
> Instead of just
>
> [user]
> name =3D John Doe
> email =3D  john.doe@corp.com
> [credential "https://pkgs.fedoraproject.org/"]
> username =3D doe4ever
> [credential "https://gitlab.corp.com/"]
> username =3D jdoe56874
>
> and drat, I've commited to XXX with the wrong name/email again

How can Git know when you commit where you will want to push the
commit afterwards?

What if you want to push the same commit to 2 different places that
need different credentials?
