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
	by dcvr.yhbt.net (Postfix) with ESMTP id 676CC1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 11:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfJ2LNu (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 07:13:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:57539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfJ2LNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 07:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572347622;
        bh=fFmcyLT2sk9DKOUlhLTbaPcTApggiXu1LbRgU8Qc40o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S/7GOdFYnmEZvaaVm9nrPuxlu96w16ifQg+oaJ/E6Ng9XzfCFPCw4UjQe5ZLs7nG+
         2b1PcBcwQ4C2+k2aWPxzAwToa7s4iI4A6T3vWjaZLFnZQv8s6h1u+3aTWYT3mF8Bc3
         hfdKA/O2+LjNsvmY8MfGYj9ai9+2O2VNBzgwIU4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1iR3Kq10P0-001hEe; Tue, 29
 Oct 2019 12:13:42 +0100
Date:   Tue, 29 Oct 2019 12:13:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/9] add git-bugreport tool
In-Reply-To: <xmqqd0eg8geu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910291202160.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <xmqqd0eg8geu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N8VDaJlXZ+lbqiVA1Ev9BXJ/H9YMUAo2WKCeAmFXpTBtdj1vJZU
 8kS4UodmELdMJ0wItlj6n7Gk8pSI361fBW9DwuS8AGUdQtUx7F8DCGKN6aCeqMIfbWUqtsi
 mihJYKZAoQbu7G9wrWJZpezs4ZlggYTRJvb4qUU7yFBa7WTpJwtFk/tZh9LIcGI1ET3ggqE
 uDqz/nN5DG02W8sdAdckA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuODFw4Cx6k=:xvbtauwsMRZlJd+V94A/i/
 BT8BlgUn4HJO4VhPbzijpv23r3JdZBtd7zuzVRYksnlGyaonE5f9ShPmJKz63YwHIxSYZSFMa
 CZ+8RkgT/P+EdZsctP5xczXFECMLDNKyw1/LhhRidELneEZGDipQYWaRIE2k0cQnLoWyei560
 DECpgKZVigmLYZdar9CSxXcSuPhpJ11IgoKo00XLYen3hXXuQOjt23jQp4KE/Pm0e+wyJYk9Q
 LWd8yykrqlVrYgcgrjkKE7FvCT4X4OxmU8pq4ELNI1DgjL6hEbb1fbHYcTODi9b8Oq0V6iuoE
 GFz0LI07ZbDvgohxQ/H/DDVHG51cBUJ0SHmT5lt4NReUHengy0o2QHTZNesi4LnrWr8SMIXCj
 ypggJBJfl+qJ1CMbD5Ltk2fVvMy8NPJ9ecv9uhVL7lsGb58BaaKouUW2jZxE5YHA280yNC1nI
 k6G/LJXyKhdtTtyFFZu8MMgjtxbiGR04CyXy7PZf8xyjqfJTORICOQS6LtYY02Pqu7hYjWJSY
 Bg1P7t2E/bozWXzA3pheViS3/87NRe8MBWHHHUFqTTOc+imnW4T3JRTRBj3DmeYvEzv6zc+NA
 oojKpt2WnlZjQy2Du13LttL3QI1G39WjS38XheEVwY8NdxRfIjcWhVF9/V64HemFmNs+dUnW+
 Csxn+LbxxxghyQwXBDoeaicbkbsLfdZwFdizgImXcp5HNkwRNR//kIepICNuSHgMDyYfJvnYP
 BUpbTsm0p1uk4FedTLID1DjBqXg4LOj7/2npPKNU44oVCUBdFaU8rV+hPncOerCOK7TAV6w3E
 676dVZkqQPfpQ03elrXCtjzqAtdlMgPOlcPQolxWV1Ch9VUK66wFKQLOthUgwGd6rOQt1vRww
 JUGWbu3JLJqSduH/vRYb+x4Jj9BwRBdv9aLnvJE+ZeYBjTtzFzl8x7SkKm30Cw6UY7Ml0CnC5
 prPTRI1RVzqeINmDDMurClnmpUWCGczuGjLxe5+VoW/FY5d+onIIOE5OyzrgCHLg1iKwgfBx6
 X3ztxetQLBELaAljTDPjwnB4pzIfRMedBVYAm8ngeXiRd48fk2WhDQTzSv+O6Qxas+ELk1CSQ
 xWQHNIaSWAufvXcZN+lSTGJrfk5GmA7YpzFrG1JxyOqPLBrR7sniCzLUfYeRIoyVE72LlVmdK
 FI/hSbzXMRMSXirX7+NvA0H2Yfg3nZV4gTGzCJEp6tzX6vT+6sIQochSgljvrRkfGzFKgjhbC
 1i5I3jhWrvZMfEszxrp+JjPwtxPeRxTljtVPsSFe7hA3alL4qGt0ffySSKmM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Oct 2019, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > Thanks for the patience with the long wait, all. Here's an attempt at
> > the rewrite in C; I think it does verbatim what the sh version did
> > except that this doesn't print the reflog - Jonathan Nieder was good
> > enough to point out to me that folks probably don't want to share thei=
r
> > commit subjects all willy-nilly if they're working on something
> > secretive.
>
> Is the goal to give a tool the end users can type "git
> bugreport<RET>" and automatically send the result to this mailing
> list (or some bug tracker)?  Or is this only about producing a
> pre-filled bug report template to be slurped into their MUA and then
> further manually edited before sending it out?
>
> It probably is controversial if we exposed contents of hooks scripts
> (I can imagine some people may trigger external process by pinging a
> URL that includes credential material out of laziness), so the
> presence test you have is probably a good stopping point.  I do not
> know how much it helps to know which hooks exist in order to
> diagnose an anomaly without knowing what their contents are, but it
> is a start.
>
> By the way, I doubt that it is the best use of developer time to
> write these in C---taking various pieces of information from
> different places to prepare a text file sounds more suited to
> scripting languages, especially while we are still learning what
> kind of information we want to collect and how we want to present
> the final result (iow, for the first handful of years after
> deploying this command).

If you want to limit Git to Linux, then relying on a specific scripting
language like Unix shell scripting sounds okay.

If you target more platforms, then a range of scripting languages sounds
a lot more sensible, my top choice would be node.js.

I understand that that is not an option here, and there is a strong
preference for Unix shell scripting in Git. This is a bit unfortunate:

A good chunk of the bug reports I see in Git for Windows are _about_
problems with Unix shell scripting. There are fork problems, problems
where `add_item` failed (which is one of the least helpful error
messages I saw in my entire life), there are problems with anti-malware
causing segmentation faults in the Unix shell script interpreter (the
MSYS2 Bash), and there are even (believe it or not) problems with
_display drivers_. Yes, that is right, display drivers can interfere
with Unix shell script execution on Windows. (This is really rare, but
hey, bug reports are rare in Git for Windows to begin with...)

All of these problems _prevent_ Unix shell scripts from being
interpreted as expected on Windows. Which would ridicule the idea of
reporting any of these bugs using a tool that is implemented in Unix
shell.

And what is worse than a bug in an application? A bug in the
application's very own bug reporting tool.

I pointed this out to Emily, and that is the reason why this amount of
work was put in to _improve_ the tool, precisely by _not_ implementing
it as a Unix shell script, but instead in plain C (which is a _lot_ more
robust).

Ciao,
Dscho
