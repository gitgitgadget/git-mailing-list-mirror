Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29141F461
	for <e@80x24.org>; Fri, 21 Jun 2019 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUVMw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 17:12:52 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:36307 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVMw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 17:12:52 -0400
Received: by mail-lj1-f171.google.com with SMTP id i21so7172986ljj.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6Isi8Q5SLDasMqV9tn4QCdOCTGkeKz/W5OHQ+9Vt3s=;
        b=UjV6Evs4TSRz9O14hf1Dxvp4jkbPWqsIASa+AaqftTG9lVV7ydISWyai3IoC2pon55
         DBuu+0DrKIG2sz0ltFCPeky9+9JotzVfSsw+uWwcb2j9jN+LRURq4IWOqzOdd/CJrMVh
         bZVpOpwUPUbKBM7xO90IV+XWlS/u112xMV4P8cHIMpjKBHeM2K9gEw0EJGGPQxU3ykDH
         cR3bApAtTNJd0KlI6ONa78g59jEpYtLrq34T9S9VzfnJzAGgDsq6N/gmt8D1l88IlvzS
         YrWOBtNuUuz7Ae0KCbmz0nzOMqZgVocZsv+k2Z7SBMM4oNS/pK9KhuMDAGWidisoVJYy
         FLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6Isi8Q5SLDasMqV9tn4QCdOCTGkeKz/W5OHQ+9Vt3s=;
        b=HC8qbdL87BBNTG0x2z3eS3oFK0ppbJ3ru0fb+lc6s6T81SRpdTt1tWL8i1kZ0e1K4L
         iQRF4BBNLa+C0lDsUSI33CIELk3xpPH5h0eB8zrrek/7ACHb5GAmF51yvLdBpnwZmPoq
         kWMiW+sTIw5228IO5dine2yA37lqZZ1tLNmoWSeQV7p4qlCUifLpUI2r3DScVMVkiQja
         kKb4AelCzYTfIHkmCsqnI5XTPELmY4bNlzhqxDbvr9IPmO5kgREx7YpVs27spM/0H8Kh
         0dTD43nPVJ02HrEltrgFf9JNhc7u+ej0SgGfV70ieN1l6HSthWr82oXWdrGRsp37hLFu
         9sZA==
X-Gm-Message-State: APjAAAVX/KH1g/Xrt3ogcg5wh2411GjrjM2zYkCywi+erPmosxQtMKPk
        Nm2zSlGu3Jpnb8VxmEw/bjyzEH2rcKp1HxWKm9Y=
X-Google-Smtp-Source: APXvYqxeisfBR2o4dhb/gvXMba3Lk9bv3uvv0zVeXGCreeQZS4CTx3Dcgr+FHjuW6qWf4xO3RpzVibHZN0ExVFMDjVs=
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr7233460ljj.234.1561151569692;
 Fri, 21 Jun 2019 14:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
 <87sgsb8dmx.fsf@evledraar.gmail.com>
In-Reply-To: <87sgsb8dmx.fsf@evledraar.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 21 Jun 2019 14:12:37 -0700
Message-ID: <CABURp0p2Z=qD2gF59AHBLaRn9iiTOeJyNXYsQDNk-_KEC4uSGg@mail.gmail.com>
Subject: Re: Deadname rewriting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, CB Bailey <cb@hashpling.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 1:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Jun 15 2019, Phil Hord wrote:
>
> > At $work we have a long time employee who has changed their name from
> > Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
> > is prone to be offended if they do.  This is called "deadnaming".
...
> What should be done is to extend the .mailmap support to other
> cases. I.e. make tools like blame, shortlog etc. show the equivalent of
> %aN and %aE by default.

It seems that shortlog and blame do use %aE and %aN by default.  Even
log does.  It is only because I didn't know about %aN 10 years ago
that my custom log format does not.

It's a pity the format author has the option to ignore the mailmap. I
think it's a choice commonly made by mistake rather than intention.  I
wonder if anyone would mind a forced-override config.  Maybe a force
flag in the .mailmap file itself.

           <cto@company.xx>                       <cto@coompany.xx>
           Other Author <other@author.xx>   nick2 <bugs@company.xx>
           Alice Doe <alice.doe@myco.com>         <bob.doe@myco.co>  --forc=
e


> This topic was discussed at the last git contributor summit (brought up
> by CB Bailey) resulting in this patch, which I see didn't make it in &
> needs to be resurrected again:
> https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/

Thanks for the link.

I didn't know about config options for mailmap.file and log.mailmap
before. These do make this option much more useful, especially when we
can insert default settings for them into /etc/gitconfig across the
company.
