Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148D41F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfJaKWi (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:22:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:40641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJaKWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572517351;
        bh=+e4vvULiP/QBXXhZbHy4AzMNLURpu+ScFmxJAURkoW4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lGjbHU4D14yWpALLAMuX05VzIruYwkotNG/xuM2xEFL52j1c5HPXid3eiHmmzBE2S
         IkfKyyn3r5e3la7bTwATjdSObdMnVFoIZ5VrboThax/qfkMHYCrk18InQ3tk0Y9ZXc
         VpaWlgxlY8C7KOHJeeEEHMTgrMW3HMkwG8Gr0rO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1iKbpD21TY-007oQQ; Thu, 31
 Oct 2019 11:22:31 +0100
Date:   Thu, 31 Oct 2019 11:22:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
In-Reply-To: <20191031061832.GA20830@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
References: <20191030183950.GA21277@generichostname> <20191030202835.GB29013@sigill.intra.peff.net> <20191030224328.GB44961@generichostname> <20191031061832.GA20830@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XjnXbEKo/DzNcpMGnhzr8/+PuDlHgaOL2JbfRv/2KkXOWlgCqAr
 Lhxy7FS5POOfVtYeb/duhMlmdYTh2BSd6afnXkl51OBduZ3xgpNBgKWAU5e7heCR3myzcoq
 DVirAQpkY+j5Tbaia2jWDZNt8jOQXJXyM3rw0W8Z9iF9Ry56LrTuUGxxDSN5Ae3XYK8AVF6
 VkMeIN39fmsOUlDWwVdTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JJRhhMlg/vc=:7dbyQeXk+vjCRCXFhTHwW8
 d1fPIRm+9OGZcaIqwSY8c8bU0aqO/y0ptleYEy62q7X50gDllei+Ru8XsUHmiTLdeaB/KkyDF
 rxw8CZ5wUKFMIEeGbc7reH+F6kDlcV2YQoNGfbhglepMvJjnuAE6FJRsQTgPHNPVYzmPPSHWM
 Yz69ksX7G9UvkuRvENoVF3XiShDtjb0+wslwkw+eh2aRV91sul9wEmMMYak1f1FT7jTCtcQDl
 r6JabHKwemdu0zG4SY0po4J1t97latmFVV27zbQtI1lmmwiK6AUaoqVytRly/7Je9DWyBw7a3
 kifqhLArMOe76/CPvb8le2tBkREUSMXLtnZA90CP1Cy+0uSiOzvym/Tl/AsZDf2q4B2eyot3d
 IuMIqloKxlSUg7xsEY3tyu5kn6KntJpetMlQDqDkkDLK5+38rmdVSXAPCWpN8OCW4b7ss+tIs
 bTRqViqs8NRFNk4KrnJWEJKIL+zlelguHeMNxJeoFZzzgVgTF1/1dFssVvnyYTsSst43foHre
 9trHx+bkG0uEFJPiBsBWuWrto9YxGcIUtc3YN2m79XQStUQpNegxpj61bjqjUSnA+BfJYBdt2
 8eBql7COCrMM9gDrDZaFhW02cQoiEdtqf84Tz1yI70RzSw1XrOwXPAR7TbuMMo8Tp1X4di7NM
 vTOhAn2TwAUwZT0KGIjUtPmTrRNwYH7qSrsnxoOYfApyPc0pO204e392QT0np0S/HoH8PcoDO
 uo4RsDVQs7raY4dB8iVO+A6z/WdPLpcdIP+sIciOl4xMMHIp9LBdiyLGOMlSyOhVQyBkYFpc1
 hUZ8vK7CCYMsoviwa2jHV0ZlFerPpMvQYU79yjLJf4YiELSjcK+FiC+cgEnkeAmk9gtE0ctOM
 CMm+OCzOWs2ufQBuizii56FXuxn4I6J2E3WWOviH9X6Er2QZKmquKp3koDDCVF0IbN6AuLrko
 QAmAx0WEUpPiMPehXdqU6SbU8IBIay60xu5V+nYZknOpEGl+vsuzVkZp8Bj38WgBsBYcMY/e0
 Fwg2yU+JvqVTiPMkEVfzKondfHiaUpYsrw59IhtpDuR5Mmy48oeNMPmGzeqHmhzcuPl5TmHEi
 Bvnd1DqxS93tnIEdbE1Az4QCVXM+Vd49Mjjd5oblAkBWy22qXUV359DJ39ROBnhAAusAYNCJU
 eGbTIPZRud2DIUL8OGX8aZBfqSrm+WGRzdfndDjWYbTIw88rJKuEY51RtfV1lCSWW9y1vA1Td
 mHZoqkExBR5wSG8Z1NPkB71HDlOGlmPsL3lWTRma09GMQ2w76j6zOUUzFA7U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 31 Oct 2019, Jeff King wrote:

> On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
>
> > On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> > Dscho brought up in the GGG thread[1] that perhaps we want to treat
> > branch descriptions like notes and have them all under something like
> > `refs/notes/branches`. This would certainly solve my problem of
> > having versioned descriptions and it would probably do it in a much mo=
re
> > general way than having a versioned included config.
> >
> > Anyone see any potential problems with this approach?
>
> I don't think it would be `refs/notes/`, as that is assumed to contain
> mappings of object ids (and if I understand correctly, this would be a
> mapping of branch names to data.
>
> You could just have "refs/meta/descriptions/foo" pointing to a blob
> which contains the description of "refs/heads/foo". That makes it easy
> to edit descriptions, even if you don't like using "git branch
> --edit-description".

The only problem with this is that it's not really versioned, as it
would be hard to go back to previous versions and/or share the history
via pushing to a remote repository.

But I guess that a very simple pseudo branch would do it, where
`refs/meta/<branch-name>` would point to a commit that has a tree
with a single file in it: `description.txt`.

I now like that idea a lot better than my original notes idea.

Ciao,
Dscho

>
> You could also have "refs/meta/descriptions" to point to a _single_ blob
> with all of the descriptions. It could even be in the existing config
> format. And then you could include it with "[include] blob =3D ...". Tha=
t
> doesn't exist yet, but it would be easy to add (it was something I had
> always considered when writing the config-include code, but there was
> never really a good use; and you do have to be careful about pointing to
> untrusted blobs). That's a convoluted way to get where you want, but I
> wonder if integrating to the existing config system would have any
> benefits. I haven't really thought it through.
>
> (Of course that's also only one step away from having a versioned config
> file in your .git directory, but it might possibly be a bit easier to
> manage, since it would always be committed).
>
> That's mostly off-the-top-of-my-head rambling, so please disregard
> anything that seems totally off-base. :)
>
> -Peff
>
