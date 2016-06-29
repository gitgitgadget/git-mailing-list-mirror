Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BAE20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbcF2SMP (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 14:12:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33182 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbcF2SMN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 14:12:13 -0400
Received: by mail-it0-f68.google.com with SMTP id y93so6181667ita.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 11:12:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LlX+KHUsriqZI83P/E1z+L4R4+nGOp9fk66EeFAqgH4=;
        b=ZPlnvTFaKNta78gy7heXOLeS9CyHvj/gGztoLe7vjAzTTBH4HCxvEJ4KiRuwY4wL1f
         4/Oq17aMDSJfXc+JiltUfPWWDxbNaF8CsY2GotLaVX59JhmDUcgjGNJEvbUKUw1YEddG
         iPYgUbKKizvPZsEYeGROtdMzeKnf1BGdD23RSpbrKucSom1IJcQScgDD6Vq1t21yvFpF
         ln7sg4k/wIAvV6ermaxARZYhEzfPsXC7/DLTFWsT5XTSFDx/GSsJdKBgf08I81vBRRwr
         +ebm43Ypg7DLrJBJxgwaOGLbBoI2FmzKyrLh463jrJe4alXJa5BxUbF3f8+zdivBIc+G
         gTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LlX+KHUsriqZI83P/E1z+L4R4+nGOp9fk66EeFAqgH4=;
        b=l9SB1XvBiOHOtPlmEgFWN/+IDli+V23J0eUBpToL38RXUAQj9P7se1ODIOrs3nSgf9
         clRMuiy9rkQBN3WksMRCjy3DYpAd9XWuep+CKQduPDiX0+Lmby4UxPXmsXLyfd8Js6p2
         PZUkTI7ueGsKhSHoDmrhAqBPPhD8MgnGoi/HJ5Mq5S4ajqWai77GWHLR9270qamM33wB
         qs2l0BEM3DSJM/53XH017zGR30bxiXLpHOqPVkk0yNyIi7+kbpIyLVoqihgWs9Cfgw5z
         zYChXb65RJzBMqBMtgC0eA3EnOuM4NzxSu1PbH2pHg5ElgUwxJJ5pCIGnjO64zDuEBXs
         WQaQ==
X-Gm-Message-State: ALyK8tJNCVYXEsb1PGllLil7D3zDhTnljNraJ9QneYFj+kGk4qfmJVkDFI6mwixIKONTTiJgImclwG0FhA4QQw==
X-Received: by 10.36.210.198 with SMTP id z189mr11627714itf.32.1467223932003;
 Wed, 29 Jun 2016 11:12:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Wed, 29 Jun 2016 11:12:11 -0700 (PDT)
In-Reply-To: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Wed, 29 Jun 2016 14:12:11 -0400
X-Google-Sender-Auth: BVPUTkbvq-_rLhceCnkrn6isI-Y
Message-ID: <CAPig+cSHy=2VaNP5gpwqKN4vuCBrOUy39L0i9xcda8m3zx+GPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 7:36 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The vast majority of error messages in Git's source code which report a
> bug use the convention to prefix the message with "BUG:".
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/merge-recursive.c b/merge-recursive.c
> @@ -1853,7 +1852,7 @@ int merge_trees(struct merge_options *o,
> -                               die(_("Unprocessed path??? %s"),
> +                               die(_("BUG: unprocessed path??? %s"),

This and others downcase the first word (which is consistent with
modern practice)...

> diff --git a/sha1_file.c b/sha1_file.c
> @@ -795,7 +795,7 @@ void close_all_packs(void)
> -                       die("BUG! Want to close pack marked 'do-not-close'");
> +                       die("BUG: Want to close pack marked 'do-not-close'");

...but this one neglects to.
