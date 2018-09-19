Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B3D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeITE3x (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 00:29:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeITE3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 00:29:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so8746238wmc.0
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UhN/5bhqhAVcuE4xU0XlmZjU6IjC/OhUYAb0Aj1Dfnw=;
        b=Za6jaTd1BGRfNHX05rw6Ki0S26M7yFJcgk9rWWE7tq+DOLe37bahY+URYN67gnPiJb
         K4T5A7tsSyvKlQBu/bv8+qHO+Qg/264+b8mC0uB2S/fGVG2kDyjX4/Ney2n9Iznv6Sce
         1Zd/sOF8dMamxCRdmGdFdSGYdh0wCBTnlwfPrTWAY99a6n5z6OvTqG556aWNurKKC02Z
         dOluQUe2+V/9YekErShSzJkaRzqNvAWVSSbBuR4RhSWMfsEjgtnSfeYvtciPbdq1uMVs
         ZNL/525wfGPGkOVzhF2s5f2xPNJ4z1sv8ZgzFiyQulI4d+wn4CJRKk7FHCqjKvgQ4s6K
         2aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UhN/5bhqhAVcuE4xU0XlmZjU6IjC/OhUYAb0Aj1Dfnw=;
        b=UBpuguWu130gSpkSO72AOlEnBWyoUGp38QONa8G2ra4mVyF8dxc0fnGx4o7nxnxosI
         jpO2umgp4LdrgERpJ0L9vX1UFWK93XwAbfcLGiqEUZfuMQUtbMgGgysocHbZfqhts119
         /nCquUqgfnWEEG+ZHLYtNSWrVdyYJKapy8vnZuxCo0zPXWeTORBxbxCDs5VS6Kyy4Nrj
         5/llW2L58xz3+jtW+gLZDOvLqmbsOm8EDVk4X3+AQNWtk/sFrKtdOslzNt6QKdiIatxi
         zErO0lKJaVX7Orj0tNDpqQnyhqwk2LFhm7eU1/SCodoDERBfDsXvhNBDDXgMVJpE3Q95
         4mHw==
X-Gm-Message-State: APzg51BzoXc53XLig9Jd/mS0RMIhR9eXvK0rtN87jZSmNvkvFDvXQtnQ
        V9IQCRSCPYOFOwvisyh4sIdgbz19
X-Google-Smtp-Source: ANB0VdZJmYwzk1pXlDetuE4u60VqExmYT/9M2NwnI9MfG81dVy/tWe64MRCdpKcnAxXIt4StoSlC7Q==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr59768wmf.25.1537397382745;
        Wed, 19 Sep 2018 15:49:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g17-v6sm60551wmh.19.2018.09.19.15.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:49:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] some documentation changes from the beginning of the alphabet
References: <20180919201231.609-1-frederik@ofb.net>
Date:   Wed, 19 Sep 2018 15:49:41 -0700
In-Reply-To: <20180919201231.609-1-frederik@ofb.net> (Frederick Eaton's
        message of "Wed, 19 Sep 2018 13:12:28 -0700")
Message-ID: <xmqqzhwd2jcq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frederick Eaton <frederik@ofb.net> writes:

> I've never sent patches using git before so I thought it would be
> useful to make a small test.

... eh, welcome ;-)

> I read ./Documentation/SubmittingPatches and I sent these to myself
> and practiced applying them using `git am`, and I also compiled and
> checked the revised manual pages to see that they format correctly.
> Unfortunately it was too late to run 'git diff --check' because I had
> already committed the changes to my repo, but I don't see any
> whitespace highlighted when I run 'git log -p'.

Thanks for being diligent.

> By the way for some reason git-contacts shows more names when I run it
> on the patch hash than when I give it the patch name:
>
> $ ./contrib/contacts/git-contacts 222580cb60ee64f7b81fed64ec8fbfc81952557f
> Sébastien Guimmara <sebastien.guimmara@gmail.com>
> Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Eric Sunshine <sunshine@sunshineco.com>
> Junio C Hamano <gitster@pobox.com>
> $ ./contrib/contacts/git-contacts ./outgoing/0002-git-column.1-clarify-initial-description-provide-exa.patch                                
> Junio C Hamano <gitster@pobox.com>

I've never trusted what git-contacts say, but the latter one
certainly looks strange, as

	git log --no-merges Documentation/git-column.txt

makes it clear that I have nothing to do with it ;-).  Perhaps the
tool gives too much credit for Signed-off-by: footer, or something.
