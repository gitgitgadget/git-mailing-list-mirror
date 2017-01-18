Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1B91F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbdARUSs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:18:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54969 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753134AbdARUSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:18:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8BE76052E;
        Wed, 18 Jan 2017 15:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wwI95l+nxB8dc22JqEXlV3lv0yE=; b=cQ8oXK
        Z3HowVrBiEHcQkvh8CO2tLPnSHoIJirDLVuBuDIR0JlB1Pf/n38baZOBEkZbVQfo
        YIAre+d+u+0BAdAEIjoeGOxXH8RpXWvCx2WGaYBFG5yeCatfmUbCuVoiDSbMLgr5
        WWo0WOKX6YDip2ajTa3ju52Qqt3Dk3RH9LY18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mB9Vxuu1jdcnNQKrPUeqlCbN+NYcBqzh
        nNzyT+/BzD2tC8pLsYobBk1SKAKFRVQ7hvEIja/rJ/BcEzYcViaD1S6BVwBeefBl
        /8r+jOgBdJLdd1E8Obo09OwSo6XbYlMEHLNc5qt+K2h9c9O+RjF2u8jSYWCS3woP
        kosu6sFvRtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C05666052D;
        Wed, 18 Jan 2017 15:18:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F47360529;
        Wed, 18 Jan 2017 15:18:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 0/5] extend git-describe pattern matching
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
Date:   Wed, 18 Jan 2017 12:18:36 -0800
In-Reply-To: <20170118000930.5431-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 17 Jan 2017 16:09:25 -0800")
Message-ID: <xmqqlgu886lf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC9A79E-DDBB-11E6-A031-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> ** v3 fixes a minor typo in one of the test cases, so please ignore v2
>    I left the interdiff as between v1 and v3 instead of v2 **

Very much appreciated.

I just finished reading this round through and didn't have any major
issues.  I sent comments on the way the feature is explained to the
end users and history readers, though.

Thanks.
