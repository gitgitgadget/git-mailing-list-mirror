Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885B5203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 01:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbcHSBAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:00:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754556AbcHSBAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6407236B5F;
        Thu, 18 Aug 2016 17:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PbPWscvxgmZYPKntTEx/bYuYsRY=; b=u27NZC
        h9AyLclOs3nc24TXsqc7j1Ks0L+ePKjh7Rrf3hZQDhF4MBnGZz1u28L6b+rktPHq
        g2zoLWnq+Rg2Y5NUkHocuxvud6ryWY4BIRvyMV3AQoGrG0cIVYdGSq+Z5uNLzc9O
        yv4P/+t5Kf87Y6OBnIBFKnicGWmCv/FHBCG+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qplA0/joO2c1WuzvGIsSFKknZh95ASDj
        8oKEjt3JpFaj1OPEGjpy51nYS+qp0yBlCxw96YlemENc0d1MR8FPRlD7Vnx7cDsq
        7NfvmTUqxiNpRmGY/6cISrrRwqkx+Tauu8PxmYvEbIhWaRWMvaEQd7k/SDM5HpZf
        enfgx6LNJIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A38B36B5E;
        Thu, 18 Aug 2016 17:41:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBC4A36B5D;
        Thu, 18 Aug 2016 17:41:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
        <alpine.DEB.2.20.1608181430280.4924@virtualbox>
        <20160818204902.GA1670@starla>
Date:   Thu, 18 Aug 2016 14:41:43 -0700
In-Reply-To: <20160818204902.GA1670@starla> (Eric Wong's message of "Thu, 18
        Aug 2016 20:49:02 +0000")
Message-ID: <xmqqzio94uw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F866A5A-658C-11E6-A3CA-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I see a choice of mail client as no different than a choice of
> text editor.  Neither my mail client or text editor is heavily
> customized.  The key feature I rely on from both tools is piping
> data to external commands.

FWIW, that applies to me exactly, too.

> unsubscribe: meta+unsubscribe@public-inbox.org

Did you mean this, really?

> archive: https://public-inbox.org/meta/

This I understand, though.

Ahh, that's coming from meta@public-inbox.org?
