Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071C720899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdHIAiq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:38:46 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33790 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdHIAip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:38:45 -0400
Received: by mail-pf0-f176.google.com with SMTP id h68so20989688pfk.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ri5YCEWCpXFxOIzwiwKkgeEgiGyuGfoW4n62EMW4c+E=;
        b=CkHl7tWrFo/oCnxauJTN0aCNtqEqTRxUrr44A5eKK2sdTzInwqTWza5hyDhqMoH7RB
         J5XeRP+YU+M34GBCxsqBzjTuW+PlX2Wak5x6fm7Ojq/Cq8RzixGahxGyjoW3MpOJeLwV
         hf0g7L9sbF4ffCfZ5hRVhR/lYm1Llr1sdOQWacpBTs/nYLwLHxJGlnMdQq0zcyBWgRyG
         U2GQyP070piplAuC3pqn/u3QEIjf5jdyCSeEejL0ANgVMRm2q/GPv8flJOZaZ53ahTAE
         yTup9hr71dh7txdMlvFMsW+j599AUafNBN1RPEbR6wI3u6nocOROTYJb7MzNgjYTEuUL
         WyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ri5YCEWCpXFxOIzwiwKkgeEgiGyuGfoW4n62EMW4c+E=;
        b=Z/JQZe50VGw2ejoc91S9046UhDVWVVrwIlk9upRt+brQ45QpBNLE+e8POpto7h1GQA
         jIlcgDwji3kZlJUilQbTJ8R5qr95il5toJRx6LgyfhSplmgRKr2cIV0QSr8/q0oXl4QY
         Npk8Bi4iX1fiItzebnih/TpKfxbb1ZiRH7CfxgPaogXPnwMRax7R1QftH8ApwalvVJ1w
         oIVY4xC4csW+7zzC/+kdkK/rTBDgAoOs5jjEPuiIdQOXOUqXBZ9nS2gexib/PybtcrPD
         EZpjjFOMXuLTp75Y6fxnRUIgOuOKpy4lROJFtqsDOURP6OyVCbaaYZVJslGWsIE2NYIq
         ZLAw==
X-Gm-Message-State: AHYfb5gLZvSCcXGjqn/pTe1oDrsC/gT/lWrxQZMJ/cjO/t1boRqAwbp/
        kp3tf19ryqig0w==
X-Received: by 10.84.179.165 with SMTP id b34mr6865311plc.455.1502239125257;
        Tue, 08 Aug 2017 17:38:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id p10sm4867978pfk.103.2017.08.08.17.38.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 17:38:44 -0700 (PDT)
Date:   Tue, 8 Aug 2017 17:38:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
Message-ID: <20170809003841.GI169894@aiede.mtv.corp.google.com>
References: <20170808234308.25565-1-sbeller@google.com>
 <20170809000742.GG169894@aiede.mtv.corp.google.com>
 <CAGZ79kZ45=2ngM437fdj8KCJjJo5h0R7FtmEBBG+VVkm0pTLrw@mail.gmail.com>
 <20170809003330.GH169894@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809003330.GH169894@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Stefan Beller wrote:
>>> Stefan Beller wrote:

>>>> Nowadays there are better tutorials out there such as "Git from bottom up"
>>>> or others, easily found online. Additionally to that a tutorial in our
>>>> test suite is not as easy to discover as e.g. online tutorials.
[...]
>> 2ae6c70674 (Adapt tutorial to cygwin and add test case, 2005-10-13)
>> seemed to imply that it was testing some part for Documentation/tutorial.txt
>> though.
>
> Oh, good point.
>
> v1.2.0~121 (New tutorial, 2006-01-22) means that the test is no longer
> testing what is in the tutorial in any meaningful sense.  That's why
> my search for "git whatchanged -p --root" in manpages didn't find
> anything.

Correction: the tutorial is now called gitcore-tutorial and mostly
survives.  A search for -p --root failed because of v1.5.5.1~19^2
(core-tutorial.txt: Fix showing the current behaviour, 2008-04-10).

That said, the conclusion that this test has mostly bitrotted as far
as its original purpose goes still applies.

An alternative method of addressing the goal you described would be to
fuzz object-id shaped things out of the sample output.  I don't have a
strong preference, given how little this test contributes to coverage
(as you mentioned) and how difficult it is to make it continue to
match the documentation it is trying to test.

Thanks and sorry for the confusion,
Jonathan
