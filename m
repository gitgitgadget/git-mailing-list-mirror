Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECFD2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 06:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdJDGUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:20:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751148AbdJDGUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:20:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 476B496B5C;
        Wed,  4 Oct 2017 02:20:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2pYldjvPfQLZszQ6odBLeWPq9C8=; b=LNZ1m5
        4kXMQM2HEbF8Mjd+tPHejVQTDPh2CbWh8+Kh1UbJVTEk4B16YetWHWR9AjQMQBk7
        Ly+U+DYKAcbJO9qhkwyGId3GrVuUsigmxf43uhNNwlfW/MrhDKcnSptm8QP+Eiv+
        3bUukf3ogpMR24Fdd+evqOM5TCBcnGOBqGrKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D7Ms2CE6kYGCsOdh8fqc678khZvaQtPG
        uzZNWr+pGTRnxvh5tgp1+y7ttEVkb2ZTdxsYQpH2Ca2dKJXXd9RDMcfymsoRHCHe
        01CHfNIAB5gidOwkdZlIOl2uXDMJGGdRQ2TWPRAGim2FxAnYKyt82khfcHm/0L04
        G7bmYTYdRjY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E74A96B5B;
        Wed,  4 Oct 2017 02:20:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8315396B5A;
        Wed,  4 Oct 2017 02:20:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 00/10] protocol transition
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
Date:   Wed, 04 Oct 2017 15:20:50 +0900
In-Reply-To: <20171003201507.3589-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 3 Oct 2017 13:14:57 -0700")
Message-ID: <xmqqh8vfcu2l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B962E0C-A8CC-11E7-8B30-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  All of my review comments from the previous round seem to
have been addressed, so this is Reviewed-by: me ;-)

