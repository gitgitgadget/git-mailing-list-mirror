Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0195E1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 21:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdBAVfN (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 16:35:13 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36219 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBAVfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 16:35:13 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so32625124pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 13:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p6dlICUSlb5CW8LZ4i6kg0JYvays2n3AA5mYIgPq5H0=;
        b=cfFnYQEaMO37ZQAYTO777IE4CASU73AZgH9N6dc4IH5gxQXRAzfiiyzUYQRndLQqry
         uXK8qdbsF5DcOQjIbUlEhfilifjU1rWeHjtdFK6nLz2T2sa4tKi0fbI3dOMsCAbHQVOW
         H5KVVSr1PiUgLmSSwWg4EWu7Cl0NwPrnV7rmb3KIG4WN7TtfR+561WVx7uOBI7KraqGy
         rtnk58O8Ad6GmWkRYxdjWpUwkiiEi9e4qIIkG42hKXpm8+NwYJ7X56q+F/48bm30TeXq
         klkzTABtGAgyMr4QMxSOCSiR/kvgudLS/6flTIaV8q1HnaivDcT2t1HWzowh/98s1/yJ
         RsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p6dlICUSlb5CW8LZ4i6kg0JYvays2n3AA5mYIgPq5H0=;
        b=kX0QVzcpZkdXZbM5RmZXeBf30ax3kBPUruN5NQMHP+eR8BIgjIW9DV4pQKS17jvk1l
         Mj7z/hOLp83S9nms/sFTEuLmYQdERGBPRhWg/JTbZeyMFv/3or5QDDpiCayIWf2+1gdY
         c0dAgpihS/FHJ7zg8tkVfiqQNGCU4vbtsRHBkGu7TVCfNtqwEN2+r6oyN1UH9b4uKcTF
         GynIH2Wm59we/W8Tz0sgYxi3amBbTZsS0clB90J3TH37leago/Iy/A+OKDhj3DaduHid
         pn7kJDSgOW29WaCHYTM54KQy/5LIMa4a1iicXnjdZrRd2JQbqMxqRiVKCIhl2cBgnhUY
         itMg==
X-Gm-Message-State: AIkVDXIJd52ca5NusDNxofRB8pdnJq5ARHG8Al4bbeljXxiiIIWikycj3loNG9sBu0Q2Ew==
X-Received: by 10.99.153.1 with SMTP id d1mr6460967pge.44.1485984912256;
        Wed, 01 Feb 2017 13:35:12 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id l25sm52070430pfb.24.2017.02.01.13.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 13:35:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erik van Zijst <erik.van.zijst@gmail.com>, git@vger.kernel.org,
        ssaasen@atlassian.com, mheemskerk@atlassian.com
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
        <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
        <20170201145300.4pn3faodhdb72jly@sigill.intra.peff.net>
        <xmqqh94dpyzs.fsf@gitster.mtv.corp.google.com>
        <20170201212825.advj7f3ucnfbspbj@sigill.intra.peff.net>
Date:   Wed, 01 Feb 2017 13:35:10 -0800
In-Reply-To: <20170201212825.advj7f3ucnfbspbj@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 1 Feb 2017 22:28:26 +0100")
Message-ID: <xmqqd1f1oar5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For instance, if the server knew that XYZ meant
>
>   - send bytes m through n of packfile p, then...
>   
>   - send the object at position i of packfile p, as a delta against the
>     object at position j of packfile q
>
>   - ...and so on
>
> Then you could store very small "instruction sheets" for each XYZ that
> rely on the data in the packfiles. If those packfiles go away (e.g., due
> to a repack) that invalidates all of your current XYZ tags. That's OK as
> long as this is an optimization, not a correctness requirement.

Yes.  You can play optimization games.

>> So in the real life, I think that the exchange needs to be more
>> like this:
>> 
>>     C: I need a packfile with this want/have
>>     ... C/S negotiate what "have"s are common ...
>>     S: Sorry, but our negitiation indicates that you are way too
>>        behind.  I'll send you a packfile that brings you up to a
>>        slightly older set of "want", so pretend that you asked for
>>        these slightly older "want"s instead.  The opaque id of that
>>        packfile is XYZ.  After getting XYZ, come back to me with
>>        your original set of "want"s.  You would give me more recent
>>        "have" in that request.  
>>     ... connection interrupted ...
>>     C: It's me again.  I have up to byte N of pack XYZ
>>     S: OK, resuming (or: I do not have it anymore, start from scratch)
>>     ... after 0 or more iterations C fully receives and digests XYZ ...
>> 
>> and then the above will iterate until the server does not have to
>> say "Sorry but you are way too behind" and returns a packfile
>> without having to tweak the "want".
>
> Yes, I think that is a reasonable variant. The client knows about
> seeding, but the XYZ conversation continues to happen inside the git
> protocol. So it loses flexibility versus a true CDN redirection, but it
> would "just work" when the server/client both understand the feature,
> without the server admin having to set up a separate bundle-over-http
> infrastructure.

You can also do a CDN offline as a natural extension.  When the
server says "Sorry, you are way too behind.", the above example
tells "I'll update you to a slightly stale version first" to the
client.  An natural extension could say "Go update yourself to a
slightly stale version first by grabbing that bundle over there."

But I agree that doing everything in-line may be a logical and
simpler first step to get there.
