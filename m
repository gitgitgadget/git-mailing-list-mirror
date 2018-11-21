Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C851F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 00:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeKUKcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:32:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59367 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeKUKcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:32:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 472DF308EF;
        Tue, 20 Nov 2018 19:01:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+1cD/ysvcqm/7aijrWLiqujdmdI=; b=ejDPdT
        oLOwcxlh+/orFJN/6dbV5cHJ0SQf7evTmI78zFsPJLt1I6ACfnwFtDpRpWkYCkCN
        gB8Z0iKpF9q2yjWs15OBWCqGo9Ay2QHqLTo9eNEK9lmWVvWM8mHSpw5sDya0f/Bz
        yxzSUvZ4Znp78QtbKyFsqXvFyR4SrjDJvBzJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NYZ0Fa8jG5JeKX5dofAwSkyDexZh7aBp
        TRAGU7LWodEsINkY778pooFHs5Z5ERCzybiWdb1KNNpSvQgju2PMDUoVGhlZxWuJ
        t/VlLgQmWWW8ydmisHBxj1m8akd3YFe1ZVrZ4ZKJcrR6Zo2WBmsSw72d5GcMfx2o
        8n73atafxIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F924308EE;
        Tue, 20 Nov 2018 19:01:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5260D308E9;
        Tue, 20 Nov 2018 19:01:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org
Subject: Re: [PATCH] .mailmap: record canonical email address for Sven Strickroth
References: <15b7df69-25d8-c168-dd43-a43b7fee23d2@cs-ware.de>
        <20181120215803.GA149929@google.com>
Date:   Wed, 21 Nov 2018 09:00:58 +0900
In-Reply-To: <20181120215803.GA149929@google.com> (Jonathan Nieder's message
        of "Tue, 20 Nov 2018 13:58:03 -0800")
Message-ID: <xmqqlg5n9u4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8789F40C-ED20-11E8-BED7-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +Sven Strickroth <email@cs-ware.de> <sven@cs-ware.de>
>
> Is the above line needed?  It's not clear to me from the commit message
> what it does.

Stare at it once again and you'll see ;-) FWIW I needed to do that
myself before you had the same issue.

Sven is trying to hide real-name name and have a bland token that
would leave the least amount of impression to the recipients there
instead, i.e. "email@add.re.ss".
