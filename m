Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDEC1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 08:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdFHIna (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 04:43:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35820 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdFHIn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 04:43:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so6131066wmc.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n8XRtt4v2/8XnsC9t5z1YAiTyNdQaMsgUQHVrKyFtFU=;
        b=CI/koXvdp9v81KfEbI2rBHEfjn3TQZNWSeiXYOXLvAyjErpwEmJ+RP8ljACuis5Cg3
         6uqP/Hc2w3gyBoxxaenOy5jzHmv8P5X9Gq+Z3YdfgStDiiy7dPQyI6kmVwWmmdQTdkm7
         YPPSsWreDcX3ZBCSBC1ACnx3pH6eboIhCdT9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8XRtt4v2/8XnsC9t5z1YAiTyNdQaMsgUQHVrKyFtFU=;
        b=JTExaqh9Do/S2I9alNSQuez2GO0QxTCWK8hkqLuSAKiiTzjPkBPCrdJz6J/MfQOcFd
         hi5ogNdc7C+XxyxSuKvntKcYgQUaXWDQmO03+wlXbx1jX/oEuq5ofxlL4Icy6Z2wLONG
         vCrlm8ng7FiFFdoU2CU9Hmog+Caf4fMg0ScOrtizEWUX6z7wPcFT4FHE2Pg8n9ArXGP5
         lM4kdezBwqcK0TGZM6/YgpFBQH+T44g6kPq6z9D091AQs8DLxZmw1y+ekwdi/2RC5W1D
         HCP5MY+7pKjazRaTaNqMlDdme56CYMiTyvAWasRZOgQA7q44MmTRiSEcEKwAcXaNn734
         O8Cg==
X-Gm-Message-State: AODbwcB9HeunVeQrdQmCEuXljlBB+Q/NvXz4xTUGX9zSd4gU0bDyPI+l
        frw90oP9XHhBqxiX
X-Received: by 10.28.169.131 with SMTP id s125mr2478904wme.4.1496911407107;
        Thu, 08 Jun 2017 01:43:27 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id s18sm2304209wra.20.2017.06.08.01.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 01:43:26 -0700 (PDT)
Date:   Thu, 8 Jun 2017 09:43:24 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Genz <liebundartig@freenet.de>
Subject: Re: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
Message-ID: <20170608084324.GG25777@dinwoodie.org>
References: <20170605105341.35096-1-adam@dinwoodie.org>
 <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
 <20170606125743.GE25777@dinwoodie.org>
 <xmqq7f0o8ywn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7f0o8ywn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Resending to everyone after only sending to Junio by mistake.)

On Wed, Jun 07, 2017 at 08:44:08AM +0900, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
> > On Mon, Jun 05, 2017 at 11:42:31AM -0700, Stefan Beller wrote:
> >> So I was wondering if there is a command that shows all trailers?
> >> Similar to a "shortlog -sne" I would want to have a list of all trailers.
> >> This is because there might be an even more popular trailer than
> >> "Helped-by", but we would not know when using the hack above.
> >> 
> >> While I do not think so, it would sure be interesting to have a list
> >> of all these trailers available.
> >
> > I just did a quick search with the following knocked-together command:
> >
> >     git log --remotes --format=format:%B | sed -rn 's/^([A-Za-z0-9-]+): .* <.*@.*>.*/\1/p' | sort | uniq -c | sort -nr
> >
> > The top 10 such tags according to this (which is coincidentally the same
> > list as the list of all tags used more than 100 times), with
> > frequencies, are:
> >
> >   61535 Signed-off-by
> >    1641 Acked-by
> >     984 Reviewed-by
> >     673 Helped-by
> >     497 Reported-by
> >     180 Cc
> >     174 Suggested-by
> >     159 Tested-by
> >     158 Mentored-by
> >     128 Noticed-by
> >
> > As you might expect, there are a number of entertaining ones that have
> > only been used once or twice, such as "Looks-fine-to-me-by",
> > "Worriedly-Acked-by", "More-Spots-Found-By", "Looks-right-to-me-by",
> > "Hopefully-signed-off-by"...
> 
> Thanks for an interesting list.  Your replacing (totally
> unconventional) Thanks-to with more common Helped-by is certainly an
> improvement, but I wonder if we should encourage people to be
> "original" in this area by having that "You can also invent"
> paragraph in the first place.

I would expect we could never come up with a list that will cover every
possible scenario. I suppose the question is whether it's worse for
people to feel like it's encouraged to come up with non-standard options
or for them to feel they can't deviate from a given list if none of the
available options suits them.

And I definitely don't feel I have a good enough grasp of what these
lines are used for in practice to make any sort of informed comment, so
I shall leave it to people with more experience than I to propose the
patch or not.
