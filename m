Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CA21FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 21:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbcHZU7w (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:59:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754030AbcHZU7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA5913966D;
        Fri, 26 Aug 2016 16:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=doNH4bnza4tsKtPykgOG9ldEKR8=; b=YQZPtH
        zXldq8CXR0S0EIvoB7zV/DEWZN0TCybbsdmZE1lz5ekijdIu63GHJiBpErMpOl3n
        P1GgTStwEPe/lpQEghM6jeKcmi/pW953TBnwa3o4p/ZiqcbPNk+br5XFchNuueI6
        w0Hj40hHdLOcFcm4l60XKV36Q5SbXviUHVK5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SJj1qOCVg4/P56Un/8gJNjIP4zRaQ4hm
        Bf/7abGzCrffPhBZj07qV0xlFAKaYN6gzaYCArCLQrVKEMcotmlmpDL6Ky5K2aP7
        cZ6SFPtUOn+SZMHRconogaZlg+lBcnSpIkubYW+D6zaQ2RnFQhAxUnfPNXLruODz
        5+W0VpFPozc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1D283966C;
        Fri, 26 Aug 2016 16:56:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B26E3966B;
        Fri, 26 Aug 2016 16:56:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 15/27] bisect--helper: retire `--bisect-clean-state` subcommand
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6c6-60f4f6c2-9c39-4840-bbbf-18902961d57f-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Aug 2016 13:56:36 -0700
In-Reply-To: <01020156b73fe6c6-60f4f6c2-9c39-4840-bbbf-18902961d57f-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqq37lrfdvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94E645BC-6BCF-11E6-85A1-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> The `bisect-clean-state` subcommand is no longer used in the shell
> script while the C code uses `bisect_clean_state()` thus remove the
> subcommand.

Good.
