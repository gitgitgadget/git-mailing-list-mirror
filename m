Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56CF20986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbcJDW6O (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbcJDW6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E284743EF0;
        Tue,  4 Oct 2016 18:58:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KtAW245Frb2c
        MTENfitTkv1oVmc=; b=lbUIuePS8V38lf4JizAypETNdh4ZEV9JAEvDaW00bspp
        Dt0B5jEzx/SyVk+8OHEyrKWB2uYgKHybstIANl6shCpz4CADikb7UhpkU9ffARrT
        VKwibJQpolmQizTaLKFzBDf7zmeigvu7ladv+aWJjtGKx4A/wRP95XO67wsmptI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qpx/lh
        tHumNzoBfQfUX+gy98tuBOp+r2swwqzGF8Y84Q6Yc6p9ohMfhqh4+veskT8ldkeU
        lmGJsuPwIhoSSP9yNSDpOk6mTbufuff6CHdbtN9N4JRFFwKiGjJF4WYT4HUVQVP3
        HZm6BO0fI6BE2E6+A4uoYkfO/7bVOhmT9HiPU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB5A743EEF;
        Tue,  4 Oct 2016 18:58:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7899C43EED;
        Tue,  4 Oct 2016 18:58:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     ern0 <ern0@linkbroker.hu>
Cc:     git@vger.kernel.org
Subject: Re: GL bug: can not commit, reports error on changed submodule directory
References: <CALhephTkohVhEjdP7TwQAcBrEBiHGtp0Hd+UxPUiJHtubMWKGA@mail.gmail.com>
Date:   Tue, 04 Oct 2016 15:58:09 -0700
In-Reply-To: <CALhephTkohVhEjdP7TwQAcBrEBiHGtp0Hd+UxPUiJHtubMWKGA@mail.gmail.com>
        (ern0@linkbroker.hu's message of "Tue, 4 Oct 2016 12:40:22 +0200")
Message-ID: <xmqqy423rabi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 062A8DA8-8A86-11E6-9024-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ern0 <ern0@linkbroker.hu> writes:

> When I say:
>  $ gl commit -m "blah blah"
> It reports:
>  =E2=9C=98 Failed to read file into stream: Is a directory

Not that I am interested in learning the answer to the question, but
what the h*ck is "gl"?
