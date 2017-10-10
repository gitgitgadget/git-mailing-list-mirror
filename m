Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA0F20372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755786AbdJJA7q (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:59:46 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:43133 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755625AbdJJA7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:59:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id d2so12290341pfh.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gel4Cx7nfpPgN+lUVr/JyiDWXcvV/b4ebDx+PSk11As=;
        b=r+kWdcRkoXXWWQnurc+BFYSJOLhguo53UFhIIZw5GxrUVvOvjBenb5UiYsgYw5QJvO
         WuRRxMlTVuNY8zET2RpBUc2bseCA8ScAOlPH7R0+ftpIiM2VExMO5Ku0C9cYoPaAPAaO
         bRnGM/gMsnH1GZh199N8dBcGFfB3cOE4sAXBYJOnzf74qEJXedNaG93NAOTio+yn0F4E
         2R7ICv0QusucZby8OA33S4yGpwZVdEE/gqyllUKNlMHp23FqeYitFfjN12PwdniqBoKw
         MS0OvWz51DwDfnW6WDTiVEaQKMwUcdjIuX2IdlI616vchz+spJ4xb6ViVcZi59gR3gPc
         s9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gel4Cx7nfpPgN+lUVr/JyiDWXcvV/b4ebDx+PSk11As=;
        b=Rs+iEPwXy+H/w4l3sHh7AaqagojUpWdMtpPXS2iAOStC08JHe9gIBS2am7X7710U/Y
         7Bni1CBFu/U+2F4K+4x1Y4J7MxKwBWWwUUxzjfn/H5KR6SYW/G52gpWH/XtryJLNMsdi
         zEa+Byj9Gcz5uw9mZZ+y11WwROmRiI6w0TEUW7y7tUHXUUQVp9ywKp2yWUx/ZGeDs85+
         wcvyDoOUNm53xp54/0Mt+sBbw10Tb7mIrtAKQi/rm6pm3PvabFy32fkYXOTdEHpTl3hO
         BwpYfJVY3sf1JHB0ozigocMfS6V4CzydXBeiQ9xTm+ZbeuGQ2eb3PLoASuVN8GBW983/
         EuWQ==
X-Gm-Message-State: AMCzsaXzh4F+6u04BpeU6x6XMqCyq8CqsUwDSlGzTxvcUFlQBu53zcjH
        H/FjRC+ClLuXCRy7JVItSdsJ/P9A
X-Google-Smtp-Source: AOwi7QCBq1LF+XQ/eG6WyTOwK3vYLiPUrV2YYOzFDUyAuqODEyFLCo7tCKXxAkq2C2Ey/wG1X4zXiA==
X-Received: by 10.99.145.73 with SMTP id l70mr10654123pge.132.1507597185235;
        Mon, 09 Oct 2017 17:59:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id k8sm15573920pgt.22.2017.10.09.17.59.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 17:59:44 -0700 (PDT)
Date:   Mon, 9 Oct 2017 17:59:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nazri Ramliy <ayiehere@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010005942.GO19555@aiede.mtv.corp.google.com>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
 <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nazri Ramliy wrote:
> On Tue, Oct 10, 2017 at 8:16 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Nazri Ramliy wrote:

>>> I used to work before, but now:
>>>
>>> $ git version
>>> git version 2.15.0.rc0.39.g2f0e14e649
>>>
>>> $ git status --color=always
>>> error: unknown option `color=always'
>>> usage: git status [<options>] [--] <pathspec>...
>>
>> Which version did it work in?  That would allow me to bisect.
>
> Sorry. It's my bad. I must have confused this with `git grep`'s --color option.

No problem.  It sounds like a reasonable feature request to me,
especially now that we are about to drop support for
color.status=always in configuration:

	commit 6be4595edb8e5b616c6e8b9fbc78b0f831fa2a87
	Author: Jeff King <peff@peff.net>
	Date:   Tue Oct 3 09:46:06 2017 -0400

	    color: make "always" the same as "auto" in config

Would you like to take a stab at adding it?  builtin/commit.c and
Documentation/git-{commit,status}.txt would be my best guesses at
where to start.

Thanks,
Jonathan
