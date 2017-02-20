Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7CC201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 19:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbdBTTd1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 14:33:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33575 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdBTTd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 14:33:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so14158721pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ywAezXOLOf/G6emu7waNByuQS84hEaqlsO+QFjk9ulg=;
        b=s6yxNG+lQ+gszpnSKvhRYdCY9a/HPZBeYz/NzchLNN08r5CI1i2z+PHDg+YaF5382q
         3HslSjPem+7SGEpMFccIl8v5VskvJyYaJdr/KpkXfiKJEOraqsriWDyoqS25kOeilAPt
         fQkkhqg58sOm1CMMJK6+1qdRpgg0rrjoV3BCL7N6su4jmdmxPjqC9xTJ8uITuXgdPQZG
         aQOGdnP3V0s5TwTT60HBmoqIxiwNKsBcFCutBGr+src5c7SBswHPmPo8w8NaQz+RM8Wr
         jv1RWEIdH4eL6hN4UDAsST4qSFgKTIEreP9E9yJbkgq7YtR8LTtiWgxzoFDZbQE+kqz+
         sPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ywAezXOLOf/G6emu7waNByuQS84hEaqlsO+QFjk9ulg=;
        b=f4kSF0R4EywxQtobqYoUQ+WHOka2sgilQBN1wxgaqddeM582VHvro5XwhxkTc64IAo
         3ezpFAaJKAl+rGVqfTd5DsKd7w7qys8C3lQqq9keah42L2joV/+3k1c7czBuaeCX31Xe
         rvO3WdsMP+gAmg6C++4eFanuhD++NjBP1dDGuy9Y0ud+RET1Bw8estXLwhH6PHSkcUEo
         wLUWXj67QREP1FwrWnqTIGhdgcRfB1m1rSIck8+E3/KiAZp3Y4ico/eZpT/6TWyWPcfQ
         cyimrsmbNL2JYhkgZCOUwsOoExpxcCQFOBFjyKOE012uhmzwEqyZK2erq1S89r497HGV
         yt2w==
X-Gm-Message-State: AMke39mxHSyyHAMr5eFLgsTMIe3fxUrovohDz47TLxWgr//bOZHTMO707SOp8of6YRQj1A==
X-Received: by 10.99.114.70 with SMTP id c6mr13003248pgn.163.1487619205909;
        Mon, 20 Feb 2017 11:33:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id g28sm36828188pgn.3.2017.02.20.11.33.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 11:33:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their corresponding commits in `pu`
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
        <alpine.DEB.2.20.1702171841450.3496@virtualbox>
Date:   Mon, 20 Feb 2017 11:33:24 -0800
In-Reply-To: <alpine.DEB.2.20.1702171841450.3496@virtualbox> (Johannes
        Schindelin's message of "Fri, 17 Feb 2017 18:50:00 +0100 (CET)")
Message-ID: <xmqqefysk67v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There is a third category, and this one *does* come as a surprise to me.
> It appears that at least *some* patches' Date: lines are either ignored or
> overridden or changed on their way from the mailing list into Git's commit
> history. There was only one commit in that commit range:
>
> 3c0cb0c (read_loose_refs(): read refs using resolve_ref_recursively(),
> 	Michael Haggerty 2017-02-09)
>
> This one was committed with an author date "Thu, 09 Feb 2017 21:53:52
> +0100" but it appears that there was no mail sent to the Git mailing list

I think this is this one:

    <ff0b0df6-9aed-9417-d9d4-1234d53f05c3@alum.mit.edu>

Recent "What's cooking" lists the topic this one is part with this
comment:

 The tip one is newer than the one posted to the list but was sent
 privately by the author via his GitHub repository.

