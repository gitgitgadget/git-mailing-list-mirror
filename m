Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78819C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6BC20714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NAffsdcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCQWFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:05:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51469 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCQWFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 18:05:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C2CAC5E66;
        Tue, 17 Mar 2020 18:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=McOIgh2zAwmh+CJqFwoRyJRtwPE=; b=NAffsd
        cfYJPAAi0x9uzhWqi4uuHMsriQB82IfniiYhZ3PUC0R0OsJ74vFrLPuNlGT2ewMr
        08H71LRC38+kCqTMD6wV6zh8qV07tSda2DBoSV6T1LSKacZV4RWtDw1iqEYxzcN0
        FSsaOJQQiFocd+7kCR5qVH98uVFjLzuZEDMLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yeYSs+FO/9J5NtWhVuRmmorPEVc5Q5S1
        167UlCoPfhiXNVxE6kMNRh5POQEoQISPAjOvhez1v+AwpNpUkHx1ZI4pr25lNANh
        Su9FZd0cAgTBgNAJ7oxl3dlwa1HQ2Ms6LPXO1DUmPjSkI7EqzBfTJMiryvrMwys5
        CHQIHtIm48g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94CE8C5E65;
        Tue, 17 Mar 2020 18:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C625BC5E60;
        Tue, 17 Mar 2020 18:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 13.0
References: <20200317153605.1177454-1-dev+git@drbeat.li>
Date:   Tue, 17 Mar 2020 15:05:13 -0700
In-Reply-To: <20200317153605.1177454-1-dev+git@drbeat.li> (Beat Bolli's
        message of "Tue, 17 Mar 2020 16:36:05 +0100")
Message-ID: <xmqq4kumiqna.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61CCF1F4-689B-11EA-B950-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Now that Unicode 13.0 has been announced[0], update the character
> width tables to the new version.
>
> [0] https://home.unicode.org/announcing-the-unicode-standard-version-13-0/

Thanks.
