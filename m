Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B611420401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbdF0R4Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:56:16 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34762 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbdF0R4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:56:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so5144040pge.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1XHUaktPe5vnINkP860XN/oejuusztDD8Yowslj66Uk=;
        b=I3TwrmHHA/zvuOVgMzp8T/e52DD9vmZEeJ3V1bQZ9+/sBa0Ra4zfQZ6kK739375/kG
         h7xBx3WGnwFiYPvSoha5bDLsJ0etIsmwZxP1tTXF0TMnj7BB4jtL7/jiJoV285KExtug
         wDsdKHKPLPekxEPvU6BVkJXLIMFUHlOBQjmuWGDa8z5+OjmYVy9U2XJ+JgowGo+Qgqx2
         c+Fa+ti0ckCnH1sSjhq5UObm+jTTOu3HpKOXFy+ola9B/TrLUOHQ1yWavh2pzNiijfeE
         bZC1MQhBUeoGFW5t4sTSz246CPlnmIxQro8UV8CK8mJ+i+bdb7KFmOFh4Uwa0OaKWHBR
         zRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1XHUaktPe5vnINkP860XN/oejuusztDD8Yowslj66Uk=;
        b=R05KDftB7SR8NAXyw+K8Smm59xnS446OcV5tnrfiJ92mqTFehUNkUzXBzv44Yhge37
         GjN/O9OQzLpSCFeXmc82tz7fzrBELcOWBU4ZSwqaLhx7ljfqQo272TQkCFM2htsKl8Lc
         vdaArcD7GjuEHi5pCTX+dSJ75RJpDn26A84RxeGA2tCQ4biIfXEkHDbQ1TS493LGWeyb
         pVPhLEp1fvCB1+T3SBnJGvIxlZw+OU2c9YuSy2R9oexLhzd5UVT14TpbVssRWLBiZ/E6
         RFIN4l2vM/7RB6kvrfyYBT1fr9+2C9DgwK4buYwcFSS/+nHUV84DTmvNgV0JrshWSWbb
         1//g==
X-Gm-Message-State: AKS2vOzZEpWJVtFMHFcDB5NMLOVT4e+RRK2kHoyC8TQ5JrAIqmoiTaeP
        IYGsBuP5aH1HRg==
X-Received: by 10.98.112.137 with SMTP id l131mr6523246pfc.186.1498586171132;
        Tue, 27 Jun 2017 10:56:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id r90sm7443496pfj.37.2017.06.27.10.56.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 10:56:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit-template: improve readability of commit template
References: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
        <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
        <1498584144.2737.7.camel@gmail.com>
Date:   Tue, 27 Jun 2017 10:56:09 -0700
In-Reply-To: <1498584144.2737.7.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 27 Jun 2017 22:52:24 +0530")
Message-ID: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>> I personally do not find these new blank lines are necessary, and
>> this change wastes vertical screen real estate which is a limited
>> resource, but that may be just me.  I on the other hand do not think
>> the result of this patch is overly worse than the status quo, either.
>> 
> I thought it's not good to trade-off readability for vertical space as
> the ultimate aim of the commit template (at least to me) is to convey
> information to the user about the commit that he's going to make. For
> which, I thought it made more sense to improve it's readability by
> adding new lines between different sections rather than constrain the
> output within a few lines.

You have to be careful when making a trade-off argument.  It depends
on how familiar you already are with the presentation.  Those who
are/got used to the order of things that come, they will know there
is extra information when the block of lines are longer than usual
without reading every character and then their eyes are guided to
read what is extra, without having to waste precious screen real
estate.  Nobody will _stay_ a new user who is not yet familiar with
the everyday output.

>> If we were to go with this sparser output, I think we also should
>> give an extra blank line before and after the "HEAD detached from
>> cafebabe" message you would see:
>> 
>> 	$ git checkout HEAD^0
>> 	$ git commit --allow-empty -o
>> 
>> or "On branch blah" if you are on a branch.  I think your change
>> adds a blank before, but it does not have a separation before
>> "Changes not staged for commit" line.
>> 
> I actually didn't think of modifying that in order to keep it in line
> with the output of `git status`.

I was (and still am) assuming that if we make this change to "git
commit", we should make matching change to "git status" as a given.

> Further, to me, adding *this* new line
> before the "Changes not staged for commit" (or something in it's place)
> seems to be wasting some vertical space ...

I think it is in line with your original reasoning why you wanted
these extra blank lines to separate blocks of different kinds of
information:

 - "Please do this" instruction at the beginning
 - Make sure you know the default is --only, not --include
 - By the way you are committing for that person, not you
 - This change is being committed on that branch
 - Here are the changes that are already in the index
 - Here are the changes that are not in the index
 - Here are untracked files

Lack of a blank between the fourth block and the fifth block [*1*]
makes it somewhat inconsistent, doesn't it?


[Footnote]

*1* Yes, we should think about removing the optional second block,
    as I think that it outlived its usefulness; if we are to do so,
    these become the third and the fourth blocks.
