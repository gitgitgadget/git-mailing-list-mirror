Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2574B1F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 01:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdKLBx2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 20:53:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752450AbdKLBx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 20:53:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4D2CB4C6C;
        Sat, 11 Nov 2017 20:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/MlHQQTbSgRof7bL3upjRxvM/98=; b=xqsyrB
        0UrqzJNCFsz5VJteEP1TfHWyT3E4oRXf1Efj1oWmSmZOJIQs6EMpvfx25tkWgPAl
        CpckOdHCPx/SADQIIJ72pUIFUISHhE3a/c7ZMRnKepxdH2AIlpBkS7TE1g17RWVE
        6N1MC9GLI0NQvk4CA6Rra+N0JH2fv3oYtykU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlSZHuBj0Q2jXbcTbRVNNdJBpy7wcMpj
        VtICZn0vh0CI8+kCJLF0oQq+QuwgRQ4flzG81iZbLw8W8DCUbmaM5iimGXYhQynK
        6jlY1OVsrpknPhNsWY614JuGmPpTHaANusoJzKFtSRg4kn31RMh+IXbCeZcpKXA4
        4rtrMOpoPoU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD44DB4C6B;
        Sat, 11 Nov 2017 20:53:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E473B4C69;
        Sat, 11 Nov 2017 20:53:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerzy Kozera <jerzy.kozera@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Strip CR chars for Windows gpg2
References: <20171111160657.11016-1-jerzy.kozera@gmail.com>
Date:   Sun, 12 Nov 2017 10:53:25 +0900
In-Reply-To: <20171111160657.11016-1-jerzy.kozera@gmail.com> (Jerzy Kozera's
        message of "Sat, 11 Nov 2017 16:06:57 +0000")
Message-ID: <xmqqmv3scley.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F7429C-C74C-11E7-A007-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerzy Kozera <jerzy.kozera@gmail.com> writes:

One minor detail I missed:

> Subject: Re: [PATCH] gpg-interface: Strip CR chars for Windows gpg2

Please downcase "Strip" (see "git shortlog --no-merges" for recent
history to notice that it would make this commit sit better with the
existing ones).
