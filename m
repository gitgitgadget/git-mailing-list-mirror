Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2902095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933021AbdCUSy5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:54:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932740AbdCUSxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 254B76577A;
        Tue, 21 Mar 2017 14:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jGOl8KgNI6KTiSu/xWFdEnBbrIE=; b=pnAGrK
        5cEnZaaxL9draZJ0f4gngyVBsStQh/TKKcTmkTZEkl/2g4e7rm1eanaA5HGmy2R2
        a21c77e+mAZUFnitTwyRJlmuuUaX9tiS+UWBuV+fCdr+qA1trWP2TlW4xjBkG7Z9
        SC1olMfC9vsh2PQlm6LVI2nBJ9fipuAvbAGpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iubtflgx6P6UWJ3qf1TUhPt0kC8LmPpU
        ftl7eCI0vQ7TKmMAfQjEQ3ivAWU0Fzjw5REuUELBNe53/bcOoSV+orAdLczkiZNd
        KBgXBOtjCjt35LLHwKbHFe4iO1hJpl58OJOg/jpgDrTpYuZnxTms+9cqveAzpkaD
        B38NMunp0JU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CC9865778;
        Tue, 21 Mar 2017 14:48:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C41165777;
        Tue, 21 Mar 2017 14:48:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 12/16] tag: change --point-at to default to HEAD
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-13-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:48:46 -0700
In-Reply-To: <20170321125901.10652-13-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:57 +0000")
Message-ID: <xmqqfui6pisx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0454FFA8-0E67-11E7-AD78-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Makes sense.  Thanks.
