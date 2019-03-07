Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4809F20248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfCGAiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:38:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43830 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCGAiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:38:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so15433603wre.10
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1NYnLxVnk7XgKYyNczkCdhxOEir8KfiY1idnDcDGqkU=;
        b=hjs/gM9aEVCZU1lQkF+Y/JCKj87ay3IDlXPfAE1Rw+jakdBlP5hdN53w6PActjnzxl
         sBwLj1Z2vukvpekE7tJEIaMbjiYqYZ+xqWEu4sk4mdEE5/ht2O7kwUQxgLL3RA/J7hCm
         BbBPrAFNlcsm9eiffLhXLO2CpLOBBtOMZWCZ8ImTY44gjqnvXpMRBA3HzM0TjIXvjwTp
         3nTmJlP0W5xlKuEzh+RKOaLVIm33XDwBXb2vNLW8ocNA57nW8SfHjiFMvgRPoqlJekHF
         HwED2milS9M7tKXYv8GICJctiRBBGaP/C4oeSzDuxNFzd4MOU9trdl4D620b06lu+t9u
         wn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1NYnLxVnk7XgKYyNczkCdhxOEir8KfiY1idnDcDGqkU=;
        b=qt5hswBfTUTGDf4AdRqhBdf9ul9PX+T74QXh6DJE5/3g8U4buM4CiJ0LzWaJfTCL5z
         0MdR4c/tmOqlhrpSvycp7dbMCBEU+b5U6X1fTHpQdJh7ZhZixC2ZX5+ex9vXOsZ4MDd6
         RBR3XvkAko3oxVl/sHw6O2bV7zCku8Z3c29ilXrVQh+KY2j3MZ22qsPO5gvUNgYnMxsN
         4Kr91LGHMrHre6QdHqkMe8e0yBOH+hPCmstoRiDMgbSXTqDLNcc7Tl4PsTeoNx8D1uYt
         jSlF7bGY4Zl0Pn2QT1tXayF3zFVuFOWIAibyA0BnElQgjxcFLSRIe4EAlOOl04up5b57
         6QoQ==
X-Gm-Message-State: APjAAAWA/bRBvyhfYqEwoAeA7NW1wJbwVQciPJqYnLZrQ4PNBqUmsKJ3
        khS/7bELl3gb+/eDKZesixc=
X-Google-Smtp-Source: APXvYqye0ZZTnMlauoJZ3W8gfc4AWqQWVFaeeBsMN8PnrwVcsHQ/nxOq39TwVlG6SnbzyM5RvQW9GA==
X-Received: by 2002:adf:b648:: with SMTP id i8mr4661393wre.319.1551919101364;
        Wed, 06 Mar 2019 16:38:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q135sm5988150wme.43.2019.03.06.16.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:38:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH 1/1] git-clean.txt: specify core.excludesFile variable is used
References: <cover.1551868745.git.liu.denton@gmail.com>
        <f8bc322cc5727d9cf45037f4231f88956f07b7f3.1551868745.git.liu.denton@gmail.com>
        <CAN0heSqTCQaTgWq4+-dxP0DFjtL=syq_W=T0cb66-2YPB4Tc-w@mail.gmail.com>
Date:   Thu, 07 Mar 2019 09:38:20 +0900
In-Reply-To: <CAN0heSqTCQaTgWq4+-dxP0DFjtL=syq_W=T0cb66-2YPB4Tc-w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 6 Mar 2019 21:22:01
 +0100")
Message-ID: <xmqqmum7o6wz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> But on the topic of preferring shorter, I sort of wonder if we really
> need to provide all of those filenames here. The point we're trying to
> make is that we consider another source. So something like this would be
> just as technically correct, I think:
>
>   Use the given exclude pattern in addition to those found in .gitignore
>   and similar files (see linkgit:gitignore[5]).

Yes.  Unless we devise some mechanism to prevent these text that
list the places exclusion list are read from spread across the
documentation set, saying "found in usual places (see $there)" and
making sure we have the authoritative single place up-to-date is a
good approach.
