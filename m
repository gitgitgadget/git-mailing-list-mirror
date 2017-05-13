Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE3D20188
	for <e@80x24.org>; Sat, 13 May 2017 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbdEMTDr (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 15:03:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbdEMTDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 15:03:47 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MU0U9-1dZhvt1u2D-00Qhpi; Sat, 13
 May 2017 21:03:36 +0200
Date:   Sat, 13 May 2017 21:03:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
In-Reply-To: <20170512234414.GF27400@aiede.svl.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705132037050.146734@virtualbox>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de> <20170512234414.GF27400@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zFgkiC1GqfxhVjj2hJiA/AzBAwGsqJIZJYFuAwqOlDsAbzH68/8
 ri1ob+xzRhWi/QZWmBzpVqFBdwo1s4338WPa53yTv6s+c6LOn1cOXYRmdvtzaD9H/Eh778A
 m3CnsoPao6EZbXoQM3WEpw24WYkS3nMHps41sUtpdfzPgOleFF84bCQKQAX/W5ysFOGTKZ7
 cSQfFZMS6+HQExxOkL4Rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S1fO2B/JTBY=:ZP4bg8/UBEXW7YIWyArfSr
 ErrjannhDCohRjiq7yI8yNIVc2V/6PTJk60U1QsTedxhTTT4ew8KcAaqBkP79MtAV8bF4y0jO
 4Zb8IWqPR6sKXNO1ekf/zeQMsl+LMPyTtzGq8+4qdWa9Ej4C4LmGoz9Uu7Zpvf7zhOjxjKs+q
 4Qc6RhLNJt/COSFOHehMyWGa2GuTdfl0ynaRGgVf8YD0pJHQiObRjWo9gWAjbUAuSAlgSI0sq
 X6vViaJDr/EtV5IuUpesT8o4RR4wT+K6lL94F3ujd/L/tFBbmhywVQ5cJ9pqir+7RDnmw8SZ8
 JdeEsIaHtPokSiAlTzisT8kW1Mgf7otmCtsGjmFMMr/zYIcMJ6dqrn942qx3ifA1Mmy3tr885
 ICmK/ZzSrgwkJcxuAxS/TWXwSUW9G9ddc6O6hMPqalqWoiFBRmAb3zGOGAel5KzytxmbOWK5h
 56MCnDn4fYpKvTkaVTyrEF9o6FNkTBVFWqhzXK4f7M+LeVoDdzsxdOhC2c3nn6qLAIVU+2wnd
 wVw5T+0MzguROEyrpsfnPciaQbas/hDbnSexTlU5IbF0mUC8aU9k/3qK+9YQnp2WDo6+HZA68
 nnUuBpipN1Rbqpn4USW3m1EDLIH1t6sd2vZD85GKhJFkfEoCu2cUyp/RegMGfyOaRa3BsnRXc
 PczqfYw8iaM1aPOpBBw+F5S/DUa9uwKayesWsagr5l/Fj4lzejv11WFIwvqxGGPwshbIsI5GG
 RMXd5jS9qWexQLsmu13DKqsmnQGgNhNOwex1VNl6biNRp5n42WAlIFM9NOnyHOVbibLucuTtT
 3ScjRbO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 12 May 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > On Windows, `(1|2)` is not a valid file name, and therefore the tag
> > cannot be created as expected by the new test.
> >
> > So simply skip this test on Windows.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> I wouldn't be surprised if there are filesystems used places other
> than MINGW that also can't handle this test.  Isn't this what some
> tests use a FUNNYNAMES prerequisite for?

Some tests do that. And they all implement that prereq themselves,
differently.

t3600 tries to create a file whose name contains a tab.

t4135 tries to create a file whose name contains a tab, but only if the
MINGW prereq is set.

t9903 tries to create a file whose name contains a newline.

It seems, therefore, that the existing FUNNYNAMES are already in
disagreement, and as you point out below, the file name in question
contains neither a tab nor a newline. So we would introduce *yet another*
disagreeing FUNNYNAMES.

Besides, in some hopefully not so far future, our default refs backend may
not depend on the current platform's file system's idionsyncracies. So
maybe we do not even want the MINGW nor the FUNNYNAMES prereq...

> In this example, it's the pipe that's not allowed, not the
> parenthesis, right?  (At least I have some memories of naming files
> with some parentheses.)

You would be correct in that assumptions. Long names on NTFS can contain
parentheses.

> Would something like
> 
> 	test PIPE_IN_FILENAME '
> 		>"a|b" &&
> 		test -f "a|b"
> 	'
> 
> work?

No.

Remember: on Windows, there is no Unix shell.

(Actually, there is Bash on Ubuntu on Windows, and with the Creators
Update, it became truly awesome, I am a big fan of it. But that is besides
the point here: Git for Windows needs to support Windows versions older
than Windows 10, where Bash on Ubuntu on Windows is simply unavailable.)

So what Git for Windows has to do is quite a burden: we ship with MSYS2,
kind of a light-weight version of Cygwin, to run our shell scripts. (I
would wager a bet that at least a third of the bug reports relate to the
POSIX emulation layer we ship to allow us to run Bash and Perl, but even
that is only half the truth: tracking down those bugs takes easily the
majority of my bug hunting/fixing time, hands down.)

The test suite is no exception. I may have ranted about this about six
dozen times already, so I'll save me the time. Just pretend that you now
read seven long paragraphs describing how much it sucks to run the test
suite on Windows.

Take home message: Unix shell scripting is good for personal use. Don't
use it in applications, not if you want to stay portable. Just don't.

Back to the subject: The MSYS2 emulation layer inherits a neat trick from
Cygwin, where it *can* create file names containing pipe symbols. They
will be quietly mapped into a private UTF-8 page, and when Cygwin or MSYS2
read the file back, the file name maps from this page back to ASCII
transparently.

That strategy is all good and dandy, as long as you stay within the POSIX
emulation layer.

Git for Windows avoids the POSIX emulation layer as much as possible, for
speed, and also for robustness.

Which means that Git does *not* map the file names using said private
UTF-8 code page. And therefore, your test would succeed (because the shell
script would stay within the POSIX emulation layer, which creates that
file using above-mentioned strategy), but Git (being a regular Win32
program) *still* would fail to create said file.

Ciao,
Dscho
