Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF508201A4
	for <e@80x24.org>; Tue, 16 May 2017 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbdEPKrM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 06:47:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:58658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbdEPKrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 06:47:09 -0400
Received: from virtualbox ([95.208.59.249]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8vJ-1e3ed83Jyz-016fYJ; Tue, 16
 May 2017 12:46:51 +0200
Date:   Tue, 16 May 2017 12:46:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Eric Rannaud <eric.rannaud@gmail.com>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
In-Reply-To: <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705161227060.3610@virtualbox>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com> <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9rtVqtpnKGoGyGJbRmkEn6vxY/ybsUeCSiR1tjoI3jq8MVlaacT
 HIB6n0Nl5XRCh/ZrAey63/7GPgF9EU4NHQn1Ye3au6O1DH7ZeXvrdrt+MYhShdX8A9czCpl
 yIkUcTflAzC5b3UWII6xuk7iAnZ4Pi0xWNBFN0Jnq+MMx2EmGplr2RIEDq1soBKsVIbPpvz
 OQlk4xWYQrD0f3rDFkuzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i2Cx7RuywRw=:+qNEdCl0nIC2P1F0jgvp4f
 k6OsLTMZr9U30eByLp5++CzrEvbaBkdDUbEpStKx2AMkxiHbCoCPTebCHjiNhdBBPq/yS5Lg0
 7ayehwjfRbQ+W47h+P4gTPAn9H7XKAH8hUDkFgDv8zEMJ+UPt4Q7qLoDxHXdq796pfQbOpIK8
 /dgOOU/JqO9f9NmFTuVzxvps0vPfozrDhLKLUyJ+iHvVeislErjOWdkATKKzc4rpT+DrrpSDA
 Ky9uq3h6S49kzK2gSUv+6zbL/Xn4QF5sUT3QOizz4c2MjARI+UAXqKbX1vupJR/rDQ/Y4U+F3
 lj7QPGa1ya8HnZGLQ+jJMmyPkcYNYe+VNzPo82rmLNmP2sf7pYCJS6M5DMGj1tPC33isHJhpp
 W7eAuFMx+P3HxHe5kVzqo8mjgwCWtLbmh5wlTjWUt7fk49VsXTYogVwwf2t9nCTfriErdMCWz
 +Na4No5s5XSak52RnMyAaQeMSwLcqb+BnaaPwjwRjOGH6mGD8nqFy0bJ0ELz5/dM4EdVKuox8
 OhWsIvV0Dlml1/Mx0MkEDloLrIq3hm5A9uZwWXQfdN47JkH3NwznSMEtdMqJFv8gJ7ShqCCyC
 zjM/bx5aIedVvkG6iwdctU9m3MSDrbk07i1Cxxhm691xYbWbX6piiBCPK4ghSCGIhWPYlZvmg
 Qtwi2kNuWvV1w5x/lb7opAufD2XUAlijIIqIUTHGU3ACrTx2KurY7xYHq54cHOb6CqZjGetm0
 5XvMFWf7aTNCbf+wEF9UrE5xoRj76oLRD9DomFQYMY938ZlOw1sUr9y65Mo/USiutJCqxvWrK
 nVrsSa9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 May 2017, Junio C Hamano wrote:

> The point of rewriting things in C and using run_command() interface was
> to avoid shell overhead.

That statement is missing the point.

It is true that converting shell scripts to proper builtins avoids the
shell overhead.

It is even more true that that results in a nice speed-up that can even be
felt on Linux (I feel I have to stress this, as you seem to be mostly
focused on Linux usage, and I do not want you to get the impression that
you are only doing "the Windows folks" a favor when you gracefully accept
the patches to convert scripts to proper builtins).

But the real truth is: shell scripting is not portable.

Shell scripting is never only shell scripting, of course. A quite
undocumented set of utilities is expected to be present for our scripts to
run, too: sed, awk, tr, cat, expr, just to name a few.

It does not end there. For example, sed is not equal to sed. BSD sed has
different semantics than GNU sed, and we jump through hoops to try to
ensure that our shell scripts run with both versions. Which must make many
a contributor feel a lot less positive about their contributions e.g. when
a reviewer points out that their \t in their sed statement would break Git
on MacOSX. Sad!

We place a burden on maintainers targeting platforms that are not Linux.
If I remember correctly, we need to override the default shell on one
Unix, even, because we simply failed to make our shell scripts run with
it.

And then, of course, there are all the problems inflicted on users on that
most prevalent Operating System of them all: Windows. Yes, I know, you
"non-Windows folk" would like to happily ignore that little tiny problem,
but that's really doing Git a disservice. So stop doing it.

What hurts me most about this is that Subversion, a software that us "Git
folk" pride ourselves in making obsolete, never had those problems. It was
designed with an eye toward portability from the start.

It is a good thing to support users who want to automate their workflows
using scripts, of course. Oh, and please, do not forget to remember that
there are tons of scripting languages out there, e.g. AppleScript,
Javascript, Tcl, Python, Ruby; just because you prefer Bash does not mean
the majority of developers do.

So let's continue to broaden our scripting support. And at the same time,
let's also change our mindset so that we can reduce the portability
problems of Git.

Ciao,
Dscho
