Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716AD2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdI0TwE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:52:04 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:45983 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdI0TwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:52:03 -0400
Received: by mail-pf0-f177.google.com with SMTP id z84so7777681pfi.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48ybebgBGiwkA2hKTpJsZCsE25Piue4mptauucRIfoE=;
        b=YlgCehF7trqfvlLggzxrUpdt4lkdNSMTvOUDlW26oEDgkd1G4u9lxgM888TNwp0K5j
         LqtF+xw8w3vVfIUdJkmVDSJi/GgGqPYkLn/3yvzHmXi5LQGnbdct6YwrW2Fqls3ytr7s
         zBgZdgx02RtCuXTNJbrFgEq1g7elNt4StHrrkvuGVd0cVQ1IDkcPcGEm0Hr1Qvlr25JC
         +cD0WzRoJTqLO4z3I85LUYVIfCIAO2fIL1Xgcb90aopkLnlJmTJYONiM37CTpJy0QVMr
         BO8DinXdQlWVzXqSCEvjiHlUuxsfKKAPRZVLgn7mNwaxAGxzBlG7De0FNWyJk0io8V7L
         HHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48ybebgBGiwkA2hKTpJsZCsE25Piue4mptauucRIfoE=;
        b=qwtVPCF/vctMTjWs8ZXkgkAvN9bKuat132hGKx1SkjYFEe4zqv/U65/kbPJ8JP7eek
         h0VOqSq4E5kMOou6z4qmmR6IrbUYv+UT19tIf9cmmyyA9F3xTphTaI6JSoEf29sVxoy4
         C+HfErdqBt/Hy72IHHjJqCHH8C6W+EnoWbQyqhfar8iKtg/YtsdT7z9yt2PFrOKtR/35
         ZcLVMEExxNfaigPA9nbH0QlfNbDEb8B9Q/8K0+RDfuIFw4o+e7FnVMU2MHEXrXd/z21T
         E+Bm+zEbJfHQSe+jt5TNpAaj8V+niderSf3FqQmdqGrliwrMvJdDIcCgfRsm5VMolXTL
         DBaQ==
X-Gm-Message-State: AHPjjUjSc94IBX/DJoawTY6JiYj7hU0eDB0ahHVvwko7OWpsWSfgMOOI
        USX57MYNgpJYdPDW3MWrJB/nG8xy
X-Google-Smtp-Source: AOwi7QAOzk6ysEMz0ItKEdHeq5GcjYXef0nYVny5jnzx1rL5hKTzOlxmJ1aufuRAkFOdNaVjwqmPCw==
X-Received: by 10.159.194.137 with SMTP id y9mr2125223pln.77.1506541922734;
        Wed, 27 Sep 2017 12:52:02 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:1558:8bd:d6aa:64f8])
        by smtp.gmail.com with ESMTPSA id y13sm22481272pfi.27.2017.09.27.12.52.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 12:52:01 -0700 (PDT)
Date:   Wed, 27 Sep 2017 12:51:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20170927195159.GE19555@aiede.mtv.corp.google.com>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
 <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Wed, Sep 27, 2017 at 07:28:49PM +0200, Toni Uebernickel wrote:

>> The previous version was v2.13.2.
>> I switched back to this version, and it works perfectly fine; without any changes to my system.
>
> Thanks for confirming.
>
> There aren't a lot of changes to the script between v2.13.2 and v2.14.2.
> The most plausible culprit is d5addcf522 (add--interactive: handle EOF
> in prompt_yesno, 2017-06-21), but I'm scratching my head over how that
> could cause what you're seeing.
>
> Are you able to build Git from source and bisect the problem? It would
> help to know which commit introduced the problem.

How about this change?

 commit 136c8c8b8fa39f1315713248473dececf20f8fe7
 Author: Jeff King <peff@peff.net>
 Date:   Thu Jul 13 11:07:03 2017 -0400

     color: check color.ui in git_default_config()

Toni, what is the output of "git config -l"?

Thanks,
Jonathan
