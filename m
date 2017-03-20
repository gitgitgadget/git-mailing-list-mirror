Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E845820958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbdCTQI7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:08:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755350AbdCTQIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:08:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F2D4793BB;
        Mon, 20 Mar 2017 11:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zACx+2NM4yJsqqWgmYDQexkuXzM=; b=D7r2qG
        85QYAxlc6z3zNUwLA/KGGU/Smtg00aZX2QZr8cz0nVk/8DqwDlrY28ljPm9rVceu
        piimESLmfL4rCWom1UrPpmREylkD2iafNvksh6NzMxIrms8YqqCkpBdXyHsMNQSs
        Z3ZG18LJx+kwgC7/GD/88N/oZifMABjCSUEBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wGU5FI/tEekAH5r8lsSCyvTFmFdx6tCt
        6b7//9o4v6Y9QZhGFwt+dobq6HsGkYcI5RB8cdI3pY3yZrUTtHffT/1SiyKcb+nW
        oa0xlw2hr6T9gzTmQQ9c/XNXj6+RPQYFTeYBdo4+fQCxHfTgLJ8dzXi9emWT/2+J
        u/ei3+Sg04k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F22F0793BA;
        Mon, 20 Mar 2017 11:53:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 651D6793B6;
        Mon, 20 Mar 2017 11:53:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v6 00/27] Remove submodule from files-backend.c
References: <20170222140450.30886-1-pclouds@gmail.com>
        <20170318020337.22767-1-pclouds@gmail.com>
        <9f6d9544-a869-3d89-4025-345fac1ac70c@alum.mit.edu>
Importance: high
Date:   Mon, 20 Mar 2017 08:53:46 -0700
In-Reply-To: <9f6d9544-a869-3d89-4025-345fac1ac70c@alum.mit.edu> (Michael
        Haggerty's message of "Mon, 20 Mar 2017 06:37:02 +0100")
Message-ID: <xmqqmvcgx7ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67603668-0D85-11E7-B5CA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Thanks for the new version of this patch series. I left a few optional
> comments, but nothing serious. With or without the suggested changes, I
> think it's ready to go. Thanks for working on this!
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Thanks for reviewing.  Judging from the exchanges between you two,
it appears that the final reroll would mostly be uncontroversial
kind that we can finally merge down to 'next' and then to 'master'
fairly quickly ;-)

Thanks, Duy, for working on this.  The end-result looks much nicer.


