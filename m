Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397631F89C
	for <e@80x24.org>; Tue, 17 Jan 2017 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdAQKxL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 05:53:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:51721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdAQKxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 05:53:06 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwnem-1cVOKN08SG-016Ned; Tue, 17
 Jan 2017 11:52:31 +0100
Date:   Tue, 17 Jan 2017 11:52:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Max Kirillov <max@max630.net>
cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/RFC] Git Gui: GIT_DIR leaks to spawned Git Bash
In-Reply-To: <20170116224022.GA8539@jessie.local>
Message-ID: <alpine.DEB.2.20.1701171145050.3469@virtualbox>
References: <20170116224022.GA8539@jessie.local>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zGP70haMYzxNxsWy0tfmdTMk024Ti12eyDUbkxDjSd37WZou+yN
 fE1TLS35+3wQoe0dU6uwDtKUgBUCzq8tNSJP76pJznBQAwBDADXovyQ6gYh0TzsdeucyPUd
 HmVUUYs7Dj5I3qMlH4ctSGeLwh26mzm+8HyF1VBXbOabYCcPBlJQi9wRHc7ZBDjVWM0EiAc
 +scNHqf9v8KeoU6LX7GPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TupnYOegd3U=:aJdy75zQME/xCpJ79y6BVh
 BNq/ARu5JWAtCOJ3QYhcKjdGzmGMOu7XTcpBpqInvb8/wR/baoo/hwtBeJexmzGr8VzLjWSiS
 tzIOwF2PGkKcKR1cProLhPZ1Nk652K2nZy7rSMMQLP60fh94DUYO7ov/OrqS7C0TBbiGyj6zw
 7Pi/BTWPEeBoxiItYJ6ieJUyCz6/lDzWA4tfB4bYHiII8o4LyFvaK6nLiKEk7saCpPBrZWInM
 k27DKRDKgv1fw3x7f1P8kFARkyigrx9R3E4n+41ge+cfkJmbKwHK0dfjIqUpWHwGOWY7nOT3E
 rzrkQmSS5BbbKNiOdPUtOt1BYX0d4UdMZHn6KZESL27m421lwuKSYqlEbun8cd8v81BLetxcp
 wF7e7EjPMXpZuIyXh+oGZIyQF2N1GzLQ4gmRXG1Vkxn0WhUg2bTJ7Rlxm98rjflpRkqcc/lwA
 8dKBsE8Wdcc+9MaJhzz+AYVA81M8YNSziaJxfiG7gcaNrKwaa0B1PjnJDz6bumqZsO/HPMWXj
 uhOUZR8KEbMap1Eo/LEHMgVqd4m+ipIU56kAz0EWe5Cu6U7e3fx5eGo/7L+P4Mp0CChR9VbnD
 /0gHKelPBD7osUmvi94cWM94Tu6O9wl3DVqlL1iGYLNY26s79zpxDhX8Hrcfx757X/uKlVCEU
 cjVe3sWjp0aSxg53s3AlMxNKtSnO3h3+IlNMr+9adedICDOD+gDLlKUYGKXrctEp5mdK9XpFp
 AClf5rFe1VMpn9vWg5I2kUUbRIdobcEJan8HOonLT/C33KZghDug6ux4NhIcmeaQJ55FC50zF
 uSsR+j1bJJ6eJ/5hSBDoJGOCVUj0SgN9shnJxYAw7D/oaWOv/voIz1ePQkDV9aZlc2cvjWHGU
 5MVnEZKBrgtmYlGqK7cBlfCXh3ugdgOVP8HUWlTPZVFFi1HLgbeUclE5A3UvxqdKcln4wMf/+
 XPCvJVnXPdMlbtgyIyH1NAb2Oixfxrw6EngeODXvMrcMAzS78SnipEyuotx4y6/MDUnru0Ve+
 MrQYDi2zZhuJu6RMT8DnZFrfSPy2YNNPcxoNWISmsdygMEsxUApUTuVM6zFXz4cF+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Tue, 17 Jan 2017, Max Kirillov wrote:

> Apparently various GIT_* environment variables (most
> interesting is GIT_DIR but AFAIR there were more) leak to
> shell session launched from Git Gui's "Git Bash" menu item.

Given that you call it from Git GUI, i.e. for a *specific* worktree, I do
not think that this bug is *all* that critical. After all, you won't even
notice unless you use the very same Git Bash to navigate to a *different*
worktree.

Having said that, if you have the time and energy to come up with a patch,
I will definitely try my best to help you get it integrated.

And having said *that*, I have to admit that I was unable to reproduce:
GIT_DIR was set neither when starting Git GUI from the Start Menu (and
then navigating to a previously-opened worktree because I am too lazy to
navigate manually), nor when starting Git GUI from a Git CMD in a worktree
via `git gui`. In both cases, the environment contained only the following
variables whose name starts with "GIT_": $GIT_ASKPASS, $GIT_ASK_YESNO and
$GIT_EXEC_PATH.

I tested with Git for Windows v2.11.0(3), the latest offical version.

Thanks,
Johannes
