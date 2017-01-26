Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CBF61F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 23:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdAZXZB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:25:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53427 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752926AbdAZXZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:25:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18A5C64189;
        Thu, 26 Jan 2017 18:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+DMczX1NKXXAYv8UUNXKb4KzmyM=; b=Xq3diB
        SRrCQZXpbUjTVK+4HDkG2UcP9kARSCX9DPYr8Pzu8nkr5ct2mb9ZQr0rTsQZweg1
        W+/JRwmy2VMlIplCJWUPeENBY/jlJumScL2uaJGvdnU6xDFlde/6c3m2kVRkz2ve
        xR6MwfTpxM6jwk2d+kmZ0umu0Ws/6rYDUrcsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CgCRBVQDgmmdGHv9zFcaO7ywi5KgRGJD
        oCRMZqBgyvOtaZzjQSGWXxTBwKSXRnK47uAIjnhia3DwtTBZYnS1yFcMhuv2gtCq
        cFwWCVAaQHNSY6r/LsRjMJUXvTOFCD5qiIjWGRw56unNz1nS/AU6Z5rHwh7cdN5i
        QsYbIunQYfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F78A64188;
        Thu, 26 Jan 2017 18:24:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61C6B64187;
        Thu, 26 Jan 2017 18:24:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] config: add markup to core.logAllRefUpdates doc
References: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
        <20170126223159.16439-1-cornelius.weig@tngtech.com>
Date:   Thu, 26 Jan 2017 15:24:57 -0800
In-Reply-To: <20170126223159.16439-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Thu, 26 Jan 2017 23:31:57 +0100")
Message-ID: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A70D419C-E41E-11E6-B36D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>
> Notes:
>     As suggested, I moved the modification of the markup to its own commit.
>
>  Documentation/config.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index af2ae4c..3cd8030 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -517,10 +517,11 @@ core.logAllRefUpdates::
>  	"`$GIT_DIR/logs/<ref>`", by appending the new and old
>  	SHA-1, the date/time and the reason of the update, but
>  	only when the file exists.  If this configuration
> -	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
> +	variable is set to `true`, missing "`$GIT_DIR/logs/<ref>`"
>  	file is automatically created for branch heads (i.e. under
>  	refs/heads/), remote refs (i.e. under refs/remotes/),
> -	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
> +	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
> +	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.

This is a peculiar patch.  

Did you hand edit and lose a leading '-' from one of the lines by
accident, or something?
