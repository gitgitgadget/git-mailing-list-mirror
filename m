Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A825E20133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbdCCUfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:35:11 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34381 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdCCUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:35:11 -0500
Received: by mail-it0-f67.google.com with SMTP id r141so3562187ita.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8gyXRXkvy2lkd9CJhLslyLUfHGbuoUZ0yxFiD5vrr8A=;
        b=mTYwOOxb7wdCridk4oqgfBgXAYCpIZ94FNSovNPTWB7qEZby1R+WVIWWydAH95+67P
         jWAjUDycnGIw8rfsENvZJA9Kv191ogux1OkNPXq7aB2OgcK0Yni57ofJh3cSIVlbVcHW
         F5Su+TAcy+Wt4axNZ9qgJeJQCWZiBPfUOn68d8cKg+y/QZQQjEaSYLjlWOHcvgLTyHQR
         e67wmronufrAG/pPyiNRTQIFqrmHx2cgEpMXaDL9Zffl6iOu31mkLqHwFhhk/5ibrq94
         OsDrZdUOUtxCwTBZ38E92mzCt7OT4v5WoCort2U4GoVaOZBPNMt/9adO8As38N8vVTna
         k0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8gyXRXkvy2lkd9CJhLslyLUfHGbuoUZ0yxFiD5vrr8A=;
        b=qzcdoiD8IAK3uvecdc3jiZWa9iyjjenEABLNG//gJYzu5ATQT20JcQfyRavEVfM+fc
         E4nPbtPDDRDQjgn3G4H9fPviEXYEMMQH/oxyk8JokZdr8T3V9wyPE7r7BmZmn4jvtXcy
         yIxXyE3x9XbizaYTDpS6LJxL9dW87BmaOEanL6++eUThcnHrtT+jiQPc1tqUXJ7KTrNh
         R0PYGzCMH6HtspMvzhkqViQNTvl5tziWWSwAuDMJlf09MKhSMUeyhacYE4VFqp2pG1oh
         U06zo6rtd1zPeevnv0NFl0zMbcJdd0nKyPpZkogAxpNQhMWBjgxzTZ1BhEfGLHsUuFux
         DmCg==
X-Gm-Message-State: AMke39mJp59nRPULsDlwCMyXNzwmoxSkKVcY/aKoKtLecQVnbIf/y+gffdYXIrXQcuS8mw==
X-Received: by 10.36.206.2 with SMTP id v2mr5362582itg.74.1488573268978;
        Fri, 03 Mar 2017 12:34:28 -0800 (PST)
Received: from prospect.localdomain (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id h142sm5010783ioh.61.2017.03.03.12.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 12:34:28 -0800 (PST)
Date:   Fri, 3 Mar 2017 14:34:49 -0600
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] p7000: add test for filter-branch with --prune-empty
Message-ID: <20170303203449.GB4763@prospect.localdomain>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-4-djpohly@gmail.com>
 <20170303075605.3pqqzmjcqdtv2bjd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303075605.3pqqzmjcqdtv2bjd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 02:56:05AM -0500, Jeff King wrote:
> On Thu, Feb 23, 2017 at 02:27:36AM -0600, Devin J. Pohly wrote:
> 
> > +test_perf 'noop prune-empty' '
> > +	git checkout --detach tip &&
> > +	git filter-branch -f --prune-empty base..HEAD
> > +'
> 
> I don't mind adding this, but of curiosity, does it show anything
> interesting?
> 
> -Peff

Nothing surprising; the overhead for the change was minimal.  I wasn't
sure what the practice is for adding unit/perf tests, so I erred on the
side of covering everything.

I will leave this as the last commit in the series so that it can be
dropped or merged as you see fit.

-- 
<><
