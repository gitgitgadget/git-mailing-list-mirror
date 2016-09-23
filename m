Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F51207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760368AbcIWVEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 17:04:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:53910 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759154AbcIWVEb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 17:04:31 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqiJO-1bJ8ln2va6-00eO7J; Fri, 23 Sep 2016 23:04:26
 +0200
Date:   Fri, 23 Sep 2016 23:04:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Stefan Haller <lists@haller-berlin.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
In-Reply-To: <CAGZ79kadpe5wG0gSpk-oasxCGuUp+3bSv-A4vhyFC+y0oL-+ww@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609232300500.129229@virtualbox>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de> <ns1gr4$pjs$1@blaine.gmane.org> <CAGZ79kadpe5wG0gSpk-oasxCGuUp+3bSv-A4vhyFC+y0oL-+ww@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uWzd7CNNeivozZjYjyFk5jockKtxSkm/0WHEuXlaUSzlfwjpmR6
 3vEh7Dq/ancXhpeuWPUucmxNPD+uQOYImQj4zWz0UkU9oV8M+uuCZGTQyBFIscUFG5PBrR1
 ul9CnCj8a1jcwlYWHUzG2jkzQZ0XvdxxN+TfpadHWQahTJfp8KWDSZEUZdMVy96jd4+fcAl
 08bb6pJgALDFysoMxALEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Xx3RadRmxM=:zGVmirNdDZmGkMlvEWjmD+
 6sXV2eYdznYlvNPhKbTY4ojviQlyK6OLf5ScvFzoxdFGiudrb5eLR6KMMiAneuM51y3soZrSq
 OR1xWFmIsBjEPWARF9HLDqETzCiCTwpMNWVqtv72m4pO0vandmBQ3X7WiQrURO4Cqjqel1ZnO
 uZZ/KmuKdF+SxEono3eFo7RBP+wc5gCQwRW/Gso02Ntfk+wOhLUvONgIcDMaelvUXzTS2Hv+S
 iCefSPrNdIxHurK8cysgETIY9xGOpBXAT6lunrErvEavF8i7C3YvpKD6alAEp4UeoxRz6gGne
 7IW0wVaA4sVAVsqkjl9DrobagRxPE4RcfexopD6cV38wuzjJz5vy7ZizCRyf3gPMthB4zsN2f
 fCxleFnPOLINCYl1m68mTliCqzHQeOLcSaJrqvgLh/uRo7rVJaM2ncDNdO7aVAwDhKLUqNLTD
 yfgCR+5lazGZCcHobosK71AnogrlLGYALs5E3fGDVxPu33cZ7lrzMF5aZ5BtN5Z2VvjhqWayB
 n40I4qED4x6fw0G2HoulPxEfdQdw4wcZbzi34ykDjrf4fi4YtN2YN643TD9Nsx2VDMq/W7SUi
 Bt7AMLY9YctGSNQLyjPYmA9VXC6yMVkwuvdZIjoxhSISF+rWHVf/oFJoYR7OTV4dHyPuSrnkv
 c1W/kB6XTxRth4WvYjAA97kSBBXDGxLle1JkGr8q8UExQ/An16E3L3HKLQHzYjpEl8beFnOLV
 +FSb4ZW66Z55rDq5zSmmjjMH0GsbFrE0JivbLYFEiKbNdZ2kSXmeYsr5rltgdLf7EVp4qHKre
 kBQYikm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 22 Sep 2016, Stefan Beller wrote:

> On Thu, Sep 22, 2016 at 2:01 PM, Anatoly Borodin
> <anatoly.borodin@gmail.com> wrote:
> > Hi Stefan,
> >
> > I've also done some archaeology and found that the original version of
> > the merge preserving code was written by Johannes Schindelin
> > <Johannes.Schindelin@gmx.de>, see e.g.
> 
> I think it would be helpful if you'd cc those folks involved, not just
> the mailing list.

Indeed. It is quite tedious to re-Cc: people. Anatoly, please do not force
me to put in that work in the future.

Also: I mentioned recently that I am not happy with the original design,
either, and that I came up with a new design that I intend to port to the
rebase--helper, once it is included in an official Git version:

https://public-inbox.org/git/alpine.DEB.2.20.1609111027330.129229@virtualbox/

Ciao,
Johannes
