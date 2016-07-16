Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0981FEAA
	for <e@80x24.org>; Sat, 16 Jul 2016 22:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbcGPWEz (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 18:04:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35254 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbcGPWEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 18:04:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so7063572wmg.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 15:04:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DK7ulCs4CaU2WH5BXklap74/KP+2zJXdW9oUQgvGa5w=;
        b=ssgF7gSJDdiYlkiEWqZf1O16w+qARLpkJV/kpSytOYCltmGlKi+e2v8A2jboDa8UDM
         uUH70dHUrl03NrObfy/T+ymQgIc0h5Ibq9w+GgWC9onG81+iQFzaPARettUcjCM4Vf19
         8f4ke/jfgs287Jk8ogWUfp5grVVKu1oo2k4WKrtgiuJ9gb3az/kGPP9LaZGfsTJ71s4Y
         fuyDyBrOsv2hEeoWyGpqUy7SaI07o6ysy31OI9Nqv6qT+OsJK6eBSM8AfBHNOfDqmRxu
         3VgAKqWJwVW/93zhffl7BmaBIBZhwSRWs7XCc7Wma59KVPGHgo2oeCOs9yc12Yooq/b3
         JdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DK7ulCs4CaU2WH5BXklap74/KP+2zJXdW9oUQgvGa5w=;
        b=EZe0kKm68rJJP2hBAbb3I3JNB8eAukw8ExubCrlhrUcXyJdFlprgH3sCZVFWqn9UQx
         RaNJcLMjGNcumtb+u5j7oUYxbuB/Ng1xKiidnQnvvKGMiWkZ30YMIO167kZ/Onlk7CoV
         eNN/5AzOd1+lEtJGj16dObLdZIi9ExUgXJzYt9owFm/qGELv/81LtAuxqtC6QaPcEpun
         GbGgDoRHLllFdO+HQKjQDrhc8e0zBkG7AuiDOIUt1eCQzamhvpxbuTq3xwZvN5lKq7+U
         HpzWH18Ndd96mtanfvzI/R73VRWM3edeNkmsmifntqLlHIYIInFzELsEY8bjzCZ5QXjZ
         DpXA==
X-Gm-Message-State: ALyK8tLIcAtGioK0J4zfNFOc5rkWgXRxtMPnWSbfN3BGUpP7KPhGckcs26GmN5hwQ+xC/Q==
X-Received: by 10.194.92.9 with SMTP id ci9mr6566142wjb.68.1468706691850;
        Sat, 16 Jul 2016 15:04:51 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA4DD.dip0.t-ipconnect.de. [80.139.164.221])
        by smtp.gmail.com with ESMTPSA id 207sm4544048wmb.7.2016.07.16.15.04.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jul 2016 15:04:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160716210454.GA7849@starla>
Date:	Sun, 17 Jul 2016 00:04:50 +0200
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <644FFEA8-3A08-418B-A29C-C45CE5F4D264@gmail.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com> <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com> <20160716210454.GA7849@starla>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 16 Jul 2016, at 23:04, Eric Wong <e@80x24.org> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> wrote:
>>> On 13 Jul 2016, at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
>>> * ew/http-walker (2016-07-12) 3 commits
>>> - http-walker: reduce O(n) ops with doubly-linked list
>>> - http: avoid disconnecting on 404s for loose objects
>>> - http-walker: remove unused parameter from fetch_object
>>> 
>>> Optimize dumb http transport on the client side.
>> 
>> It looks like as if this topic breaks the OS X build because 
>> it defines LIST_HEAD. LIST_HEAD is already defined in 
>> /usr/include/sys/queue.h. 
> 
> Oops, I suppose GIT_LIST_HEAD is an acceptable name?
> (looks a bit like a refname, though...).
> 
> Or maybe CDS_LIST_HEAD (since I originally took it from the cds
> namespace under urcu)
> 
> I also wonder where we use sys/queue.h, since I use
> LIST_HEAD from ccan/list/list.h in a different project
> without conflicts...
> 
>> See: https://travis-ci.org/git/git/jobs/145121761
> 
> Is there a way to get plain-text logs?  No JavaScript, here.
> Thanks.

Here you go:
https://api.travis-ci.org/jobs/145121761/log.txt?deansi=true

- Lars


