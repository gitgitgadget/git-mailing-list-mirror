Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A028F202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 22:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdIVW67 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:58:59 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:53087 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIVW66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:58:58 -0400
Received: by mail-pg0-f52.google.com with SMTP id i195so1301816pgd.9
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2zOCRvg9tmFctVY8W/sin/4O5Sc5b4HFFHrJix7Uek=;
        b=p8CEQWu/AzUWnM38k1NmQyZcUDjPeYKI7gmd8tTE6frMt8rJfur2lmWzuXdd3euwm8
         NR+a4Z3t3Y9yBGOKVXKRUjjKTGvygEKdJ6VY1mv/u17sUJ+gjnBAx9j3VJseYysV6vT9
         eKaMH3FrLm5QCCmXxYtMworYK02b5M6Xkqn/py9GFGlFB/m5FG6dfVEjo/7pHzFFmJ9p
         oGXiGG9jK2sIGmpJBe4i737uNwQ67Dhx3C6+rC8r5RG0RDa5a6JvLs+PdpdBHXspMG8f
         uy+vWzcJOgaYT+siDWeBYnUegQ5f+YpulPQf9LR5a1Y7Q7wx7m0Nfr7T84VbxW0xLbFi
         Y3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2zOCRvg9tmFctVY8W/sin/4O5Sc5b4HFFHrJix7Uek=;
        b=QRRsUhDbbtqtXLdm0ujOoeLTVyItZtFFN9J5Upy6PLGydgz8c73JaAokNIBfKQ0sn+
         26GNeuwyr4soFs4tpZLet57hbhdauk1Fr0TW1o6h2o+mFe2yhJe9HAw/8aiQOEUcsiei
         G3fL1gQ+EjNOhjWGoH3qeTIQgmMDiaBpISFVfsCMIPZ9ORb7eoq1BFLfv9klb9xAWeLR
         p+KpxoTPbUO2smP6fq/mzdSdj6wkSyq3N4B1BS72y7BUvbJMnoGCqVUsOA2nl8vbA/Cw
         opujhQ/Li8RvhCR4P/uEWF1dGpRzsgKzB3xASo+Cjaol418vSVASUMOMchvZOBMEVqXj
         3ycw==
X-Gm-Message-State: AHPjjUgvBPoV3xWCMiDEWKdag7JCw16aqpb9bBMBr8piUWk3Q6Mu4Qqa
        ope3PNh0T6qcE0emopxf3zX7AXxU
X-Google-Smtp-Source: AOwi7QA//8HkFniqDDcdFllvnru902cn4Ln7s7+IIgtXjRf0O6gRkhkseFwGe2UX+niE+keLeiTZgQ==
X-Received: by 10.98.34.149 with SMTP id p21mr556222pfj.322.1506121138195;
        Fri, 22 Sep 2017 15:58:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:a8e5:9a8:2d5b:f3dd])
        by smtp.gmail.com with ESMTPSA id x27sm1040763pfe.65.2017.09.22.15.58.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 15:58:57 -0700 (PDT)
Date:   Fri, 22 Sep 2017 15:58:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2] Documentation/config: clarify the meaning of
 submodule.<name>.update
Message-ID: <20170922225855.GM27425@aiede.mtv.corp.google.com>
References: <20170922213740.GL27425@aiede.mtv.corp.google.com>
 <20170922225250.19705-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922225250.19705-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> Jonathan writes:

>> You'll want to update Documentation/gitmodules.txt, too.
>
> No. /grumpycat
>
> It should already be fine, as I read it as if it is only relevant to 
> "git submodule update" there, already:
>
>   submodule.<name>.update::
> 	Defines the default update procedure for the named submodule,
> 	i.e. how the submodule is updated by "git submodule update"
> 	command in the superproject. This is only used by `git
> 	submodule init` to initialize the configuration variable of
> 	the same name. Allowed values here are 'checkout', 'rebase',
> 	'merge' or 'none'. See description of 'update' command in
> 	linkgit:git-submodule[1] for their meaning. Note that the
> 	'!command' form is intentionally ignored here for security
> 	reasons.

I disagree.  Actually, I think the git-config(1) blurb could just
point here, and that the text here ought to be clear about what
commands it affects and how an end user would use it.
