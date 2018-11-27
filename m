Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AB91F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeK1Duy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:50:54 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:32865 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK1Dux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:50:53 -0500
Received: by mail-wr1-f54.google.com with SMTP id c14so17798210wrr.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Roz0CJH/1elmlo1Qdlks+rlehkj29qSpt3zmTUD+SGk=;
        b=AzdczMoi60rgW0HGNYQbQ4BEJCyEjwP1Nko0ZlxnZlIw+WvOxO+nHVIoe7XR+SrE+s
         KmTKh17MjHig54hHT/8YqYseJIJfiIhqgTwdSW4hToZuIwBPSW/CJFy692ZS2e2wcq+Y
         JiTbge6FJ6BxHT/E0zL/zJAEA3rR7AKVheHCEz7AcNagRNWlCRFILq4ABb0qOiw/57VK
         5emAUNK11Hlti1kW1lfEGtiiLHN6QVNjXvjXIAgtXQNqec3t320FgYy23+tJ0EKIApOm
         T8F1c5bWmmQ9TMOyr78mjsVgFFojdln3MDKnCIFlv+EcB79jNzqt2mMxCTkUXb/bFznN
         Mp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Roz0CJH/1elmlo1Qdlks+rlehkj29qSpt3zmTUD+SGk=;
        b=cdNm1iHFlvx23yH81Ku6WbGdqXOp7yQP++or3ihOodzaUKLbw26gtao8g2mo46FdY2
         MpqNRdXuNLnzn6UcwhcgBBEjclQZpxCbeOhg41uN2RGEM7JQosEbrDvnpvsBqvLZJOvy
         4sbgat9AIxzX5WjoGguXSIXmMGnioZuP0DPUSfpRpOhB4fa+sVaTAA37rf0AgF64lHIJ
         8/ngqMc3PcpFIQSqUR0tsW0mTmDrpD/EclDIOFSWxupgtXm0do17EQjhuzmTzkmzIY2p
         Ocnm5FNXOOAER2Y+GdY4oyBuCQwWHyvVIAESNLK7ZLaTcTlhPX+MEIu525sED+HJdXN4
         CgCw==
X-Gm-Message-State: AA+aEWacysCYlOkNIS5quoh/wFfEUAjoZspDw7q/zp+2mi9+NP3MIEPo
        K1fdaXivcwRzCzdhcaGBQer9ja20JbY=
X-Google-Smtp-Source: AFSGD/W2p2xvzQWRxz8InWqr3ybqxbQykeJE59h5sPIWd3fvKKQFHUO3o0nBWC/BsHJUvCVeNyZ+QQ==
X-Received: by 2002:adf:8506:: with SMTP id 6mr7468584wrh.128.1543337542078;
        Tue, 27 Nov 2018 08:52:22 -0800 (PST)
Received: from [172.25.5.67] (sharedmail10.essensys.co.uk. [151.237.232.131])
        by smtp.gmail.com with ESMTPSA id y19sm3265886wmj.2.2018.11.27.08.52.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:52:21 -0800 (PST)
From:   Will <william.duclot@gmail.com>
To:     "Git List" <git@vger.kernel.org>
Subject: Git pull confusing output
Date:   Tue, 27 Nov 2018 16:52:09 +0000
X-Mailer: MailMate Trial (1.12.1r5552)
Message-ID: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I’m far from being a guru, but I consider myself a competent Git user. 
Yet, here’s my understanding of the output of one the most-used 
commands, `git push`:
> Counting objects: 6, done.
No idea what an “object” is. Apparently there’s 6 of them here. 
What does “counting” them means? Should I care?
> Delta compression using up to 4 threads.
No idea what is “delta compression”, I suppose something is being 
compressed. It’s using anything between 1 and 4 threads, which is not 
a very precise or useful information. Should I care?
> Compressing objects: 100% (6/6), done.
I still don’t know what objects are, but I appreciate having feedback 
on progress
> Writing objects: 100% (6/6), 656 bytes | 656.00 KiB/s, done.
Writing what, where? Should I care? Still good to have feedback
> Total 6 (delta 4), reused 0 (delta 0)
No idea what any of those numbers mean. Should I care?
> remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
I do know what’s a remote, but I don’t know what “resolving 
deltas” means. There’s local objects now? I don’t understand what 
happened to those local objects, are they the byproduct of the delta 
resolving or the input or something else? Should I care?
> To github.com:williamdclt/some-repo.git
Fair enough
> 1ca9aaa..4320d30  master -> master
Fair enough


All in all, I didn’t understand most of what I’ve been told, and 
don’t seem to care about it. Don’t take my sassiness for disrespect, 
I really appreciate (and am impressed by) everything that happens here, 
but I feel like a less confusing UI is such a low-hanging fruit. How 
many devs understand what all of this means, 1%-2% if even that? And 
even them, do they need this info every time they push?

I feel like a less intimidating output would help, while showing info 
about objects and deltas with the verbose flag:
> Compressing… done
> Pushing to github.com:williamdclt/some-repo.git… done
> 1ca9aaa..4320d30  master -> master


I’d be more than happy to work on this (`git push` is an example 
amongst so many other), but want the mailing list’s opinion on it. Am 
I wrong in thinking that this output is not something users want, am I 
fighting windmills or maybe just being ignorant?
