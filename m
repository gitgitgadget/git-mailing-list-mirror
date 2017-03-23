Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2755F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbdCWSXc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:23:32 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35200 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935747AbdCWSXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:23:30 -0400
Received: by mail-wm0-f44.google.com with SMTP id u132so68700629wmg.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9iC8swZX373zUxOHqi1WzgnSz+matpxcQ7SWZRfQzaw=;
        b=ZJBU1rJcB0yque2GsN45GTzQBweJ1+2D0zBRQbBd5jXf2bOKi2ntDi5MyOr/EJy7vc
         qIVXx37f5srvzU3YaTNubSAPWUUg5HK9gtWas5a5ZESE4TwaNk/rf1sQ5eiWx0h0ZNH+
         wjL01cGj4+DlVswURygYSVn/fcxcWKx/FPd5DOjIidbkw3TtipwzbxwOtcYD1YsJKco4
         ikk0iZtU1jT4VFE2fJr0TyIEJKKgga/kAK2leA3w3PpLB0OrBg9lwgd9XsOy/ankbZTB
         UIpHU5pu2zzWt47F4RTvL3w2M+uPsRU8lfxx74kh9Nhjyb3uA6oKNDffYKWZtDE0MoBS
         iGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9iC8swZX373zUxOHqi1WzgnSz+matpxcQ7SWZRfQzaw=;
        b=QzA2ju9XfClTU2AMtSK+/eb0LE027fOaqlaM6F67uTAy3ssAF3fY6LrMpOeiaqAYQI
         y5Hg1ZRTYzTXMg45LQF1QV8wAvCYcrKlVqfgIdBASCUI2XJcERof5/RxE35sFdS3AKg3
         8w4WshaUisJSbJM6PeHhawsWRJ9gEAXvWb2VFj9bumFaHdxm38fNlgdTEBsZAR4ZQZtX
         3L1CCGVlZs2UPnCqbaq1xwV50fXuqnDBYFHY5NKyQWaGigGmUFwWHV8CuS05PANB4A7z
         oYU58Oah47wYmuJEaQdwA+18RAuba2woMSAjItYuJps8BKrI4BpdG/vgnYkU8Wyg53bA
         0lNQ==
X-Gm-Message-State: AFeK/H06ceIiNST+bAOGPtnrascmnr0tqzRhGYVL+OdV11DRUurX1O7i3YAoJEeVOISfaw==
X-Received: by 10.28.113.74 with SMTP id m71mr4514354wmc.133.1490293408711;
        Thu, 23 Mar 2017 11:23:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k32sm1835292wre.18.2017.03.23.11.23.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 11:23:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Mar 2017 19:23:27 +0100
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <2713C936-BF9A-47E0-9169-3D6F634907EE@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Mar 2017, at 20:29, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Therefore, we did the following:
>> * Johannes Schindelin set up a Visual Studio Team Services build
>>  sponsored by Microsoft and made it accessible via an Azure Function
>>  that speaks a super-simple API. We made TravisCI use this API to
>>  trigger a build, wait until its completion, and print the build and
>>  test results.
>> * A Windows build and test run takes up to 3h and TravisCI has a timeout
>>  after 50min for Open Source projects. Since the TravisCI job does not
>>  use heavy CPU/memory/etc. resources, the friendly TravisCI folks
>>  extended the job timeout for git/git to 3h.
> 
> The benefit is that Windows CI does not have to subscribe to the
> GitHub repository to get notified (instead uses Travis as a relay
> for update notification) and the result can be seen at the same
> place as results on other platforms Travis natively support are
> shown?  
Correct!

> Very nice.

Thanks :-)


>> Things, that would need to be done:
>> * Someone with write access to https://travis-ci.org/git/git would need
>>  to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
>>  repository setting [1]. Afterwards the build should just work.
> 
> We need to make sure this does not leak to the execution log of
> Travis.

True. I think I took care of this and it should not leak!


>> Things, that might need to be done:
>> * The Windows box can only process a single build at a time. A second
>>  Windows build would need to wait until the first finishes.
> 
> Perhaps instead of accumulating pending requests, perhaps we can
> arrange so that Travis skips a build/test request that is not even
> started yet for the same branch?  For branches that are never
> rewound, a breakage in an earlier pushout would either show in a
> later pushout of the same branch (if breakage is not fixed yet), or
> doesn't (if the later pushout was to fix that breakage), and in
> either case, it is not useful to test the earlier pushout when a
> newer one is already available for testing.  For branches that are
> constantly rewound, again, it is not useful to test the earlier
> pushout when a newer one is already available for testing.

Well, look at this. TravisCi *just* released a solution to
exactly that problem! Good timing!
https://blog.travis-ci.com/2017-03-22-introducing-auto-cancellation


>> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
>> new file mode 100755
>> index 0000000000..324a9ea4e6
>> --- /dev/null
>> +++ b/ci/run-windows-build.sh
>> @@ -0,0 +1,55 @@
>> +#!/usr/bin/env bash
> 
> I know this is not a usual scripted Porcelain that must be usable by
> all users, but I do not see anything that requires bash-ism in the
> script.  Can we just do "#!/bin/sh", avoid bash-isms, and follow the
> usual coding guidelines in general?

Sure!


>> +[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)
> 
> i.e.e.g "test $# = 3" || ...
> 
>> +# Check if the $BUILD_ID contains a number
>> +case $BUILD_ID in
>> +	''|*[!0-9]*) echo $BUILD_ID && exit 1
>> +esac
> 
> Too deep an indent of a case arm, i.e. align them with case/esac, like
> 
>        case $BUILD_ID in
>        ''|*[!0-9]*) echo $BUILD_ID && exit 1
>        esac

Will do in v2!


Thanks,
Lars
