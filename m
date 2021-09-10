Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB09C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 09:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D5D6105A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhIJJe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 05:34:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:50831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhIJJe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 05:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631266392;
        bh=fcgm9FsgKsXNqE+V1Yjukh8nUj+Hjk7Gs8fpr1DcmTk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j97eyu27rA8ElETMALZ/WfU5CUSgew0pMaGR054NuILubwdQMSX9S6hV2oHHVZ6gK
         PHnyJBjF10Q5omOmzKNLhbEMQU0x0pxdrzGhX7c+GxvjgaifqSof2jUZTMDJeTPIW3
         MaV0WH0ntjrVO3RkCtLST5FFt/Al8kRj0Wjf/ofs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1n3EdW47nR-015XAr; Fri, 10
 Sep 2021 11:33:12 +0200
Date:   Fri, 10 Sep 2021 11:33:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Miriam Rubio <mirucam@gmail.com>
Subject: Re: mr/bisect-in-c-4, was Re: What's cooking in git.git (Sep 2021,
 #02; Wed, 8)
In-Reply-To: <xmqqr1dxuigf.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109101132460.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>        <nycvar.QRO.7.76.6.2109091308200.59@tvgsbejvaqbjf.bet> <xmqqr1dxuigf.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GYs7Dg64ZB5vZnGH91NaloK9jY49GzlHrACzPyZXeIrLd5O1LrT
 kWrpVw71WtncarSxwMY5SGPGEx5FQ0c90XYyV16whgdnqNYUMzL8XmuUx1BtiNrhcdvhrr9
 QRniwia6ALkIvr66JJVrImKTMItksXIufCcF9flm1RjfUbvccGlpqhz1KK5MalyvwVbVWhp
 QW5FFIK9upWlqnGBE4oLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBq/7Xcftg8=:YC7RwfOX0SZ/zMaLF/MxB8
 xX+VVUUfw+c4gUP9LZ7hYtKB4O9irjEFm9GskRiKsaB9Sidymvy09FWSICNACfuHoLz95Ui7y
 iOCl0lsStRSVHxekBeKWzrqn9fYkQozifaRvFzOwVIZk9ZlwkFcEZZA5Zt9BtRvPfbS0yXJTN
 XOj98ZcbrVIUZmWZtqwGoCepTiWYIUOikrZSOA/NaInFu4MX2l35nNWJmj935V3PxgpgTRfi/
 rzOehngW67VSpP7/1skr6LjZvWqshIIYbGbEEj1li/NWN9E3txIEzR8CrRSzua/cD72s3yc1u
 VzwjMXRN/JZqP9UwzJgN3zjKVGekl9Edn9LqHA/1M/ss5fOkW6DqwjoVZklxAcVcWAROfNx8s
 OYz71+mYifoeXeNX+W8qqlXr2xQGXYcUwjhU5gKlqq51ytERhTt1vfegEmLfu7lAGQBSUrAK2
 fmzoslUqGFfiiC/q4oOkSicpspEzrM7nWMmJ92u2hBJyXt1iCSRWr8M7xbw1X2xjwNRC07ZEf
 ZkxR4y6IAG8a5h0XBmD1ypPOIZ6Bl8azLpVqKwIlx+e7y2VSylHI1+Z64rm88j2I82vctB97M
 Ci3Qh4d7ALWYBogrOUXp1pYAM1MjWLzXVCExhO8zZ8ac3bW9j5Sthe0bGMdTtUHHMPi6xWqPy
 /zMAPVlvtCJqTLvGnvyaF2gzjHA8oUBjdvdYX0Y84/rqN/MwpbqudU6QvRPgPtrB3A41WmPtz
 Btk/9dsdLDCoky/7w8+X8yLPCnr2pjx+QzM56b5P3sUUlSbzBKNdx+Skiv1cZS0KseiLDFqT6
 r/T8YnMYXOPFFf2VawREyzDvcpWkhJPHbEZITmVaxgs5YzbmyiNHHOZlsUy70tyeioVx1qTOx
 SUJggRWutW1pc0A9+wNXhKPZYy3JETfVMtC+kqB11AP58pp5T41zq9NVxt9M1KlT4rfO7SsZW
 dMASfmG1UhMZnN6Y7Xd8115sgtyuDrttBSwGq1W58+hqVyGUapLhOs/Yf0PRlCIgzh5tBpfZ4
 pDWUc+PpUCHo9b41sbvz3psuLYLpjVU6XioeFMOOdmJdoM2QZo7PIilS4HwZVyPah0ZSmHdnb
 wJbpNed/S09P0Q=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Sep 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 8 Sep 2021, Junio C Hamano wrote:
> >
> >> * mr/bisect-in-c-4 (2021-09-02) 6 commits
> >>  - bisect--helper: retire `--bisect-next-check` subcommand
> >>  - bisect--helper: reimplement `bisect_run` shell
> >>  - bisect--helper: reimplement `bisect_visualize()`shell function in =
C
> >>  - run-command: make `exists_in_PATH()` non-static
> >>  - t6030-bisect-porcelain: add test for bisect visualize
> >>  - t6030-bisect-porcelain: add tests to control bisect run exit cases
> >>
> >>  Rewrite of "git bisect" in C continues.
> >
> > From my point of view, this is ready for `next`.
>
> You agreed that redirection with dup2()'s in [5/6] was good enough
> for now [*1*], but in that case, we need to add a few fflush(stdout)
> around the dup2() dance [*2*].
>
> So this is not quite ready for 'next' yet, although it is almost
> there, I'd think.

Oh right, I fogot about the `fflush()` stuff.

Thanks,
Dscho

>
>
> [References]
>
> *1* https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109090922310.55@tvgsb=
ejvaqbjf.bet/
>
> *2* https://lore.kernel.org/git/xmqqtuj2h7cp.fsf@gitster.g/
>
