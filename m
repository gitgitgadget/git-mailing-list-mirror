Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721EF1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 01:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeAZBbz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 20:31:55 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38200 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbeAZBby (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 20:31:54 -0500
Received: by mail-pf0-f193.google.com with SMTP id k19so7150796pfj.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BsA2/WCioGk2GcbSRroBUt+okwvHCZYQDDWhDoLAwwI=;
        b=mFWzaHGJsV6pWo549am5q0Ehn667l/apzkr5UeSvMOUAX2/H6+f4Ktu7SV1JtZv3i1
         ogz3gkFA9Z2raN+C/R6pjlipFYMPWd6ptxIXvS8ZBWzdJCUT3gQNmD3pAee61Jbr+ZSS
         kUjhKEiDpqMF/RN+TGR9AKROR9+x4nLcM7rOnpOsNSM/p0NvpQbVdT4XGAWeCk7ntVHP
         X19pebjdpMVTlS3XX8oTLtqO68oz//h9Vc3REGSg4d+rFn4zKzjEy3T5Feh1bGBuIbTZ
         7RWFhcsw1YqlW6E9PZ3lrPx8AcstKlposgt7IfZIvIfBFut5jA4X80yPcmowz/N7QnWR
         GxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BsA2/WCioGk2GcbSRroBUt+okwvHCZYQDDWhDoLAwwI=;
        b=dkC47Wpvu9RoCEC+b59cJHZhZHNHt74bjDQi3ORZKiFlxjmogX1GVEKz3pQvXgMes/
         5Hrjh5/wN97Wfr1Bu8aBF59Q8Vj1JmYbw0axH0/VVnI58/z018vtg+zgG6raSnWSLnNE
         w1zhJaymlHJiWsoVRN7z8bpjqHh8lJ4b4oZGYrv4en+4Iw0bm7GlsP5zVYx6+o6Z0J9I
         optdh7Geu6mo4XCqxtTEV3sh/X2XVSRB54WK+kIEDCi1Ehv7InAB6+TYVlPp5D/69n6y
         FPJrkdofw6C7/G4oFN3peUdgXgAlmMsK3zFjZrEbrCca34abjp8oS2GoDnbeZLD5MiUL
         RlzA==
X-Gm-Message-State: AKwxytdB3PKG5N31VTgZHMkn6BQH/6vC5IeDQfHBdXA7mZDbOw42HlLB
        freHK7rg1zypwYgrm7nDzXJbMw==
X-Google-Smtp-Source: AH8x224eRkZlutGZVg3k+nO31zbK9QVCtRgWYr2Teuu4Ke4E0vxmx0OGoekctBWqWCRtt3vzXkS11A==
X-Received: by 10.99.96.201 with SMTP id u192mr14321843pgb.234.1516930313805;
        Thu, 25 Jan 2018 17:31:53 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id q16sm18350079pfg.124.2018.01.25.17.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 17:31:52 -0800 (PST)
Date:   Fri, 26 Jan 2018 08:31:42 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: support --strategy '?' for git-completion.bash
Message-ID: <20180126013142.GA11346@duynguyen.dek-tpc.internal>
References: <20180125094031.6584-1-pclouds@gmail.com>
 <xmqqo9lhai46.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo9lhai46.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 10:49:45AM -0800, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > Bash completion support gets the list of available strategies with a
> > grep and sed trick which does not work on non-C locale since the anchor
> > string is translated and it does not cover custom strategies either.
> >
> > Let's do it a better way and make git-merge provide all available
> > strategies in machine-readable form.
> >
> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > ---
> >  Another, perhaps better, option is add "git merge --list-strategies".
> >  It requires some code movement, so I'll try with a simpler approach
> >  first.
> 
> If you run the probing "merge -s help" under C locale, that would
> just be a one-liner, no ;-)  I.e.

That was my first choice but I was worried that it failed to catch
custom strategies which are preceded with a different anchor string
"Available custom strategies are:".

I didn't look carefully at those sed magic. But it looks like it
correctly handles this case too. So v2 follows below. It still feels
dirty to do this kind of text manipulation though. But that can wait.

-- 8< --
Subject: [PATCH] completion: fix completing merge strategies on non-C locales

The anchor string "Available strategies are:" is translatable so
__git_list_merge_strategies may fail to collect available strategies
from 'git merge' on non-C locales. Force C locale on this command.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..88813e9124 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -594,7 +594,7 @@ __git_is_configured_remote ()
 
 __git_list_merge_strategies ()
 {
-	git merge -s help 2>&1 |
+	LANG=C LC_ALL=C git merge -s help 2>&1 |
 	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
 		s/\.$//
 		s/.*://
-- 
2.16.1.196.g4f5118c359



-- 8< --
