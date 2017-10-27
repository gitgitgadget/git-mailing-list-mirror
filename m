Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435B220560
	for <e@80x24.org>; Fri, 27 Oct 2017 18:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdJ0Suv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 14:50:51 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46456 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdJ0Suu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 14:50:50 -0400
Received: by mail-qt0-f172.google.com with SMTP id 1so9619673qtn.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qeLijSDWGhDNxqPmFnO0rodJSIPghoOjM0L54T9+XTI=;
        b=pqpqCncihkOFMzepDh2MlbfFoI3aGplJTrLP49050AM9twi6r0QSZy+eCe6rASLzBZ
         vICHB5ZRBmiD79UKE7z3c8de4RWhi8hW0RFp88XvynBMlD+Nqb/x5ZVIJcmpzx+2nJCX
         MOB2QjgkzO0jQXZ0yx806Ny3SKwm1mpXNZPT5jp+zTQ4htbZ0CNspOYTjMnTNoDg4FRk
         YWkMGXZl9PlO80AgjjDN0aJhI8zirj2ZGgy6hd/Zr38aUF8y8EEdrzy5TIZTO/RvGW3G
         P6a65vjFXMtTxcnIUfAoBNfc/WKbKCtia7wfMybghALxEMV/3ubRfb/uALP4e0tQQ0Sd
         bsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qeLijSDWGhDNxqPmFnO0rodJSIPghoOjM0L54T9+XTI=;
        b=ITovVdABlClqQH+NcIu1m/Dp90m/aAmcStqGROcP1RZyDtXqqq47hlFAR9FIzzeaYZ
         XNtOHq/J6V/yavhr0CFKEi1RDM07etRpZUWOj1RnNWL9Bcnxus2/inRkRzdMNcKtjy59
         20pOu6QfVXaE7iYUT4rGhxzBeyQ6IuG3rbF7miQxFK17xOR3nTgFxH+GjGdSGGFehrSu
         PzW0F92cvcDGcxko1SkcR9tjwJh+v0mRGMEO+2Ij4lDqhmwcl7uv3UD0q7nIouTXefAD
         qFZp0oRj+fHor58DxxAtWbAccHt92oE9IW+uDPXhgiqdVmbTTWDFq4ga44HaUJfNqCxz
         DmVg==
X-Gm-Message-State: AMCzsaVnNT0aOUsySR+fKsxJVxXQcwPLQ9WKdXjHJroGHdP//QVapNRt
        TDvooc8f2SPj8ZxMH6VTIj4WbVRsVvPCplIp84DNXw==
X-Google-Smtp-Source: ABhQp+TtMUHHxvTYGbpO4ZhnEPQqjOg6DOnmYu+bsqZO+whEVx5X9x+J0wrMCbeUIUE0eRBQnzAkbXRRExr5jLN+l7o=
X-Received: by 10.237.37.132 with SMTP id x4mr1290966qtc.224.1509130249908;
 Fri, 27 Oct 2017 11:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 27 Oct 2017 11:50:49 -0700 (PDT)
In-Reply-To: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Oct 2017 11:50:49 -0700
Message-ID: <CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>   (merged to 'next' on 2017-10-26 at 30994b4c76)
>  + Documentation/checkout: clarify submodule HEADs to be detached
>  + recursive submodules: detach HEAD from new state
>
>  "git checkout --recursive" may overwrite and rewind the history of
>  the branch that happens to be checked out in submodule
>  repositories, which might not be desirable.  Detach the HEAD but
>  still allow the recursive checkout to succeed in such a case.
>
>  Undecided.
>  This needs justification in a larger picture; it is unclear why
>  this is better than rejecting recursive checkout, for example.

We have been running this patch internally for a couple of weeks now,
and had no complaints by users.

Detaching the submodule HEAD is in line with the current thinking
of submodules, though I am about to send out a plan later
asking if we want to keep it that way long term.

Thanks,
Stefan
