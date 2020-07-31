Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A0C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9047A20829
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JbCUb2Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgGaCMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:12:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58504 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 22:12:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DE8EE2631;
        Thu, 30 Jul 2020 22:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GuP94tCgTxO59QEMZuJbQRS/5ug=; b=JbCUb2
        SpgRJ0fB4XvGAbLdC5stWiWSQg6t6hebLOE58WRCZLNaCiFG1o2Qg1+YetVP3iSB
        dtBWoET2FI2SapZc/WRdhwNF+1kF4m//1WHiXoPdiSNOGQ768FWwZuB4/9voCIDK
        oTVeUmcGBM1IdqxPyQeFDx3lihdzF1H+QH1Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xsKXjmBAYyVDrFJgbieocvAn02KMp+ao
        p2f5LozPOiX64N6qKmCGnIVCOU8TObnb5IBectO+fp5CzoJA1unEwWZJDr3H31gM
        yeEG2FJ7mCYZjCEsWAsFaE5m6THh7oPjNpCSH8bEjOvkIp3z5LZ+arHz1kYm70S3
        2OWBu+cN91w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65733E2630;
        Thu, 30 Jul 2020 22:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACB4AE262F;
        Thu, 30 Jul 2020 22:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Bram Huenaerts <bramhuenaerts@me.com>, git@vger.kernel.org
Subject: Re: Git union issue
References: <A7C11212-1ECB-4D8D-B3B1-C7DB6673F3E6@me.com>
        <20200731010541.GI6540@camp.crustytoothpaste.net>
Date:   Thu, 30 Jul 2020 19:12:09 -0700
In-Reply-To: <20200731010541.GI6540@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 31 Jul 2020 01:05:41 +0000")
Message-ID: <xmqqpn8c4eme.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DEF061C-D2D3-11EA-A413-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> folks will be more likely to read your message.  (I was personally
> surprised to see the list accepted PDFs; I did not think it would.)

I am surprised too, and immediately after I saw *.pdf attachment, I
discarded the message to the trash, thinking it is a phishing attempt
or something similar.
