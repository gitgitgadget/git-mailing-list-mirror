Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBDA20248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDKUhI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:37:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:45581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfDKUhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555015022;
        bh=AePKQqSwz69+zUPM2EAJRr6Qt/MbFBmYwQbNtVvPvxc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HV6WQ5Y992UHImAMSjc6sECyBa7EGbsQkdXPk0aITALeeTmT6VahTNxL0keTnETAY
         JED5AQ2jLSBfpraygLHkK7HvEf/hmDo/TPc0JK6uSzEvJwObISUc7g8w4P5jXzGZtu
         lljvWuHTqHMy288oHnf32w7U4fWR9BtC2XSJchF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN0jA-1hGuQw02jg-006dn2; Thu, 11
 Apr 2019 22:37:02 +0200
Date:   Thu, 11 Apr 2019 22:36:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
In-Reply-To: <CACsJy8AE1cOYCNDu7suQDJ0NYxeoG3w6e-+mZ-J1D5j_WNLWeg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904112233490.41@tvgsbejvaqbjf.bet>
References: <20190403113457.20399-1-pclouds@gmail.com> <20190406113453.5149-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet> <CACsJy8AE1cOYCNDu7suQDJ0NYxeoG3w6e-+mZ-J1D5j_WNLWeg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3MANm3LaP3kflMAvvPLbBwD5nlUzb2Q9YcL2k7mo40qLvb5o8YZ
 bTWkW86PTq5fHQWRFiA2LQkB1Uo/xIsfZJdtVyTzcQo9VNB+UY5sN7HVxtvUTfbgygm+AZv
 MbHTbf6Ripg+1By2frfZkfCkFRcVH3farFoUnXbD5F7lS+rT+74bfDOUGdsR8FsDtspKBsw
 s/IMg1U3p2BBpmHmvB+Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pb6+qgfcdhI=:OlvXJLrhYABBPvhcAsd8tK
 I1Hm0txIFiFet0/55lF4/VokNU0ERVheaGhoIBLVegMKRu8r+tFbwHj97fbqQJH+2QNVKqmLi
 ykK+WnmSFVXNmVsYSBKaMd0PfpAl7G1id+uyveYXTLDw6nT5/fxmW9rE4Xoy/IcKDYU/uIjF/
 eYaIxWFV/OpgzZiivVmN7kfPTn8b6bopWZbTBDwgBatmQx/xQOtZwq8jni9w/Hq3xXlDGIs40
 NYy+qDzgGOSweFRFL/INeFzkX3aNk/y8kmhNOZGaNSL5z40XSQck2X5JnLgV2Mnn9J46AB2JT
 SWhY2Ltl0ml9NruqlqqfU233i/tm08CdcRwZa3aPFsBI9Qn21SQYbctB2wgLA/vLa2NTQfnFt
 CoeH8l7yzHFos3XHwoSdPwFYmEF7zFtYj1fQmrJgFVRXMTE9GrvsWMXKRVanHtHmA+Hpi+nqF
 AZ24MBXN50450q7qxeVjV+llLcG1a+a4CC9ct6ZwwH7hHBmWrfvO9pQ8oL3kzvGZnsWoqvrrG
 1yf/PH/0wlhIgLC2hRTPjxYIYcTg/rb6HTXhPiI3EftNbFlWyJu4HOVQ8l4jrUvLnj6ih28r1
 AvPK8+BG6+kKaPcVVOnmmS2m9dKNog3dOCEYsEBPpqNBJaAMiEs388UrsNfNq4INFX1WtfPye
 PN0nIVmvnfktKE2Z8rkvFr90UWe1TbE5t2rbyzQym8P4mJ/LKVjSaPDloC9tSXM87GFD1/7wO
 20V1KXW0+MaPVXr+ORlI5k3Lii7sdMYyIkeOd+G9VUzsEtxdMdzWfiophxEEguRWm8gRh6gA2
 fg+sKlGqcgGJZlqWzitoLjXfnDoOUhkLKl4wYJLRNCm02nEE0mzShoPaAwsozoKNnVcw15RyJ
 eZklCCNe33TU1bYzGpIRzuXED+dYwXTPy0e2e4zx19ebJcG2wP1idJpda8TiM+AhgrX8BFohE
 aVb0J1FX8IQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 11 Apr 2019, Duy Nguyen wrote:

> On Thu, Apr 11, 2019 at 3:56 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > >       @@
> > >     + expression c;
> > >     ++expression r;
> > >     + expression s;
> > >     + @@
> > >     +-- get_commit_tree(c) =3D s
> > >     ++- repo_get_commit_tree(r, c) =3D s
> > >     + + c->maybe_tree =3D s
> >
> > I think this is wrong, and admittedly I had the very same version
> > originally.
> >
> > When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> > opposed to `the_repository`), the conversion to `c->maybe_tree` is mos=
t
> > likely incorrect.
>
> I did read the get_commit_tree() source code before doing this. struct
> repository is only used to get commit graph to speed things up and we
> can't change a thing there when maybe_tree is reassigned. To reassign
> maybe_tree, commit-graph does not matter. Neither does the_repository
> (vs arbitrary struct repo)

You read the current code. Obviously, you had no future code to read.

The cocci patch you are changing will affect future code, too.

The safe, and correct, thing to do, then, is to not pretend to know what
future `get_commit_tree()` functions will do, and instead go with the
stricter  version of the cocci patch, as I had suggested.

Ciao,
Johannes

> >
> > Therefore, I don't think that we can do that.
> >
> > Ciao,
> > Johannes
>
>
>
> --
> Duy
>
