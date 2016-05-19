Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=5.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,FSL_BULK_SIG,HEADER_FROM_DIFFERENT_DOMAINS,PYZOR_CHECK,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29FA1FA7B
	for <e@80x24.org>; Thu, 19 May 2016 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbcESPSz (ORCPT <rfc822;e@80x24.org>);
	Thu, 19 May 2016 11:18:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754140AbcESPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 11:18:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32A231B2FC;
	Thu, 19 May 2016 11:18:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uoq1oCgLlTqpdDX/iUbLy7J1Wic=; b=qGVO0q
	LogaZ3/sL5FacB08XnvMfwoc0x2mNwInqePTwsywWiEK/Cf6G5kn+A0aO0CQgsYW
	TN7GUM2cp1CYiWKg4Rioe5Z8meqx7HOoj/JqGxauj6HdKBa+8vYBpaohs8xVqZu2
	pSS4OuXnHtmLayIlLdPBcmdRxFrAbYIwKAXfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i81hIjjE9F2WK9c05QJLweOaDX1L4I6Y
	eHpt+74qLixM2a/R0t0y/2Djw17eI7Jl+dW7mZFfaASiWikilX3V7/qqRuxdqbxB
	/bGbam0kvY1JgxfICIPYA+PPJWiizGts61XZxGXYHJ0kWHZ0ultNK3IGaUPFJIPW
	zxW3PMA4po0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B5F71B2FB;
	Thu, 19 May 2016 11:18:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAF431B2FA;
	Thu, 19 May 2016 11:18:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: Confusing --graph --all output with detached branches
References: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
Date:	Thu, 19 May 2016 08:18:51 -0700
In-Reply-To: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
	(=?utf-8?Q?=22Bj=C3=B8rnar?= Snoksrud"'s message of "Thu, 19 May 2016
 15:45:46 +0200")
Message-ID: <xmqqzirmoz38.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: FF6F4260-1DD4-11E6-B5D8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

