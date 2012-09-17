From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 23:09:27 +0530
Message-ID: <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfIk-0005vP-9f
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab2IQRjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:39:54 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34651 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab2IQRjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:39:48 -0400
Received: by qaas11 with SMTP id s11so1802487qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BP2QRv45IZ9tU/9Ofah1rCdkaBQxrOqzwevykf5qAaM=;
        b=nxU19bendjdHtTDNVRDfvOIVXKZDzeptWqciMPjQbRSLlz6KlU+TnTle1vg4r4iR4I
         vBE342ZD/a8BPxDkvNbfuh2dg2hQJJYiKl8gfi2EVMjlmpFUpAu6nFbX2hoDkiUVAGhZ
         Vj0HIt3f6KPj36K1ILao7ltqz1EgX912LB8ozNo3NnAWCJHtqKgzPp9jENi+5wxJGB62
         38dEBJTmTAppCWEEZXH2H7nQwmFpC7+vcCb+bHDoZO6Jgarna/xEhRv6i1MDr7Z9P9Ed
         4ik23197TLnCXdjHP2ohS0nTqXChC6uioxozvOX5//GvI2hPtrgnQqHz0ilreTDHhDEC
         Dt2A==
Received: by 10.229.111.156 with SMTP id s28mr7746950qcp.93.1347903587953;
 Mon, 17 Sep 2012 10:39:47 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 10:39:27 -0700 (PDT)
In-Reply-To: <20120917173531.GB1179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205722>

Hi again,

Jeff King wrote:
> That's certainly odd. It sounds like the valgrind setup is broken for
> you. Can you run:
>
>   sh -x t0000-basic.sh --valgrind
>
> and see what's happening near those weird errors?

Not helpful:

+ . ./test-lib.sh
+ mkdir -p test-results
+ basename t0000-basic.sh .sh
+ BASE=test-results/t0000-basic
+ GIT_TEST_TEE_STARTED=done /usr/bin/zsh t0000-basic.sh --valgrind
+ tee test-results/t0000-basic.out

>> test_cmp:1: command not found: diff -u
>
> Lack of diff is going to be a problem. What OS is this? Do you really
> not have diff? Or is there something funny going on with your PATH?

It's plain Ubuntu.  Ofcourse I have `diff`- I don't know what's going on.

Ram
