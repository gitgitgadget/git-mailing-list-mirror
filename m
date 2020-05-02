Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FCC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 11:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1FB21775
	for <git@archiver.kernel.org>; Sat,  2 May 2020 11:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgEBLwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 07:52:30 -0400
Received: from hz00.koulikoff.ru ([78.46.42.68]:32883 "EHLO smtp.koulikoff.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgEBLwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 07:52:30 -0400
Received: from p5b01d7dc.dip0.t-ipconnect.de ([91.1.215.220] helo=hp470.localnet)
        by smtp.koulikoff.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86)
        (envelope-from <dima@koulikoff.ru>)
        id 1jUqh1-0007Wq-A3; Sat, 02 May 2020 13:52:27 +0200
From:   Dmitry Kulikov <dima@koulikoff.ru>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git log --since=<date>
Date:   Sat, 02 May 2020 13:52:23 +0200
Message-ID: <5265732.OezXlLLYS9@hp470>
User-Agent: KMail/4.14.10 (Linux/4.4.219; KDE/4.14.38; x86_64; ; )
In-Reply-To: <20200502110350.GA3143@danh.dev>
References: <3860060.ab4mYtCOl4@hp470> <42953119.Wv2erQna2g@hp470> <20200502110350.GA3143@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Envelope-Sender: dima@koulikoff.ru
Envelope-Recipients: congdanhqx@gmail.com, gitster@pobox.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 02 May 2020 18:03:50 Danh Doan wrote:

> On 2020-05-02 07:54:03+0200, Dmitry Kulikov <dima@koulikoff.ru> wrote:
> > On Friday 01 May 2020 15:03:10 Junio C Hamano wrote:
> > > You of course can say "git log --since=yesterday.midnight" if you
> > > want to be exact ;-).
> > > 
> >   What should I enter instead --since=2020-05-01 to have a midnight time?
> 
> You can use the same syntax:
> 
> 	git log --since='2020-05-01 midnight'
> 	# or ISO-8601
> 	git log --since='2020-05-01 00:00:00'

  Thank you. Please, do not forget to mention that in the documentation.
-- 

With best regards,
   Dmitry Kulikov

mailto:dima@koulikoff.ru
skype: dima.koulikoff
phone: +49 151 6338 5032
Viber, WhatsApp: +7 925 505 2185
