Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C9D203C1
	for <e@80x24.org>; Wed, 20 Jul 2016 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbcGTXKO (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 19:10:14 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38410 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbcGTXKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 19:10:13 -0400
Received: by mail-wm0-f48.google.com with SMTP id o80so2622099wme.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 16:10:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+6Hn4EhPUwQtk2evCmw5fjSAbJy3u761bE4MxnX4p18=;
        b=Q8NCr0YQHto0EyA0IM019hkGrbnbu/WYaecgg8cJnEZ4P5Aef4uJfVyV+243rATkEp
         SitB0qEXepdeJdco8hMJ+1BnXn9h5l0MNc7nhUB1v9v6lnRu927KWPjbmJtn1SW5d+gw
         s/wuPpKhGpP2PWSstukG0HA5APm76s0lrLKyUF97wq/refcOnemEF6SH2hgJz3thmq/a
         8a8/dWLiwidrnAs/zZuVdbJsGzOn1AC7DRc4aHZ2bpd4OKFZjUdnGjkUTrUQtDP1KqYO
         +PLUrAgSYHNnJPVDGbsN5t1yUOqZ8SeLmpntGldroo5My1IL5mkxhbRcfx2vnhpfCC5g
         LsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=+6Hn4EhPUwQtk2evCmw5fjSAbJy3u761bE4MxnX4p18=;
        b=Ot4V+BTFKSbtZ8W0UHsq3gqMiWrjKt1LZVP6gUwyvwQgTYOlqAusLC7j/2yfYOHKN6
         TzrwWWI4jhkhGc4nWlM7xC4/YB1HbzdAcPKY8EyWxPykiFnUPovU0utyXAZW/O8Eoxrm
         b2xolgIU72OTb5bQYsiGI0d3kA0jmXq5DtHG6++qs+mXh0VGamcc0FQGPXz6fUsqP4qd
         WY8Wi2qTywFyGcZsNiLxyUXa4+cQLYj0DD7y8y5nh1VdBA+MSPTMUbffuDejV99//svO
         us2pqWlrE3VmEplhopuXhZIL81fTt5lNpMdshda/4ERhwEExKXoBNj2TWbZ/pFTbfikl
         nBLQ==
X-Gm-Message-State: ALyK8tKLWIf7zBES0EEDyX74GFg0bGC2BboJZP/hSfX9T0+QhifxkSmbpwsJBW9HH0b7zg==
X-Received: by 10.28.51.210 with SMTP id z201mr14163543wmz.98.1469056211990;
        Wed, 20 Jul 2016 16:10:11 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id i80sm326921wmf.11.2016.07.20.16.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 16:10:11 -0700 (PDT)
Subject: Re: How to generate feature branch statistics?
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
 <20160720131424.GC17469@sigill.intra.peff.net>
 <xmqqd1m8du1b.fsf@gitster.mtv.corp.google.com>
Cc:	Ernesto Maserati <ernesto.2.maserati@gmail.com>,
	git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579004CC.8090503@gmail.com>
Date:	Thu, 21 Jul 2016 01:10:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1m8du1b.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 20:49, Junio C Hamano pisze:

> For our own history and workflow, the duration between the inception
> of a topic branch and the time it gets merged to 'master' is not all
> that interesting.

Nb. if I haven't messed something up (the git history is not simple
merging of topic branches into mainline), the shortest time from
creating a branch to merging it in git.git is 7 seconds (probably
it was a bugfix-type of a topic branch), the longest if I did it
correctly is slightly less than 4 years (???): 641830c.

-- 
Jakub Narêbski

