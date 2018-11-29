Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C94211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 13:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeK3AvD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 19:51:03 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39598 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3AvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 19:51:03 -0500
Received: by mail-ed1-f51.google.com with SMTP id b14so1926408edt.6
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 05:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kU4mcNFloB0+jciAG43NfrV57it7z8peKrxDfKEON90=;
        b=U99LTZ25TzUwfzEjXX+9avHZ0k4hDHCFUxvhsI4z9lu0BQKbGGHu0TIXJ05kHwai2y
         hvsDzmsehJM6e+myDu/Sizz/Y6HX8CE7kpiMfeoWHXPUV8JkyBjL7Bb/nY4E7sjXVBzO
         IjKCa/XNmIAoCs+Ueq4IEfSnZIg/waiJrjyDLbV8n1mgJg1qleZ4MhKhrgKIjFx9/cCf
         yCHi7lse7M8EHJc+WirOTEdyTclH61AsHhJJwqzrnwNH2ea7Ss2UOb5xixrvwN4YrXUX
         eukLDAc2qevX6+/zmXJpbgyabwDt1q4pu6D9WXJ/Gq00YFi6HUj+fc3tmpXclOgzpL1I
         Q8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=kU4mcNFloB0+jciAG43NfrV57it7z8peKrxDfKEON90=;
        b=LX8wAcGzz7xppz5blBFOaalNgHsNHxY58ijMAU68g3/c5n4rPx8lgqw68Pn4g7JZGk
         YxV9OT/Ky4l4slqVp4B53aX7h5wp75rjWeRgNhWxDmGjiZljTM1NTt/30l9eZPSz99bq
         YIOstPj5mBmRIdfMMcY7oecoLrssFb2n3R9FvxmLT6gnW6uvnnrW+DEDEOtnT8hZ71wO
         lKIlSHDp2Gpi3/6SrX6MJ5LMDBUp9iVIpbKiiT1QoAFvTZJI0kKbX4KziRxIt9HJHn50
         F6n085DBOMZJ1tYXvCAmBLSA2/WyHDkA55RpbCQ9bSFnv2hwYlyKwAaMj9b9y9XFMeAT
         0DYg==
X-Gm-Message-State: AA+aEWZ7JBoG0hzxOpjpu29CnF093JYOg4LGb491P1Es8atxt6cdK0D4
        Lz4/XP5YIN7HOMnwHP2kaTSWvg9kWzrD0T3lAOvwFT946ElEiRAN
X-Google-Smtp-Source: AFSGD/UDeVPD3ozO6TIAkWHg9DBrvdKul0F5I9cLBXV/ECC9b4/xQqe6PUzFTg6GWyvinTwDz3kbtRMcWjTlecvgsXs=
X-Received: by 2002:aa7:cdda:: with SMTP id h26mr1805468edw.248.1543499137051;
 Thu, 29 Nov 2018 05:45:37 -0800 (PST)
MIME-Version: 1.0
References: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
 <CABUeae_4yxtxFmi14+OivX-wFQq4Hd5uEV3_WhRMsMHbvSxy7w@mail.gmail.com> <001901d487e9$0f9e9d90$2edbd8b0$@nexbridge.com>
In-Reply-To: <001901d487e9$0f9e9d90$2edbd8b0$@nexbridge.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 29 Nov 2018 14:45:10 +0100
Message-ID: <CABUeae_jj1eqwgRNkC7R5GfLBhuKZjXYTBUJ5VgPyfLocFfJOA@mail.gmail.com>
Subject: Re: Git Tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Nov 2018 at 14:40, Randall S. Becker <rsbecker@nexbridge.com> wr=
ote:
> On November 29, 2018 6:56, Mateusz Loskot wrote:
> > On Thu, 29 Nov 2018 at 12:50, Stefanie Leisestreichler <stefanie.leises=
treichler@peter-speer.de> wrote:
> > >
> > > git tag -a 0.9.0
> > > git push origin master
> > >
> > > In my local repository, when I run "git tag" it is showing me "0.9.0"=
.
> > >
> > > Then I did (on box B)
> > > git clone ssh://user@host:/path/project.git cd project git tag
> > >
> > > Now git tag is showing nothing.
> > >
> > > Why is the tag only available in my local repository?
> >
> > >From https://git-scm.com/book/en/v2/Git-Basics-Tagging
> > "By default, the git push command doesn=E2=80=99t transfer tags to remo=
te servers.
> > You will have to explicitly push tags to a shared server after you have=
 created
> > them."
>
> git push --tags
>

After my yesterday experience [1], I'd be careful with git push --tags :)

[1] genuine screenshot and link to related thread at
https://twitter.com/mloskot/status/1068072285846859776

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
