Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37866C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 12:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBF520731
	for <git@archiver.kernel.org>; Sat,  2 May 2020 12:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEBMCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 08:02:17 -0400
Received: from hz00.koulikoff.ru ([78.46.42.68]:32928 "EHLO smtp.koulikoff.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgEBMCR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 08:02:17 -0400
Received: from p5b01d7dc.dip0.t-ipconnect.de ([91.1.215.220] helo=hp470.localnet)
        by smtp.koulikoff.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86)
        (envelope-from <dima@koulikoff.ru>)
        id 1jUqqU-0007dI-UU; Sat, 02 May 2020 14:02:15 +0200
From:   Dmitry Kulikov <dima@koulikoff.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git log --since=<date>
Date:   Sat, 02 May 2020 14:02:10 +0200
Message-ID: <6402621.Z0eHAnHnDS@hp470>
User-Agent: KMail/4.14.10 (Linux/4.4.219; KDE/4.14.38; x86_64; ; )
In-Reply-To: <42953119.Wv2erQna2g@hp470>
References: <3860060.ab4mYtCOl4@hp470> <xmqqd07nl3dt.fsf@gitster.c.googlers.com> <42953119.Wv2erQna2g@hp470>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Envelope-Sender: dima@koulikoff.ru
Envelope-Recipients: gitster@pobox.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 02 May 2020 7:54:03 Dmitry Kulikov wrote:

> On Friday 01 May 2020 15:03:10 Junio C Hamano wrote:

> > The behaviour is as designed.  "git log --since=yesterday" does the
> > same "as nobody said which hour and minute, we take it to mean this
> > time yesterday".

  After some consideration I still think, that the time if not set explicitly 
should be midnight.

-- 

With best regards,
   Dmitry Kulikov

mailto:dima@koulikoff.ru
skype: dima.koulikoff
phone: +49 151 6338 5032
Viber, WhatsApp: +7 925 505 2185
