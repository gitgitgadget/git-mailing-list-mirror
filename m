Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DA01FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 07:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbdFLHDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 03:03:15 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33240 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdFLHDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 03:03:14 -0400
Received: by mail-qt0-f170.google.com with SMTP id u12so115783153qth.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JwKudqIuasmpz2Mz4jS6ymCUcQmRKPIZwAcFAJ4nKss=;
        b=JZKIZNPw6esaqZmpiIXVxV+2+0JrTsejvfbvdySu05cLvMTYG/fihceCDxqQ+ytCsi
         MPkWSQSXAkssdGcso2J9YjVkU+/00DwQ9+rpb/UkQGOreF8nO/TBWetKlPpxRhpGwhPq
         TFOZVBD2OQtdq2YYHQftyAKJBgScL+Pjk/g8rYHAVaILUuWID8Oqitta7utUKpn5AVXM
         o5BLQbK7qCA+w8oVxQiSB5Veb9VUUqFYDOFYc0uCeBAEfQecTBHnE0HHj7kDBUfXIYjF
         I5/Yfqb8Nx5mJW3yYwY4HTQiwjj37cWmSTva+TYcpHCd4CUJriBfBOBDXZEzR/VyT8/Y
         //Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JwKudqIuasmpz2Mz4jS6ymCUcQmRKPIZwAcFAJ4nKss=;
        b=saEewMRxDGjvS3yS7moegF1SxjjAsUe0wzvyQRLUrLNTGbGqK459cmpoAZIm/2I6x2
         ea18lmnAHUgKJE9fcHkOmqDRCS7SBenHaPDVymHJtHS/ofOAhgbcuBaqsMHH7HIwjllX
         z8/HQ32/KIw6c29FugYpo5hv2GvGHfU0VlMoN4VTg1WI2W7k9vjyBhckAvd8Ohimcgi7
         VQLpVanj5f3KP0CRx/B+IwF0sVfUySf+uaMDgE1ULMyOxXsDGQOnpdSZp6NmnZMiDubR
         qupLwc/YwH7G3kk5j02Bd93ufBijsDzHOp0qiHM2kHpKtE8rHUSiRtO+PcJE63fm7A7p
         KAtg==
X-Gm-Message-State: AODbwcAooKL4lIJ7MJszPhJwdQuy9FWb09MEF3g8gfBa8LOKt57eOpuu
        ko4Dv5ML3uhgTznBdyHKW0F7odff0ZQD
X-Received: by 10.237.46.226 with SMTP id k89mr19902983qtd.158.1497250993524;
 Mon, 12 Jun 2017 00:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Mon, 12 Jun 2017 00:03:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Jun 2017 09:03:13 +0200
Message-ID: <CAP8UFD3fK5SYmyKjR7TQ=TyiMy3DovHDvgD9cBfpm1L+tU5AEw@mail.gmail.com>
Subject: Draft of Git Rev News edition 28
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Kevin Daudt <me@ikke.info>, John Shahid <jvshahid@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-28.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/246

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday June 14th.

Thanks,
Christian.
