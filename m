Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E20DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54422611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhJUL53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:57:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:53673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhJUL52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817312;
        bh=OpaDr+k3Uaxi7OOftuaUH937F0ICltPdyjQpmww/5W4=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=UyBVUDYsddSt8QMGzu11jGebZqn1ZiQz2xfRgACWV/wSuI4HKlAx0kM2bW7qMVKuJ
         pLDvE25ZI6fWyMJA8iHOGECY+kusgotopawEX9sD54DbKEXJb4anpfZKSbMyEKIXh/
         YmOg3d/gkzSAiaB2oOvqFFaZ9JDZDBMebK9PIUW8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1mi0oq0Bqi-014FIT for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:55:12 +0200
Date:   Thu, 21 Oct 2021 13:55:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Notes from the Git Contributors' Summit 2021, virtual, Oct 19/20
Message-ID: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d55sF0O0XE1kJqtXri0P6ZggwTnDIN6Mb/G8Uu63gVMPCnoCfb+
 YDWLteIB7432NN6kS1o+yENnZU17EekZKhrp6v1T/Do9R6NtWjn1KzXFIYvjX0M8nFNFJwX
 Z/6bg6qgj7FeYq86InnkZgQaUAssTqIzTiX2lTyyukKNcOOAD7viQ/hKd9J5ATjItzWGlRA
 5mjoE94dlgSi5b25lp7Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5S7Qx+AvFfM=:iMjBDmh2s0qiATQPot9kJ+
 WNmCo9905tx5exuU49j9aMF/vaqIwqOHRx1S9PshISCi6xz7mgF/02AJys7t2e6DZWa0UYCgR
 aQDbMgkl6VJz1QMvJQwwV9v3ZhU9Fb55O5G54ivWoh0Hq7PtdFohPEzC8tBSxeafaPxJvJBLO
 LCHEQnaDafozTh+MwFNOrG2RtY/SjNny6sqobUm5yRBKvERE9JyOgcIAgiSrlOQyDk5JmC+2Z
 DDrlmoHbcbp7ZIB6kXKLQPtf0w7yCBDiELyfnzarVaYzmt/B+Z7pcxfCe+DCXz5WD4yUKAMv7
 Y+B+tCP7u44f8wCdltsJReqfdyHBhgLVEo2hj9S9d8NrTu4by+aJwHCoEOyhnsY7XnnnpIXEj
 X1x24RdxMgfixdTnuYJm9YAUsND03MMd5tRRn3Y19xTf+yHN8O5BgpxDtg6RYfHvJQJR9Jy0t
 Bht5JDAwZ+7jhq05NllTmlFJk0EFW3ASMYhqL8R9pxhcN5q5aU21XHPMKbaQY8OHPo9+rH0RM
 1hxmscXNxmjBNE2r/mhtpi3jlo9SQQBflCWyL5XI9OFUAfulnvEyhb2ncov4JpPQHr5Nq9S8H
 3pZiXnHvlMjIVxYMeqjm35ChbKyOsykBYj+mWmDEN/o4fp0db8ZkAyJxxxZ1U/YQRPRD3vRFr
 HNbWNZ8zCt5hhhTu4HbbmRPhXMY1DzmTmDheQ7+1NXMS1OHu981Zc3XWyNPfOi9cIxWi8pjNv
 gNWYSAVPifMpRlEw1icC2FiCHCk4dF+XW9xtGFxG0EYegXM/niP7jKzYZGLBkZcL2iHtaa/LB
 aXlA0msdk/oPeX1yqf20HrAFQEO2V/AwWCsdMwz3MQZt26FmIxUw5KOHqpmz3XJUND+k9GPyK
 wsk90TwrUI7SfVJG4IUbhvsHTaMHltTwV7aH6ZX5X/0r9uMWcO2R4ColHGBRI6tNNRiVc58WX
 y5D2S0KJznCqua1yj8bT9BlGwh73SlTLSaZGi6tYFDHdclVf3gVCWc9iwYiuzMXJ9hphxByiH
 0jZP3LhgiLnCstVa7oFT/PFFUkOGZi875xzWvoTt5FTX+kNVyEQzklB1Q6RTAMYHQjleXsVrn
 iAAeUtkq5e5P0Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

we held our second all-virtual Summit over the past two days. It was the
traditional unconference style meeting, with topics being proposed and
voted on right before the introduction round. It was really good to see
the human faces behind those email addresses.

32 contributors participated, and we spanned the timezones from PST to
IST. To make that possible, the event took place on two days, from
1500-1900 UTC, which meant that the attendees from the US West coast had
to get up really early, while it was past midnight in India at the end.

I would like to thank all participants for accommodating the time, and in
particular for creating such a friendly, collaborative atmosphere.

A particular shout-out to Jonathan Nieder, Emily Shaffer and Derrick
Stolee for taking notes. I am going to send out these notes in per-topic
subthreads, replying to this mail.

Day 1 topics:

* Crazy (and not so crazy) ideas
* SHA-256 Updates
* Server-side merge/rebase: needs and wants?
* Submodules and how to make them worth using
* Sparse checkout behavior and plans

Day 2 topics:

* The state of getting a reftable backend working in git.git
* Documentation (translations, FAQ updates, new user-focused, general
  improvements, etc.)
* Let's have public Git chalk talks
* Increasing diversity & inclusion (transition to `main`, etc)
* Improving Git UX
* Improving reviewer quality of life (patchwork, subsystem lists?, etc)

A few topics were left for a later date (maybe as public Git chalk talks):

* Making Git memory-leak free (already landed patches)
* Scaling Git
* Scaling ref advertisements
* Config-based hooks (and getting there via migration ot hook.[ch] lib &
  "git hook run")
* Make git [clone|fetch] support pre-seeding via downloaded *.bundle files

Ciao,
Johannes
