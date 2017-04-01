Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B30A20958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdDASQz (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:16:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61600 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751915AbdDASQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:16:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 421F98B95F;
        Sat,  1 Apr 2017 14:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=xPuNth
        kTual+SF5TN1WlA/hnIroe4TFkJafp8JbEPkbRkMmeWTxndOAZt/FZDhyfKnNo8y
        LJ4I8L12xwkAX2ob5VfZDFc74Wc2JrRqT3/6beWHQ7oOahItzo1CSgfws2nQQWeL
        5OLaFJWbor+RrsMwOjQm2WaOPnXKtP5wCtX+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p2qqa9vLsWJ/gWHUJDrDXri6Qzy3rRsi
        G0TbeCvBDYnavypb6lOxaMNcenbmV+E4qEhSPbyMe6DK/8QhfAWx3GBim7KQ46cI
        qprv5nVKfQcFGLHHzgy46uz+mTLYtFJFBE1ruj+r07K5ZPAk3e46IVoxaJvPQdYg
        wuEKsQwD/iY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38A988B95E;
        Sat,  1 Apr 2017 14:16:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EAB88B95D;
        Sat,  1 Apr 2017 14:16:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mostyn Bramley-Moore <mostyn@antipode.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: improve git ls-files -s manpage entry
References: <xmqqpogwx3yr.fsf@gitster.mtv.corp.google.com>
        <20170401070825.8033-1-mostyn@antipode.se>
Date:   Sat, 01 Apr 2017 11:16:43 -0700
In-Reply-To: <20170401070825.8033-1-mostyn@antipode.se> (Mostyn
        Bramley-Moore's message of "Sat, 1 Apr 2017 09:08:25 +0200")
Message-ID: <xmqqfuhsuh6c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D3EC6A0-1707-11E7-ACF1-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
