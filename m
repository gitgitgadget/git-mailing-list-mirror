Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7E020401
	for <e@80x24.org>; Thu, 15 Jun 2017 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdFOQnk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:43:40 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33820 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbdFOQni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:43:38 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so9885812pfs.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WmIofi7Vz5BMux8BrtfihEe2Aqv9s6YFSduS6P8YhUA=;
        b=MAAT2rv7xsJJIFKMoSoHo0x47NUYJHs0Xzh33DrQvZB8D/8hDLcFMeYEgCCbsvs68q
         B9QwFtmBNQ/ymF5ByplAuUUQsYuHvzJNQEdo1B48mZ8jCaNwCe7tGOtJHE0LcA3fcxlE
         1qlDBpYW1+rM1hasWyX+Og2CwkVsrzzid+yvOOfVXMa0u2S1Pg4OPR+zPBDnxfcdjGiA
         ZCU1YaV9VYG8UglzRdMS+EQMWkAvIDhrWFHA8FAGvKIKCMveJO2NREZSvcFMqdqTpT/s
         1YIk3ueGUGSVWkXXFe3hPkg2wyx61P49mExPrsRRjNY9Xqrya7X3VHHmb+nugpnLzQg9
         +wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WmIofi7Vz5BMux8BrtfihEe2Aqv9s6YFSduS6P8YhUA=;
        b=EhWDt40MUOID/wxQvMFzmcPj6nVTOABo6aTM37Sf6/avfcPB0D2lWyTyYX//brlYZj
         Z10asCpmS6QUMNdSthEIQOzAezLtM76bi7AgwCwSyR2Bsql6BNTbE+qqvw41EwO3+RjK
         28rGUYLVkiy+NHUnBa1XoiTG4PQEZyyOM2de8RBuBQTIekuuMvDExQ/i8G+xrgSXE0fj
         qMDCdtlTVlzoXmoFZqIVXqfPTSPO6qGo2zzZmifOTkwyu/Tv9BsORTwIbOVpW1gbTES2
         XUbdFc9TlN0rcDxucWoXnLGwO22jCQ0NdGLYSwmNltIS3sEkIEz0NRb87EvOg4jjRADK
         3nrQ==
X-Gm-Message-State: AKS2vOwO7kGoc7wgbn+m4ljNNlY4WPWfI0PE6N6GIG0AWLwrCVL2Ahp3
        tjTtezJAZqgVpw==
X-Received: by 10.84.231.141 with SMTP id g13mr7195659plk.157.1497545017662;
        Thu, 15 Jun 2017 09:43:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id a187sm998192pgc.37.2017.06.15.09.43.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 09:43:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
References: <20170609142151.94811-1-larsxschneider@gmail.com>
        <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
        <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
        <CACBZZX42JcqFAsWgi0bSuRv5CC8hiUF1Ahnx3nJL=LyHkk03Cg@mail.gmail.com>
Date:   Thu, 15 Jun 2017 09:43:35 -0700
In-Reply-To: <CACBZZX42JcqFAsWgi0bSuRv5CC8hiUF1Ahnx3nJL=LyHkk03Cg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 15 Jun
 2017 10:09:11
        +0200")
Message-ID: <xmqqk24d2oco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> There are things we get out of this that would regress if
> submitGit were changed this way:
>
>  * Now when you submit a pull request you get a Travis build for
> git/git, I don't get this if I push to any random branch in my
> avar/git, and although I could probably set it up, it's extra work
> etc.

Thanks for pointing this out.  I agree that this indeed is a
downside.

>  * I like being able to "git fetch" patches I'm reviewing. Now I can
> just set "+refs/pull/*:refs/remotes/origin/pull/*" in the refspec for
> git/git, if it were pulling from target repos I'd need to "git remote
> add" for each one, not a big deal, but less convenient.
>
>  * There would be no single place to list submitGit requests, which
> you can do now through the pull page, although I think this is largely
> stale now because nothing auto-closes them if they're merged (by which
> point they'll have different sha1s), but that could be improved with
> some bot...

I do not think these two are 'regressions', unless your definition
of 'regression' is a "this thing I used to be able to do, now I no
longer can", which is slightly different from mine, which is "this
useful thing I used to be able to do, now I no longer can".

It would be useful to be able to do the above two things, if the
list of submitGit requests and what you can get from pull/*
hierarchy (1) covered most of the changes proposed, allowing people
to check only this place and nowhere else, and/or (2) covered the
more interesting changes that are worth looking at than other
proposed changes.

I do not think either is the case.  The submitGit mechanism being an
easier way to propose a change to the mailing list, by definition,
(1) will not hold true.  And among the changes proposed to be made
to Git, the "selection criteria" to be in the set to be discoverable
by going to github.com/git/git.git and checking the submitGit pull
requests is not that they are of higher quality or touch interesting
topics.  The only common trait these proposed changes share, compared
to other proposed changes we see on the mailing list, are that they
were originally made as pull requests and (2) will not hold true.

Another thing that may regress that you did not mention is that we
would lose a convenient way to _count_ proposed changes coming via
submitGit (i.e. you can simply go to the pull-request page), so that
the number can be compared with the number of proposed changes
directly made on the mailing list, which would be a good way to
gauge how submitGit service is helping our community.  But even for
that, you'd need to go to the list to find the denominator
(i.e. total number of changes proposed), and by the time you do
that, counting the numerator (i.e. those come via submitGit) by
finding the telltale sign submitGit leaves in its output among these
denominator messages should be trivial.

So in all, I see the only downside is the loss of automated
triggering of Travis.  But I do agree with you that it is a rather
significant downside.

> There's probably ways to do this without git/git pull requests, but I
> don't see what problem would be solved by moving this off git/git,
> even if there's open requests submitGit is the only thing using these,
> and any confusion about that pull UI would remain if it wasn't (AFAIK
> there's no way to completely disable pull requests on github, but I
> may be wrong).

Hopefully the pull-request template update Lars proposes will keep
the pull request useful, in that they create one and then have
submitGit relay it to the official channel.
