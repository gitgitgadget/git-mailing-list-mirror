Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C3C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8861820857
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKTAdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:33:19 -0500
Received: from pug.qqx.org ([50.116.43.67]:45424 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfKTAdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:33:19 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 19:33:18 EST
Received: by pug.qqx.org (Postfix, from userid 1000)
        id EDE212FFFC; Tue, 19 Nov 2019 19:27:29 -0500 (EST)
Date:   Tue, 19 Nov 2019 19:27:29 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] wt-status: show amended content when verbose
Message-ID: <20191120002729.GG4444@pug.qqx.org>
Mail-Followup-To: Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20191116161856.28883-1-me@yadavpratyush.com>
 <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com>
 <xmqq4kz13k8p.fsf@gitster-ct.c.googlers.com>
 <20191119145632.xi6zebglzu4lbgcq@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191119145632.xi6zebglzu4lbgcq@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 20:26 +0530 19 Nov 2019, Pratyush Yadav <me@yadavpratyush.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:

>> > It too makes quite a lot of sense to allow readers to see what the
>> > 'amend' did, but that is not something that would help write the log
>> > message.
>
>It would help _amend_ the log message though.

Indeed. Another possible use is for sanity checking the amendment. I'll 
often look over the diff in my editor as a final check of what I'm about 
to commit, and when amending a commit I think I would find it helpful to 
be able to review the changes being amended separately from the full set 
of changes.
