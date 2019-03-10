Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4026920248
	for <e@80x24.org>; Sun, 10 Mar 2019 01:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCJB5e (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 20:57:34 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:36142 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCJB5e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 20:57:34 -0500
Received: by mail-it1-f170.google.com with SMTP id v83so2128176itf.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 17:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3Eict7h0jrLYhKRyJo9r4UWOv13Z/dRRssCPmw+mp18=;
        b=hQ9Xr2qNT6E+8ipXAV45NjsPu+EMnvjhJy7RsGX8vLsKpJnxU+pwC3FWLhIbk3t/lx
         mHWK0tidd7TZs80wAIFsro5m8CgT1fRCa+u+kzscG9e8g/AtysChYVpR9AsZ1R5Yk2xY
         YECZwyUF6/0jWxCqb05QhV0Pd5kC23krAYmBJq60LsRot7Jl2NQ0JWhwdWTOax+i68pL
         rcs5IFIHVJ7RbpWVWP+yO8HCFfP4Y5qQeurO6w2lLYP66Nh+gB3+ms0vODneakTS+PhF
         awzvBmT7d/WZ4BpM/mknVA+mqkEDhZaXslriA9goEuEVYXXblKA4pko9J8t5AGc1Vdwp
         y+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3Eict7h0jrLYhKRyJo9r4UWOv13Z/dRRssCPmw+mp18=;
        b=qGaGysiKNZk8Khfj9N84iENwMXVRQsbumgGBpwOvMrCPcE1LOjNB3zYWrrRui3wa3Q
         uX0RPkB5ng9M9F9MKCVZYJlfSu6+D0+51JhMwiIdJSqmc+twvXYkT61oR8zuVv14a06T
         CRSXpy8fWUrQmdh3vefFZpQyLX6CXV4NmnyVLp/gn6fz/SAOREKc2cXrBA6RkuihjhPa
         ecJ0wmGyL7w1t34rYHuONbCXIWs0pJBn3OILQ/RpNM04O88RTw4jlsxsEvd32P+jxb2U
         ZN6Lpcjxcbv8xqq2Vt0h3dBxsa4+yUTc0o2l1ELIfg6OrOcxFcA0fLO7At6Op97m2LGe
         ABlQ==
X-Gm-Message-State: APjAAAXMm2JEa7eJ1aj3DbUaRSYvMxpZue1D/bHMaGKblL8FZgl/u58N
        w1CnTmS8GoaBs60ZVVAZa/K5lpmG67Sxa+BVabw=
X-Google-Smtp-Source: APXvYqwLGKe+Aogq7zKg52b1rZhtN1GyrOA2ytZH8P37jbwsAexS1CMINRrXkLXW7V//OKRDlj45UZfV2MZ9rLkIaqI=
X-Received: by 2002:a24:3a12:: with SMTP id m18mr11437367itm.5.1552183053193;
 Sat, 09 Mar 2019 17:57:33 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com>
 <20190309161003.55t4irdwd76asnuf@tb-raspi4>
In-Reply-To: <20190309161003.55t4irdwd76asnuf@tb-raspi4>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Mar 2019 20:57:07 -0500
Message-ID: <CAH8yC8=01S8m8XCPoHgfX1woAEzHN7HXEn2Ncc1ceOF0SMnFaQ@mail.gmail.com>
Subject: Re: t0028-working-tree-encoding.sh test #3 data
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 11:10 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Sat, Mar 09, 2019 at 09:36:34AM -0500, Jeffrey Walton wrote:
> >
> > I'm experiencing a failure in t0028-working-tree-encoding.sh. The
> > first failure is test #3. The source states "source (test.utf16lebom,
> > considered UTF-16LE-BOM)" but it looks like a UTF16-LE BOM followed by
> > a UTF32-LE stream.
> >
> > Am I misunderstanding the data presentation?
>
> Thanks for the report.
>
> I think you understand it right.
>
> May be you can help us: Which OS are you using ?

Fedora 29, x86_64 fully patched.

However, I'm building Git and all of its dependencies with additional
flags for testing. The prefix directory is /var/tmp and the lib
directory is /var/tmp/lib64.

RPATHS are set for everything being built, but I don't rule out those
stupid path problems that plague Linux. In the past I have seen grep
and awk from /bin use special builds of libraries in /var/tmp/lib64. I
have not figured out how to tell programs in /bin to stop using test
libraries in /var/tmp/lib64.

> And what does
> echo "hallo" | iconv -f UTF-8 -t UTF-16 | xxd
> give ?

$ PATH=3D/var/tmp/bin/:$PATH echo "hallo" | iconv -f UTF-8 -t UTF-16 | xxd
00000000: fffe 6800 6100 6c00 6c00 6f00 0a00       ..h.a.l.l.o...

And:

$ PATH=3D/var/tmp/bin/:$PATH echo "hallo" | /usr/bin/iconv -f UTF-8 -t
UTF-16 | xxd
00000000: fffe 6800 6100 6c00 6c00 6f00 0a00       ..h.a.l.l.o...

> We may need some more debugging, may be you can send the whole log file ?
> Even if there is are a lot of ESC-sequences...

Yes, absolutely. Which file would you like?

(The only thing I can find is config.log).

Jeff
