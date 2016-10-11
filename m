Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C419D1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbcJKVtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:49:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60985 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753058AbcJKVtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9873467D3;
        Tue, 11 Oct 2016 17:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VH+uWeamAOn1fLyS7F2CGwb5gjs=; b=cmOqBL
        QVzeKjV1q/G2po4dcFyCD5HNJnBzpBOQsdf65e7c07DrfNrKIUe+Tx2rsaGUcy7b
        yxSCHhLel2wfr7tkYDxuApddur5Z8kQNCZdS3hY06hzyS1P6RVsY4Jj9id84Zx+m
        8plz7VTd4o17qiO9ACoQ6EY0npiipyBYZ85R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vQ6QxTk18yx+Cq1zHWr+ecrXrhiXbjn/
        YK/u8KxPdBOx8R3a/9GrmcCXxexiGsqMGLFykFSALdHNdip5iDP6zEiFdlbXl3nE
        iXxEFcl/tkQiKGpG4nVv4KrsXY6kCAiUNB0GkrnmDGI5mEuNaUA7DcJ0Y6PXxZYS
        fXn2MTFFaxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1662467D1;
        Tue, 11 Oct 2016 17:49:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3297E467CF;
        Tue, 11 Oct 2016 17:49:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support `git reset --stdin`
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net>
        <xmqqshs28z52.fsf@gitster.mtv.corp.google.com>
        <20161011212644.zzqidtcgatu3qsei@sigill.intra.peff.net>
        <xmqqoa2q7elc.fsf@gitster.mtv.corp.google.com>
        <20161011214713.y2fpjkrx6sspks4a@sigill.intra.peff.net>
Date:   Tue, 11 Oct 2016 14:49:36 -0700
In-Reply-To: <20161011214713.y2fpjkrx6sspks4a@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Oct 2016 17:47:14 -0400")
Message-ID: <xmqqfuo27dzj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B590D02-8FFC-11E6-944F-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Anyway, the existence of this discussion is probably a good argument in
> favor of Dscho's patch. I was mostly curious how close our plumbing
> tools could come.

Sure, in 100% agreement.
