Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077AFC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC64960FC4
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbhH0Hav convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 27 Aug 2021 03:30:51 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:56056 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbhH0Has (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:30:48 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 03:30:47 EDT
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id F2B23600004E
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 09:24:43 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id DA9A4600004D
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 09:24:43 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 27 Aug 2021 09:24:43 +0200
Message-Id: <61289339020000A100043878@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Fri, 27 Aug 2021 09:24:41 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: =?UTF-8?Q?Antw:=20[EXT]=20Re:=20[PATCH=20RESEND]=20branch:=20all?=
 =?UTF-8?Q?ow=20deleting=20dangling=20branches=20with=20=E2=80=91?=
 =?UTF-8?Q?=E2=80=91force?=
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <xmqqr1ehgq8t.fsf@gitster.g>
 <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
 <xmqq5yvsf8p5.fsf@gitster.g><xmqq5yvsf8p5.fsf@gitster.g> (Junio C. Hamano's
 message of "Thu, 26 Aug 2021 09:54:14 -0700") <xmqq1r6gf6ne.fsf@gitster.g>
In-Reply-To: <xmqq1r6gf6ne.fsf@gitster.g>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Junio C Hamano <gitster@pobox.com> schrieb am 26.08.2021 um 19:38 in Nachricht
<xmqq1r6gf6ne.fsf@gitster.g>:

...
>  * It is hopefully becoming harder and harder to check for behaviour
>    in broken repositories in a "portable" way, simply because we are
>    making it harder to corrupt repository.  We hopefully won't point
>    a ref to point at a missing object, we hopefully won't prune an
>    object away that is still pointed at by a ref, etc.
...

Maybe git needs a "--disarm-safety-belt" option that disables all those nice checks for testing purposes ;-)


