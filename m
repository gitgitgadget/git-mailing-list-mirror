Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E69D1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 07:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbcLMHLw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 02:11:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64595 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750818AbcLMHLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 02:11:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFFD64D507;
        Tue, 13 Dec 2016 02:11:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/1e92N7HBZ2zBdszQb2XbT5/HGo=; b=w8qkiQ
        NgcNUAp91mmPcIP02mSIXKHxAjGBVAHWG+JvxYy42a/p0j9h8/PDPeU+18sgVGpC
        CkI8d4fBR+dOt7YITo1ED3DZr9eUHf0NI+IdZfeB/7iJHEXLbHVt+A90gFs5Mc0c
        v9UfjeECu/IkCPe7jiHEA4d6QCYBbaQ4dc620=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DaCBhwOOxAJxDKFxo+55K+4TUQjRJeuE
        OiI3w7sOcXgv9TWJwTGYNl53yzNTbdmPLS9CWK4LkNwH27lJgYwX3FG88ipJzV2K
        SKUghWCZGO0Wao1BNIT78qPO4sBIaHeifK2brriV7Kr3AvWwJaaNBXvafDHh67j1
        t0H9Rc8Ody8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B36094D503;
        Tue, 13 Dec 2016 02:11:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F9154D502;
        Tue, 13 Dec 2016 02:11:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t3600: slightly modernize style
References: <20161212235455.13796-1-sbeller@google.com>
Date:   Mon, 12 Dec 2016 23:11:47 -0800
In-Reply-To: <20161212235455.13796-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Dec 2016 15:54:55 -0800")
Message-ID: <xmqqvauo5mmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A27D9B0-C103-11E6-AE91-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Remove the space between redirection and file name.
> Also remove unnecessary invocations of subshells, such as
>
> 	(cd submod &&
> 		echo X >untracked
> 	) &&
>
> as there is no point of having the shell for functional purposes.
> In case of a single Git command use the `-C` option to let Git cd into
> the directory.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks good.  Thanks.
