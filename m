Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238CB20323
	for <e@80x24.org>; Thu, 16 Mar 2017 16:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbdCPQrr (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 12:47:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51864 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753095AbdCPQrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 12:47:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FD2668DA2;
        Thu, 16 Mar 2017 12:47:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LZriExLDLPOnhF/rbk8qEpRyWBg=; b=jpOy38
        gGo2l1dWcDqaqPNPeW0aAN0HNNE8P01VSOy0KInNeYglFDIYwGnjT/xSVEsZUgod
        /kgnidNa5ES1Hw8SucBMjAD2SxaVBIGwNP+uhsaVkIXytFvAvBE11U8T4YHp7221
        tZ1v0psDVnOOEDVIkX6I6tz0+GaJ2SWbYHrQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oN7yYxNqLnPBIDyRnu6U0zLa2w5UbHpt
        eUMQlF+t/FMCyuNuqZrv0UkDFQlt9SetuozYKVCb1AlA/qKJPcdKztnBWpohxgb/
        5FpTt1YRHgLYefm2PenSHOFq7xGAROStCGuRAf41pEgEmQpLsPtrWZPzmlAVn/ic
        kkMGlS8ohUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3870368DA1;
        Thu, 16 Mar 2017 12:47:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7F4068D9D;
        Thu, 16 Mar 2017 12:47:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 09/10] submodule--helper init: set submodule.<name>.active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-10-bmwill@google.com>
        <xmqqinnbiqzs.fsf@gitster.mtv.corp.google.com>
        <20170315224604.GG159137@google.com>
Date:   Thu, 16 Mar 2017 09:47:14 -0700
In-Reply-To: <20170315224604.GG159137@google.com> (Brandon Williams's message
        of "Wed, 15 Mar 2017 15:46:04 -0700")
Message-ID: <xmqq4lytcgod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36014686-0A68-11E7-B4B0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> So if we did
>
>   git clone --submodule-spec=lib/
>
> then each module under 'lib/' won't have their submodule.<name>.active
> config set since submodule.active=lib/ already encompasses them.

Ah, OK.  That removes my worries ;-)  Thanks for an explanation.

