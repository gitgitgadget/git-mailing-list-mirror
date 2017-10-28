Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C2F2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdJ1QEY (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:04:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:63169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdJ1QEX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 12:04:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8ZtH-1dE3I840f5-00wHOU; Sat, 28
 Oct 2017 18:04:20 +0200
Date:   Sat, 28 Oct 2017 18:04:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] git-describe <blob> ?
In-Reply-To: <20171028004419.10139-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.21.1.1710281802530.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YiQoS4QfgV7lBT/qwP0FCcYQbKhswjXIgiZydY3xnFMGXsUJSs5
 ruD4+A69vyUC+pXA1w4Uncpeuholsd6c8CYCkgNlSW9811yJWzePy9rpXWCwsGD2ck/TPaN
 Us6hZRIzJCSiK80jDmHDkECCPqpACwSpVgQ5EVqsKvdoMz6rREquEzlzIt6vTDfAmfoQ4vs
 06jw23xCWk2U8j1/Cf67w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4iiXo6SfSZE=:Xfr0Z3vH/lvPRar9uV25Qd
 v+bN3cYnM8kj5e92jqYH0Kj9wM9UECV6sGzhcR0XPiUmaF5WNanYxdrSf83O+hP+1OBKaAUMQ
 DyuBxxfOltByzLI2h76g7Sg52IMBDk7wEd43yWDymzRdFazIaquJYY3O4goO1EIkdOjus6K/Z
 p5nAofBh5h+bwTx7ETyoLtmVrgad1InLWzkeUkK5g2BciLrdZOyoqt7oSCUowmbDp0zcHAIEg
 Fen7NWxjY7uYgeLgN9GMQZX15d1Hi90eb+9wc2sxswu4bBiAEa9d7TTJE5S4oHkL+RULy/Ixl
 zGR5LlanezKe2qFN2BfgFLVQZ4BcIfhSWrWCBPZmgGebY2S0ioXA616LXhgyhqCuf7UAcAMb2
 icJFADxEh9mqEJ6CvXdrNZfCqU3BplrImg2Ed2OH0ad9SFFyoGlV+QFmcSO13gjAGorKNiJMW
 +JS+cYqTkagrBGvNp7m/MftDs9jHdvPmYzgRh7cRraRHZ8CgDRAqhbw4P56BpJKiEFuw5Hlf3
 5nVUjGHIEDyRKUDCnPhQJdtW0JNO8DG8swjpk1NRqepqgHEJPzhkjfJoss0wm9wOv8jiDPfFO
 MTV2DkZ3NjRj7ueBbUCfhkf8cNLp2etUAcnwGCgt2MedAN941gCXzk9az1gfhjDvH/9Cj8pVe
 DXhg9+TvE7KZBCJDNELJxP168eSnODlWvrb4pwvtByX0LNmFuBU31UqCJxAioM6mwHjROosS4
 Ek0eO0JMaljWE77qz7pSr4K6y3h3P3gr7tOjm06cFdmg10XgWZuu7V/799NOhZaD2HdXovM47
 XzFl7/D5DzjogkX5EtQNcFkx8GI/ErvG0TzHnKG2lqLC1I8+74F7VXBIHxlWROJgSDCxjDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 27 Oct 2017, Stefan Beller wrote:

> Occasionally a user is given an object hash from a blob as an error message
> or other output (e.g. [1]).
> 
> It would be useful to get a further description of such a blob, such as
> the (commit, path) tuple where this blob was introduced.
> 
> This implements the answer in builtin/describe, but I am not sure if that
> is the right place. (One office mate argued it could be a "reverse-blame"
> that tells you all the trees/commits where the blob is referenced from).
> 
> This is RFC for other reasons as well: tests, docs missing.
> 
> Any feedback welcome,

As you ask so nicely, I'll just cheer (I do not have time to review it
right now, but I really, really wanted this, I even started working on the
name-rev side of things some time ago but eventually had to let things
slide).

Ciao,
Dscho
