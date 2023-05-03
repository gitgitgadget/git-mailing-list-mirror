Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE5C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 07:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjECHP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjECHPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 03:15:55 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F740F3
        for <git@vger.kernel.org>; Wed,  3 May 2023 00:15:46 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 6235D241BA;
        Wed,  3 May 2023 03:15:45 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pu6iH-jYk-00; Wed, 03 May 2023 09:15:45 +0200
Date:   Wed, 3 May 2023 09:15:45 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: rectify empty hint in call of
 require_clean_work_tree()
Message-ID: <ZFIKIXF+nOoC+U1D@ugly>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
 <ZEorMhPZRL/w4yKM@ugly>
 <xmqqmt2thvuu.fsf@gitster.g>
 <ZEr4VKMPSYZZxgIM@ugly>
 <64515cff45e03_1ba2d29458@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64515cff45e03_1ba2d29458@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2023 at 12:57:03PM -0600, Felipe Contreras wrote:
>Oswald Buddenhagen wrote:
>> if i wanted to be super-pedantic about it, i'd assert that non-null 
>> strings are non-empty.
>
>I would disagree. "" is empty but not null, not just in C but in many
>other languages, including shell.
>
yes. that's kinda the point the assert would make.

-- ossi

