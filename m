Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4470820193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935233AbcJ0RCu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:02:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934208AbcJ0RCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:02:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 665FC49291;
        Thu, 27 Oct 2016 13:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5/sToB7aJdhb46T74KijLEIVenY=; b=k8xy60
        hiEMFv1nEd+611dllgYrNv4UPHrJUz364I62LLoMvnZhjVhKk3BQbXKCXMjsVzcT
        pcUq/kuoVCE+VKA8TzkKiYvGGbwW09n/Hmwr7AnwUKqWzo8AU887esfrKAUmznct
        dCETfxMlUJjnpja3HJvIv+3nDLeO/A2cpBpGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wnVkJ+U76/AKiDwg7Bz7M2hxh2KOl0PS
        mFeXApa8Ok7oNlea3yHKjN5mCXsrnP3TqNoHOAkON7jZYAJL/e2RdpV3RIsp4LFw
        mAz0iu5Bxxm5kekuqEN47DxZ9fIb5YPtDMSrcB6oMCS/UeQ6cpeu0s9jGUnhz17u
        5KV9ivLjkXs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DA7949290;
        Thu, 27 Oct 2016 13:02:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C70CA4928F;
        Thu, 27 Oct 2016 13:02:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     tboegi@web.de, Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/2] Stream and fast search
References: <20161009095649.1886-1-tboegi@web.de>
        <20161012134724.28287-1-tboegi@web.de>
Date:   Thu, 27 Oct 2016 10:02:45 -0700
In-Reply-To: <20161012134724.28287-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 12 Oct 2016 15:47:24 +0200")
Message-ID: <xmqqr3717miy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FC3FB84-9C67-11E6-9358-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc'ed those who touched convert.c or read-cache.c in our relatively
recent past with a change that affects the eol conversion codepath.

Does any of you (and others on the list) have time and inclination
to review this series?

Thanks.
