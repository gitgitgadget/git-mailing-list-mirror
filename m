Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001B01F403
	for <e@80x24.org>; Tue,  5 Jun 2018 22:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeFEW3X (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 18:29:23 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38031 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeFEW3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 18:29:22 -0400
Received: by mail-it0-f44.google.com with SMTP id v83-v6so5498604itc.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0KPZZI/FEyhDnLZHK2EVH9NsS4J9Sa15yEGg7tjTOI=;
        b=xOjVfWwHzOo3AckmgetQiyYHl0tmfqWYdP/CQ4lPNshtU6ZIRyfkHDx7nWEKafL8vH
         1DPp7Hg5/DXj/QUgLRS+yGmqIQXBJjCKJvETuJ8xc9V6c/MPwxLLElIaYAQmyzKHC2a+
         H1oOCfs2pyNtZx3q5dsk120H5yCXjHaCF02WoLvHZQHN4eFB68gCAvl+hWnCmjn3ErSa
         /3z6+MfchxHuJtPi+vUmBvt1ihRpTRqjCihfvH+aUwCVuAHL7CyRyXTiCkx+Qfrdw+Yx
         ohjvDS5jkANvOk4r6mwwjaCaOV60u1c7rIQEsHieA2DMkf42fIL2exyCDUt9SEk98PpO
         8cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0KPZZI/FEyhDnLZHK2EVH9NsS4J9Sa15yEGg7tjTOI=;
        b=iPg0FhdTsU5o/+Xu3K+qEIKy6Oh1kfO8Tb8eO5YXnl7kel9Xj2O6w5Hz+5+vTuPmec
         GiRQxBjonQG68IVuuwVAUaIjjTbhOzo8nyG2JXw7X2BCYfQe9ZWlH0mJYEPAyS5Ij/pY
         wL2In6OY4ahPITvyQ5dukEOdVpBmquRnL61MhvVcG9+hp+aMtRNsPNX115aOl0eC4D8Y
         m7H61GChz/vCfdwuDdCLmHuEUqnnPiNJ+XAa+1zl33IThi3wvGn6AG9YkFHpAGxohkt5
         8oElqh4WQiNjWL4OeUBNCfCQ7g3QwkuqpPY301kLFDOVUSrhfcef7wUZkPhyQ2xj0MgE
         EPKg==
X-Gm-Message-State: APt69E1bCu3jviMQT2QW4AbIauFBdBtmu2DnKceqD1EnpgmRpcKZXuP0
        IAsRRUUxuLKTY2ji0SXIIoWfd1f/RblRYDnCWrHxyA==
X-Google-Smtp-Source: ADUXVKIxPbKwz5bin5ZdMajM0VQXEDKhpUxIZRIgFQYWc7ByZwj9/VIFv56KGM2bRG8nLnKQH2l8eTRB6i2J9S0DHJY=
X-Received: by 2002:a24:4689:: with SMTP id j131-v6mr100110itb.111.1528237761230;
 Tue, 05 Jun 2018 15:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
In-Reply-To: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 5 Jun 2018 15:29:10 -0700
Message-ID: <CAGyf7-GN=wx4cc7WxbmMweC0VSnp_9aZ8fTUGE0W6vLK63qpVw@mail.gmail.com>
Subject: Re: git question from a newbie
To:     SHeinz@aaanortheast.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 2:33 PM Heinz, Steve <SHeinz@aaanortheast.com> wrote:
>
> Hi.
>
> I am new to Git and have read quite a few articles on it.
> I am planning on setting up a remote repository on a windows 2012 R2 server and will access it via HTTPS.
> I am setting up a local repository on my desk top (others in my group will do the same).
> On "server1":  I install Git and create a repository "repos".
> On "server1":  I create a dummy webpage "default.htm" and place it in the repo folder.
> On "server1":  I create a web application in IIS pointing to Git
> On Server1":   change permissions so IIS_User  has access to the folders.
> On "server1":  inside the "repos" folder and right click and choose "bash here"
> On "server1":   $ git init  -bare    (it's really 2 hyphens)


This might create a _repository_, but it's not going to set up any Git
hosting processing for it. You might be able to clone using the
fallback to the "dumb" HTTP protocol (though I doubt it, with the
steps you've shown) , but you won't be able to push.

You need handlers for git-http-backend which handle info/refs and
other requests that are related to the Git HTTP wire protocol.[1]

Documentation for setting up Git's HTTP protocol via Apache are pretty
easy to find[2], but IIS instructions are a bit more sparse. I don't
know of any good ones off the top of my head. But that's your issue;
your IIS setup isn't really a valid Git remote; it's just a Git
repository with contents visible via HTTP.

[1] https://github.com/git/git/blob/master/Documentation/technical/http-protocol.txt
[2] https://github.com/git/git/blob/master/Documentation/howto/setup-git-server-over-http.txt

Bryan
