Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EA720451
	for <e@80x24.org>; Wed, 16 Nov 2016 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbcKPSrV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:47:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36304 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbcKPSrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:47:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so13952795wma.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9/FEH3LQsvO63vjBRiJ/nt/Ld3a3isil4I9Ln1h84M=;
        b=cDZpWjv5cd46H9yS45NWtpLjvsZ6erxFlGumXloRVn0METIjx+QUnB/ezEQd3WSqZ8
         DXufWveiPQ2YTu/9xMQOj6+n+H/zbrFRtbla59DxtR5wKA/w4zhQARAV/ShFw47HI82F
         N2o2JmrflwNZHgFvk/opdRtvjo1oGwgRB2I51IWj6CgdSvvLb0DJD+ZuLjW1t9XlYUqY
         IFcqoZgWdmOidNJYtZTMpO2GiBlI77HbiWes7ovoyvmA1WEUU6jF5uvgEBhxJKWM9V3q
         kXRqVEDLcpCFabOLY8itmvCsiz50kZIEi4VViklWQU597yeB3zoUdobRqklAADbIkapR
         gSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9/FEH3LQsvO63vjBRiJ/nt/Ld3a3isil4I9Ln1h84M=;
        b=Q6UjCtbgJwcepExvuYO9aeQ0eGhyedZGfgNwEt9rQIEe8nzlZ851BluOBjYdUHsJ/w
         22cZnUL6wF3R+x3gEKe8FXIORk1tUz1SdXEfTHDYjl2T9MbC/V8p05f2FSMO0hma2uPc
         RFS3M2Frr8dzsET/ACYyT7jmxRG/cYvxuiOFH/sz4JEuC5jC68cEG9ONCzs6WLhlFJdg
         6uyaUBWWHsd6S/rV6mrnfUXHB+njjd6oMW1lQqeJmTnu+pbpFMbMg34k/bWKqMVeHUDl
         TDD4o7C1beCjAWrf9baXREUdUUG3S+WETgZAJ8XKjAt435r37K9uw9htEmQv1VDBG6F/
         5RQA==
X-Gm-Message-State: ABUngveWlsVcMS0LOz1+F4j7i2/IwO5F1E1PNmKASVH7S8zsLCW1y+bxBccP5so0qFMhRg==
X-Received: by 10.194.2.198 with SMTP id 6mr3428386wjw.51.1479322038943;
        Wed, 16 Nov 2016 10:47:18 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u81sm11541387wmu.10.2016.11.16.10.47.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Nov 2016 10:47:18 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqpolvqoka.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 16 Nov 2016 19:47:17 +0100
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2F93C9B4-157C-4F5C-9BD5-A67AA519757A@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <20161115010356.GA29602@starla> <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com> <xmqqvavotych.fsf@gitster.mtv.corp.google.com> <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com> <xmqqpolvqoka.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Nov 2016, at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> * You'd need to rein in the maximum parallelism somehow, as you do
>>>  not want to see hundreds of competing filter processes starting
>>>  only to tell the main loop over an index with hundreds of entries
>>>  that they are delayed checkouts.
>> 
>> I intend to implement this feature only for the new long running filter
>> process protocol. OK with you?
> 
> Do you mean that a long-running filter process interacting with
> convert_to_worktree() called from checkout_entry() will be the only
> codepath that will spawn multiple processes or threads?  
> 
> That is fine, but it does not change the fact that you still need to
> limit the maximum parallelism there.

Filters using the long running protocol are spawned only once by Git. 
The filter process would get all the smudge requests via the pipe
protocol and is supposed to manage the parallelism on its own.

- Lars
