Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAD420A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbdAWSmn (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:42:43 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32820 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWSmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:42:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so28429172wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YWjsoGxPv3Ud6MMXz1phbGWw8jQ84B/Os9JFmE/EDqY=;
        b=DUTOX1RK1IXkDdsvkvlxiemPJY3RrdBAuvPQMhmDC1p7YOLE54qyZoKTzCscFHvqKh
         Q2Tz5jJ0ZYfxOaW7n6C5KPo0hdkuxQbaY3dyMZcvMFDDgBTdjQ7N+D01LrCZuCi2sbYQ
         fwXPPqWuEf1Is6rkhgN1+8BT62kwar+hp79PT3T/CijQeZUQwSDbyAhJzHS+Z3uWlMDb
         pQTVYQOHSn4LCMX3OUzLWRxTqCiJO2W4ysjq/S+QM+gc7dZIpGU1Xj54bVBpCHjVYQss
         G8hVYHookR6EZAjpfqYzmK5+Q+O5exNEq3+zcpMAa0GRvCFcJmn0nKwbmtHMDsXEibD3
         ewDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YWjsoGxPv3Ud6MMXz1phbGWw8jQ84B/Os9JFmE/EDqY=;
        b=jTPTksscxN1tWDVPeI4J38Wk/gBP2RKOFefXv0x1HBtazG6wONt/qLsYApqob1qtgN
         FXwvcbxKsz46QVhJDdIvC8mAEi8Vpu8OUED0Zic314CNyCt/DUyU0NYa5vv4N0oY8kfZ
         zQaclaycgL39MfKhObuvHVbFfFEURXyZ9JtkHFoQ81evsMxoy47PSvOM54Sbx+/2+q3I
         f1FhJM//kkOP3j/zvw8g7q8NJbLdoO6wzBgdOaLdoYep5IjkgEIpaEJyO3icnzJF/aHE
         5cG6LDl1NzRj31lusJbQG4h2G6Jzj3RTNbIalHkIbYL80EFvsvx09gxUvmBc6BzEihEB
         kBdg==
X-Gm-Message-State: AIkVDXJ2qSIBl2+QgRQv5AiDgUNVXWdEcitf0LqPusfX6pDFlXxdTc350IAjgRO19OVEyA==
X-Received: by 10.223.164.10 with SMTP id d10mr24009205wra.90.1485196961540;
        Mon, 23 Jan 2017 10:42:41 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id z67sm16033975wrb.49.2017.01.23.10.42.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 10:42:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Case insensitive Git attributes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvat5sjym.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 23 Jan 2017 19:42:40 +0100
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C265204B-BCCF-4085-9933-F28EB459CFB9@gmail.com>
References: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com> <xmqqvat5sjym.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Jan 2017, at 19:35, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Dakota Hawkins <dakota@dakotahawkins.com> writes:
> 
>> Apologies for the delayed bump. I think because we're talking about
>> affecting the behavior of .gitattributes that it would be better to
>> have a distinct .gitattributes option, whether or not you also have a
>> similar config option.
> 
> As I know I am on the To: line of the message I am responding to,
> let me quicly let you know that I won't be responding to this thread
> for a while as I don't recall what the discussion was about.  I will
> after I'll dig and find out what the thread was about but it won't
> happen immediately.  Sorry about that.


Problem:
Git attributes for path names are generally case sensitive. However, on 
a case insensitive file system (e.g. macOS/Windows) they appear to be
case insensitive (`*.bar` would match `foo.bar` and `foo.BAR`). That 
works great until a Git users joins the party with a case sensitive file 
system. For this Git user the attributes pattern only matches files with
the exact case (*.bar` would match only `foo.bar`).

Question/Proposal:
Could we introduce some flag to signal that certain attribute patterns
are always case insensitive? 

Thread:
http://public-inbox.org/git/C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com/#t

Cheers,
Lars
