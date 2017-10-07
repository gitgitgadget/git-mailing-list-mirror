Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97911FA21
	for <e@80x24.org>; Sat,  7 Oct 2017 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdJGIvM (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 04:51:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61913 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750763AbdJGIvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 04:51:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 232C3B5D71;
        Sat,  7 Oct 2017 04:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qFkUQIlg1EhfkP4M/bshwiEr5w0=; b=PFF5jQ
        DSgSeBkaYOksxlsZ9+fZHYvYdbgIB9DAqQZYnVK9YILEYni13laFzHRo0JGQbs3/
        t4Qos5EVfCWM6MvFh/Y2Njn5RrLrUsGojMkByBP469dOTZ5iJ44hRaP/Ese7vQUv
        sNDc+SUWnU0/TdAjoUoZcw9419ml/1WyTyaNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kfXi+90ggbnim7C31FonF6hSH0pqSFVo
        oBDjfPxnNPGVb+Yd3PCcjYHS2Q7L+ynZpcPK1mauh7aKla1t3D+iLSKQESTD2oFX
        iaU7b0UNymC+ZoCKn6yn/zUWHy5lGN3VaLwYvfchjVPyRFjsMZGIdSQt9d/48V6H
        hAPYTEXPaps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B2D3B5D70;
        Sat,  7 Oct 2017 04:51:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94716B5D6F;
        Sat,  7 Oct 2017 04:51:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Incremental rewrite of git-submodules
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
        <20171006132415.2876-1-pc44800@gmail.com>
Date:   Sat, 07 Oct 2017 17:51:08 +0900
In-Reply-To: <20171006132415.2876-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 6 Oct 2017 18:54:12 +0530")
Message-ID: <xmqqshevtk77.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9FA3708-AB3C-11E7-A3D0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Changes in v7:

FWIW, the previous one is at

    https://public-inbox.org/git/20170929094453.4499-1-pc44800@gmail.com

Alternatively, the References link can be followed back from the
cover letter to go back to quite an early iteration of the series.

Hope that helps ;-)



