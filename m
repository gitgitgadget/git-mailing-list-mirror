Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15341FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 04:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdJLEQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 00:16:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36513 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJLEQe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 00:16:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id z11so4386912pfk.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhjbCv3NDosigu2oRCmb0XoxqL7Y16khP4Bm0VQkyqA=;
        b=dVvgT8lm9eJLdmQZSQahmncV5xiZ4LEQpu7EjY5oNJJ0NKCv9eawJ6AAizeF3wQWGA
         i0IdsLWfKfZM511/AlhvGfUmdyPZ9uWrGHtMG/SlAgN4EFmEJdjFr6TxKHh9qJBk622F
         leyZ3YyeIgyjghYgLgX4jAE0hknXTKnIOQi/gkjwWe5FctP3SzG2GRulBDNBWWCKAP8Z
         Cz3glL2t1zUc0ENmxj8U9iIK8OT+xFQwMm+YdWV0rhkKNRRFdhILDjuc84hfm2CuzxI/
         r9aChtkxCQWI/f5lX/0c5sOzkgkwKylJWvwDUxQ1nka4lronJGepXHbtsx2VeiIQ6CuX
         nU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhjbCv3NDosigu2oRCmb0XoxqL7Y16khP4Bm0VQkyqA=;
        b=Ys+NP0kVE27NhUMAz/TuQdHHIaFC6tsV5erAYLML2w4tWZBt2VVIYp82JtNx0JMJvB
         /DHTogtDUI4QBbfYYc+MTYL1FjS4XTryQv7ZEPIVcOpRxvDExZrGyV69DpBPGEhXevki
         B8fK4dE0+J+/jOWA2YPaXRq+ZPBc9LS06vDSjkP8q/ERyOdk+vEexfLlViW+B/FX+iRS
         TahUAW2VQN3SKtxVuzBQbbGnCIUdoJ5GXOCnzAG8DABILrCOBkAjJQONTQrrtulDsTC0
         1DyKPejN+U16XB0QaZEo1bXkPkvreTEmuqUZvCcixLVpi2JRlaLJ9aHaLhnO0NFWs2pq
         xkWQ==
X-Gm-Message-State: AMCzsaUnCUfzGYlhrHIwgklO/l48NtL9ank2/kuN+gFczX2FtYISdoTx
        kw38SdcoPP54r5XgVaQiO3STLDdU
X-Google-Smtp-Source: AOwi7QCn7LPwOJfQV7L0GvhyAN6D4GjJYaR69Yaej+d/uHyjRY3Nl51T5VXXRdg58ebaj8HErbUYYA==
X-Received: by 10.101.87.202 with SMTP id q10mr1044677pgr.141.1507781793784;
        Wed, 11 Oct 2017 21:16:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id f7sm841423pgq.5.2017.10.11.21.16.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 21:16:33 -0700 (PDT)
Date:   Wed, 11 Oct 2017 21:16:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: emphasize stash "--keep-index" stashes staged
 content
Message-ID: <20171012041631.GC155740@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:

> It's not immediately obvious from the man page that the "--keep-index"
> option still adds the staged content to the stash, so make that
> abundantly clear.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 00f95fee1..037144037 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -68,8 +68,8 @@ entries and working tree files are then rolled back to the state in
>  HEAD only for these files, too, leaving files that do not match the
>  pathspec intact.
>  +
> -If the `--keep-index` option is used, all changes already added to the
> -index are left intact.
> +If the `--keep-index` option is used, all changes already staged in the
> +index are left intact in the index, while still being added to the stash.

Aside from Junio's note about "in the index" vs "in the working tree":

The "Testing partial commits" item in the EXAMPLES section explains
what --keep-index is useful for.  I wonder if some allusion to that
would make the explanation in the OPTIONS section easier to
understand.

Something that I end up still curious about when reading this
description is what will happen when I "git stash pop".  Will it apply
only the changes that were stashed away and removed from the working
tree, or will it apply the changes that were kept in the index, too?
If the latter, why?  Is there some way I can turn that behavior off?

E.g. in the "Testing partial commits" example, it seems like the
natural behavior for "git stash pop" would be just restore the changes
that were removed from the working tree.  That would also match an
assumption of save/push and pop being symmetrical ('inverse
operations').

Is this related to "git stash pop --index"?  I notice that the
EXAMPLES section doesn't give any examples of that option.

Thanks,
Jonathan
