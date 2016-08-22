Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BA01F859
	for <e@80x24.org>; Mon, 22 Aug 2016 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbcHVTC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 15:02:28 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35981 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbcHVTC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 15:02:27 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so133846662wma.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=4fu8osz6+qCixQsEP1slsh1+gxbGggIGr1RZAEAc1Jc=;
        b=S9fLci+V3Kyuqi73Nsft8SiA0ZkU0YRzb8Tb9MmU2yO7kgJ8YCjKJkL33dKDR2dPJc
         8bztzDTPlURcYWBKaK6jfCKDPh+5I8VvTuZX14UvxJ9261G6QaUNynzazbFqmBhvOYeQ
         nuyV6JuXJVduj3zIr4erqTHABsCZNfKSg1pAJ/1Zx6Juzz+eusOEXHbGRr/zuX3dSlQP
         MZ6oXPoiTbS6n3jb/wpAWF2gGLml+fTYUAiZnF+VqVj/KAkB3mGr3IGuNOR5gY44DOQa
         YqzcQs0FdelVNLVUxNu6jsOh2jQjhIy0omJYUFJLIOW/YWGXnhq8rClseti4K5Yn+A8B
         dDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4fu8osz6+qCixQsEP1slsh1+gxbGggIGr1RZAEAc1Jc=;
        b=Q0CcVFyx2ax5Pb9rsv/XqYRlq8gGp1dU5Miy/I+03mHIvWSL4fAG978jCEJLuBwahQ
         HQazlnjGumksYzNTE0B0IfSAfbQeoiUPmdjelhBb97WQewVeJVyOcQWiqDs7J/e7vL2S
         4sEnPJeawAtbvtVBANBXNtzIrxW9ZEsraYc3raVKndapic9ihnVJdWE5WKJeqzkEEw/P
         0Wm22T4oeo9OV4qd3WQ1bZzfww3G4gmK6pDikMSJsKo3PruQ0fPi5bJiaDlj1MYuwccJ
         y3iwNBP2vH3qCAIz1zIfTsCYyIEDlwFpZn0kzRv/dMThMQ0+scbN8lwY0GX7IZe6Ig/O
         KVHA==
X-Gm-Message-State: AEkoouvPeS1528jEp36fTY0igpcu9bJ7IvEbmF7gwOqqSS7dK2HRagCGitAaDW7WAxz9ZA==
X-Received: by 10.194.95.105 with SMTP id dj9mr20100581wjb.20.1471892545228;
        Mon, 22 Aug 2016 12:02:25 -0700 (PDT)
Received: from [192.168.1.26] (adap92.neoplus.adsl.tpnet.pl. [83.11.251.92])
        by smtp.googlemail.com with ESMTPSA id m81sm23080189wmf.1.2016.08.22.12.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 12:02:24 -0700 (PDT)
Subject: Re: Editing a typo in the message given to "git commit"
To:     Norman Shapiro <norm@dad.org>, git@vger.kernel.org
References: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8b0cf1e5-41c9-4b5a-0baf-4996c45d31ef@gmail.com>
Date:   Mon, 22 Aug 2016 21:02:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.08.2016 o 17:19, norm@dad.org pisze:

> I am learning how to use git. I would like to know:
> 
> How can I correct a typo in the message I gave to an old "git commit"? I see
> that the typo occurs in exactly two files in .git:
> 
> .git/logs/refs/heads/master
> .git/logs/HEAD
> 
> /usr/bin/file says that they are both ASCII English text. So I could just
> hand edit them. But that seems somehow sacrilegious and might break git.

As the pathname suggests, those two files are only *logs*, to be more
exact these store so called reflogs, which allow for example use @{1}
for previous position of current branch in your local repository, or
"git checkout -" (or "git checkout @{-1}") to go back to previous branch.
You can edit them (just take care to not touch the rest of line / file),
but it wouldn't change what is in your history, what 'git log' would show.

If the typo was in the last commit you have created, the simplest solution
is to use 'git commit --amend' (assuming that you didn't 'git add' any files
in meantime).

If it was something few commits back, you need to use 'git rebase --interactive',
starting from the commit before the one you want to change.  Then you need
to change 'pick' to 'reword', as described in instruction sheet for interactive
rebase. 


P.S. Good source of finding answers is StackOverflow[1], and new (and in beta)
StackOverflow Documentation

[1]: http://stackoverflow.com/questions/tagged/git 
[2]: http://stackoverflow.com/documentation/git

There is also #git channel on FreeNode[3]

[3]: ircs://chat.freenode.net:6697/git
