Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FCB1F461
	for <e@80x24.org>; Mon, 13 May 2019 05:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfEMFFb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 01:05:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65501 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfEMFFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 01:05:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F350315637A;
        Mon, 13 May 2019 01:05:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LphlV/cjpAhI9huvZiuo9WkUtEY=; b=T4h/BV
        s61Q2xBjOnpLgJ0J7pwv7A6v7ciN9FgPwz5e3of+9xjCqlMeWbZBCs0FG6IaIfMc
        Gd8S7CddgsCxtyXlJWHOCEhDeKnX0QzmbUafFOz5zYpCRYNGEkKguZQXVqZxVnEc
        pyqcNoqFsNFs4R9lsZHorVRwXsugHWsUgEc9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjBh1TwFyFba7DM05BDB6lMlpkXdXgdj
        z788dlqGqwvlONywLK85rBwOrycst2foKQO04UlBUbrBcPdF67uPPi6981Nw5tLX
        WlY+RnMkT6OpD7A7gVuAhCcPZxWsZH4Gke5WzXix7kYBHn/4S/bNtv8Z8+2kFOQ8
        5Xe61jcLWtc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9CEB156379;
        Mon, 13 May 2019 01:05:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B556156378;
        Mon, 13 May 2019 01:05:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 06/11] commit-graph: extract fill_oids_from_packs()
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
        <30c1b618b139e637122d9476f54d5eb8ce8e0d57.1557411749.git.gitgitgadget@gmail.com>
Date:   Mon, 13 May 2019 14:05:27 +0900
In-Reply-To: <30c1b618b139e637122d9476f54d5eb8ce8e0d57.1557411749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 09 May 2019
        07:22:36 -0700 (PDT)")
Message-ID: <xmqqtvdzc5bc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B99A3278-753C-11E9-9E10-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() method is too complex, so we are
> extracting methods one by one.
>
> This extracts fill_oids_from_packs() that reads the given
> pack-file list and fills the oid list in the context.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Quite straight-forward.  Looking good.

Thanks.
