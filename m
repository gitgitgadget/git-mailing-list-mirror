Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA7C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhKWQn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:43:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhKWQn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:43:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5337621940;
        Tue, 23 Nov 2021 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637685618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mc0pOcGvr34n54Q4h7Ur7RmhLdqqIruI2/WRfblAnmI=;
        b=kWrIUwaWQ4xt8nTCV1Q2OifmMvwER/LFkhMYztqypsxY1MJmETZ2ElIFn2h9zJZrn56zyJ
        7pz/16PgY9PHLzgSmnp5xa3PyvGTlQ7nnLq+5XZ9ZexCaIFm1BMtzaptChytViEEhSDSsU
        /a8rgIYj35AQwX5JYyMBN4MR1bI/8dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637685618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mc0pOcGvr34n54Q4h7Ur7RmhLdqqIruI2/WRfblAnmI=;
        b=4d2KbeoTFDCa2EnM732kEmgu9O22CZF/iSXMG5YhdEYZNHAfTeBbktfXGs6hGlCa6GcA0i
        Z7E7gdgD7NYNYADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA5213E2B;
        Tue, 23 Nov 2021 16:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V31mJHEZnWGGaQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 23 Nov 2021 16:40:17 +0000
Date:   Tue, 23 Nov 2021 13:40:15 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <20211123164015.6zkbf3xmnofykedz@cyberdelia>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia>
 <xmqqczmsi0i5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqczmsi0i5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Junio C Hamano wrote:
>Enzo Matsumiya <ematsumiya@suse.de> writes:
>
>> I'm preparing v3 with the above suggestions in mind.
>
>Thanks for an update, and thanks for working on this one.

Btw I'm on hold until =C6var's patchset is sorted out, which seems to kind
of overlap/invalidate my fix.

Sorry I couldn't follow much of yesterday's discussion.


Cheers,

Enzo
