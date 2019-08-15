Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51F01F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 08:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfHOIfb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 04:35:31 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38664 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbfHOIfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 04:35:30 -0400
Received: by mail-wm1-f47.google.com with SMTP id m125so628332wmm.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=xU8UUH6csghw/LcN/rPf1NN7UofBDpD9KEXqOgBoFpA=;
        b=CFerehvEXHrSMN/sgQWegaD39MALxvASfM2kG0ci9gGR+FXCZRzswV5XMtEpjOyS/r
         AWdOKWJUZT+s4kENtjlkbkc/P522Wc8I74R6RYlmqwz7k9naXJNBEsxuqDfdJSSkIcoZ
         x5xh2GMQknWJ3Hu85GJBEwxtoQoHnJeF5q8jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=xU8UUH6csghw/LcN/rPf1NN7UofBDpD9KEXqOgBoFpA=;
        b=C1wP2bTNWwLfB9pyXHzTmfpuzDVAH+MeGlNhKoEzN8v0uMmK7eJ3CdAXF+Htzaz0j2
         fzN6zRCmItoxieHw2I/lX8Dsygom4HL9rbMzlgwCXw67r5hS15eYCZwyGrk1TE6/hD3b
         VZWoU+pySovMevWQTtSt0YT/ucu3bIaI+JbdUh1r8LIgCJU5X8qrtg76eUEqABMaqM/j
         EaDFdmxHxYsBX0Se55KJRqAXebwTlC9jPFVEDfe0JBrLuLRqXI2yWeZjqFEFBWacrOLj
         hruTok8jLbd4tSoWxiV3zYZwbt1H5hdRZJB8UtzdCAXlMUptUNbb+J3Z88HNPAz6K9z9
         Ai8g==
X-Gm-Message-State: APjAAAWIkBqj91PwZSeMIHHu57maOd3+ashKNgjuO3SKjq4eBbqmwAGx
        DZxvEt42jEpkEty5njRV2M6jD4aHswE=
X-Google-Smtp-Source: APXvYqyClCBCvgf8+Coy9vN/HdXLIcijSurZjWF/QE2KsMnvROEkEMKUiFlmJUWbxZDS7vWl3wZfgQ==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr1505781wmb.160.1565858128704;
        Thu, 15 Aug 2019 01:35:28 -0700 (PDT)
Received: from Utnapischtim (p2003000611CFBC6551F5AE86918AE2A1.dip0.t-ipconnect.de. [2003:6:11cf:bc65:51f5:ae86:918a:e2a1])
        by smtp.gmail.com with ESMTPSA id z6sm6500449wre.76.2019.08.15.01.35.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 01:35:28 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     git@vger.kernel.org
Subject: git log --graph with a sort of local revision number
Date:   Thu, 15 Aug 2019 10:35:26 +0200
Message-ID: <87blwq7rn5.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Hi

I am an occasionally git user and am very used to local revision numbers
mercurial provides in its log command. I don't want to start the
discussion whether  local revision numbers are useful or not, nor
whether mercurial is better or not.

I only want to know whether there is any possibility to have this number
in the log.

I have seen 

https://stackoverflow.com/questions/4120001/what-is-the-git-equivalent-for-revision-number

That 
git rev-list --count HEAD

But I would like to have it in the 

 git log --graph --decorate

So something like this 

o  changeset:   5:d3ae13222c31
|  tag:         tip
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Wed Aug 14 14:23:29 2019 +0200
|  summary:     Six
|
o  changeset:   4:64a3eee07e93
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Wed Aug 14 14:23:28 2019 +0200
|  summary:     Fifth


Anybody know who to achieve it?

I presume 

 git checkout revnumber

Would not work?

I know that 

 git checkout HEAD~somenumber

Works

Uwe Brauer 
