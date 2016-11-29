Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E10D1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbcK2Tqf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:46:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751726AbcK2Tqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:46:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F17774E953;
        Tue, 29 Nov 2016 14:46:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DgTRs5DTOH9T1QVZigpZ61qYwK8=; b=JSbTm3
        VjNgBz6VVjH0zjYJ5sqOZq3We1akrIF8ZjZPW5XlWtHFb4/EgX20zk9ecDPKa1x9
        Qgts5Ru8ahVWRflVChJw8h6kxIoSmVPi6So2vmi5zZfsRWp2jtlzwONOI3n2B39W
        XN5lbv/bw4KWmbn3aWpyeiQMg4+DShQljtajQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLwAxtKUoZqm4QKWSm82W36YojEUDWZ/
        snnNRK9pmcGyNgBuIgxMlwojh+sRjrDt3CsRYEwzhN9DEr0mRMb2NBvHHdeP99gv
        lWw0WObsqG6XB3dwSwzzxbm1P2vQsUyMvQyIbNpqeplmkcmcPnLqGcx2L26PZGEf
        +4wGvYV8J10=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E939B4E952;
        Tue, 29 Nov 2016 14:46:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 804DA4E950;
        Tue, 29 Nov 2016 14:46:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Barzilay <eli@barzilay.org>
Cc:     git@vger.kernel.org
Subject: Re: gitconfig includes
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
Date:   Tue, 29 Nov 2016 11:46:31 -0800
In-Reply-To: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
        (Eli Barzilay's message of "Tue, 29 Nov 2016 14:40:09 -0500")
Message-ID: <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8760F0E4-B66C-11E6-93B2-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Barzilay <eli@barzilay.org> writes:

> So this is at least a documentation issue,...

This already is documented, and I think it is clear enough.

       --[no-]includes
                  Respect include.* directives in config files when
                  looking up values.  Defaults to off when a
                  specific file is given (e.g., using --file,
                  --global, etc) and on when searching all config
                  files.

