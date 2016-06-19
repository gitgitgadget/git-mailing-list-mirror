Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53C120189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbcFSStk (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:49:40 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33388 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcFSStj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:49:39 -0400
Received: by mail-wm0-f50.google.com with SMTP id r190so6706311wmr.0
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 11:49:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Riy8Zm5uv1oUJXnR7M+Xq/RAyC7BH6Z9Ta+pn+31t90=;
        b=HJ5uAhjvQRN81lN8FJ8xbIOq68TqWVj5ZoRnGMu5lymQ5GGjLLuO6eX0Cc2sL3PvnH
         uFwPYXqmGzpgO/XcaRSXf/dMH8B6lGqCQ8sHVtVTNFWl84OOjJ3bAmC/W/dtgGbdnj49
         UUhUdkcIEjALPiyXehe7CBca11j2epC3XgjNDQu9IKf6gDDZX1xIaA6Ze5sdYNhXgvie
         TBnKHJgF5vwlcqCi7SGNqtcsyRAqkkEGiEh+49ytj0Ik69Hq21+NfCqHasNFeFXzPkYE
         4njPAQA9Hv+DaS0YfC1Vhb2BsAbQgQK5x+0/3DchIS9p37PPvbBIy38DGEN5rGaEzAx6
         HAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Riy8Zm5uv1oUJXnR7M+Xq/RAyC7BH6Z9Ta+pn+31t90=;
        b=fnChak+pM73jUT1HGxpCA9djJORlG/ixcXPOBhNn/e2L0mZS9CzImmx6CIg/3dD2ET
         vPgE8GzZDS16gSs/Xf1L/mb2V/WHJyC4I5ejFQ3Aft5ol2yyTxObOSDb/lIrUGqT2Om+
         8eN71i5j0+bYcjtTX21t/1lzrE1ClLtuIo8GtwrHb25d7YaHcDrsYM+lRsFRUIl628ak
         SbSJe8+igPqdEtFQiCFopUAzrz/DCZtFS4eDRU2mOLj4HBpE6WU4g9wejEtkbWxOFQ12
         MTPWq6F5gtr3vxe5hjBBKw3rYzrA3tXsP5gX0cPHRhpszMU3IccWgClrJ/QHn3nMqsWt
         ZSJw==
X-Gm-Message-State: ALyK8tIYwr7PhXQWKJBlzutNwnuDNuOHw1HNjTGjprYC5cN3diVq83kGOlMtl/3hohBvaQ==
X-Received: by 10.194.37.40 with SMTP id v8mr10954038wjj.161.1466362178437;
        Sun, 19 Jun 2016 11:49:38 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id y6sm4545590wmy.8.2016.06.19.11.49.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jun 2016 11:49:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinx5vyg5.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 19 Jun 2016 20:49:36 +0200
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D0F4EDD7-43BB-4311-A8C9-7A83E45CACC6@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com> <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com> <576650E7.70107@alum.mit.edu> <3E132EEE-CEBA-4C0D-A5C4-62F587A02225@gmail.com> <BC5163B8-7CF2-4106-9FBE-8CCD096252A2@gmail.com> <xmqqinx5vyg5.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 19 Jun 2016, at 20:13, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> This seems to fix the issue:
>> 
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
>>         self.useClientSpec_from_options = False
>>         self.clientSpecDirs = None
>>         self.tempBranches = []
>> -        self.tempBranchLocation = "git-p4-tmp"
>> +        self.tempBranchLocation = "refs/heads/git-p4-tmp"
>>         self.largeFileSystem = None
>> 
>>         if gitConfig('git-p4.largeFileSystem'):
> 
> Anywhere in refs/ would be OK, but don't you need to adjust the
> test, too?
> 
> Even though I do not use git-p4, I'd imagine that I would be upset
> if temporary refs that are used only during sync contaminated the
> set of local branches I have, if I were a user of git-p4.  Would it
> make sense to use "refs/git-p4-tmp" or something instead?
Yes, "refs/git-p4-tmp" would work equally well.

- Lars
