Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C0C2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9A520771
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391991AbgDPEor (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:44:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60594 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbgDPEoq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:44:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 03D4A1F751;
        Thu, 16 Apr 2020 04:44:45 +0000 (UTC)
Date:   Thu, 16 Apr 2020 04:44:45 +0000
From:   Eric Wong <e@80x24.org>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: explain "mboxrd" pretty format
Message-ID: <20200416044445.tgofuvhp6c2i4ebh@dcvr>
References: <20200416041658.85100-1-me@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416041658.85100-1-me@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> wrote:
> The "mboxrd" pretty format was introduced in 9f23e04061 (pretty: support
> "mboxrd" output format, 2016-06-05) but wasn't mentioned in the
> documentation.

Oops :x  Thanks for documenting it, now.

> Signed-off-by: Emma Brooks <me@pluvano.com>

Acked-by: Eric Wong <e@80x24.org>

> +++ b/Documentation/pretty-formats.txt
> @@ -83,6 +83,12 @@ placeholders, its output is not affected by other options like
>  
>  	  <full commit message>
>  
> +* 'mboxrd'
> ++
> +Like 'email', but lines in the commit message starting with "From "
> +(preceded by zero or more ">") are quoted with ">" so they aren't
> +confused as starting a new commit.
> +

Looks good to me, thanks again.
