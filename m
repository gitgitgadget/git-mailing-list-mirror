Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DDC1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfITUMa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:12:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53136 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfITUMa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:12:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C323805E1;
        Fri, 20 Sep 2019 16:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wFJW4yKRbfRe6NVx1UYo7ZG1lHg=; b=G0TOKh
        13ShajZFtKQhNFs/hMD4CpSMrYt9cVuH3PW3EzeTTLMq10kuEFvrGdOauRh1OGy8
        xeeMezz1+YXUnV1Dowxr00lP6jWtI+vjaCaBSzv8cBz7OldWHQz12FfZUcgQwYGI
        SdHUvVYjrYkF9SVXrj0XfrWE2Nxxfs2eKYNOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=re5BaUdBqnz7qKr5prhnn0JEMpyRMvLW
        9rITTHyYGC0LDUwb9nsUCiRU4EYPbPNYePUKIINUYIfps72ccMLN1rboUqbCUGiw
        CnCxyCACOl/Ds5VEsj1n0iFm+URLQxlrZZG9TzZR+kMrT/GYbBWhg5XvUGZD4avN
        VnyVi+HGsus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25254805E0;
        Fri, 20 Sep 2019 16:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56653805DF;
        Fri, 20 Sep 2019 16:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 5/6] midx: honor the MIDX_PROGRESS flag in midx_repack Update midx_repack to only display progress when the MIDX_PROGRESS flag is set.
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <57f6742f09820964453bb325023d44d86bca05a2.1568998427.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Sep 2019 13:12:23 -0700
In-Reply-To: <57f6742f09820964453bb325023d44d86bca05a2.1568998427.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Fri, 20 Sep 2019
        09:53:51 -0700 (PDT)")
Message-ID: <xmqqh856u3q0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F65A0596-DBE2-11E9-851B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps 4 & 5 look OK.
