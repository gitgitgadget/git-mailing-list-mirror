Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01BE20D0A
	for <e@80x24.org>; Mon, 29 May 2017 21:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdE2VF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 17:05:29 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:2742 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdE2VF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 17:05:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wc8Qb5nVSz5tl9;
        Mon, 29 May 2017 23:05:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6BCDD303E;
        Mon, 29 May 2017 23:05:27 +0200 (CEST)
Subject: Re: Error with Templates: Could not find templates on cloning but on
 creating
To:     Mathias Artus <mathias.artus@pecont.de>
References: <201705291120.v4TBKfkV082879@mikako.shopkeeper.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa99116f-ce82-f7c6-30ed-807c873c3634@kdbg.org>
Date:   Mon, 29 May 2017 23:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <201705291120.v4TBKfkV082879@mikako.shopkeeper.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.05.2017 um 13:20 schrieb Mathias Artus:
> Hi,
> Today i've tried to set up a template directory. I added in the system wide gitconfig the following lines:
> 	
> 	[init]
> 		templatedir = "//OurServer/SomeDirectory/GitTemplate"
> 
> Where //Ourserver is a Network Path.
> With this line i can create a new Repository and the template gets copied. But when i clone a repo the following error shows up and the template doesn't get copied:
> 	templates not found /OurServer/SomeDirectory/GitTemplate
> 
> I Recognized that one slash was missing. Hence i added one:
> 	[init]
> 		templatedir = "///OurServer/SomeDirectory/GitTemplate"
> 
> Fine, cloning works after that, but creating a new repository then shows up a Warning:
> 	templates not found ///OurServer/SomeDirectory/GitTemplate
> 
> Is that a known bug or is it my Failure?
> 
> I use git 2.13 on windows 7

I cannot reproduce. I'm on Windows 8.1, but I wouldn't expect that to 
make a difference. Are you using Cygwin's git by any chance?

-- Hannes
