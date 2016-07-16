Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354BF2018F
	for <e@80x24.org>; Sat, 16 Jul 2016 20:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcGPUyo (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 16:54:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34098 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcGPUym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 16:54:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so6928484wma.1
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 13:54:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a9NJVMv2nl8+Uv8xCN7maZAzxvcNCDS3/sXpnDBRBzo=;
        b=v/iQvxCXSpjgwsqgZJZaDEGHrrMgK/m6NQ5AFVjP0KDIrmGgST2KjMWsaJ8CQHF3ZV
         2DgFuMaOqJfMFpY9tGlSPRiT+O/nxxdOKvAYSQZpzqG+bQuSPkf5l/1vMCq3i4an8xz6
         vPQG5dj79w+iyjzlv3Po+a36O4KGnIOp18muIGW5lOpLTjOUYeMFTJKovJiH/YRGpX01
         53NJab/rceG6y1tm/wcmgoENxkPQYHdkoknQ71GrW4l2h0UnQbVCt/MhNjUGpY+Hh2xV
         PMw2wv0N7f9mm6pJ8TEDwX/v8l8rmIKRnizQ55SlwntRpX1C6wg3IB8GZ+eHS9BfZMLm
         xcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a9NJVMv2nl8+Uv8xCN7maZAzxvcNCDS3/sXpnDBRBzo=;
        b=XgO2OF788M7UT5Ywzn0fgNulUVCKI7npw7J44sHkoPQwNC6bKnvfMRKlWsZvkkslyo
         lm9j6cHvg9wFxUjHgXMJLxB7C6wdheLiebmTMYuv1ltchuaAoe0A0Clgi0+w2Z2bQCsU
         Tqx14nVSMpYVq7yJsoMH8Y+OZ2ZwhRzE2W3FtiB1CKvcLLWmQ70frBE4DS6r/NKi2Ug4
         l5eBnSnP8VJS0N+YgsIYjswSVNl2G6oQSBfPzRo0d7N2oWaeX4mGIpJ8mFwDU3JYqOdc
         JHfqlGts31YIFFtOJB0ykfTA4vK2Ed2iHMVmBi+MOO8kYrex22ztXhyfI4EyJ3gMyH2B
         ccCQ==
X-Gm-Message-State: ALyK8tLu6dl2D6YnIu0jGo34gAHuWgBkua2cZQ/7tKnEZrdZNXmTyMUwef4JDpb5Z9LnOA==
X-Received: by 10.194.169.33 with SMTP id ab1mr6269519wjc.151.1468702481001;
        Sat, 16 Jul 2016 13:54:41 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA4DD.dip0.t-ipconnect.de. [80.139.164.221])
        by smtp.gmail.com with ESMTPSA id kr1sm7177618wjc.46.2016.07.16.13.54.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jul 2016 13:54:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
Date:	Sat, 16 Jul 2016 22:54:39 +0200
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 13 Jul 2016, at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
> 
...
> 
> * ew/http-walker (2016-07-12) 3 commits
> - http-walker: reduce O(n) ops with doubly-linked list
> - http: avoid disconnecting on 404s for loose objects
> - http-walker: remove unused parameter from fetch_object
> 
> Optimize dumb http transport on the client side.

It looks like as if this topic breaks the OS X build because 
it defines LIST_HEAD. LIST_HEAD is already defined in 
/usr/include/sys/queue.h. 
See: https://travis-ci.org/git/git/jobs/145121761

- Lars
