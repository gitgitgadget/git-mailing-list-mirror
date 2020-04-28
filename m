Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3553C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D62206A1
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgD1SA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:00:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgD1SA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:00:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7647AE30;
        Tue, 28 Apr 2020 18:00:57 +0000 (UTC)
Date:   Tue, 28 Apr 2020 20:00:56 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fetch-pack: return enum from process_acks()
Message-ID: <20200428200056.6fb5dd6b@naga.burning-in.hell>
In-Reply-To: <xmqqftcn4klg.fsf@gitster.c.googlers.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
        <cover.1588031728.git.jonathantanmy@google.com>
        <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
        <20200428005333.GE36078@google.com>
        <xmqqftcn4klg.fsf@gitster.c.googlers.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Apr 2020 09:54:19 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >>  	/* return 0 if no common, 1 if there are common, or 2 if ready */  
> >
> > This comment can be removed now, which is a nice bonus.
It is still present in the pu branch.

Is there other branch where I should look?

Thanks

Michal
