Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DC71F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 01:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdAYBch (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 20:32:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55630 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdAYBcf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 20:32:35 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A201D1F437;
        Wed, 25 Jan 2017 01:32:33 +0000 (UTC)
Date:   Wed, 25 Jan 2017 01:32:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Beller <sbeller@google.com>, cornelius.weig@tngtech.com,
        Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Subject: Re:
Message-ID: <20170125013233.GA16463@starla>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com>
 <CA+55aFx_W500Ct6HuG18owG37FviirjsrJ_4zZpRcDD-0tmpFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx_W500Ct6HuG18owG37FviirjsrJ_4zZpRcDD-0tmpFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jan 24, 2017 at 4:21 PM, Stefan Beller <sbeller@google.com> wrote:
> >
> > +Do not PGP sign your patch. Most likely, your maintainer or other
> > +people on the list would not have your PGP key and would not bother
> > +obtaining it anyway.
> 
> I think even that could be further simplified - by just removing all
> comments about pgp email
> 
> Because it's not that the PGP keys would be hard to get, it's that
> PGP-signed email is an abject failure, and nobody sane does it.
> 
> Google for "phil zimmerman doesn't use pgp email".
> 
> It's dead. So I'm not sure it's worth mentioning at all.

I disagree, we still see it, and Debian still advocates it.
In fact, we may also want to mention S/MIME in the same breath:

  https://public-inbox.org/git/20170110004031.57985-2-hansenr@google.com/

Richard's more recent mails seem to indicate he's reformed :)
