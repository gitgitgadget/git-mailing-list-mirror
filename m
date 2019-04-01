Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5738720248
	for <e@80x24.org>; Mon,  1 Apr 2019 15:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDAPYD (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:24:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:42021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554132240;
        bh=qRGIiza5x+mOFonq4sv9EmnQmsmYtx7Lt7i38LG2RXA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JIxySKu55JWjEEZrKP3f5ZJ/CJmB5qTiVnVDaE1+2qhhssWFzIhUXNsSEMnQlq/GJ
         g34v1GQwCLX+tDHFJ6ZIuiDj+GHbdVbDM97OBlBUSBiOgMTnYDsYc2m3sVBNKpoFLd
         zmelHJAVsDqbzL+wy3qdbYXzJprXPPOeqAGvzM/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAQMg-1h3mzy2IjC-00BddI; Mon, 01
 Apr 2019 17:24:00 +0200
Date:   Mon, 1 Apr 2019 17:24:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <stefanbeller@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "Give me a break"... well, you gave me one
In-Reply-To: <CALbm-EY6RBoj+pEvvL3C30CxN2z+fG47eEFMuObpuJ8r-TO77w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904011723450.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet> <CALbm-EY6RBoj+pEvvL3C30CxN2z+fG47eEFMuObpuJ8r-TO77w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1991376227-1554132246=:41"
X-Provags-ID: V03:K1:AGN7rjYtMGyjbEpVebTFOkosJ3WIwyzNvgwDAVoFj9ObpNxt23w
 2u5FVybJU3Vh6kCeq7yrkVgPO1+d9pk3U96mXlBaWH/XUxD+SLva8IaH4PrRKpe+cfTHecH
 jE8hgb3xtrzaCl7kodPaD5hxNS7Q7qhCzEHOAUDXTSHg+sFEIU+JLq74+jj9P6Lu16kjzwr
 B9gmKMiRT29Rkp1zfTMvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjpa1NV4Ndw=:2wTaLR0/5lNGxTObzEVUFv
 gdIQg9od3kkLS4hz4nhgm0+1eRU8flXcZAaLsc0JR3NwuzIrH5fDY5lS2OH2TN0pLVx02hrRF
 AqdpuoMqP0fhSZM6ri25OSSDNQDhfvEGrdpBqWyookWPY9yDLI/35AenN787FA2N9+6Lbz+oF
 bsZZvrDiwagDENFhaaIW6b9NYeSNxusdIpS+oLfuwL+CmCtSYi8/GTi8Velsk1DObK1uw7nZu
 VXK6mjCJtUzIxfcbNMlR5QwNkNFKwJ5s4aPIjWR7hH76m3Pofdf0gtat6mjteTSsg+zUbQGFN
 th928oNVdxGvwNg0RvYE3TYZVKaT6YAq9/uqabd94SvmpIZD17nSQ4hkJFYiWFNN0Bx/53aDE
 ZU8EJ1NMInGSTcmHnho5j8uhC8wFBTBDb2BmDhGvIXrbFDGnAUwbL9IfG6pIbIjeyKeJuCO4k
 iqXktuHWTXvMrZf+/+QjMxJSmmMCktJBEwejL9V4JhTHEBy5yecpUh4HVa3cmra7UXLTq8f+a
 KRO/rdzlLEz3/lEOeyz1PlHacb7uFpZ078JmmrSqv6kvyrD7MbYBj0p0m4ZAlZA1uRcBsfefb
 1tMc47mIypzGEMnXefFRACQjjgEdXx/t/U+tMbpJlUaQGB5gu5xFZ+wTeFGi28U0gVoKL9L1e
 XiwPXvKWuzWGJst2hbRqNJp+ZBEdJOwUmeBd2BjX+uUDbZgGu4AkEvgpEj/KHo6Qnm6OK3oYI
 LqSBtuiiWytLrASz1DKL4Fe4IHtv/vdAT5d06UpEcV6eSpf9pbb4Z61ghH1+6vC8RsBgmpBzB
 tjRBXywlMTsE8fDXG8GvM9/Xw6044fopw5fOnD9HC1kzj+401AsLCh5zNrPyEepO1akfihVen
 hEPV2SdOjLWFoWbYQxlrL/zp56LEGV4btNs32vYdf2dMH7c4pJJkQPHdCoL5J9WPwO9oAkuqE
 prLfYocP1iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1991376227-1554132246=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Fri, 29 Mar 2019, Stefan Beller wrote:

> Am Mi., 6. M=C3=A4rz 2019 um 06:14 Uhr schrieb Johannes Schindelin
> <Johannes.Schindelin@gmx.de>:
> >
> > just wanted to express my gratitude for your idea to introduce the
> > `break` command in `git rebase -i`'s todo list. I use it *all* the
> > time now.
>
> You're welcome. As you know I am currently taking a break form #git,
> and it turns out I had my email filters configured wrongly, which means
> I just realized there is a bunch of emails where I am cc'd.
>
> I do not use the break command myself yet, as I am stuck with
> an older git version on Mac for now (Macs and Git don't seem to
> go well together, if only there was an active Apple upstream person...).

I usually use Homebrew to fix that...

Ciao,
Dscho

--8323328-1991376227-1554132246=:41--
