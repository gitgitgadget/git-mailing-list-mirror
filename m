Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2C71F404
	for <e@80x24.org>; Mon, 18 Dec 2017 00:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757047AbdLRA2P (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 19:28:15 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:43398 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756890AbdLRA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 19:28:14 -0500
Received: by mail-wr0-f180.google.com with SMTP id w68so161216wrc.10
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QeOpzbp61gI7LhQKO/iwG3WUb5rogqNsJMLezEAgZvw=;
        b=YvGID7ErR4W3oI7ne/OwVt47xVz0nNZlz9cx085G5BxLqWA3nyXibJ458v6i47qieu
         7tfzS7oOKb+79S/Z2V5XiYzCLWvTWWfWydTqIgCzeQ47WZhqOvVCxsSt19NxqcA8Nmzo
         N6VkS04soD17fOoRHUPp5Xbe3rvHhYFBeUklqBYgERAoRTtWUKaI2Vyf4QwuQPvG7THT
         OZSbIDd0/3P6sAKX4kb54JlVaXfN76192a3p1gzzivmwbFVGPWZ4ecUGV+B1aT//uZpa
         h+u+aEZ+XccOYUCcNt+IoeG5F1La510UCzJ/XPYEZ4ca9CR+Q8kwfHYZWsumAMoFb/ZZ
         q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeOpzbp61gI7LhQKO/iwG3WUb5rogqNsJMLezEAgZvw=;
        b=c3UZyXxfwTrtugW8kvNFJrUMIcgFKviOJHqmhYoGT3QhjZJaNwQATQkI5zmyIVC1uz
         YDPDK06+WeqPMFdsoj7Q4VaRzgBA4dpXWaN/zQx6kkINiYf6bau+7kK0oKYT7VQOoIyV
         RktZXnSw/yUQddMYzXbE0H4Je0APUJtPnP9YcLD3hCFJQQwOr6SDdBFswCSMm2cpFHv9
         PQ7UNtXHz1T7nBaQGvoQZF38y9Ss8Qaa3s9C8m18rzi+ylY6nIz5dhE58iFWMQptqtuP
         +a++bU6I5Xj9gsarkpDp1BVW7vwc6PBUqShg8pLU9V9OkKXMPCJL5A+YRJ1AtnN7gawL
         YI5w==
X-Gm-Message-State: AKGB3mKyrudkB51lVKgg7fjdfQC7w/6PeTA6akh/3sZMyfH+TtFQXWlI
        5CdcK3zEzVsppMcGxpRlRuIS2oip
X-Google-Smtp-Source: ACJfBovmXkTK6q71GiTuxeJQehsAIaC56EAm3tlyKb8oX9GzrGQB54rgEZCd2Gp/N7tVOThkg5OZ9A==
X-Received: by 10.223.150.84 with SMTP id c20mr7169356wra.202.1513556892892;
        Sun, 17 Dec 2017 16:28:12 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id h12sm1520472wrf.47.2017.12.17.16.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 16:28:12 -0800 (PST)
Subject: Re: feature-request: git "cp" like there is git mv.
To:     Simon Doodkin <helpmepro1@gmail.com>
References: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <45bf86e5-1cac-58ca-8ac1-0400b7efd568@gmail.com>
Date:   Mon, 18 Dec 2017 01:28:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon,

On 12/12/2017 11:53, Simon Doodkin wrote:
> 
> please develop a new feature, git "cp" like there is git mv 
> tomovefile1 tofile2 (to save space).
> 
> there is a solution in https://stackoverflow.com/a/44036771/466363
> however, it is not single easy command.

While having `git cp` alongside `git mv` would make sense, I`m afraid 
that is not what you are really after, nor it would help in your case.

Looking at referenced "Stack Overflow" post[1], it tries to address 
`git blame` not following "file copy", where it does "file rename".

Proposed steps seem to be "solution" from your perspective, and while 
that may be absolutely valid and acceptable for your specific case, I 
would argue it`s the wrong approach in general - because `git blame` 
already supports what you want (just not by default), and making 
three additional, unneeded and possibly confusing commits (one being 
a merge), just to "bend" `git blame` to fit your (out of line?) usage 
expectations doesn`t seem right.

I would say a better direction might be using `git blame` "-C[<num>]" 
option[2], where desired effect is achieved without any artificial 
history fiddling.

Example being worth more than plain words, I`m providing a script[3] 
that demonstrates what I`m talking about :)

Regards, Buga

[1] https://stackoverflow.com/a/44036771/466363
[2] https://git-scm.com/docs/git-blame#git-blame--Cltnumgt
[3] Demo script showing how using (multiple) "-C" option(s), with 
    specified numeric value, can make `git blame` provide desired 
    information, recognizing "file copy" operation (line copy, actually, 
    but that is what we are really interested in, using `git blame`):
--- >8 ---
	git init

	echo a >A
	echo b >>A
	echo c >>A

	git add A
	git commit -m "create file A"

	git mv A B
	git commit -m "rename file A -> B"

	# ---
	# (A) regular flow
	cp B C
	git add C
	git commit -m "copy file B -> C"
	# ---

	# ---
	# (B) proposed "solution", https://stackoverflow.com/a/44036771/466363
	# git mv B C
	# git commit -n -m "rename file B -> C"
	# SAVED=`git rev-parse HEAD`
	# git reset --hard HEAD^
	# git mv B B-temp
	# git commit -n -m "rename file B -> B-temp"
	# git merge $SAVED # This will generate conflicts
	# git commit -a -n --no-edit # Trivially resolved like this
	# git mv B-temp B
	# git commit -n -m "rename file B-temp -> B"
	# ---

	echo
	echo '(1) blames B back to A, as expected:'
	git blame -- B
	# git blame shows that file B has a history (back to file A)...

	echo
	echo '(2) blames C only, missing B and A:'
	git blame -- C
	# ... while file C doesn't have a history

	echo
	echo '(3) blames C back to A, as expected:'
	git blame -C -C3 -- C
	# git blame shows that file C has a history (back to file A)
