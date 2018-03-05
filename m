Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8C81F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeCESxc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:53:32 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42740 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeCESxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:53:32 -0500
Received: by mail-pl0-f65.google.com with SMTP id 93-v6so10202016plc.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZAGjjue7pEZiU4cZa8pMn7ecoyreM5aseMQObUFKDw=;
        b=JAvG1ZcMfAhdyKLOA4Mlz/SURDMv7zD3r16XpkPmgZ2KhjitXJzzFpLTpnQ8hycRlu
         v7gJR8Qy0HgusK8IrtmQPz6TrVqOKy5m9TpskS9bkLcVNui4ZkJcjaXExk79vlK7nuLA
         7Rt5GfAUM0veU8aiI9k/qu8MWDi19fyOzmKVCCpUgWPIsmlCf0akwENRDkndw9B86vbx
         GqsnjietEvdqXLnNcgqiThLFVFzWedBr0+fxMcPVA6D2g53GahgvzQB7ogVuUqyhojGr
         pH7Qtppae4JE6Khs+SOqbHT52hW/YpHLqixxOdq5ZLSl+apA1MsBR1L10JKcELgAtvoH
         Re+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZAGjjue7pEZiU4cZa8pMn7ecoyreM5aseMQObUFKDw=;
        b=ZlUE7c919n+HkpF18uP5QjVhSJsnZGz6UwvjT05Hd9PFHCjs8/2dIqIIi4veqAEmdI
         U4plizlVdCHny6YJXLEaEwr2ODp9mxT2/LE0BCGM788eSOOy8PDAD7CcMALvBHHckhxQ
         GyqcETWSlbEC0Yq0UKdXO2N1CEmIKxLRPiBcbaSzPhrZzf5M2oBpgcRcrsGcRiwO/mvG
         pagJcCXT3hOVvNUP4j0eCj1BBWq4NKmW8QpTjt3KiMslqyXy29K5qgL2aSUOIR64nt/K
         nPMeY/+qq6CQefDrPyrZ3Imkr1jmF5MY4ytu9eiWdCwlpRuAF07SKtC1JkvnUrpKwy7d
         RNFg==
X-Gm-Message-State: APf1xPBwJ4/RstbhM5uF9GNsjiawYHNkkCylsmuImUJe2JoJz00++LeT
        cmWXK6rm/V/axGroYaAYND6oy9ST
X-Google-Smtp-Source: AG47ELt5Tg7EV9D0RbvhYB05bUlDascf6dmA2AQXWLqBhAc6tGhq3R1bohEZR6savnVhye6i6/4G0w==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14-v6mr13595288pls.76.1520276011258;
        Mon, 05 Mar 2018 10:53:31 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 10sm22906866pgg.73.2018.03.05.10.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:53:30 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:53:29 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180305185329.GE28067@aiede.svl.corp.google.com>
References: <20180303103010.GA21068@sigill.intra.peff.net>
 <20180303103957.GA24498@sigill.intra.peff.net>
 <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider wrote:

> Thanks for starting this. I would like to propose the following topics:

Cool!  Do you mind starting threads for these so people who aren't there
can provide input into the discussion, too?  In other words, I'm
imagining

 1. Thread starts on mailing list

 2. Contributor summit: in-person presentation, discussion, etc lead to
    people having better ideas

 3. On-list thread goes really well as a result of aforementioned
    in-person discussion

Quick feedback:

> - hooks: Discuss a proposal for multiple local Git hooks of the same type.

I'd be happy to weigh in on a mailing list thread about this.  It's
also related to
https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
which is an interest of mine.

> - error reporting: Git is distributed and therefore lots of errors are only
>   reported locally. That makes it hard for administrators in larger
>   companies to see trouble. Would it make sense to add a config option that
>   would push recent errors along with "git push" to the server?

I'm interested in instrumentation but worried about the privacy
ramifications of this particular proposal.  I'd be happy to see some
built-in instrumentation hooks (or even a standard instrumentation
approach, if the mailing list comes up with a good one that respects
privacy).

> - fuzzing: Would it make sense to register Git to Google's OSS fuzzing
>   program https://github.com/google/oss-fuzz ?

Of course!

Alongside the obvious security benefit, there is money available to
support someone working on this:
https://opensource.googleblog.com/2017/05/oss-fuzz-five-months-later-and.html
https://www.google.com/about/appsecurity/patch-rewards/ clarifies that
the reward goes to the contributor, so you don't even necessarily have
to share your reward with the Git project. ;-)

Thanks,
Jonathan
