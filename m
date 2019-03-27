Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F7820248
	for <e@80x24.org>; Wed, 27 Mar 2019 21:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfC0VKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 17:10:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37890 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0VKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 17:10:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so10291249pfo.5
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d7odEyiOAguby8XHPhcgfnEPgBxlFThIhfnsFimakVs=;
        b=EGSAfffdfaiG3YOlXA5GgUvraYKcWyGR/B+LOs/OnUZYZ2snFx1xxNs5xwWFkfuoNq
         fvxR40tiU13NVQLoPEaCPkqItlrmEaqZB12NmxT0ZXhi2qZ7m03ycJPaIFRXz6uWM+IQ
         HP1ufOV5Vj40jCFPMSuk6iV1uZbm4qA1AYoyGdIxcUMfnuBIu8tdc5UP5rPUpFm4mtcq
         Jbiw1nM8HOgMRBuxjcYqw1A7nRkXDf9rhw0K5sTWJktef6hIixuok+ovvr3oFlyzNCNC
         oqC/nfI73eb4T2MFhPUy5Pe1bfF/EzpQ2ijYMsY9+T6VfmN6OUgzVyLQzEAkzvxGf20m
         RHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d7odEyiOAguby8XHPhcgfnEPgBxlFThIhfnsFimakVs=;
        b=Xvs151CSl6NuY1EpzCxYcBJwmeS6oKWebnEZ6zV8w9sjf4c0RI3Q0UVjVOQDZVxjhP
         0tHll0zIN6ihOcgmgDeEIFKwwjz/M3G6ONbE4aD9VzuZxiVBIZikmLU5dDybaWlZK7IX
         AX4wKSyRwckbB4FU1YTIjcBWViaGe4ny2Uskit/X4EFefmO8rCNDDCqHKfXpddd5MCZM
         fWbGQBce5cyAQs+t3O+SryDxFtN8VF2Jq3Vy31lYmOiFiZ3ey9IH3b0i7/7JlNclEeS8
         KzVXAOchpHT9enz/1VgFSBjTa2+XL843zxNoaBQ8lMFMHq7i4ltS4YKBi/6XGK2KyUEm
         FolQ==
X-Gm-Message-State: APjAAAXo4DOdLp7sOwoT6GQzYh29GUBd2Cjo6UuZpq8SmW9slbQ4znA9
        JVBDFr1ZOTNys/RrpaypFaw=
X-Google-Smtp-Source: APXvYqzC+80Sg55onkj0Yl9qxZX4QZoyU0FBmrMamU/bRSSSvosTf3JiNLQW9D9VC/7bJ+pNBRYvFw==
X-Received: by 2002:aa7:8208:: with SMTP id k8mr20178956pfi.69.1553721053110;
        Wed, 27 Mar 2019 14:10:53 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id w21sm4162985pfn.48.2019.03.27.14.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:10:52 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:10:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Julian Cheng <julian.cheng@utoronto.ca>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC] [t9803]
Message-ID: <20190327211050.GA4062@dev-l>
References: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Julian,

On Wed, Mar 27, 2019 at 07:26:12PM +0000, Julian Cheng wrote:
> Hello Git Community,
> 
> I’m new here and hoping to get to be a part of GSOC 2019. I have questions about the main project and the microproject
> 
> Main Project Quesctions
> I was hoping to work on “git revert --drop” and “git commit --reword”. Are there any mentors available for this project? The ideas page lists mentors for other projects but not this one.
> 
> Also, “git revert --drop” and “git commit --reword” appear not to have been discussed yet in the public inbox. Is this correct or am I just not finding the threads?
> 
> 
> Microproject Questions (test_path_is_*)
> I would like to improve t9803-git-p4-shell-metachars.sh 
> 
> On the microprojects page, it suggests I should run the tests to make sure they all pass. But if I’m making changes to the tests, is it really adequate testing just to make sure they all pass?
> 
> To run all tests, I assume I would just navigate to the tests folder in terminal and call “sh *.sh”, but that doesn’t seem to work. Also, when I call “sh  t9803-git-p4-shell-metachars.sh”, I get “error: GIT-BUILD-OPTIONS missing (has Git been built?).” Git is definitely installed on my computer though. I’ve been using it for months. I cloned this repo with Git. What am I missing here?

When the tests run, they don't test your installation (the git you're
currently using in /usr/bin/git). They test the git you've built in the
project directory.

First of all, you should build the project. You should run "make" from
the top-level directory of git. This will fill the directory with git-*
executables. These are the actual binaries that will be tested.

Next, go into t/ and run "make" again to run all of the tests. You can
also run individual tests by doing something like
./t9803-git-p4-shell-metachars.sh, for example.

For even more details on testing, see t/README.

Also, some other helpful documentation to read include:

* Documentation/SubmittingPatches
* Documentation/CodingGuidelines

Hope this helps,

Denton

> 
> Best,
> Julian
