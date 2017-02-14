Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435561FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 03:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdBND4o (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 22:56:44 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34168 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbdBND4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 22:56:41 -0500
Received: by mail-qt0-f195.google.com with SMTP id w20so15864946qtb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 19:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:cc:to:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zEhh/vabfnNq3jjDx7Nejhf7BUCQfhSCy10FtcTUrBw=;
        b=RLD3pzqiw4Ji2ewLDgrBEMu2QLOI8yK5C9PvdvOhTouEe3G8Zwfu3PNhS/bG9Hfv7/
         VnaPDWJ2GvuVKB7isqc7AdgblrIGSglLWMRJe0OWWPSv6t4cOrfyCvmcPwEUaqCQLmRC
         jL/V8tw6Q27qzmsYO3Ya1HVAnZM8d7Qja8hmYG9TjElfC7cyc37v0GfJEPmYYzE+YmDv
         blL0qD8rJGUHa9cSfh4K9ZQ2uSB73vatak390gbqzMczUC8oq7si5BvNnYlQEgvLYPm/
         tIouQ3FQpAiVaxMlhfeHCY9OWLksrBkpGpvBUelsz4EixWnAuq2H6nZ2uWwer1pdsXA/
         h4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:cc:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zEhh/vabfnNq3jjDx7Nejhf7BUCQfhSCy10FtcTUrBw=;
        b=sZEZAgQoYcZiL80o9N05E1iDYAVQars1qhtzl2jvqAUeNTlVQQ8pKBWm3dJiD7bedE
         GXD4836GOh8VfGrRQveIfXCdVqydRXfk7Ae46CirI0e3wkvFL22zmskRsfJYhN9X6Vy1
         Jhk6YBSfzhGEpYuW2BpzIcDPKZ8bMknsjQV4XFrk6n1q2nSxgU0hTnUT5qCnrW48EL53
         A0h740kbV0oim0UpHJwTPPqz6ehFu3Rt3ike674fBctKGL9fdXLw5Gtt6NqrzktPdLbl
         Kvlopp5Dny3lEYChFCNqaoWnSpWkoIkktgjCOMD8tThY/chi6lsz6CSpMZoMp4hF6xnl
         A3Yg==
X-Gm-Message-State: AMke39kl75LifkM5kA3BA0VvVLYvFS2XLPyNdmwgv4bJcadZNwY0/kbEtDWAo47DVo8ZQA==
X-Received: by 10.237.35.231 with SMTP id k36mr24843720qtc.192.1487044600398;
        Mon, 13 Feb 2017 19:56:40 -0800 (PST)
Received: from localhost.localdomain (c-24-131-5-126.hsd1.va.comcast.net. [24.131.5.126])
        by smtp.gmail.com with ESMTPSA id r57sm8834194qtr.27.2017.02.13.19.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 19:56:39 -0800 (PST)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <alpine.DEB.2.20.1702131533400.3496@virtualbox>
From:   Arif Khokar <arif.i.khokar@gmail.com>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Arif Khokar <arif.i.khokar@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <7dbe0866-4a9b-7afe-8f51-ca1d5524d4a4@hotmail.com>
Date:   Mon, 13 Feb 2017 22:56:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702131533400.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 09:37 AM, Johannes Schindelin wrote:
> Hi Arif,
>
> On Mon, 13 Feb 2017, Arif Khokar wrote:

>> Thanks for the link.  One thing that comes to mind that is that it may
>> be better to just download the patches and then manually apply them
>> afterwords rather than doing it in the script itself.  Or at least add
>> an option to the script to not automatically invoke git am.
>
> I actually had expected *you* to put in a little bit of an effort, too. In
> fact, I was very disappointed that you did not even look into porting that
> script to use public-inbox instead of GMane.

I wasn't aware of that expectation.  My idea was to use NNTP as a way to 
facilitate the development of a new git utility that would serve as the 
inverse of git-send-email (sort of like the relationship between git 
format-patch and git am), rather than using a

IIRC, I had posted some proof-of-concept Perl code to do so back in 
August in 
<DM5PR17MB1353B99EBD5F4FD23360DD41D3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>

Looking at public-inbox now at the archives of this group, it appears 
that several of the messages I sent weren't archived for some reason 
(and I didn't see any more responses to what I posted at the time).  The 
messages are accessible via NNTP when connecting to gmane though.

Also, looking at the source of the message I referenced, it appears that 
my MUA decided to base64 encode the message for some reason (which may 
have resulted in it getting filtered by those who I sent the message to).

I will look into this more now (given yours and Junio's responses).

>> Getting back to the point I made when this thread was still active, I
>> still think it would be better to be able to list the message-id values
>> in the header or body of the cover letter message of a patch series
>> (preferably the former) in order to facilitate downloading the patches
>> via NNTP from gmane or public-inbox.org.  That would make it easier
>> compared to the different, ad-hoc, methods that exist for each email
>> client.
>
> You can always do that yourself: you can modify your cover letter to
> include that information.

Certainly, but it would be nice to be able to have it done automatically 
by git format-patch (which I'll look into).

> Note that doing this automatically in format-patch may not be appropriate,
> as 1) the Message-ID could be modified depending on the mail client used
> to send the mails

I think the best approach would be not to make including the message-id 
values the default behavior.  Specifying a new command-line option to 
enable that behavior should address those concerns I think.

> and 2) it is not unheard of that a developer
> finds a bug in the middle of sending a patch series, fixes that bug, and
> regenerates the remainder of the patch series, completely rewriting those
> Message-IDs.

Perhaps, but should something like that not warrant a re-roll of sorts. 
That is, one should reply to the partial patch series stating that there 
is a bug that renders this particular patch (series) un-usable and the 
re-roll could be posted as a reply to the original cover letter?

>> Alternatively, or perhaps in addition to the list of message-ids, a list
>> of URLs to public-inbox.org or gmane messages could also be provided for
>> those who prefer to download patches via HTTP.
>
> At this point, I am a little disinterested in a discussion without code. I
> brought some code to the table, after all.

If you have the time, please take a look at the message-id I referenced. 
  If you need, I can re-post the proof-of-concept code.
