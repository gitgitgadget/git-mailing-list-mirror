Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA6DC2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 09:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABC320714
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 09:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KEcdUAf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBLJCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:02:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:45833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgBLJC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 04:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581498131;
        bh=/HCBf3gUPkrwjlOf42XVLMtVELF28XufW9kijT8hZzo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KEcdUAf8WMaTCYqmZIgWJpWi+ppgnfZZGXJXDAsGRCULwzRbFWAqYr1BMtBY7qZ0m
         BoPg44E17z2Os0WxJvH4ZmrKuxMwZkfhntH35HbGy5m9euUFf4XogzHy7tODgRCMIq
         Uk840RBAv8AZ5cvkJqcPcN6+BMZ/5zuIoIdHxgOw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1jAIEc0okr-0097EP; Wed, 12
 Feb 2020 10:02:11 +0100
Date:   Wed, 12 Feb 2020 10:02:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Steve Keller <keller.steve@gmx.de>, git@vger.kernel.org
Subject: Re: Develop a patch series with git?
In-Reply-To: <20200211200044.GG2127797@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002121000500.3718@tvgsbejvaqbjf.bet>
References: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62> <20200211200044.GG2127797@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aCqroo0qvocTgwjytxP1EI1PJ+5Ky5i89s9RaHuy4VUeSOZ+g4Z
 p5TTyFSZ4uX181JogrinmDXWJdGuQ8MZTPpeimsbtjxur2MkJ54ZEkE6PoTtj2Jl8oZ+iic
 vmZAwyam0HLRmCT0Kx3Bx4wEGnO34jCWkx04u6H3vFIJcoGIER7feU9wMZhAJY+0MlXPT5n
 cptO09LH1oflxSVE7sN3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZScgN7EjAU=:clwoiEYCkF4262NM+dRQlw
 7Kh7DgpVbLaCCAiy7oeAvrHFE3ydlTcrlrL39JaOajcZH424JT5gy1Xuxk3R8juWozAkenA3k
 PhrKMZnHob4rIjIYk9JIFMY615GCHiShNcQsRNkUrFurFr2dMmIEMFz8MDUYc5P7tNgHeqUx7
 OgEaBgeRtKHjqiXHC+0x/CNBJfu4pOmK0EWeLGREFgsnGFHZlcwLevPh3WhwDlPzV1TIQNFW9
 2Qr6f+oYlLu1Krm3AKcwheWCj4vW1YyvJZQp1J5Z7Mtwil743otdgKGsWkTsNLzBnPyf7Vc1I
 8BsvdeWjX7yrjT/y3BTR7KKzmwNwKwcXW+v0hDEkn5plKULNicOL00CpUXgaJebNwEYGEdG8C
 ovIYFLSEhtVlGjN/5W7qRjB9esqte2GQJ27qSDc39gMNPYLR+tS3OAGoePNGmF9eg60Tf8O7r
 PboHMvjWkrli8N5s4a3eQSafsxRxhyIY9t2ZfnFz+HiJxlteVyBtaTqsT1V/kbgFEuq7UXvdA
 s35g73vKzVWBBsE0f5ODPj4Yq3rffBvZT5HV6dth4gwz9K752EuhyOaWP2w8+GJJXYJttvKEE
 dQ4H33jL/yZciv6mZTQMkzek0dQwNU4S/+VqIT54U17l3AKKCZUUZaQ1NzWK/hzwsrSgQz8pl
 0VsaQwK7yJumf8JuVMmmTgAr+/gv+ZWo+d468Thz6mOLcQy3QmUuPNxjGXuLM1rK8CeZQFvRM
 +HNn0bCDajdpsu3aoxC7VB2abpYMsrjZjQTQZVn2cd7faFLXRt2lxxbdINgzfIvURAnstt/Eg
 RS3c2rJbzjvv8ehgt1K3ZUtf4Ul3mSq0iNvvCgBLxnpjvoFlNw6KxrrcIlpPg8WrGhN4EJFdF
 pmZrqK/lsBvb9IEd+QFm6K1EBSC/FF6TlnqJCbJdcoELd7Pwsyya1ojn088ki/9Ok7cLkvprD
 q9LQgLBdxsNwnm7PbQ2DwmNTNtYQpP5pNrOpmn5SuluPZSNXDUggv+PVGDB16Q59DqDeyvBPj
 yr9tPGIxsCUWlIwyI6AAzm1PQ8Bfq/TRyNsrcmGsKacj2JJQpuPaXVlDvb81HGqUOE0T+54p3
 1LppVbwjfDkbUVGYllSw03Pt/h8EuF3QJLrtbNcvJFGX2VQFg0qK9PuPpLXpi6/1cdkyZvMh9
 7otx8/3suYRBP+16p3IORNatIGU7LTssMpBlVgTYb4y2z6JV9BNzUIpCIeIfbgqRQw9cDLDc+
 XpOMl9RoVTvh6B8ai
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 11 Feb 2020, Jeff King wrote:

> On Tue, Feb 11, 2020 at 10:22:20AM +0100, Steve Keller wrote:
>
> > I wonder how git supports developing a series of small patches.  In my
> > usual development I go back and forth along a series of patches before
> > I can commit them all.  I use quilt for that.
> >
> > Say I want to add feature FOO and start a patch "FOO" editing some
> > source file.  In the process of doing so I realize that I need an
> > extension of some function to base my patch on, so I do "quilt pop" to
> > undo patch FOO and insert a new patch BAR and then re-apply FOO by
> > calling quilt push.  No I can use the new extension from BAR in my
> > current patch FOO.  The patch series often contains quite a number of
> > patches and I push, pop, and edit these patches quite often.  Only
> > when everything is done I use git commit all the patches into the
> > repository.
> >
> > My question is whether there is git functionality to replace quilt.
> > Or is the combination of quilt and git common?
>
> Another responder mentioned "rebase -i", which is the most direct
> equivalent.

I think the most direct equivalent is `guilt`:
https://repo.or.cz/w/guilt.git

There haven't been any patches since May 2018 which either means that the
project is dead or that it is so robust that no changes are necessary
anymore.

Ciao,
Johannes
