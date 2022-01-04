Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D635C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiADN7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:59:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:59021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbiADN7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641304760;
        bh=1XoEbwSwXwMxTPk9t8Xxb9EQl2VzSuOEKK7DuC5a3BY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EtsI3mEpRw/DiSmdE5DtNbCbi/E1PwW6LDFu2GQwR9BrYCPPSoomZrO/FTc67Xnnk
         hVJp7X/o1Q+qeoR65NN6WMWJwGn5krTBy7HuW4ASwtXK34NKW0BHPY9rv18pWRXIVR
         msDWNpSi+D075R0ikE7VFQWkfQIW9yFKJxeu3kIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1mf4EE1GxW-00imAz; Tue, 04
 Jan 2022 14:59:20 +0100
Date:   Tue, 4 Jan 2022 14:59:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: lh/use-gnu-color-in-grep, was Re: What's cooking in git.git (Jan
 2022, #01; Mon, 3)
In-Reply-To: <xmqqsfu4duxl.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201041458150.7076@tvgsbejvaqbjf.bet>
References: <xmqqsfu4duxl.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TQLmlJfdK/d/AlzD0muXOD9s3s4tZ350PuA/Nxd13B8sILDwrup
 3DdSItFv1cl0Fy+cVAtd8GPfYcOw4Q3VHNESaUM5eaX/0CaY6XK7AiI3xoZpYdxsG23zucj
 BDk84J7ivKBv06j4umb0TJy3YmjYqfFojpF37br21DnEWIYZwpLvJaB0YAKyV+utw2xiN17
 6NZyf/RAFA1Tiu0NuuRxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I2x3iRoj/K4=:QinZ3efx+5lmQd0ZtjKaHx
 kTywtYzogl+8GrknWB7ufLWhU2rwU8w11uFFmDuJCw8O8BUAHuiJGbul/vXg3NHqCF/Pu0lns
 +F00MP5dUuUUn1nF7f8xSR6TvPn5aAJFBwc8aktdZaE7PCVuZshny+M7BJF7peTQZi5u4AVsQ
 3lumEZ1JGlQYfeNFo9KwlKRFn182npSRuuRkaTMPBlyMCQoihRTU8G72WZ7zTs/f76GlFLgL7
 EX8ntzyxCmAhtH1XVDAO6z8ixk7o079OE1ji4Al4H9Q+p8mBwxB5L9lnj2JNc+HczDiyzASTl
 3ytoPAhnwzkot4e9hDfW6qnP7mwNatHiavxeoAktSUVFwvbztF564J75RY8Ci+UqWXQ1EfEV4
 jmnOoZ5c9Cm+/prC/TouCWAE6812Q1MbEpkYVOpmCwHQoQwCkEAGeTmCRnt8OP9rYTXa2XFXJ
 Z0M7Am+rzGVRbiJHwipf7Gy/FEhhjxoxzYY3nJk2yGKFEHLgeaDinFGPqyAXm5Rb59eE8gPlW
 L79wY3AfrLFAgp3CZGILy+zswqDUw8pUV24ceFUkBuKrIfnqT5EXZWUZHY7B9LypsEB/Lfkhp
 CtZfDBjAVtHx8ICe+LlPVhG8lAyqNyn+Gs5PoVpXhaCyJ5Etfni6YTaHm4CSqK+6wF2Efv9co
 xEnW9jo+pJe1N+ul4L6sOqbYbORLnoLDE20Z5KU8miNO7wy58BCJyBkQ3ud04gGkLPSl104om
 Gkapiit1jNp/TVby2Lp1vUc8awdGgROi/M7o42GTk36rteMdNVOQddkxtnfdh0B6vju0xxbzA
 0jGNcIkLg9O199aCyUt3riuuMyg/MJEw2CXnHJlE3dTeXFt7BObTQOEBJOVO24Pq3k7e0BLLA
 SYsHWP+CkNXVqQ0xqkeVxT/YcGqnt01gaMmtSMMInGKM8V3+oVqR0pIHumMachCpBhJTeg0CQ
 UJlYroBxUxQS+2aNae6wZZRg942FM95Pbv3TSD2LrMMb9/RBjEtRc2PczbRzjYo0NrVWWUhs/
 2rw8UVURotwpHHkcgcV0Klf5YfL/5v8ieMMUt1UK3GMK+BNwd9qtTOn3sYrxI1r73O0JseLq3
 3liiViszozvs2E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 3 Jan 2022, Junio C Hamano wrote:

> * lh/use-gnu-color-in-grep (2021-12-16) 1 commit
>  - grep: align default colors with GNU grep ones
>
>  The color palette used by "git grep" has been updated to match that
>  of GNU grep.
>
>  On hold.
>  cf. <xmqqh7b88b3o.fsf@gitster.g>
>  source: <20211216115622.85506-1-lenaic@lhuard.fr>

FWIW I am in favor of adjusting Git's `grep` colors to GNU's version. From
the users' perspective, it provides more consistency and less unexpected
surprises.

Ciao,
Dscho
