Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859411F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 15:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967153AbcHBPVz (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 11:21:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36391 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967040AbcHBPVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 11:21:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so31444767wma.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 08:20:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=k+M0ajjiAF3I7aJNdyHGMJx2hU98ZPWjpH90sLOYrKI=;
        b=qqNgLcoYVLRt4WkVuI7CqzKPyV6UaqF1/ctxotq+NqJGAYJU63MJu6SEDG07C1FUGd
         skSZZ+YCBjIRc6W3GZRxJE6ZNX+ZOsVk8QDY0yiofDTN1r3DKevf3qzeQEHnFufl0YwQ
         TNHmuMPI2y4AVWa9WLRf+M7P9201++KDwj91hVUBz8u9eenWMWuqxwpzUI2Zg+cxSHT2
         BPmhFZhVCo1vbdORbK5JLXioWvh7pmqEpLxoXOaxjt8NNkNNRTIfLLoCvoQaZiuQXgp4
         qxBY9gYFxp6ckKhOsCycsydPNCqcPT5oiOfxnHK38zHjdKzcbsFfofiZbC4UQaZx63pd
         Ggmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=k+M0ajjiAF3I7aJNdyHGMJx2hU98ZPWjpH90sLOYrKI=;
        b=N1KVDqbk3wGJx3EebwIKHBrWPiqZeKUIJOqLgAvl73kLKqGWiRtGouim3Wye4q6SB0
         nSrVb4vv3lsIrAM8Vd9LhS/JMDuQrot/b4dssWSNHQIH99vJLYNIA5MkgrW4EklHncUN
         qSSnlql2OYBq57pF4pS2tUfFSh3saqG+Rxn1AoTVhR6IpBtdhL5idb6M1q8+tKCvPZQf
         P/qk9hyIFjCipkt0Dp2ioWiEcExVjX2WGJ/Zy0sOb7TbDXw52wnt9XxVUViKaqRul0V/
         t8SzQCiEAdd5sORYpacCvob1mhqUrJiIMKyfqCeN5gmlQ4eYdZJzxOp7IUbOUHO+BHvW
         sZfQ==
X-Gm-Message-State: AEkooutg6M061YPpalCn2/QNfOCofS7Qq1wvFegPt5bnQvl0R0V/PmJzdnNFitNNXqrvAg==
X-Received: by 10.194.133.104 with SMTP id pb8mr56569160wjb.139.1470151202513;
        Tue, 02 Aug 2016 08:20:02 -0700 (PDT)
Received: from [192.168.1.26] (els92.neoplus.adsl.tpnet.pl. [83.21.212.92])
        by smtp.googlemail.com with ESMTPSA id wc3sm3098557wjc.47.2016.08.02.08.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 08:20:01 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] status: update git-status.txt for --porcelain=v2
To:	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
 <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
 <fe5d1dd7-11da-e09b-5880-cf103e34fb9a@gmail.com>
 <579F6D3A.3010704@jeffhostetler.com>
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4afec4ce-ecb4-dcce-b8f5-c37844d963d8@gmail.com>
Date:	Tue, 2 Aug 2016 17:19:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <579F6D3A.3010704@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 01.08.2016 o 17:39, Jeff Hostetler pisze:
> On 07/30/2016 01:22 PM, Jakub Narębski wrote:
>> W dniu 26.07.2016 o 23:11, Jeff Hostetler pisze:
>>
>> This is a nice change, available because of lack of backward
>> compatibility with v1.  The porcelain v2 format branch-related
>> information could be enhanced without risk of breaking parsers,
>> or having new information put at the end even if it does not fit
>> there (like in previous iteration).
>>
>> One thing that can serve as goal for the series is using the
>> question: would it make __git_ps1() from git-prompt.sh be able
>> to render fully decorated prompt with all bells and whistles,
>> and with all combinations of options.  Thus beside upstream
>> in the future we might want SVN upstream, and/or pushed-to
>> remote branch (and remote push upstream repository), etc.
>>
>> But that's for the future (and it is possible for the future)...
>>
> 
> Yes, I was hoping to be able to simplify and/or speed up
> __git_ps1() with this data.  "Namespacing" the branch data
> here.  And then later add the state data (in a merge,
> in a rebase, and etc.) in a series of "# state.*" headers.
> And so on, until we get everything that __git_ps1() needs.
> However, to really make that work, we might want to add
> a --no-scan (or minimial scan) option, to just return the
> header data, since __git_ps1() doesn't care about the list
> of changes.

But __git_ps1() with GIT_PS1_SHOWDIRTYSTATE would want to know
if there are unstaged and staged changes, and with
GIT_PS1_SHOWUNTRACKEDFILES it would want to know if there
are untracked (unknown) files, isn't it?

And GIT_PS1_SHOWSTASHSTATE would want to know if there is
something stashed, but I guess it is outside the remit of
git-status...
 
Also, __git_ps1() uses colors from git-status, so if it
is switched to use --porcelain=v2, then there should be an
option to turn the color on, isn't it?

-- 
Jakub Narębski

