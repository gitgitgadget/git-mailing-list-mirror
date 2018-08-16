Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D581F404
	for <e@80x24.org>; Thu, 16 Aug 2018 07:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbeHPKZN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 06:25:13 -0400
Received: from server65.mylittledatacenter.com ([78.46.58.69]:44245 "EHLO
        server65.mylittledatacenter.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389332AbeHPKZM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Aug 2018 06:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hadisafari.ir; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LkiP8HD5v/QWGWbQS0rk7Gr2t/Xq62PXhP0bcUkzdsg=; b=0FySOArAH9LUREQboYxZrBAYmV
        Luc1VIpU6e7ZnLabneVsGL2/l0g+uTEGayldaS1UexAltq3GpekRVXMEkMc2nb2s5tzXlCjR2zaTe
        jdxAZHCkA+QNCf6qzDn9YcCtzr3u6Mag7DCI2QAwXQFsfnBBtv1+QzizOvPBgKSG8it210O60zCZW
        4Y1rJBZAXL/aBmVq64tYmU2DxM4nSfYW2otZONYglMJ/evZV3oFuLjrUkwo/CkFUKpJGLrI22PDa5
        C7id7DLw52tCvmsCLgnBMNhvyYISBR3MUEYJgmNVdQZ43gtfo7uKYVY3XZlKQ3vBm24VWqlHs7fHz
        EeefMdWQ==;
Received: from [5.112.80.61] (port=9016 helo=Hadi.local)
        by server65.mylittledatacenter.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <hadi@hadisafari.ir>)
        id 1fqChz-00BaVM-SC; Thu, 16 Aug 2018 11:58:40 +0430
Subject: Re: "Changes not staged for commit" after cloning a repo on macOS
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
References: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
 <20180816062317.GA5080@tor.lan>
From:   Hadi Safari <hadi@hadisafari.ir>
Message-ID: <d132cb0e-97f2-708c-83b2-124ee4569e17@hadisafari.ir>
Date:   Thu, 16 Aug 2018 11:58:33 +0430
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816062317.GA5080@tor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server65.mylittledatacenter.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hadisafari.ir
X-Get-Message-Sender-Via: server65.mylittledatacenter.com: authenticated_id: hadi@hadisafari.ir
X-Authenticated-Sender: server65.mylittledatacenter.com: hadi@hadisafari.ir
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/5/1397 AP 10:53 AM, Torsten Bögershausen wrote:
> This repo seams not ment to be cloned onto a file system, which is case-insensitive.
> For example, (see below), this 2 files a different in the repo, but the file system
> can not have 'WordPress' and 'Wordpres's as different files or directories at the same
> time.
> This affects typically Mac OS and Windows users.
> 
> There is actually some work going on right now to inform the user about this problem.
> (Thanks Duy !)
> If I clone it with a patched Git, I get the following:
> 
> 
> git clone https://github.com/kevinxucs/Sublime-Gitignore.git
> Cloning into 'Sublime-Gitignore'...
> remote: Counting objects: 515, done.
> remote: Total 515 (delta 0), reused 0 (delta 0), pack-reused 515
> Receiving objects: 100% (515/515), 102.16 KiB | 35.00 KiB/s, done.
> Resolving deltas: 100% (143/143), done.
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
> 
>    'boilerplates/Gcov.gitignore'
>    'boilerplates/Nanoc.gitignore'
>    'boilerplates/OpenCart.gitignore'
>    'boilerplates/SASS.gitignore'
>    'boilerplates/Sass.gitignore'
>    'boilerplates/Stella.gitignore'
>    'boilerplates/WordPress.gitignore'
>    'boilerplates/Wordpress.gitignore'
>    'boilerplates/gcov.gitignore'
>    'boilerplates/nanoc.gitignore'
>    'boilerplates/opencart.gitignore'
>    'boilerplates/stella.gitignore'
> 
> Would this text help you ?
> 
> I am asking because the development is still ongoing, so things can be improved.
> 

Yes, thank you. It's clear and helpful. I got what is happening.

-- 
Hadi Safari
http://hadisafari.ir/
