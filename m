Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2EA2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdJ1RNa (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:13:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:56947 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdJ1RN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:13:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so7274688pfj.13
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=hOLzu9owEuzoIR/Grn9SySywur65wj5CgwD5ZRwUemw=;
        b=anRPosk86qNpZuB1XdYw5YoKJWRaon7N/tIuBWVFodmeihP3wfIjkeUowr9TTzrs0e
         ZefcC/RQKSAZrbEHzeJEyBMJQG8/HstUuL90599ByWmG9LUDvnBCjxRmBQaVbkBhUYeZ
         iHtcwJb6CbuiwAqcjw71M3Ko/XbbWqnZMI4VTzD+OyQ/0guaFe85iutXI221fJP6Nx8W
         Awz89BinyITzd3fjTbjq7Ct/agrO5gCGHhT+YTQU7F82mTQkeSQb+bR4thFqXvHVhikA
         00jEWEF6NuiMZiFtMJBT8ZDZWNJ/D/35KXaaiqE15dfJSxJgVhSjgCaHMbN3nBPwCz1q
         EqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=hOLzu9owEuzoIR/Grn9SySywur65wj5CgwD5ZRwUemw=;
        b=CmU1GaSMmoGnFKAuAPtF24XvXhVmQxc99cWyqVNAsSabBNEizBFgYHslLTwf5L3GMl
         iVcOo6NjqOFj3MA9TjBnYtk0N7z46Gq7MlPAwg9DlQs1lneB2acx4CtaOvYbWE3qWQob
         7ixgXAW+1hL9igiXndYBgtcKIUMY6OwHvj540UPNEGtq/CCGZdcP6iXpk9d2Us41fsJe
         mVBbPsD4JKnAEeNj20iN1sGaGIVzQSN695mf2/HrMADS0x2ftKF1tUUm3JMdDeS+L4s0
         Td9+LKD87hmUQM4WaLmc170jIUA3fdnY+/aUDBzlmYGryW2sxflA6EJPFzeVVIpv730W
         Hdcw==
X-Gm-Message-State: AMCzsaVyp8gIUFxgnc8SR+Gt53bD8vn6NuwW+HguaCDrpxr0sCZeK/GC
        JJaiiibWV0lhstnvJOn/irWGXcHt
X-Google-Smtp-Source: ABhQp+SEDmFk5w3q2Efz+HvZlU/w6kV0uHtY/rkeJ3+Fr5Su18r62fTpGPYDuwq5+danCJzszlA4dg==
X-Received: by 10.98.201.138 with SMTP id l10mr3955355pfk.116.1509210809080;
        Sat, 28 Oct 2017 10:13:29 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id u9sm28703798pfa.40.2017.10.28.10.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Oct 2017 10:13:28 -0700 (PDT)
Message-ID: <1509210803.2256.7.camel@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 28 Oct 2017 22:43:23 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-27 at 17:32 +0900, Junio C Hamano wrote:
> * jc/branch-name-sanity (2017-10-14) 3 commits
>   (merged to 'next' on 2017-10-16 at 174646d1c3)
>  + branch: forbid refs/heads/HEAD
>  + branch: split validate_new_branchname() into two
>  + branch: streamline "attr_only" handling in validate_new_branchname()
>  "git branch" and "git checkout -b" are now forbidden from creating
>  a branch whose name is "HEAD".
> 
>  Will cook in 'next'.
> 
> 

Good thing this is still cooking in 'next'. I guess there's a bug as a
consequence of this series (though that's just a guess and has not been
confirmed by a bisection). See,

https://public-inbox.org/git/1509209933.2256.4.camel@gmail.com/T/#u


-- 
Kaartic
