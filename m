Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF4AC433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 21:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiC0Vi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0Vi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 17:38:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1625338A0
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 14:36:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2875A187BCF;
        Sun, 27 Mar 2022 17:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qy5pqnaHAODuBsxPRJW/nYprzaJ8+KvZOV5J5F
        mc3JU=; b=WZReRerqLfP3RPQ5TUldDCPONkVXfJz/pfRApqFWBxd3yzgk95ufiN
        gSIdjNvRhzH86HPae5UK4TW4By4kL8WZSyV9O0LV9LHfsD29Z/bLRz9xxjJkUlfi
        rYObv+VJeQ05JorzcXp6OBn4s9ERJiAa1xyXL6SEjwMihQO6lL7Iw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2010B187BCE;
        Sun, 27 Mar 2022 17:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84680187BCD;
        Sun, 27 Mar 2022 17:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v6 1/3] vimdiff: new implementation with layout support
References: <20220327112307.151044-1-greenfoo@u92.eu>
        <20220327112307.151044-2-greenfoo@u92.eu>
Date:   Sun, 27 Mar 2022 14:36:41 -0700
In-Reply-To: <20220327112307.151044-2-greenfoo@u92.eu> (Fernando Ramos's
        message of "Sun, 27 Mar 2022 13:23:05 +0200")
Message-ID: <xmqqv8vz5b86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE4C1A34-AE15-11EC-9001-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see these from "git apply".

<stdin>:102: trailing whitespace.
debug_print () { 
<stdin>:114: trailing whitespace.
	# 
<stdin>:132: trailing whitespace.
	LAYOUT=$1 
<stdin>:133: trailing whitespace.
	CMD=$2  # This is a second (hidden) argument used for recursion  
<stdin>:159: trailing whitespace.
	#   - AFTER :  ( LOCAL , BASE ) / MERGED 
