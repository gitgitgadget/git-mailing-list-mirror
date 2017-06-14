Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2F020D21
	for <e@80x24.org>; Wed, 14 Jun 2017 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdFNRqw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:46:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33053 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdFNRqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:46:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id a70so935071pge.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nZw/4ILBi2EOoXcaz+438yHSMyVxFqda82w+We0F+w=;
        b=deDXK4BpOL2nkpQR5QqXoN65vhquR4W8PyDCMZ7XaPjbrDCVXGA4vPoudorQ0EJ7Iv
         EVrbe3l69Yr1mJG5uC/nDf1kgBEzzs9aK8BW5wNDSueSiZGRc7PInt0JzHq2xWOAc71d
         5ra5hXn4S48wRwWkw/v+hKbN5OhHj0fnQbvhM8DQc464NqVLvA42Ih90O5KtQRMgVHS1
         9jovH3NBjdaIZZl1OvSNM9PnzpYCtwHenrvMvcDy8fK1tU8FDzkyN4SECAxb4ihKk6gd
         NcAZ6z4BquBIf+TV0Nf3ky4udlUIf2hsqbiNxZIkmGGVQZtaDEHPKy2q5vRa7kUqe6pZ
         oFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nZw/4ILBi2EOoXcaz+438yHSMyVxFqda82w+We0F+w=;
        b=Ot+ihqOQMUcQQLOSSF8A2je2Y0DVw7oN5I/Cej+uFab82+jc7tPefPdWJgXzriQYHS
         bHctgPuE8+n7DVgf6KxcuEl/Z/Pf9j9KELe4BdJqFMzJnh1BmifkWoyG7Wsuw8dtP4uW
         Z15wBCEp2x5o1A3A/Q33u8knvMNN2hatV0DgwNXNGstYIczAmpHCZv2QNgJejmnoA8cU
         wJNF80xD+b98X25eR3o8ZEuCUe43eGsWb4Uc5OIy81HsMNasMPf7rhvQ11aLAvF+jTZ3
         DMRMgotDuPHNV2oVCfyKaxtmyIHS0wMVoV6gVYI/Qt+1fZCOgrEpafLhP3e5lh4+guRI
         ZmJA==
X-Gm-Message-State: AKS2vOyv+Gw8CI9RLSdBeNMS4e489kvRJzj/TeDDPZQjL9R9z/R9SFW6
        ToSh3svwEzKxAA==
X-Received: by 10.98.14.79 with SMTP id w76mr1106718pfi.63.1497462410504;
        Wed, 14 Jun 2017 10:46:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id 69sm1085745pfy.119.2017.06.14.10.46.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 10:46:49 -0700 (PDT)
Date:   Wed, 14 Jun 2017 10:46:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v3] Configure Git contribution guidelines for github.com
Message-ID: <20170614174647.GV133952@aiede.mtv.corp.google.com>
References: <20170614073536.45498-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614073536.45498-1-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider wrote:

> Many open source projects use github.com for their contribution process.
> Although we mirror the Git core repository to github.com [1] we do not
> use any other github.com service. This is unknown/unexpected to a
> number of (potential) contributors and consequently they create Pull
> Requests against our mirror with their contributions. These Pull
> Requests become stale. This is frustrating to them as they think we
> ignore them and it is also unsatisfactory for us as we miss potential
> code improvements and/or new contributors.
>
> GitHub contribution guidelines and a GitHub Pull Request template that
> is visible to every Pull Request creator can be configured with special
> files in a Git repository [2]. Let's make use of this!
>
> [1] https://github.com/git/git
> [2] https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .github/CONTRIBUTING.md          | 19 +++++++++++++++++++
>  .github/PULL_REQUEST_TEMPLATE.md |  7 +++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 .github/CONTRIBUTING.md
>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
