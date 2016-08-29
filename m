Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3B91FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbcH2SSN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:18:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753671AbcH2SSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:18:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52E4838A73;
        Mon, 29 Aug 2016 14:18:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fVDPfgx35RVi
        1NjAmQjYUTucTD8=; b=HCFZ/IOLLwOML9dKAQS9DbROPNQGPkJKJPe/xLxHAsFe
        T4chqxWM9WZwut4FPXTcDV3QwPdv8D1HEOSYSYAWYdydGYVBm1doPPKiJU9tNJA6
        sJcxE+DwfQzT10Bn2ZVDKFsQXTWTodZdaCUDehsn9N+8fTafFgP98SoQlravY5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pdqe8G
        WiX2R2nMTWfr0iUPFdqvF6JsMxhcySfdN9ERb7+n1ifdzWHbnDgHD+k9sXbT+36X
        iMzwSYuMJlYGFWSTJleSvGbz7cAWG0fxuJY5fBPBB/upKK7dDtHIwXfjqHS844WF
        06sqY3Hx84BXRjAIv8uTtXD6wBJBb/wfgmSA8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4983338A72;
        Mon, 29 Aug 2016 14:18:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6E4938A71;
        Mon, 29 Aug 2016 14:18:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        hvoigt@hvoigt.net, dev+git@drbeat.li
Subject: Re: [PATCH] Documentation/SubmittingPatches: add quotes to advised commit reference
References: <20160826222714.31459-1-sbeller@google.com>
        <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
        <0a480dd8-186f-8411-3f9b-371a4628b342@gmail.com>
Date:   Mon, 29 Aug 2016 11:18:08 -0700
In-Reply-To: <0a480dd8-186f-8411-3f9b-371a4628b342@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 27 Aug 2016 10:04:02
 +0200")
Message-ID: <xmqqlgzfbfrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F14F504A-6E14-11E6-979C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 27.08.2016 o 00:42, Junio C Hamano <gitster@pobox.com> pisze:
>> Stefan Beller <sbeller@google.com> writes:
>
>> -- >8 --
>> From: Beat Bolli <dev+git@drbeat.li>
>
> ???

The primary value the change adds is to make readers aware of the
gitk feature.  That comes from the primary author.  Not something I
added, Stefan added or Heiko added.
