Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE8F1FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 10:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757173AbcHYK0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 06:26:33 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36542 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756804AbcHYK0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 06:26:32 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so232869852wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A+MwTB8TI9KaDHE9/MtAlo209rIfP6uOPa+luJB5Y8k=;
        b=muFV5VjuPuQB0Jg9eZ3KzYVF4B3mnqNRBbZH5Bycbjfh9uT5NmslmwgjtuoJQwvfqf
         8dk1l3KyCqdajh9gznNcYVJ+BIhF66sV48Lvuh63xcNvu2IVlOoFa4aYmQvIMIGV/fDN
         Gr+NQYcW2l1Op6P270vqeVvBb7oFZGsnY51yw9W98bb76gbWC1yAoo2F+CQnhQzAd9Zt
         zIzhH1A/XuS5tBebtkCFToPAgv8KkK2JPu2mPIwfdRd2CBAcO92nBR0r1LoCKN5u1lHX
         zXqEOrFge1Vrw2aZkgbuv1/YxcXaTKTRTwt3vem1aEvSb6/rImy0uvmEKqpF5Bi+0SdW
         vCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A+MwTB8TI9KaDHE9/MtAlo209rIfP6uOPa+luJB5Y8k=;
        b=Ljh+msh3K6JJiYo9oCuB12AXltVFydFjf3yt8IvrKwhtGS3RZkJE5mMGjwv0qCv/A7
         qru7/uKBtILHlz5ODkJdsGpSBtxp1WWfQJOgUrsE/uFNzcVsb4aLZdSvL/S1zKm05Rzp
         wjNWNu1Kn4d2NbT+6tVmYCY/YrLTjxxce3uhDuncSCpRorc1RBKLkxkL+X4ah01tB1t2
         IbhR71VZ+k7zqHJ4nqlDYEoBWBfCYmTrpksSV1qkIaIJPg9/Dy5XlJaRDcSTVGZ4PLTv
         nFWLi5OqA3PPEJrUW4HxpYu7e9t5MBOtP3b+3BPzwyJXD6EWvhwphkIeS0y0yO5FRwu9
         I8FA==
X-Gm-Message-State: AEkoouvfRe8sUNfoxCARIAUU/bBxMnL/YJj3j+ELzVcK6dQPJbpUL76ZQvmIaAhZs5CuAg==
X-Received: by 10.28.181.66 with SMTP id e63mr27943819wmf.116.1472120790515;
        Thu, 25 Aug 2016 03:26:30 -0700 (PDT)
Received: from [192.168.1.26] (afj243.neoplus.adsl.tpnet.pl. [83.25.139.243])
        by smtp.googlemail.com with ESMTPSA id d64sm15026520wmc.22.2016.08.25.03.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2016 03:26:29 -0700 (PDT)
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     Eric Wong <e@80x24.org>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <20160820212937.GA20555@starla>
Cc:     git@vger.kernel.org, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <70c3a9f2-7afb-dfa4-8982-d3e1236d2f2a@gmail.com>
Date:   Thu, 25 Aug 2016 12:26:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160820212937.GA20555@starla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.08.2016 o 23:29, Eric Wong pisze:
> Jakub Narębski <jnareb@gmail.com> wrote:
>> #### Other version control systems
>>
>> 20. What other version control systems (SCM) do you use beside Git?
>>    (multiple choice, with other)
>>
>> Explanation: "using" version control system here means using
>> it to actively contribute (propose changes or accept proposals),
>> and not only e.g. using it to download software.
>>
>> JN> Perhaps we should split it into two questions, one about
>> JN> centralized version control systems, one about distributed
>> JN> ones.
> 
> Perhaps there can be a question about use and interest of other
> decentralized/federated systems which could be potential
> collaboration tools or transports for git.
> e.g. ipfs, gpg, tor, diaspora, *coin, tent, xmpp, matrix, ...
> 
> And another about how they use email: webmail, GUI client,
> console client, phone app, none at all.

I am of two minds about those (and similar) questions.  One
one hand side, these are quite interesting (especially correlated
with other answers).  On the other hand, they are not about Git,
and we have large number of questions already - I'd prefer if
number of questions was below 50-60.

That said, those questions could be added as a separate section:

#### Other tools

XX. How do you read and answer email (check all that apply)?
    (multiple choice, possibly with other)

 + GUI client (e.g. Outlook, Thunderbird, Evolution, KMail)
 + console client (e.g. pine, alpine, mutt)
 + webmail or web client (e.g. GMail, Hotmail; HyperKitty)
 + phone app (e.g. K-9 Mail, Airmail, CloudMagic)
 + I don't use email

XX. Which of the decentralized/federated systems do you use
    or are interested in?

JN> Have I missed some interesting and Git-relevant federated system?

 + IPFS
 + PGP / GPG
 + Tor
 + diaspora*
 + Bitcoin, Litecoin, Etherium, etc.
 + tent.io
 + XMPP / Jabber
 + OMEMO
 + Matrix.org
 + pump.io
 + other, please specify


There are a few other questions that we might want to ask if
such section is to be added to the Git User's Survey 2016:

XX. Which of IDEs and programmer's editors do you use [with Git]?
    (multiple choice, with other)

JN> Have I missed some popular IDE or programmers editor?

 + Visual Studio
 + Eclipse
 + NetBeans
 + Xcode
 + IntelliJ IDEA / PhpStorm / WebStorm
 + KDevelop
 + Anjuta

 + Sublime Text
 + TextMate
 + Emacs
 + Vim
 + Atom
 + Brackets
 + Geany

 + other IDE or editor, please specify


XX. Which of the programming languages are you proficient with?
    (multiple choices, with other)

JN> Based on TIOBE index from August 2016, Language Trends on GitHub
JN> 2015, GitHut (languages in GitHub), Stack Overflow Developer
JN> Survey 2016, and my own preferences; in no particular order

 + C
 + C++
 + C#
 + Java
 + VisualBasic.NET 
 + Objective-C

 + Python
 + Perl
 + PHP
 + JavaScript
 + Ruby
 + shell scripe

 + CSS, LESS, SASS etc.
 + HTML, HTML5
 + TeX, LaTeX, ConTeXt
 + SQL

 + Go
 + Rust
 + Swift
 + Scala
 + Haskell

-- 
Jakub Narębski

