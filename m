Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF131FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 13:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761221AbcLRN0Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 08:26:25 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33364 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760842AbcLRN0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 08:26:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so3608377pgn.0
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 05:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qS4qlUXsK4LEzrA+aOUsKQH/w5yPzWOokOv6nCZ9TeE=;
        b=fQCFUTRYHDCDYfdEDmFQEZF9lCs6rNTIu8Rw0VO+qRMU8VY1Dvxij19PCBfEtkxvJd
         mnUKxBT8cjWA8gpHZaUN0IlvqKw84OQnQ75imk4TDtEt6IxZMWyoH+7WZLF0WRz+andH
         e3Yg1Ry2M659QjbFe7On65IPJ/7Zm76hB1Si6gViz4fqHIkZgbJXOHjIQrtSa0ChOzJL
         kAVY6qq4HWlro0kVlmAUF5eRsneK83YQAd9VrMvwNi4YlY6VshVU5i8gdj7VUwCPwbdW
         BVgu0gTGYxJz8jPjqwr+D/rXU4OJUDEz3RTs1GZuxNn0xXVEM+cR4/pMHPCwA3q3TjGj
         AbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS4qlUXsK4LEzrA+aOUsKQH/w5yPzWOokOv6nCZ9TeE=;
        b=VaktrMjirscuDL+q+UUypgWrbYHVSLBmugsA0mmxq9zg1s2H7xbkIY2lYOjbO5jP1O
         LALiYJ8VZiaZBap5H5axDzxfNr0FWEkxuIvp1ElQ8A+wgsMBYRbmcvEFNI828eBieNZX
         yOzTluVgzJlxYAhp8ScGg1eC9KKtkybeK+mq2CY7JaicHX29FsPtpwqCrSZGsHJjTRHg
         0UbWSlWDsL/Ndi2iqVR7n/yI/+jPShjrvZPpqqcRm5UKfKV9vd8b2oPgUT7ZbVUbWxoV
         QvaP8xJB+hyGvUS2aYr6jDOohXSvwBMV+BiL5bm8pED85IsOv0nhyz5xdMxhwQMvb00N
         uhhA==
X-Gm-Message-State: AIkVDXLeMV+abYWa+hdx11OQ0uNvcuPn3Rrf4W1BWaVF0KoucUdUHWhMh5Edai1FPSU+yA==
X-Received: by 10.99.126.68 with SMTP id o4mr4156978pgn.66.1482067584057;
        Sun, 18 Dec 2016 05:26:24 -0800 (PST)
Received: from unique-pc ([14.102.13.66])
        by smtp.googlemail.com with ESMTPSA id x4sm24646266pgc.14.2016.12.18.05.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 05:26:23 -0800 (PST)
Message-ID: <1482067588.13943.4.camel@gmail.com>
Subject: Re: Suggestion for the "Did you mean this?" feature
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Date:   Sun, 18 Dec 2016 18:56:28 +0530
In-Reply-To: <5e1a3c4b-43b9-29f2-68fe-8149d9940123@gmx.net>
References: <1482063500.10858.1.camel@gmail.com>
         <5e1a3c4b-43b9-29f2-68fe-8149d9940123@gmx.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-12-18 at 14:16 +0100, Stephan Beyer wrote:

> I cannot tell if this is a good idea (or why it would be a bad idea)
> but
> why do you restrict your suggestion to the case when there is only
> one
> alternative?
> 
> Why not also something like:
> 
> ---
> $ git sta
> git: 'sta' is not a git command. See 'git --help'.
> 
> Did you mean one of these?
> 	[1] status
> 	[2] stage
> 	[3] stash
> You can choose or quit [1,2,3,q]:

That would be fine too. Just thought it would be a good start to start
with a simple case. Also, I wasn't sure if there were any drawback's
that I was missing. I guess if it was implemented it wouldn't be
difficult to extend it further.

-- 


Regards,
Kaartic
