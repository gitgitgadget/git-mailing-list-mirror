Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B671F858
	for <e@80x24.org>; Sun, 31 Jul 2016 17:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbcGaRdN (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 13:33:13 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38608 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbcGaRdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 13:33:12 -0400
Received: by mail-wm0-f44.google.com with SMTP id o80so214350865wme.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 10:33:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DeiqzjunSmMo5nV8BQm7lICTjEs0jwjauLmYWl5c6ao=;
        b=XvU1XXEa2ZIZtpQdDfsczng3BgTKZUCKm8aSu+As52ENW/VhTWViqyMnWG2ZB6UeyI
         C9nBS7L3k52uWcJDlezxxAj2uc5r8NxAiNqXc6Z7oDe7SIy5Px0FS2TzVxbemjr2sGaB
         XQpL2iC5UlDc0uA61xT7nOZhin2cztiVpecnoGgGPa9ZDw51wJpuTtKRiwmG2B21pPNE
         BiGVUpGIPq5ZoQnmetz8iaIVc6oYUDbiga6H5S3aDoeHS512LAaTZQwFpT8AQoCQudF1
         1Pebae1zsIwi9BCumiweeIZncejknp9DuECA9ja4fnM+z7hXdXL5HozAWzbNzP1w0X32
         LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:cc:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=DeiqzjunSmMo5nV8BQm7lICTjEs0jwjauLmYWl5c6ao=;
        b=OPgKaHEgrzwVDgyRqbqV/1wNiVAuC0LHr688aP3Ez6IMh8B83HNIVMKumZwbE0eLCh
         Obs7Ll0QYVX4wcPU0peHGK1bzb0xJnaKgI+Mj1e4HNuGdIuV9g9+2vOjINCwKm1wozIR
         h28XLBCefA3aktZZHw8Y/W/g+g0NnWvThSiPUJ5IaC4FWKznhTZVzY3jlBQnzV8smqdT
         sQeEk5dp4XZ31rqP3S64BDFKnv2R5GWfxnQxFJqQhvD7oX1cbYuB/m1mnqbnbDRPKExl
         oDdi4WThLJ02tMSPWYavOKaTprmAZAusj31BBfeUw1qpvVKBvrmdGSl4oY068g0FZe0j
         gF/Q==
X-Gm-Message-State: AEkoouvhjsQjt1hsRzLFVaH9T7sbin5fOADZR+69ryIeM6Bud+lvbzrFVIGAG/DmlErktA==
X-Received: by 10.28.174.76 with SMTP id x73mr51838813wme.60.1469986390979;
        Sun, 31 Jul 2016 10:33:10 -0700 (PDT)
Received: from [192.168.1.26] (dad247.neoplus.adsl.tpnet.pl. [83.23.3.247])
        by smtp.googlemail.com with ESMTPSA id z18sm13003743wmz.6.2016.07.31.10.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2016 10:33:10 -0700 (PDT)
Subject: Re: git 2.9 subtree split with rejoin
To:	Sylvain Garrigues <sylgar@gmail.com>, git@vger.kernel.org
References: <1BED74C8-2E4C-4CA7-B785-F0666B69C1A7@gmail.com>
Newsgroups: gmane.comp.version-control.git
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ddf95185-0b87-b81b-6583-6e0aab5a6b5a@gmail.com>
Date:	Sun, 31 Jul 2016 19:32:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1BED74C8-2E4C-4CA7-B785-F0666B69C1A7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 31.07.2016 o 16:32, Sylvain Garrigues pisze:
> Hello,
> 
> It seems now with 2.9 you cannot use git subtree split —rejoin
> without —onto otherwise you get:
>    fatal: refusing to merge unrelated histories
> 
> I wish I could pass --allow-unrelated-histories but that doesn’t
> work.
> 
> Adding —onto makes the split operation much much longer. Could we
> make a bug fix which allow to pass the --allow-unrelated-histories
> flag to subtree split?

This should be soon in 'master', you can check it in 'next',
and I think it would be present in the new release.

From "What's cooking in git.git (Jul 2016, #09; Fri, 29)":
--------------------------------------------------------------------
[Cooking]

* da/subtree-2.9-regression (2016-07-26) 2 commits
  (merged to 'next' on 2016-07-26 at 9d71562)
 + subtree: fix "git subtree split --rejoin"
 + t7900-subtree.sh: fix quoting and broken && chains
 (this branch is used by da/subtree-modernize.)

 "git merge" in Git v2.9 was taught to forbid merging an unrelated
 lines of history by default, but that is exactly the kind of thing
 the "--rejoin" mode of "git subtree" (in contrib/) wants to do.
 "git subtree" has been taught to use the "--allow-unrelated-histories"
 option to override the default.

 Will merge to 'master'.

