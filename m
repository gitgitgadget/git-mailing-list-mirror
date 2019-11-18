Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48EC1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 01:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfKRBPa (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 20:15:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56776 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRBP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 20:15:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9991433C1F;
        Sun, 17 Nov 2019 20:15:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AX1kzuKSTWSlmXXDy3I1Wnwmi2M=; b=Ku3Bf6
        KzHIxCS19Aa0oF5C722xbGUKXliycX9mZ2MsUqPvkNSj3GAHtKkc8Kt1avO+W2Qo
        1ecOirvCI4QkGj2OXSZCJX/Qx2hkrPAm09p+07eMvgEVzFotuycq0IPW+LEGx9vH
        rQmx4xEVI3BhMArlUFcGW6ivVx6MoJ5Q5REdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBKL6xdperD8dcmpXaZEbNgBrgscWjXB
        hVMujQLmGO702wKTEpWQEfzJTLEqkPo6gwRbmtWJATbV5PV4+7D/oHzl31YNsQ4T
        ObNW5gP2jErgjPnaKKY28JsJVTSmzRIK4NCpFsIJ23YzaWsARlk4+19vS+CGw85x
        HWvPK9h0W38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90B0C33C1E;
        Sun, 17 Nov 2019 20:15:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0229E33C1D;
        Sun, 17 Nov 2019 20:15:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 0/3] Feature: New Variable git-p4.p4program
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
        <xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 10:15:25 +0900
In-Reply-To: <xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 16 Nov 2019 11:40:21 +0900")
Message-ID: <xmqqeey63ryq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E76C20AA-09A0-11EA-AA7E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As to individual patches, our local (read: project specific)
> convention around here is to state the are the patch touches (in the
> case of these patches, "git-p4" is the appropriate area name), colon,
> and then a one-line summary of what the step is about (the last one
> is done without initial capitalization).  The summary is written with
> the focus more on why and what than how.


Sorry for a late typofix.  "to state the AREA the patch touches" was
what I meant.  So I would expect all patches to this file (which is
the only component of 'git-p4' subsystem) to begin with "git-p4: "
prefix.

Thanks.
