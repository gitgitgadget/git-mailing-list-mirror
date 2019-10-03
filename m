Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4E61F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfJCWqx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:46:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55259 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfJCWqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:46:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B90423C09;
        Thu,  3 Oct 2019 18:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RoqlMaiK1i1OT+r3WWLVUcJ+OuM=; b=ZI1KO4
        1IedHWnB+LnJtJB+9mSbzfko5l48j4IlcF5bYmk8dpov1b0qBa9kA7Qel/NAxDS5
        4Q/MlGaMmRJ90MnE2ewr4upt0qj95QKsrDL2SxWMJethIH65MlVUw1TEwy4/IqU4
        138H6eNv0FtmASCWmNawn9fnVLn+9Pzx1ZT/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LAyQpNzloXnaETZrk8mmM/KG/pyPch8i
        5B1/ucoHTKF1cAs4dCQUGGyiCMbZuCLfIBb7aS7K8kUHEl+Cg5TLVMEuPdB13guK
        B1aby661aZ0w8AzfWGXoSoNft6EA3W4IgAO4B3nc78Rtnht0SaXe8PokCppFqjUo
        b2I8GKaycqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0367723C08;
        Thu,  3 Oct 2019 18:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 691EF23C07;
        Thu,  3 Oct 2019 18:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH v3 0/6] multi-pack-index: add --no-progress
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 07:46:50 +0900
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com> (William Baker via
        GitGitGadget's message of "Thu, 03 Oct 2019 10:53:31 -0700 (PDT)")
Message-ID: <xmqqtv8pa1lx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0BCBB08-E62F-11E9-ADEB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the third iteration of changes for adding support for
> --[no-]progress to multi-pack-index, and it includes the following updates
> for the feedback I received on v2:
>
>  * Fixed commit message formatting
>  * Updated 'pack_paths_checked' from u32 to unsigned
>
> Thanks, William

Thanks, will take a look.
