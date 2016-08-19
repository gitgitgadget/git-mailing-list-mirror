Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C5F1FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbcHSIcp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 04:32:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:52665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752675AbcHSIcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 04:32:43 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M5tU1-1bGxfy017Z-00xpuv; Fri, 19 Aug 2016 10:32:31
 +0200
Date:   Fri, 19 Aug 2016 10:32:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        me@jnm2.com, philipoakley@iee.org, john@keeping.me.uk
Subject: Re: [PATCH 1/2] help: introduce option --command-only
In-Reply-To: <20160818185719.4909-2-ralf.thielow@gmail.com>
Message-ID: <alpine.DEB.2.20.1608190954461.4924@virtualbox>
References: <20160816162030.27754-1-ralf.thielow@gmail.com> <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:whYmcHxUjzm6UHOU4JxlgdpIJpSgM4VMlaPniy6m8Q+cIMTU+yV
 I2CdBDlFE/VjT2dmdmY5BpmZz9mFIZhB346EV1pnL2qlWvsktczK3eSoJpoYl1Ug4F0b20l
 Nlb8oEcEdYI6FRBjTdD29L38tNV1J063DVP4dtVtzQc4/OXBivoHZv3BTHBNmrLk+GOpxxI
 ApeaN9pj6XnF70N6mk7/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WMHzz6eGBOo=:teddFPh9gaMiLEDuRFZzRF
 fP+6+zqGHSwU96bc9RN4i9qrXWFJ66FzX9/dQbJCn3WFjCJ3da9FzUNcpubwB3xS/yTUxQe6K
 EI6wjulDujzv7tUDYSwAnyh3l1Aj+E+qptk8fuTDqcRLxqdWzP87Kxw2putFz1up72/gxcaVs
 PBX7NDQK4fPuEpjKsRc03hEdTAJbaL/Au1GxGhsC2pjK21VzPNFvfPwuZz5NaGecKHlWfWtE8
 T48vBm5gug9UbE4Tf9kWnZXqXxlpn8yHYZz120+wQ0MxcT1vCbE+cnMQknHKOmy6Y3xe+vn8R
 TX3aKIJ+FMm4D26XI/F4PQEKomtSl15K5PR66EoeKR/yGKEgH0526MpNC1R+uF+2eEkZUWBK5
 Lcb+FnIrO0zeoJmqFoeIMtTXKCMi3FDdDIuKaGyzBCj0VyYUjRjNKeDO/dXowVozmsabziUX4
 l313FuhyEY3afpvWVku7LR1JaRVj1j1WxzdQFqaJq54yxk8t9woC3ewMGylo1/AHigsHpZT6Z
 i842P2WFpAFOSwNsJwphalfmrxXdkNr2jVzSDAlH1n0rFQQU5rbw5pKjkjRVrURAuMv4ZJXb+
 W5fzTkVF9btuH13VqTfA1UhWanSLYtTf+wrshTAobwzvc6v0p/tu7hiZlmwwR1CLtzXlSYnY8
 MBqU4QONkqkVBiNMrDWGzVgcAd8HgIL8oFZ1nDTqi2TOMExXbhFbVrkmkZHcoa3UCcY2UPf8/
 GYHkagRTb5A9aYLhCjBUaeXXWCG77SdoRUDEbgT/UohOdEaXbNpLqg98Yk2xLsMbaK7p13G36
 GjkSoZL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Thu, 18 Aug 2016, Ralf Thielow wrote:

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> new file mode 100755
> index 0000000..e20f907
> --- /dev/null
> +++ b/t/t0012-help.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +test_description='help'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "works for commands and guides by default" "
> +	git help status &&
> +	git help revisions
> +"

Apart from using double quotes (which is inconsistent with the single
quotes used literally everwhere else in the test suite), this test is
incorrect. If the man page is not *installed*, it will fail:

$ sudo mv /usr/share/man/man1/git-status.1.gz \
	/usr/share/man/man1/git-status.old.1.gz

$ sh t0012-help.sh -i -v -x
Initialized empty Git repository in .../trash directory.t0012-help/.git/
expecting success:
        git help status &&
        git help revisions

+ git help status
No manual entry for git-status
See 'man 7 undocumented' for help when manual pages are not available.
error: last command exited with $?=16
not ok 1 - works for commands and guides by default
#
#               git help status &&
#               git help revisions
#

It gets even worse.

On Windows, the default format is *not* man pages but html pages. So those
would have to be installed, too, to guarantee that the test succeeds.

It gets *even* worse.

On Windows, there is really no central location for man/html pages for
documentation, so we have to emulate that "prefix" (which is typically
/usr on Linux) via a "runtime prefix", i.e. a prefix determined relative
to the location of the currently running git executable. In the test
suite's case, it is typically the top-level directory of the git.git
checkout [*1*]. There are no man/html pages in that directory structure by
default (I, for one, rarely build them myself), and certainly not in the
place expected by this test.

It gets *even worse*.

Since the help.format is html on Windows, the page is opened by the
default viewer for HTML pages. So even if all of the above would be fixed,
running t0012-help of a supposedly unsupervised test suite would open new
tabs in the web browser. Probably forcing it into the foreground, too.

So how about fixing that? I would suggest to do it this way:

- configure help.format = html (for "man", the current code would always
  add $(prefix)/share/man to the MANPATH when testing, not what we want,
  and hacking this code *just* for testing is both ugly and unnecessary).

- configure help.htmlpath to point to a subdirectory that is created and
  populated in the same test script.

- configure help.browser to point to a script that is created in the same
  script and whose output we can verify, too.

The last point actually requires a patch that was recently introduced into
Git for Windows [*1*] (and that did not make it upstream yet) which
reverts that change whereby web--browse was sidestepped. That sidestepping
was well-intentioned but turned out to cause more harm than good.

Ciao,
Johannes

Footnote *1*: That statement is actually not even correct. As the git
executable can live in both $(prefix)/bin/ and $(prefix)/libexec/git-core,
i.e. at different directory levels below the prefix, we need to inspect
the *name* of the directory in which git.exe lives, and a git.git checkout
typically lives in a .../git/ directory which matches *none* of the
expected suffixes, so the runtime prefix defaults to "/", i.e. the
*current drive's root directory*. So your current test would only succeed
if the man pages for git-status and gitrevisions were copied into
C:\mingw64\share\man\man1!

Footnote *2*: https://github.com/git-for-windows/git/commit/243c72f5b0
