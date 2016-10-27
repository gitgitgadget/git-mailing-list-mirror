Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CACF20193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030452AbcJ0V0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:26:33 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38743 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964938AbcJ0V0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:26:32 -0400
Received: by mail-wm0-f51.google.com with SMTP id n67so74843416wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=a160hl9mXdQL6TKmnggdUklmfjalYrMyrap+ilFmoAE=;
        b=Y8/tGgDa+Vd0azE24hprXRrmRrf5KHfTj4MXttWWnq+dB5GV7skgf8XVQEx6RVtMjG
         c4E35fP78sMG08zHd43wchZDOnNyaQbgjJWw5pRvohxUHGCBFNjS5k5c9JRWpLvYjJVM
         reBNzqGmQiLRdjbdGDPW1fFKWkDZZbg6T7oT82C3JokAsNtrEP7+RTC7d1iB/iQHi/Jv
         o1SgZ6JO2ypKeCd/PnPHi3c9ofwIJDdnn5FaPsyQUENUY7p1kHdJKj7c2u05bXYTDepW
         lBAYxGPba997Gh04VjNF/ajOTrMLvaHL/1Hi6DymEbPumWP5LMgY/35V78KMTsoZrbYF
         JETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=a160hl9mXdQL6TKmnggdUklmfjalYrMyrap+ilFmoAE=;
        b=dAHlf1omaRxbuxLwf0vuNT2tWGt9cB3S5PKryp+/XdFdgh1Gls24p1Ofc0pFQBOMxc
         xS0/eqA6VbNsgkYhO/ouEeEqoAeH9z1Gv3p3gk10kHRAiQWbK7LAqdGaLBfwPj2Rmv0O
         zqlcp3yPjZVwFSUyV0MSfU3w9eX8QnHsllpNMiVuFBSPWENynqP2D5+6CtdmwlhSf9t9
         R6zoLAJGKjb2PF51fnFFzuIKbMUrInfqnlqmqWP6L9FV5+hBSCt8Du4/7fj5gnoI1f2D
         968doU+T1sR5Uo69G2xcXE8D4M/et8JI8N8GaBoZz1r27QvKNB6PzEn9Z7sr67KvX8gb
         nHMQ==
X-Gm-Message-State: ABUngvd0pRJ/mhsPTbFM2wRsY6qc/5wB4IN0w03Lx6I4zXMy8JyDT/+WkvnCIzwqbUSYeQ==
X-Received: by 10.28.48.203 with SMTP id w194mr663899wmw.115.1477603591263;
        Thu, 27 Oct 2016 14:26:31 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id gk6sm10584158wjc.21.2016.10.27.14.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 14:26:30 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
 <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <dc71f67c-e244-c3f7-534a-1d946c2324d0@pelly.co>
Date:   Fri, 28 Oct 2016 10:26:25 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 10:04, Jeff King wrote:
> On Thu, Oct 27, 2016 at 12:48:34PM -0700, Jacob Keller wrote:
> 
>>> I think the normal behavior in such "foo.d" directory is to just sort
>>> the contents lexically and read them in order, as if they were all
>>> concatenated together, and with no recursion. I.e., behave "as if" the
>>> user had run "cat $dir/*".
>>
>> Yea, this is the normal behavior, and the user is expected to order
>> their files lexically such as "00-name", "50-name" and so on. Pretty
>> traditional for a lot of newer configurations.
> 
> One thing I will say about this approach is that you can implement it
> without any changes in git by doing:
> 
>   path=.git/info/exclude
>   cat $path.d/* >$path
> 
> and I have seen several config mechanisms basically do that (e.g.,
> Debian packaging for a program that doesn't have its own ".d" mechanism,
> but needs to grab config provided by several separate packages).
> 
> The reason to teach that trick to git is convenience; you don't have to
> remember to build the master file from its parts because it's done
> dynamically whenever git needs to look at it.

Precisely.

>> One thing to keep in mind would be that we should make sure we can
>> handle the .gitignore being a submodule or a git repository, so that
>> users could just do something like
> 
> I'm not convinced this is needed for in-repo .gitignore files. The point
> is that you are pulling together separate files that may be administered
> independently. But git repositories inherently have a whole-project
> view. I'm not sure that separate files buy you a lot there. And the
> compatibility issues are more complicated.
> 
> I do agree that:
> 
>   cd .git/info
>   git clone /my/exclude/repo exclude ;# or exclude.d
> 
> should work; ignoring dotfiles when reading the directory solves that,
> and is a pretty standard solution.

You raise a good point about the requirement. I was about to make an
argument in favour of it, but I argued myself out of an argument. I will
say; why have it work in one place and not others?

