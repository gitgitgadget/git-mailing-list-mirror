Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF5620248
	for <e@80x24.org>; Thu, 18 Apr 2019 21:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfDRVHA (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:07:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:42511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfDRVHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555621616;
        bh=7aK/eE8F9pUAoHm1XZT3IEWymIF0OYFrb3mcI78tin8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gMqoP4GO5C6IpmYsUS3ZKHNOsGwNlG6cBVolprzFZWJKx1a5P63SIQ6j16Mybjfdk
         3cpt4F9xLmtHY7iCIMZB2IKLmKxTwMPQc2JV6+N/qS7GmY+IZEZ5himmkq8KKccm2H
         XZlckZACyKVlCXcrBl4aJ9MwNyIsBIsQL/idiVH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1gdErP0tqh-00hte1; Thu, 18
 Apr 2019 23:06:56 +0200
Date:   Thu, 18 Apr 2019 23:07:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Julian Cheng <julian.cheng@utoronto.ca>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC] [t9803]
In-Reply-To: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
Message-ID: <nycvar.QRO.7.76.6.1904182257240.46@tvgsbejvaqbjf.bet>
References: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1937607367-1555621623=:46"
X-Provags-ID: V03:K1:BNolksRhl3fMZHOxcB09VH2arLigSRQ4c5XSMYwyZxDWzz4+5yh
 P3NNuVoOAEDOIhnkXX3aCP9gb09398pwJ2p7val5O/ATlKmTmSMAMqtpnAfa4B+COVeJnIA
 N/I/FMhoWKyLJCCtGUrzNaEtFzVrUN9hWlAUGaNXp2VopMkl/SelFg3kW3FX/GRwD4feNvP
 P7pkq7hC+JZK/jWFObfJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C83czRRVmG4=:fYnJr5cIy2PiSrGTV+cghN
 aK7RgANYU/pBp2943+GaiqJQ8OQJMDyhQBS1JxTIkq/xd+qiX0ggaBwjRIE0ty9YCtRgwAkVx
 kBQKYNxvAWoIqUtDP3Fxa8NgdJCEp5+ySL7KqGhW6v+6cbmEasXgWKugKbsl3VpOvIc0NzqR5
 vLybUktp5w43oebpsWhogLG7k6lVUyAuhY4b2jk2zhC3CrXLbjTexQ3UrOIu4ZqHDx8Xfj09T
 hZ7oiW4Pk4ncDZeq+XUI/oJ05dI/1tJgF6MOBZcuRxOsv16lrlvyknT0duPcBNL9PEKkd58/Y
 bV9sWImrzPQrz7OdNhSThWj1YITb3KrCYaFLvfHmTokEUH/AjQmK6RFmsZJLHbi0HexbJVMU3
 YHYJzMO8noExR/a2p3yRMHftguzVIOvEo0r8TRyVYmU4caftc3PTQ3mPU+6mGhHxcX7lidt5v
 An9EIqAm99Dh+YxtAJdinlTShWXle5MpcrHhHYIhCLrzzOsAO13XQs8mXipHvXttb8H8Pb2j1
 pUSeoGgAn9njpaLAKTJb4Ezxz5OIKPoGf5DOY2HdnsJwS6cvujkCYIjU8jVzG96jf6LB2KHKH
 Fee0D+A4xRIxpIw4Ym78LbTI0DzqMUpcLcvWoNXGuiGfSK/YeqX4DxsvhUCMLo+JTY8AqaLVv
 vsaikOWGRxK4iWV83BIOMMXuXLouPZy3MLKIRZJviSdTLc+KOFwKYLkzCnkt8kxL4ZoiqM2n2
 r11yCQj/51lBuilmTy/KCHAsFkkLoEZG6UESvzVF84PRyyCLxQ3o3RBdFC8y4KGSmx5yo0P7H
 KD5BvnLFjUfRxXaqlIdKmFEZgPVQZ0Rd45noJNr4fgmWcoj9Kmw6rcaMUDYmHVGd5fyDfgcxW
 S6husrxakyHnPasUo0LjPI721AMG45c/sOnReq6fYiFvXHAxaI8oRjkNaiRb0vMWIdg86Hxpp
 Y6eyy4w44yg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1937607367-1555621623=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Julian,

On Wed, 27 Mar 2019, Julian Cheng wrote:

> I=E2=80=99m new here and hoping to get to be a part of GSOC 2019. I have=
 questions about the main project and the microproject
>
> Main Project Quesctions
> I was hoping to work on =E2=80=9Cgit revert --drop=E2=80=9D and =E2=80=
=9Cgit commit --reword=E2=80=9D.
> Are there any mentors available for this project? The ideas page lists
> mentors for other projects but not this one.

I cannot speak for the available mentors, but I would imagine that all of
them have the technical knowledge to mentor this.

> Also, =E2=80=9Cgit revert --drop=E2=80=9D and =E2=80=9Cgit commit --rewo=
rd=E2=80=9D appear not to have
> been discussed yet in the public inbox. Is this correct or am I just not
> finding the threads?

I mentioned this idea in
https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtual=
box/

> Microproject Questions (test_path_is_*)
> I would like to improve t9803-git-p4-shell-metachars.sh
>
> On the microprojects page, it suggests I should run the tests to make
> sure they all pass. But if I=E2=80=99m making changes to the tests, is i=
t really
> adequate testing just to make sure they all pass?

You should of course read the test cases in order to understand what they
cover and what they do not cover, and add test cases if there is something
important that your patch might affect.

> To run all tests, I assume I would just navigate to the tests folder in
> terminal and call =E2=80=9Csh *.sh=E2=80=9D, but that doesn=E2=80=99t se=
em to work.

There is exactly one way how it can work. But there are a million ways how
it can fail, so you'll have to be more specific how it "doesn't seem to
work".

> Also, when I call =E2=80=9Csh  t9803-git-p4-shell-metachars.sh=E2=80=9D,=
 I get =E2=80=9Cerror:
> GIT-BUILD-OPTIONS missing (has Git been built?).=E2=80=9D Git is definit=
ely
> installed on my computer though. I=E2=80=99ve been using it for months. =
I cloned
> this repo with Git. What am I missing here?

You have to build it first, by navigating to the top-level directory and
calling `make

You have to build it first, by navigating to the top-level directory and
calling `make` (I like to use `-j(nproc)` to build in parallel, you might
want to use that, too).

Alternatively, you can set `GIT_TEST_INSTALLED` to the absolute path of
your `git` executable, but it'd be better to build from the current
revision (the installed Git might have different semantics if it is a much
older version).

Ciao,
Johannes

--8323328-1937607367-1555621623=:46--
