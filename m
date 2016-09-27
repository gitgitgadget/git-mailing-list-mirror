Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9260920986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755586AbcI0U61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:58:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752586AbcI0U6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:58:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45FAD3D44A;
        Tue, 27 Sep 2016 16:58:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dpSYSQqenwUnsxIgx+ACxBY6lHM=; b=u6zSKe
        fxP8vH2N0ny2wZycGIf16FOJQWQ0BB+zv2lMK1yoLiu88IgUFXHk8Ww7Zryw8thk
        7lc+fhdZuckJPANcwiVy8cmWu9jP6ey6imhB6YE8iqw19hCYplQmHTr5PJtSbFbU
        ln3YLE6DQT6vMLKNAIbaiyrcefdBYLsLdutUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WZ/AhT2TYj6XDcRzN/5eo5jKarudu57f
        5Yia8mZE8sFHMEtGLh93rej8nx9XNIANKgKW5qRMTHwvZD1/HksZySt3oKfUk3bt
        gWnSTpVgP+L+R2odNfylNbSg2pSNK0QCOmoOQMCdU6HSDNZGEmi62pGs5OKAusie
        Qh5qyOUQbhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E3833D449;
        Tue, 27 Sep 2016 16:58:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA5E03D448;
        Tue, 27 Sep 2016 16:58:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
        <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
        <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
        <20160927205202.GG32565@google.com>
Date:   Tue, 27 Sep 2016 13:58:21 -0700
In-Reply-To: <20160927205202.GG32565@google.com> (Brandon Williams's message
        of "Tue, 27 Sep 2016 13:52:02 -0700")
Message-ID: <xmqqh991m55e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 210E16BC-84F5-11E6-B54F-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> my mind is drawing a blank, what does the 'lf' in 'lf_to_nul' stand for?
> line feed?

Yup.  "man 7 ascii" ;-)
