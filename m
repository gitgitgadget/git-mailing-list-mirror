Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9050F1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGSOGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 10:06:01 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36242 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbeGSOGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 10:06:00 -0400
Received: by mail-pg1-f169.google.com with SMTP id s7-v6so322397pgv.3
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mF0r7sbAvYrY9N+ufrg2kYX8rz/JDsForLxXoxsbZT8=;
        b=gH5ad7ATKd0BlOmKajv6iS8JPjosJffsUUd+8sNnzmQlLgcyO0bE+1tVs5aSa+uliE
         DdVWy/mRlQGS7DdvIp0RoGH4t6UyZElD3oOWsZ+Iyl2vEL7ikdF0WY7ptSU3eGHAsZk7
         T/Qg9L4NiBPinvSTUl/Rz5tFf/sdZNG5bw2EkO/dpXuPuHyqHAkkADV5mSmyG5vIk47e
         jcwx6XpntIBfQ/3EI3w68GbD8L+yJm7ijq1x4huMN9ySZbPWTPlvR/L5zIw+9k/nSwsM
         EQ67UnqF26vN+hz5JlUhlSGZRY4jdcSOAYa506kUxd6+6O95nuUBQ5kof7Jlk4ZoVVTz
         srlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mF0r7sbAvYrY9N+ufrg2kYX8rz/JDsForLxXoxsbZT8=;
        b=rYxZaPG5Zj31ZzRLfbHM5fORnQAGUoAczTCi8nA1Z6fwEQZV2CpYRchqzpY2H+Yal1
         Zp7x7KUOg4+WcmDJ7FIIA0QNJ4bOPwvenkdzPb/aS2CCoDkxSY0OubGrq/cA88gHVycO
         lJJ4tSzNjOR4hETD/ezY92dZnR/6s+5z9w8xLqfvhuPtRgO8jIw+nEC5wZMLXlY3S/EU
         QLW/QhCmAuB0kwcrJEyAOtuZIfnsSWbtvyBUE9q7gslk6SZoOfcxf1+/Z9YvJky6xSuJ
         FAIUmCd5oaoeHeSTdl2wmnnUBRDpsKSd7zfyvIGyiJx+/BJW7FiDg6dXaohpLRi1nN7h
         6jmw==
X-Gm-Message-State: AOUpUlHt7sLDcc7Ep9lBja+VSwEonT81JHkz++Nvk73KRicA2gRRUH5C
        LTUqv5YdDWA+nhNpwGJC4sMVPqFZd9I=
X-Google-Smtp-Source: AAOMgpcfub8gRbMiq/j3RW+VSiEXFJ0S+vXiO8S7uR6F6v4pKXDDHC0jLC8HxFG5oeQn5AgiY89Owg==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr9718493pfn.18.1532006571639;
        Thu, 19 Jul 2018 06:22:51 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([183.83.81.223])
        by smtp.gmail.com with ESMTPSA id u71-v6sm12103559pfk.174.2018.07.19.06.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 06:22:50 -0700 (PDT)
Date:   Thu, 19 Jul 2018 18:52:47 +0530
From:   Sitaram Chamarty <sitaramc@gmail.com>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Use different ssh keys for different github repos (per-url
 sshCommand)
Message-ID: <20180719132247.GA16497@sita-lt.atc.tcs.com>
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 03:24:54PM +0300, Basin Ilya wrote:
> Hi.
> 
> I have two github accounts, one is for my organization and I want git to automatically choose the correct ssh `IdentityFile` based on the clone URL:
> 
>     git@github.com:other/publicrepo.git
>        ~/.ssh/id_rsa
>     git@github.com:theorganization/privaterepo.git
>        ~/.ssh/id_rsa.theorganization
> 
> Unfortunately, both URLs have same host name, therefore I can't configure this in the ssh client config. I could create a host alias there, but sometimes somebody else gives me the github URL and I want it to work out of the box.
> 
> I thought I could add a per-URL `core` section similar to `user` and `http`, but this section is ignored by git (2.18):
> 
>     [core "git@github.com:theorganization"]
>         sshCommand = /bin/false
>         #sshCommand = ssh -i ~/.ssh/id_rsa.theorganization
> 
> I thought of writing a wrapper script to deduce the key from the arguments:
> 
>     git@github.com git-upload-pack '/theorganization/privaterepo.git'
> 
> Is this the only option?

This is what I do (I don't have two accounts on github, but
elsewhere; same idea though)

    # this goes in ~/.ssh/config

    host gh1
        user                git
        hostname            github.com
        identityfile        ~/.ssh/id_rsa_1

    host gh2
        user                git
        hostname            github.com
        identityfile        ~/.ssh/id_rsa_2

Now use "gh1:username/reponame" and "gh2:username/reponame" as
URLs.  It all just works.
