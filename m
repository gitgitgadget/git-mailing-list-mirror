Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2AB1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLESV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:18:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLESV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:18:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F3F71974D;
        Mon, 11 Nov 2019 23:18:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xqnDvVPSDDiE3z2tq7rcPc/I5Ao=; b=wlJc9r
        1sxo/PY56mgfCkFNJdxf/SD937WoayQbj6hm+kKaeHrMhKACPLsgrkPHa9AYdCON
        8dkJElNcbc6WLBG2+stJOe5uTsb0q2uoH5MDk6m65V/Ol6ZKMh5cClYI9e9rmaLB
        OYi7XvY0pzxJA3LeQvwecwmqemVq+2UMSD/vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yB2OJKIWGQhQihvaqmFYAD3snUTdRhNg
        bNbCtF2fZiP3MzE6wAoCfPjpc0TLYK2Joc05ka3sLeGU2qAtp+JPQvNwVNw9CDRL
        ZsAMO5MAx+hWbKBACxyvwRS3qcPdNMi4/2AcepGlr3LwqAv6/C8S+IHEYIlp4uJX
        aHPbnMQXq/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76DDC1974A;
        Mon, 11 Nov 2019 23:18:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D764719747;
        Mon, 11 Nov 2019 23:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Naveen Nathan <naveen@lastninja.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] doc: improve readability of --rebase-merges in git-rebase
References: <20191110095942.GB6071@a.local>
        <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
        <20191111232137.GA29586@a.local>
Date:   Tue, 12 Nov 2019 13:18:17 +0900
In-Reply-To: <20191111232137.GA29586@a.local> (Naveen Nathan's message of
        "Tue, 12 Nov 2019 10:21:37 +1100")
Message-ID: <xmqqy2wlg22e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B0B90A-0503-11EA-8901-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naveen Nathan <naveen@lastninja.net> writes:

> When --preserve-merges was deprecated in 427c3bd28a a sentence
> was introduced describing the difference between --rebase-merges and
> --preserve-merges which is a little unclear and difficult to parse.
> This patch improves readability while retaining original meaning.

I notice that the above also was rewritten since v1 and I think it
is a very good change.

Thanks, will queue.
