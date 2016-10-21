Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1B520229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbcJUWyS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:54:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933808AbcJUWyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:54:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9FE7487E1;
        Fri, 21 Oct 2016 18:54:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x9PmZJwvM55XszWepW3nCWtRB+g=; b=nAI/Js
        BbpRP08VSNWcM9NtHyxLp5hOPdiE2N0ISIMP0ez+MP95z3x8c+9c2mOGuHf7akwB
        g0H4qY6rVBhxi7PT+UBWyDlR/wJMYTWHXX98fd7qWsbqkGrSVJrn2HFIrfBcbskz
        rYFPt7ZpQGhg1ClnLvGWAGcDNND92+Hwg5+js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=buKoNpj5URyHPZ9OMInSNnin6/FkF9mJ
        qduHq2O6T2e9Tc6W7hVwwpad7fHR1dXPB1EX1tIRD4NJYZuuyETF+6+ce1sWYKeS
        wTl66E0+FlY32x2zKe+3ulL9SnPVPNA7vtkfZTlfs7+fXNnHgW4o2iCTYEZrBD8/
        EH++VOoBQTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E24AD487E0;
        Fri, 21 Oct 2016 18:54:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66019487DD;
        Fri, 21 Oct 2016 18:54:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
References: <20161020234009.1768-1-philipoakley@iee.org>
        <xmqqa8dyeebj.fsf@gitster.mtv.corp.google.com>
        <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley>
Date:   Fri, 21 Oct 2016 15:54:14 -0700
In-Reply-To: <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley> (Philip Oakley's
        message of "Fri, 21 Oct 2016 22:26:29 +0100")
Message-ID: <xmqq1sz9b9ex.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B130AEA-97E1-11E6-959A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> It appears that acciidoctor sees the art as being a separated
> mono-spaced block, with border/background as locally
> appropriate. While the asciidoc looks to simply change to mono-spaced
> text.

FWIW, I changed my mind and your patch is now queued on 'next'.

Thanks.

