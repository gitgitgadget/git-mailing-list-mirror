Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77334203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbcHSBAS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:00:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59022 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753902AbcHSBAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB73349C4;
        Thu, 18 Aug 2016 12:21:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GoV+nCAhfiV65oJswYfCeVNMO5I=; b=NeTlYh
        Gb+oYcT5NDf8ohunYvWNW+lGYLwcpuCX5p981hX2sL0l4S4JPCH/cNRtb7tK+wFI
        7BhIckoUavU09IObIB3UlfHIqoU32lSEYt/h4onst3DWsB3DiavxK0KeyWkKFLf4
        oDdFvK76FtXt8XrBi0JBWdZOF5o8wHb/l1MG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j0NvRIocxdmtgPubR/X0OCmmXPpdo1D+
        rsqMY5RLti45LlGliTSdJFfAT0mIB7nAXcLfm16eYzksYj64zTphJNn5SPHVptHP
        C6w0mthU8umuS6tElMFMbXYLDcs3ypYPsNHlQluT1Y89BIgxg1ASTcQJfM/cQXu8
        C6yuypOISaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6409349C3;
        Thu, 18 Aug 2016 12:21:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84CEB349C2;
        Thu, 18 Aug 2016 12:21:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] cat-file: fix a grammo in the man page
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <561560a6144f775fdde3fa51f4acc54867797027.1471524357.git.johannes.schindelin@gmx.de>
Date:   Thu, 18 Aug 2016 09:21:02 -0700
In-Reply-To: <561560a6144f775fdde3fa51f4acc54867797027.1471524357.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Aug 2016 14:46:13 +0200
        (CEST)")
Message-ID: <xmqqoa4q6ob5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2C7C710-655F-11E6-B705-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> "... has be ..." -> "... has to be ..."
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-cat-file.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 18d03d8..071029b 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -54,8 +54,9 @@ OPTIONS
>  
>  --textconv::
>  	Show the content as transformed by a textconv filter. In this case,
> -	<object> has be of the form <tree-ish>:<path>, or :<path> in order
> -	to apply the filter to the content recorded in the index at <path>.
> +	<object> has to be of the form <tree-ish>:<path>, or :<path> in
> +	order to apply the filter to the content recorded in the index at
> +	<path>.

Thanks.  That's an ancient typo dating back to 2010 ;-)


