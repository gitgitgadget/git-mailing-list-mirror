Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403F51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfJCVSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 17:18:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:60755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733114AbfJCVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 17:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570137514;
        bh=EfrpdyEY0fDUsTWNuYvNMeHrLlSzY7ZqVetju206rKY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fhQulLURUAjGG0j+SCER+0o/joRerd53TWI6qBaKin5Ttw/Ffc/+1hNMeUrpAQmQy
         YKXUA6AcQof9vLvB0mZoxpSRlbdGGLD1xE6QGDrif4IPki0o7nGvR/b9ZdFh7WMvq5
         nvuTZr3mTO4ACvA+j2BOkxh6JLdGMFQI/OxB5j3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1iWHvx0hlv-00JYEd; Thu, 03
 Oct 2019 23:18:34 +0200
Date:   Thu, 3 Oct 2019 23:18:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     gespinoz gespinoz <gespinoz2019@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [Outreachy] Outreachy internship program
In-Reply-To: <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910032317230.46@tvgsbejvaqbjf.bet>
References: <CAP_ANik21_mkUdqwd0YQS4VDa80AnqQ+Xa1jWsQ7ihnfyQymYw@mail.gmail.com> <CAJoAoZkq1=VfJ05J8L2AvJjp6GxoTNTF6pNFAzQ1rx+7LKk6bQ@mail.gmail.com> <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com>
 <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1131529447-1570137514=:46"
X-Provags-ID: V03:K1:aGsHPh3wEGcC2U7GuxeBJCR/WNZTuk/yAVLO7amWeg0JNVTH75f
 vn1l2H/6XT7gguPpCiRlMuL3BrkeTMGMqS/74kTS0KA1tx6ZxGUjFJCFx6xFOvYkSMk6Z7j
 1+vBlCvqZhaXCdKRLyZ1ryO7x5GHXBMZG6QqF9A+5YRzipvmGB84I2z/kkSjqdpxJU0twGO
 m+Ncw+fP7CZrZRa+xKZ3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UEJLgS3dLRU=:5EOnWsCr5LovxdK3H9R2jL
 sJ/D5fmAhVen+fN8pWLGEeeMK1LI8WGzgTZ1jtWb7Hm+oqj5N1QUIuiKm4+Z1GMh8MKnJRQon
 d8jiyHfKQAhvRSdoBWHEhGxdxl8YJveLrZN9W/h12sUS0RGnd/BvUfLIOeByAnTlxyN/f5AUn
 iQbGsUQKjv8Yic4FvorkJXJCBx6ZnboV8tBLhyz//U6oMhTkT0CR9eI8g6whp1kKUImbyAkaJ
 h/psls2lc2tDRylMT2XMdds6ZgtSk9mZOd5p669qhzD3ASrHLGFJ9ByLzcRXWcFLLZOJ9keDi
 n7kZHCe6IkxYrGZRk6my4/72AHASzIRE9i8KohujcH60Iz9Q2Ga87h6K8EaG6OgWuaR1+G7pa
 P7lTufakXpZf4svIlvD73OFzLdcJm8+1/dgRZ/0ogMCq7t8uPp4S4QDNYLjM9DiiyIs42weyx
 CI1p18BhoukdncPJVKBSfWvJeDihrbSdkBG2E+sYX526tc6S/nood/2D3XD18rPuSzkkTP2cm
 E4E8lf8UouTve41uq5+3fGd0UuUQTV9v7A51NVDXJctm7sO/ZLHwKxk3CWjvJHBRv6pBG2WSb
 EXKPvsqBXMvIty3A7N6WBz44fNaoysaE38w0xtsYXyfPG90gGArhmecgQjz9BAUsiRcLNC0w5
 svA6rFl7cxfOVg9r9OR9A0UV5HuOCqtIL3+GSWYCbaPzxlGKGBJHBWTX9kXuwQwAA4HbFBHJw
 c8svGVeVdUrKyUQ8016M8ew9q5ZMgE4P3nvxX1/NK9dpTZmCfNyL9XGiZWWl8bEmKyGT+pCXr
 VgJMyz4X7JHwbB24BNTeCat3ERrooxr+1LuzDEIA3hV+F0/71lEl0sc2lqVsyP4w56DbG1X8K
 mvIeSJixLy3HTKhu4mIM3XS3O4v6yg+DZyWYtZbe25W4fPuPqXjTEf2hf4gH07wh6Hcxi0/f2
 EpAiczCDwmEs9ElhX1MdZVvozymhDdKFsKwfMfx7nRYK3tjDr67lD8em2GDDFj/C93UktsonE
 nsHrjZekCP4mEMYFO5+FkqFXjfY1tmi58KLmOhuc8SZEICCWDgTbkiTOVUXQLVc64nhjA75ok
 O9dZb7rQuzlLTh0C6TJGMMGqxSMKLJkkf5Vfgfa8YwaEvvgMVB5iNquzIF7zBkvauW1UpZoAb
 S1re69FbuuqsJNQ4oXTq0XFvzL6Vwp824/ug9yPVlxQrqqpePe/QAYJMy5D4sn1/1CHl0PSfe
 Hs9NX6nOpGKuBJCsYqdeA4+pMuEdweIPQYL/X4xECR2XBICof0c/ZasRjw1k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1131529447-1570137514=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

yes, there is no `make` or `gcc` available on Windows by default. You
will have to download and install the Git for Windows SDK:
https://gitforwindows.org/#download-sdk

Ciao,
Johannes


On Thu, 3 Oct 2019, Emily Shaffer wrote:

> Hi George, it sounds like you are probably using Git for Windows
> (https://github.com/git-for-windows/git).
>
> I'm actually not very familiar with how folks who primarily use GfW as
> their client manage their contributions to the main Git project.
> However, I know there are plenty - the GfW maintainer is an active
> contributor upstream.
>
> I'm CCing the Git mailing list as well as the GfW maintainer in the
> hopes that you can get some help from somebody who regularly uses the
> workflow you're trying to achieve. :)
>
> Unfortunately I use Linux everywhere and so I can't try to replicate
> what you're doing - but once you have a good workflow and are able to
> finish the My First Contribution tutorial we should still be able to
> work together.
>
> Can you be specific about which "official website" you downloaded Git
> from (share a URL), and paste the command you run and error message
> you receive? Please also share the output you see when you run "uname
> -a" in Git Bash.
>
>  - Emily
>
>
> On Thu, Oct 3, 2019 at 12:40 PM gespinoz gespinoz
> <gespinoz2019@gmail.com> wrote:
> >
> > Hello,
> >
> > Great! Thanks for the tips Emily! This mentor and internship program s=
ounds awesome which is why I decided to apply. I=E2=80=99ll look through i=
t to see if there=E2=80=99s a specific micro project available later on to=
day and run it through you.
> >
> > I am having one slight issue, I=E2=80=99m not sure why I can=E2=80=99t=
 use the =E2=80=9Cmake=E2=80=9D command to run Makefile, I=E2=80=99ve done=
 it at school in the past so I was a bit familiar with Makefile and how it=
 helps compile things. This is what I did. I downloaded git from the offic=
ial git website, installed it, then I found the repository link and I clon=
ed it in the git bash client to my desktop. I=E2=80=99m using windows at h=
ome but at school I used an iMac and when I cloned repositories I used iTe=
rm and pushed to git within iTerm. I=E2=80=99m guessing the git bash is si=
milar since I was able to open and edit files using vim commands similar i=
n iTerm when I was going through the walkthrough. So now I=E2=80=99m stuck=
 on the =E2=80=9Cmake=E2=80=9D step to see if I added the psuh feature in =
correctly. I also noticed when I looked at the INSTALL page on github it m=
ade it seem like maybe installing it through the website wasn=E2=80=99t th=
e right idea? Maybe that=E2=80=99s why I can=E2=80=99t use make? I also ca=
n=E2=80=99t use man correctly. For both I get bash command does not exist.=
 Should I install something similar to iTerm instead on windows and just s=
tart fresh? ty.
> >
> > George!
> >
> > On Thu, Oct 3, 2019 at 11:14 AM Emily Shaffer <emilyshaffer@google.com=
> wrote:
> >>
> >> Hi George,
> >>
> >> Great to hear that you're walking through the MyFirstContribution
> >> tutorial - that's a great introduction to how the Git project gets
> >> stuff done.
> >>
> >> This is my first time mentoring for Outreachy, but as I understand it=
,
> >> you will start by doing a microproject so everybody can see if you ar=
e
> >> a good fit for the project. The community discussed the list of
> >> microprojects for applicants to try in this mailing list thread:
> >> https://public-inbox.org/git/20190916184208.GB17913@google.com/
> >> I don't think you need to wade through the replies on that thread to
> >> determine whether the microproject you are interested in is available=
,
> >> although you're certainly welcome to. You can also ask me if you see =
a
> >> microproject you are interested in and I will be happy to help
> >> summarize it and point you in the right direction :)
> >>
> >> It is also probably a good idea for you to search that mailing list
> >> archive for "[Outreachy]" so you can see what Outreachy interns have
> >> done in the past and try to emulate how they submitted finished
> >> microprojects.
> >>
> >> The tutorial you said you're reading covers how to send your
> >> contributions for review when you're done, but if you find you're
> >> having trouble or want someone to check that you've formatted it
> >> right, you can let me know!
> >>
> >>  - Emily
> >>
> >> On Wed, Oct 2, 2019 at 9:55 PM gespinoz gespinoz <gespinoz2019@gmail.=
com> wrote:
> >> >
> >> > Hello Emily,
> >> >
> >> > How are you? My name is George Espinoza and I am one of the applica=
nts in the Outreachy internship program. I hope you are doing well! I want=
ed to introduce myself and connect as I am interested in the Git open sour=
ce project that you are mentoring. I'm currently creating my work environm=
ent and tinkering with the git program while doing the myfirstcontribution=
 walk-through. I have had a bit of experience using git for a school i att=
ended over the summer that used it for clone and pushing repositories. We =
worked with iTerm and I learned how to use vim as well. I know some basics=
, in no way a master yet/ I hope to learn more as I progress in making con=
tributions!
> >> >
> >> > After I set up my environment I will join the IRC channel and intro=
duce myself in the project's public chat and go from there searching how a=
nd what I should first contribute.  I'll also join the mailing list. If yo=
u have any tips or advice that would be great! I'm looking forward to work=
ing with you and learning more about Open Source Projects! Thank you.
> >> >
> >> > sincerely,
> >> > George Espinoza
>

--8323328-1131529447-1570137514=:46--
