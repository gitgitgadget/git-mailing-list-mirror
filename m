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
	by dcvr.yhbt.net (Postfix) with ESMTP id D96CE20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfCYVI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:08:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:46447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYVI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553548131;
        bh=f4tZMPHIJ0XROY6CgRplA/TnAiYOeahqHVYlqsA+7to=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y4ROepUKzEtapmw8zKJnra7oyPt90yCeD0k9UP6Og7IXYegVBh8d2SrUMOMRTjGii
         5QCM9X6mIvkTwv1mmt7xw+WJNPiHKrkgrnjTEt09t2C4O/iPYpAuDOmP5ig7kDEvWN
         80GfN+nJmjOyddQO8VeBJd/BCM4Q/dD9C2ZX57kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqQzp-1gUoJ00Vfd-00e7bT; Mon, 25
 Mar 2019 22:08:51 +0100
Date:   Mon, 25 Mar 2019 22:08:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] check-docs: fix for setups where executables have
 an extension
In-Reply-To: <xmqqbm20ph45.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903252206201.41@tvgsbejvaqbjf.bet>
References: <pull.162.git.gitgitgadget@gmail.com> <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com> <20190322184347.GC12155@Taylors-MacBook-Pro.local> <nycvar.QRO.7.76.6.1903241055230.45@tvgsbejvaqbjf.bet>
 <xmqqbm20ph45.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9sGdxClohcFUMrMSLMVHH79juq1c9p0SMwbTwDWELFxYOxF0Ig8
 5N0aN5Md6f66axThRRQQwBJqnitiLdxrR3+/9BvJrXeJ0ns4Q7lLZeIuo4KUBRQ3fwafojs
 AeHU8nrl2thp1Zz6l352mS9jUfE1Gkx95Xn7L+ZXbpGtfVIz0xMkSONZc2R2R8bgYawEAod
 QGdyeqkgH6htsoc5zFZpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnA92qFa3x4=:Jfce2FQz7Y9Ru4MEcpiq8g
 iuB9m75ZR96Cxba7CtWqR9FBfgQ4FLlgMVTJmVdjriWi7b9Pt8qqatI0OOVi8QxZM3GPmcCKa
 BzuAj/b1s+XwiCbo1BHCtToWLQZcK8AuLdwW/0iZLq/ge0xqce6OtbLZaMxRl0/jmPfG0Z35B
 61imf0UA6hidqwqA1QGRU1UnxbIFERFiexv7xcMido0kcjy9wFChbMO8Fd7KUEJGY8UKiABUf
 fKKmSnYmrJzTgaOEYFcmNMupcq3Or+dJKxH2D+AtuRfB0POObkshBtGbAzEC4kKT/xYF9I+Yy
 UHinrHF7wkhDsMPj1QTt6y+fBqxehy4zjRIrPLaq55xnooCQWfyEuMK4SYSpIXJ8KDB1PJP+t
 /JnQSBS1HXbZuZI/pm7vdD/uqPmY5m4lMs0vhrYa3EiY+Z675e5b8wfq5tnJwL66Fto8uESpz
 ku4E6sWZMawTui/nlDV3akJCa1Ei5IMBHv2Od/RAkOz97znIcj785Z3e3qW+oS0dnJX9xxKC5
 qQ5aIixb+KKXgx85Wz9jmv+I1MCQM0rUJqscC2jA9xSFQqBV50k8cgce4bRbt9y9eyOBv63eI
 Yk9+lhOpCWcVdcmxqE4+N5n1DZlyMVYp3koOodARLQYitgGBVIdT68rjk/gzO6oS0zKDHpUCr
 rcW7xcyEsKBBwDF0u1hBAdpn+aNXuRbpl6zmJ2oh/N1LMJ77pXXUg/y/OBSkqOujzix3R37uu
 pVrat+sy5cCZFgCEGwEk6yf+HIuVQm36MC5OVJ0RnMlRUaOTPzDKp0jgfA9y7AzorFXCdo1pV
 pYmR6w60SI9F3/GtP8Tte1qzSSOfh2ssWqC0DBoKMq6hFLjUh7f2CeY8jKipTsW+YcYqHNxpG
 bT7uPdIAt2PAGSmOWJHRIv1QkSq8F4y8oeqRrNTD7G88HKjvbn2FqV3hFb7BurzaEWcjoKn4X
 D5ACKk0wj4g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 24 Mar 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Sharp eyes, and a *very* good point. The double space is actually requ=
ired
> > for this patch to work as intended. I added the following explanation =
to
> > the commit message:
> >
> >     Note that `$(ALL_COMMANDS)` starts with a space, and that is rathe=
r
> >     crucial for the `while read how cmd` loop: some of the input lines=
 do
> >     not actually have the form `<how> <cmd>`, but only `<cmd>`, theref=
ore
> >     `$cmd` evaluates to the empty string, and when we are looking for
> >     `* $cmd *` in ` $(ALL_COMMANDS)`, we do find it because the latter
> >     starts with a double space.
> >     In other words, the double space helps us skip the lines that list
> >     only a command.
>
> That sounds more like a bug in the existing set-up even before your
> patch (in fact, these lines are probably from 2007 or so, long
> before you started touching our top-level Makefile heavily).  If we
> want to ignore lines with only one token, I'd rather see it
> explicitly done, e.g.
>
> 	... generate data ... |
> 	while read how cmd
> 	do
> 		# skip a line with a single token
> 		case "$cmd" in "") continue ;; esac
>
> 		# is $cmd part of the known command list?
> 		case " $(ALL_COMMANDS) " in
> 		*" $cmd "*)	;; # skip
> 		*)	echo ... warning ... ;;
> 		esac
> 	done
>
> instead of relying on "if $cmd is empty, then SP + $cmd + SP makes
> double space, so let's have double space somewhere in the list of
> known commands" cuteness.

You are right, I should have root-caused it, it had a funny smell to it.

Turns out that we should not just skip those lines with a single token,
but instead fix the bug that prevents the `how` variable to be set to
`documented` in those cases, as had been intended all along.

I fixed the commit, and accompanied it with a bug fix for this, plus for
the fall-out bugs that had been hidden by this bug.

Ciao,
Dscho
