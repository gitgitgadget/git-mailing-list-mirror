Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13ECF1F461
	for <e@80x24.org>; Sun, 19 May 2019 01:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfESBcs (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 21:32:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55650 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfESBcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 21:32:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D3D115F2F0;
        Sat, 18 May 2019 21:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhptDEAYi96XlEl28jkuDVJM21M=; b=tBGG0R
        QN7QIxJS3bl5NKOIKU/mq4lRMXU0DbdqeyH7fJAgxdwIbUwYPq4Q6+dQkSZeBOcc
        SE6SmMxQAE+eUvvau1rKWpDLkzpyLP2vDDoHdcksz7TFIP3pNtl5VDIqwpK25gOR
        YCDKa+KXFDC/Q3fteVozJyNn8ODS2tVelP38o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SKI2h98fkBFx1LoGLjyrjvl4TAvqZYD+
        CcwcNR81qYKmlCI6vfh4ycCQDuFzMNfhdB4TfJ7LX/5oVLBogK8wZSJQHG10w0qu
        TqhiN6eDbY0CoV7bVBeUT9k2HbDXgZ3nQkbCYKZ6E2cexwcVJlZSmY1aLWtfcHFS
        HJvmjN9naNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9406215F2EF;
        Sat, 18 May 2019 21:32:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0838515F2EE;
        Sat, 18 May 2019 21:32:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] rebase -r: always reword merge -c
References: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
        <20190502102249.9071-1-phillip.wood123@gmail.com>
        <nycvar.QRO.7.76.6.1905170855000.46@tvgsbejvaqbjf.bet>
Date:   Sun, 19 May 2019 10:32:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905170855000.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 17 May 2019 08:56:42 +0200 (DST)")
Message-ID: <xmqqwoin1b5w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0089A694-79D6-11E9-9410-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think this one fell through the cracks (at least I failed to find it in
> `pu`),

Thanks, I think I was waiting for an Ack or two, but then the thread
was buried.

