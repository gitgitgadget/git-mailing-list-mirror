Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8011F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdHVXp4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:45:56 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35146 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdHVXp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:45:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id x137so745169pfd.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUxuMDG7AU/oUd5hoNfgU++cARx/n1tXWXZwJ71vakk=;
        b=dS3q7BrrguZsIvndycOMd98awMEFh/js6o4tC8mVaxEIKzCq1pybyPckMYhp8mn6UA
         KIWcXh/uRDxkE0yzedmU6iXlUuqyxudz1DDD4jYtszkIZA0OUpwnyM1v3/Ejmgc9IfkR
         0/V05RUvGQ25aM7MThHWAxYWWC4cL2DHBRZ8UcxYPzkkisnYOpy8L0MFO67Pdb91EZOz
         HsB4V26X9q50NSYIr4ntfQ6/HGeIZYbwTDtIkZiJ5hQGzsgjtoWoDKx2OqIvf8KgipTM
         pX6E6pPjWRWtmK8ux7ac2z0S4AvsG8cigqe16uhkqfPSJnoeKFmfHzZtdWVvA34nmX6a
         j+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUxuMDG7AU/oUd5hoNfgU++cARx/n1tXWXZwJ71vakk=;
        b=lEqXgzA5c/FALSiOVq0M8PMfb6WJH+rshbyUptwrbzPwDbwj6CtM56eMQxvxOuDJSV
         gNUL4mICLIPjQfGe9WHz9XiG+eeGP7rnH9ANqJ0pkzkOJ2Qjpyl25w0VSwY1cLJ2motF
         5LNpkn9d+iFyZvyYxh+324lTg9RHDW+Tbg4KGUK9wjH4jAp6TW+LkhYc9Iu/Lk74eEKw
         3nMERgs68UJ/AaK3RDpallQpmlJ0AkahKcECELc6WkgCjz7YzhOlpYvdffJvKeWV7XSg
         7VS8GVYBWsGshvxtp6WYse5rnXqMJKV7eWjYENMgeqMwF7ZcRl8rMPiFNv9z1QIifxo0
         XIXQ==
X-Gm-Message-State: AHYfb5gnqQJU9iShfBJEWUJnFRdkN3xJGbRBEyCc1NB+unmqFpoeBtgd
        cfhhE8WgRpNJiSs/DxU=
X-Received: by 10.84.209.193 with SMTP id y59mr843776plh.459.1503445555637;
        Tue, 22 Aug 2017 16:45:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id v31sm164408pgn.7.2017.08.22.16.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:45:55 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:45:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
Message-ID: <20170822234553.GC13924@aiede.mtv.corp.google.com>
References: <20170822213501.5928-1-sbeller@google.com>
 <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:

>> The svn specific declaration of repo_init was not used since 723b7a2789
>> (vcs-svn: eliminate repo_tree structure, 2010-12-10).
>>
>> This was noticed when including repository.h via cache.h as that has the
>> same function with a different signature.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> It looks to me that this is a reduced duplicate of what brian posted
> yesterday.  The first two patches in the 6-patch series that you
> commented on, I think, covers what this change wants to achieve and
> probably a lot more.  I've merged those two already to 'next' and
> was about to push the result out.

I just sent
https://public-inbox.org/git/20170822233732.GX13924@aiede.mtv.corp.google.com/
to fix this more thoroughly.  I can rebase on top of bc/vcs-svn-cleanup
if that is helpful --- just say the word.

Thanks,
Jonathan
