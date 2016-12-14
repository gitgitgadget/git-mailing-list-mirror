Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C1620451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbcLNBOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:14:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752738AbcLNBOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:14:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37D04577D1;
        Tue, 13 Dec 2016 20:14:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DJJTMMbpf+y+mwFjnQ5sDQe9PsM=; b=GTt9B1
        vhf5VeqGctLkJzeAQh75DWf41F1wbo/rwljMQXY23rmO88dY2SroM9lUJcE+LcRr
        p56VP5uCL2BglZWslz7Lhir6IDa78uwJBLd1ZuXrttJ/qmnclIaXEHWa79Xt4CXb
        QVh8dPNRvBB9BNUkko5Cm8IixA6/XE8q6I9w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d9s43QITIuL08TLLHoqOz23un9y9MNDG
        VEv0YtJkGrj8j+k6QRjBVDwuAy97krT8YzESMLGBpZ6dvxanAGffekMpy93GD/zX
        NERVkNDFmgiLF14XyinP9Dlqx7WlhgZB8FT5/dJ/Xa0I11ec7aZhK1qcCLYd6SkS
        KLpvQpw8TB4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EE8F577D0;
        Tue, 13 Dec 2016 20:14:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4820577CE;
        Tue, 13 Dec 2016 20:14:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] unicode_width.h: update the width tables to Unicode 9.0
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
Date:   Tue, 13 Dec 2016 17:14:36 -0800
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li> (Beat
        Bolli's message of "Wed, 14 Dec 2016 00:31:38 +0100")
Message-ID: <xmqqh967z4zn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE6CE560-C19A-11E6-952B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. Very much appreciated.
