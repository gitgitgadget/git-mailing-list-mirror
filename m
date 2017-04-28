Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AF3207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161080AbdD1NhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:37:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:56204 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969006AbdD1NhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:37:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA8hF-1dEray1KOH-00BHXw; Fri, 28
 Apr 2017 15:37:05 +0200
Date:   Fri, 28 Apr 2017 15:37:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <20170428110827.7kiwidz7ks3o2d2o@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704281536160.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de> <20170427062114.p367j6rojnw4aj5r@sigill.intra.peff.net> <alpine.DEB.2.20.1704281241260.3480@virtualbox>
 <20170428110827.7kiwidz7ks3o2d2o@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YCuZanyz/27nM2f6RisOeQGF8mEI215sw2NhuJipiRNy0rwd4tU
 C80j/1Oh5Y09QKx6gUEysJw8CO7d9ew8MXnnYhxOuP75kuPDnoJda4UBXt9y4asWKprYqTe
 dgKahuNzNAFcMmJU67xCgmcW4X671p1nPIXaD7TQzfw/gjv+STdhBB+qlRV4SH+5ErW7yDg
 mFVtbFIm2aT8M4GR3oMeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kWP5KT5XHGE=:MuLyP/29kzsxkneWSlzlZW
 8c5+TIWYXoO7J2Nl3rDJNv1OhkI0btNHjyGXhw4UGgu7FBaOy6oJv53YKe2qDNokdSa4Vjocs
 Z1mOqY7+cbC9Tgiz4JjSdq8YTg2EjqMa64kNQ2gvOujZvDSp7dSYbWVQErrAwGEUAIUfQpBDB
 rGgYhMpi0mnK2VXYzVb1TzkrkFcwkutB9J/bxt0VB6K2oxOau4aByhVoTQQt0deRuqipNjMWK
 WDp2OWTIT4amytn2d0N3faVVdV4mnoaQZVMp4OwQANH3DTnv4gf8s6n1jAr94RPyvuHYFsxys
 GxjAvt19JKlMYXR4julM3Z0K2zEI1RzeWPPevF1YvbrGe5U56JHkRht+jvm4Ay2gRMJZkzYrZ
 ECQKb8EpSzZUBtq+KThlJ/AsfcpN03QI7aPd4YpKbxFStEeqsFY4i19k9eVOUULNgonoyouvm
 x2oE/vYHJPGE52SBVpcujjHP9yBjXaoJDBZkkTQ6L1iAmDvDSaam+tPjKZ3fVgkZeyARco+gd
 /S2YwBSaQENUwjuim66hM4crXH0TK5HOMSGoZBxWtx0Ui9mnHdSBJ3s0WhqjIM+cvCMbzCQnZ
 JvZuqeY4NIidOCJcX0C4OPBaZKvfUzR07eCWxaVyMjzVPMeNBpnZdaN/dp8jqijNGV7nhmA5N
 4+e8d3FqGknnuSCQs6l4Ru0nXfqvCNQkEkNkxWyp84xhSsug0JTm6ay56oVgEMdWTcP4N9I1V
 DI0KfG4UpJR+ZLjKIdMclQX0F6GcdMm/+h6QpBxmwtPNDBgfZFxSY2z9y3kXNGKspnasaVV+/
 Njcw5LU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 28 Apr 2017, Jeff King wrote:

> On Fri, Apr 28, 2017 at 12:44:52PM +0200, Johannes Schindelin wrote:
> 
> > > Also, what is the behavior of ungetc when we pass it EOF?
> > 
> > According to the documentation, it would cast EOF to an unsigned char and
> > push that back. Definitely incorrect.
> > 
> > > It looks like POSIX does what we want (pushing EOF is a noop, and the
> > > stream retains its feof() status), but I don't know if there are other
> > > implementations to worry about.
> > 
> > That's not what my man page here says:
> > 
> > 	ungetc()  pushes  c  back to stream, cast to unsigned char, where
> > 	it is available for subsequent read operations.  Pushed-back
> > 	characters will be returned in reverse order; only one pushback is
> > 	guaranteed.
> 
> POSIX covers this this case explicitly:
> 
>   If the value of c equals that of the macro EOF, the operation shall
>   fail and the input stream shall be left unchanged.
> 
> That comes straight from C99, which says:
> 
>   If the value of c equals that of the macro EOF, the operation fails
>   and the input stream is unchanged.
> 
> I don't have a copy of C89 handy, but I didn't see any mention of the
> behavior in the "changes from the previous edition" section of C99.

Yeah. I'd still be more comfortable with being explicit in this case, also
because our documentation states explicitly that we do not necessarily
live by the POSIX standard.

Ciao,
Dscho
