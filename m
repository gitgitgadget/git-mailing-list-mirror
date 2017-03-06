Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E821320133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbdCGAAW (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:00:22 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33762 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdCGAAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:00:19 -0500
Received: by mail-lf0-f48.google.com with SMTP id a6so79829000lfa.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=62Z7agQe/ZgwfFXzWXrgZmLYjUp0CTOqYX7HWrvmVXQ=;
        b=nUvfeg084HyNiI0Gcy8gHFIZGFJC+qHaX1yHNZwiB/bcEZyd0YPrWSTbCP7l17EXq3
         zg2L/Vcf5jD+rqK8ZUHjybClNyMhfYjwOHhgNASvy+QgECdbo8S7XeSTx+uP69i9JMb5
         Y9+4Rj33vvut3seWDkxGye9WxXDaH55beyG6CF9TxE7ZsQslCgT0aL0OqssxNRsfIgI7
         F/fgEV8w3Bq7pF3c6d0e33Q97sBdHR7degspXWiJl1DNkCt06abCo6NW8KyCotVGNJxS
         MJ0Rsj2+iUlmvOUYiq4/BlLArAj8pcgjzDxHiQwE1MouzIZM1ebcsSMrocibMqrcnz5w
         qqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=62Z7agQe/ZgwfFXzWXrgZmLYjUp0CTOqYX7HWrvmVXQ=;
        b=oeJVNPTp9WWH+2BkeQnO/jb+tZb1/Vv+fHc78ixnoRnQVEwNzM0fQhoDu5881GQuiI
         6QwM6dTlJRcLoUBUmiUV7bbMmag7Q8uQGR61JpWGGMIvu6EG48I33BNnoGsV/c3J8Xgg
         MEyNdXDhdExuEA18g2iSVwpSmlC7xCWm8YCROg+ks4saVakWVtcoC9YuNsLpCOLEqOuI
         a9sQUkI+B8uDH/nCOtk4feZ6ISNnQ48mC6WrNED6cGUdNQS4Th95Gy1sG7dUL69I/91z
         19t5nAi0lYYteRs+DTNxSZvkqu51ikAMEy1BIFyD71fJpFK1dqFLd3a2MFmwUZBoAKmV
         7TOw==
X-Gm-Message-State: AMke39msJ+e1vyIiGX2x8E7NBJETCAib+E6+Y8Aw9OU4r2QWYf2c00tdyP/KCuZi/TWf7Q==
X-Received: by 10.46.1.209 with SMTP id f78mr4961110lji.121.1488844770704;
        Mon, 06 Mar 2017 15:59:30 -0800 (PST)
Received: from [192.168.1.26] (afb78.neoplus.adsl.tpnet.pl. [83.25.131.78])
        by smtp.googlemail.com with ESMTPSA id h140sm4368405lfg.39.2017.03.06.15.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 15:59:29 -0800 (PST)
Subject: Re: [Request for Documentation] Differentiate signed
 (commits/tags/pushes)
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <47ad8b6d-0a65-2f8c-dcc5-49a8a8d5ab2a@gmail.com>
Date:   Tue, 7 Mar 2017 00:59:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.03.2017 o 23:13, Junio C Hamano pisze:
> Stefan Beller <sbeller@google.com> writes:
> 
>> What is the difference between signed commits and tags?
>> (Not from a technical perspective, but for the end user)
[...]
>> Off list I was told gpg-signed commits are a "checkbox feature",
>> i.e. no real world workflow would actually use it. (That's a bold
>> statement, someone has to use it as there was enough interest
>> to implement it, no?)
> 
> I'd agree with that "checkbox" description, except that you need to
> remember that a project can enforce _any_ workflow to its developer,
> even if it does not make much sense, and at that point, the workflow
> would become a real-world workflow.  The word "real world workflow"
> does not make any assurance if that workflow is sensible.
> 
> Historically, "tag -s" came a lot earlier.  When a project for
> whatever reason wants signature for each and every commit so that
> they somehow can feel good, without "commit -s", it would have made
> us unnecessary work to scale tag namespace only because there will
> be tons of pointless tags.  "commit -s" was a remedy for that.

Also from what I remember signed commits came before mergetags, that
is the result of merging a signed tag (storing the signature of
one of parents of the merge commit to not pollute tag namespace).

And this workflow, from what I know, is quite useful.

-- 
Jakub Narębski
 

