Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D5520986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbcI0QC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:02:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751519AbcI0QC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:02:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BC363BFBD;
        Tue, 27 Sep 2016 12:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GWMctlVCcgClDEnZ57C8yKTp1SY=; b=C+n0kF
        Z04iIDC7P+kcg8GDJYXxB77x8YE42+oB86+HTWFR5mOEr9oTxgOEd9atGFghdq6J
        hwSgDZga+f8Mdyyd1O4+LHRpVro5Y8yz3lnrQgd8cXoEQpaRV5IOrJkxRFmoarpu
        UgZQBA8W9logf1E/Ug5Ciaas+J97w2EaENY18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ehvJr94xAYhf17DrS+AvMoVUhengxC8Z
        kMaKEq522FhxZNbbqswFi/RTaZIT0Dw2xBd2goUpiQZ2Jbm15bT5qsXAYj9ZKRTC
        6Fi+f9FI0QUrZA8wggPkFoX5j2q5QDlY63e4k+148o+m91uHX4/Hl5XS+6UpZSYu
        27jlELw3p8Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 827E43BFBB;
        Tue, 27 Sep 2016 12:02:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 040903BFBA;
        Tue, 27 Sep 2016 12:02:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: git-upload-pack hangs
References: <66A60DA77398CD439FA676CEF593977D692508@exchange.1.internal.pdinc.us>
        <62E3FC352BE4428A90D7E4E9B137A9FB@black7>
        <50DEA1C222E449F59BC8488C921D6F95@black7>
Date:   Tue, 27 Sep 2016 09:02:23 -0700
In-Reply-To: <50DEA1C222E449F59BC8488C921D6F95@black7> (Jason Pyeron's message
        of "Mon, 26 Sep 2016 23:45:19 -0400")
Message-ID: <xmqqlgydqqk0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8042E40-84CB-11E6-8F7D-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> This is a very, very first draft.
>
> It is allowing IIS to work right now.
>
> I still need to address chunked issues, where there is no content length (see http://www.gossamer-threads.com/lists/apache/users/373042)
>
> Any comments, sugestions?

Does this have any relation to another thread earlier this year,
which seems to have ended here:

https://public-inbox.org/git/20160401235532.GA27941@sigill.intra.peff.net/

