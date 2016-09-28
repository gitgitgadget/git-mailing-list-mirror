Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636211F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbcI1UeF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 16:34:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753483AbcI1UeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 16:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0634E401D4;
        Wed, 28 Sep 2016 16:34:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ngPkbaFhNiwd8ZMImxhYvQi/bQw=; b=v/Zaaw
        wQL4ch60q15Z1Lk7xsMcD1EG+e8TbqMxamKbvg6HS50ActupQDSheA13KRiJ4bkA
        3CRVCZwyX5OulJS9b5paiq6pvALO/Xn67oZ/mhXERnMOoEeE0+616FpyoMfalgmH
        GLFdxfZyO7bfCFdkJPy0T170w6uRPXDH6gE60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DnesMTO6PCxnLNzwDoDk53Xa7DsgtwWt
        H49d60bnllEN9e6MEls3Po0pXzNgu56U2A/bgjdjumch5ZxiAvDknxN53TYNhMnh
        ZI/1ulsl2l+IABmVHZkGNX7Nf2AFYSh6r+8dZsbKy7hhUWkJIS+Ad6XBMzmE3fRB
        JsfrfCkIuAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F33B6401D3;
        Wed, 28 Sep 2016 16:34:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FD79401D2;
        Wed, 28 Sep 2016 16:34:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-2-pclouds@gmail.com>
        <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 28 Sep 2016 13:33:59 -0700
In-Reply-To: <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 28 Sep 2016 12:28:00 -0700")
Message-ID: <xmqqh98zix1k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E47FCE5E-85BA-11E6-9789-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I already said, --shift-ita is not quite descriptive and I think
> it should be renamed to something else, but I kept that in the
> following attempt to rewrite:
> ...

Please do not use that verbatim; it was full of typo and grammo.

> After reading the three patches through, however, I do not think we
> use the command line option anywhere.  I'm inclined to say that we
> shouldn't add it at all.  Or at least do so in a separate follow-up
> patch "now we have an internal mechanism, let's expose it anyway" at
> the end.  Which means that the last sentence in my attempted rewrite
> should go.
>
> The patch to diff-lib.c machinery looks good.
>
> Thanks.
