Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4473020705
	for <e@80x24.org>; Thu,  8 Sep 2016 20:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbcIHUpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:45:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62598 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752011AbcIHUpc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:45:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0C453B75A;
        Thu,  8 Sep 2016 16:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rqt5dYhIX+oVwWRkm626/imn6II=; b=GVSBym
        Zjr/2eutXVySXvXjBIwFSu3U5GxzWqCBAApzqx6Ic3xbbYnwkcW67miSKllrwdCD
        gXe47he4RmvjE+WaOMKWCQFRBc+EYGW+H7TqBb8qiVc0egS6MBZPilNfWzPjycPR
        AERLN3LELVUpSAQhGrIfpR4i22i73iQ5zskj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TmsKPg2mQF5y/A5xbEuguST5frQrYCIW
        QMTvB/9e4gvpjgCysdFkZoVg8yaPmY1NEF8mjHhdISxyCZa61rz21KB6WIBMW3bJ
        jhB9ds5MCcC0AlrMb1Lz9LDJlUMVDrq5jYJPaqZrcl6VZLv+EEPB677oebtefU9L
        1/auBTyKoFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8D6C3B759;
        Thu,  8 Sep 2016 16:45:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63DA83B757;
        Thu,  8 Sep 2016 16:45:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/13] i18n: apply: mark plural string for translation
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Date:   Thu, 08 Sep 2016 13:45:28 -0700
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 7 Sep 2016 14:49:05 +0000")
Message-ID: <xmqqtwdqf7dj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E3FCC76-7605-11E6-B981-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.

I'll skip 01-03/13 and queue the remainder for now, as I'd want to
see Christian's "split builtin/apply.c into two, moving bulk to
apply.c at the top-level to be reused" merged to 'next' sooner and
to 'master' hopefully during this cycle.





