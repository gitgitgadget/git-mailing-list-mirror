Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F8120248
	for <e@80x24.org>; Thu,  7 Mar 2019 20:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCGUHT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 15:07:19 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:44277 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfCGUHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 15:07:19 -0500
Received: from DESKTOP-E4U7JCE ([5.168.27.16])
        by smtp-31.iol.local with ESMTPA
        id 1zIRh7lRaCH4t1zIRhxOiY; Thu, 07 Mar 2019 21:07:16 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551989236; bh=U7AiY5uBDXXCS5XCoOEaLHbJFe0tD6zh909lxff8Wgo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Lb3DbLoAcAhMlQ6NtXPJRk5ap7pzgY2bKV8aVwNK7GZChjf/64aIr96fAt8kuIHQt
         R7eO1kz0scZpBLcBU0qrTBtV8tMpYAPhM5VKjU1ld7Pc53Z+qDNL18az5LyB0SPLBG
         y10egG03yehZv2HaNUUtoSINjn3g/PkKGHBUVXlwur42Y10mPl8SGP4I0vk1hAS7At
         BAOJySnpHfyyYNupkTz31OH1aZuRZucnIw8U251YDpP1ZRu6TMiZtc1qEy61VJAp7a
         Ktm/o1+ID/LOmh5j36uCgTnvdEJP+WIgzCAuR7peP+MLoRYTz3qGFjk73OBx7HcquY
         8IIOkuRn/b5BA==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=wkB5e7ySmgWO9ZIu7OSBqg==:117 a=wkB5e7ySmgWO9ZIu7OSBqg==:17
 a=IkcTkHD0fZMA:10 a=AFfvGgbAPDkJUd3kWr0A:9 a=PKot6ye-Ful4Ar5Q:21
 a=t5WU_LRf5y9J3MME:21 a=QEXdDO2ut3YA:10
Message-ID: <1551989235.1606.3.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Thu, 07 Mar 2019 21:07:15 +0100
In-Reply-To: <20190307194146.GA2453@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
         <20190304204007.GA32691@sigill.intra.peff.net>
         <20190305191519.GA12791@sigill.intra.peff.net>
         <1551902320.1727.1.camel@libero.it>
         <20190306200356.GB23315@sigill.intra.peff.net>
         <1551905579.1727.8.camel@libero.it>
         <20190306215752.GC32630@sigill.intra.peff.net>
         <1551985495.1606.1.camel@libero.it>
         <20190307194146.GA2453@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDJ2UF5XvKu1zGuodEmweYcU7GGSYlnafVlY6odtWAa5B0ETY3NL8lZC/15s1oLmL8YtPbySB/hKtoM4WH02w6UngQMIh8M5kbz4Vayt2ube8qt5TWlu
 SAPVXvrcBrkKV/528tjY8ftHpsFRZV1cFT/xd11SC+9pI412Bl8r2yx8Vb4lMHJObkNO+gg4HkPhIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for forgetting the cc!!!
Thank you so much for help, hope not to bore you all ;)
I think that I will go on studying git this way, and follow all the 
improvements that were made along his history. I think that
asymptosis too gave me a good link, related to that bash script
implmentation.
Thank you Jeff, now I'm trying to understand how could I show the
contents of the index in that version.

Fabio.

Il giorno gio, 07/03/2019 alle 14.41 -0500, Jeff King ha scritto:
> [+cc git@vger; let's keep this on the list; I'm not sure there's a
> lot
>  to be learned from fiddling with this old version, but if we're
> going
>  to do it, let's at least record our attempts for posterity]
> 
> On Thu, Mar 07, 2019 at 08:04:55PM +0100, Fabio Aiuto wrote:
> 
> > I made a directory "trial" and inside it I ran init-db (that's the
> > grand-father of git init) inside that directory. Then I created a
> > file 
> > this way:
> > 
> > echo 'helloooo!' >file.txt
> > 
> > then then executed update-cache file.txt (thinking that's the
> > ancestor
> > of git add), but that doesn't work and it returns with a
> > segmentation
> > fault, due to the nullity of the header. But in this first commit
> > how
> > do I add a file in the cache? What's the right way to build up a
> > repository from scratch with commit e83c5163316f?
> 
> Hmm. I tried that, too, and got a segfault. Then I tried it again a
> few
> minutes later, and it worked.
> 
> One thing that seems to provoke it consistently is having a zero-
> length
> index file (because that causes mmap to return NULL, and the code
> does
> not check for that case). Try this:
> 
>   # This works.
>   init-db
>   echo content >file
>   update-cache file
> 
>   # This segfaults
>   >.dircache/index
>   update-cache file
> 
>   # And this works again
>   rm .dircache/index
>   update-cache file
> 
> I'm not sure why it would ever fail without that explicit empty-file
> write. Perhaps there's some code path that writes out an empty index
> file, and we inadvertently triggered it.
> 
> If you're going to play with such an antique commit, you have to
> expect
> that things won't necessarily work, and be ready to poke around in
> the
> debugger.
> 
> -Peff
