Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038FC1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdLYUFP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 15:05:15 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37916 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbdLYUFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 15:05:14 -0500
Received: by mail-it0-f41.google.com with SMTP id r6so21229099itr.3
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HeKVmKTuE5rIs8U2FDznT029b43gxvKkR71JyLc3MH0=;
        b=RzmpynU/+pF7P2gx1HCTu7J2S+2Sq5L1PrD84RyqyYzT8WrDFRwq+cMJf0wIOY2hV9
         ZX3FhFogtr+iCwuhZt0SlRu+/L5tqYjqEJNiiJSxiwXZe+mH/w9fkQivRf+aDiTcYjxU
         ZMg4RDJkG6AWSzTLn1pRctA98xqirMB7FR2Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HeKVmKTuE5rIs8U2FDznT029b43gxvKkR71JyLc3MH0=;
        b=dterEaareWq1ZHEa1d4be0FvrsP9eaDPOwvKGA/sKhjUHB8k6d0SJ1qVsNRySzWcrO
         viPjWDLOZQ3jD9J0qiVqrlphQnZK1mRENbNaRvYChuK2utWg6HxmaEHuQd07P3hwhjO6
         n25+5Us1LvsoIiHIqxVE0KdztnLz5CiTmq3Tcj48n1hzCGYSNyypXEbpJlL2ngb7WQvb
         ZCGnnsTotGNs28/HjGPMXMBgJjJT65iGRAhump3ANNgbd9FHgRhJFFT30KLpHQMmT8Qt
         OfeitD6WLKv9PMTgy9WHbtlebBjzf0bVOBElREu6CfnqmSFeBgAXDVMXVxy+wGXZdwjL
         P1bw==
X-Gm-Message-State: AKGB3mJS6bPvXdLuI+/D1pqMDN0Gtlt+y+9XPeNn1eISoyoQfFMzxqRR
        jPlylNzs1P++dYJUQ3L5O9n3/w==
X-Google-Smtp-Source: ACJfBotXpRyjnxRvvLU0jvuNaEGCvu513UF8zHPypUvREHX7L2lenLl2UOJxkLV9/uxSQ5daA7VTcw==
X-Received: by 10.36.65.83 with SMTP id x80mr29136566ita.130.1514232313433;
        Mon, 25 Dec 2017 12:05:13 -0800 (PST)
Received: from hpz.ecbaldwin.net (c-73-14-102-153.hsd1.co.comcast.net. [73.14.102.153])
        by smtp.gmail.com with ESMTPSA id 191sm8578277itx.16.2017.12.25.12.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 12:05:12 -0800 (PST)
Date:   Mon, 25 Dec 2017 13:05:11 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, 'Git Mailing List' <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171225200509.GA24104@hpz.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <000d01d37c3c$207d7050$617850f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000d01d37c3c$207d7050$617850f0$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 23, 2017 at 05:19:35PM -0500, Randall S. Becker wrote:
> No matter how this plays out, let's please make very sure to provide
> sufficient user documentation so that those of us who have to explain
> the differences to users have a decent reference. Even now, explaining
> rebase vs. merge is difficult enough for people new to git to choose
> which to use when (sometimes pummeling is involved to get the point
> across 😉 ), even though it should be intuitive to most of us. I am
> predicting that adding this capability is going to further confuse the
> *new* user community a little. Entirely out of enlighted
> self-interest, I am offering to help document
> (edits/contribution//whatever) this once we get to that point in
> development.

I agree. I have a feeling that it may take a while for this to play out.
This has been on my mind for a while and think there will be some more
discussion before anything gets started.

Carl

> Something else to consider is how (or if) this capability is going to
> be presented in front-ends and in Cloud services. GitK is a given, of
> course. I'm still impatiently waiting for worktree support from some
> other front-ends.

It all takes time. :)

> Cheers,
> Randall
> 
> -- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.
