Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BB41F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbdFEOER (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 10:04:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36630 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdFEOEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 10:04:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so2238544pfd.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=71pXDzF7s6fBL2dP5zyVfyqwtiFzFVHAsvJcQ68aMpw=;
        b=RrsDW9ojjdJ94JTgULXraXkk9XavvmE00GtbFvki59laBHwXhcGzXxAWnYV34YOqhl
         BG5mHOIfzhDhk3nHIszUhGoSYawFoMLeRecn6XvHx531juQi20z6xl8gxDBldhsF9JMx
         4CovgFZ0FO9tEFGdzH6aCEZqZa4U89zq1KG5lThG6R+Wv0+bHfA1fuP3w/yEz4Co0+n8
         6/dbbxc9KhCAatygeEPMmbAkQoTZN12GznoYe45nbb6D3HC2HuUnXo4a6R+mUv4epMXX
         EmIUaKP25CspNCDos9M0UrM0a2/gcQs5qRtfcB2jfQ2UZiiSH9xfLoMNnMp4l7xWtDyQ
         UsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=71pXDzF7s6fBL2dP5zyVfyqwtiFzFVHAsvJcQ68aMpw=;
        b=FxIPhdWlJr/WYXatOCkDKQKf2NSqPt7rVkz0vhOij1kRb+jY7nTSLo/JDk+aW7atfF
         BPZWtned3qR0Ay6hXwogsdUrInRY/1XgE/9R51SPd3PgAzzjU7zVUui90l3tf2yQjksH
         Rnev7+FM/g9asPbf9g4udxDwZlVj4Y8upDpPxMbvISLDu61Ci3bLgmijTS8U7Rr10Yn6
         bxNAWrgWB0cDxBKjdxQ/+eN4oKEKJpRYN3LCQVUVUQlizWzjwPqUiFHe2/HR/KBnuBE9
         Y6ETG/4BRxTYf/f/5qS59ih41KHt03VP8GMAcYaqqv4NHyWsDUlNZkiTAGjS6+bpQDm/
         pSsw==
X-Gm-Message-State: AODbwcCB55kNoviYUrhRke8PnyI1i33zXogw4s+3VHOq9IhmBhIHQTA0
        o8GHB0fuYjWdDKHiIi0=
X-Received: by 10.99.174.5 with SMTP id q5mr21011338pgf.196.1496671455956;
        Mon, 05 Jun 2017 07:04:15 -0700 (PDT)
Received: from unique-pc ([2405:205:8106:9cf5:4eb5:4c3e:aba9:d3f5])
        by smtp.googlemail.com with ESMTPSA id x30sm33172535pge.23.2017.06.05.07.04.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Jun 2017 07:04:15 -0700 (PDT)
Message-ID: <1496671452.4809.2.camel@gmail.com>
Subject: What does this output of git supposed to mean ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 05 Jun 2017 19:34:12 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I noticed a weird output by git when trying to run 'git status' on a
newly initialized git repository. It prints the following,

> On branch master
> 
> Initial commit
> 
> nothing to commit (create/copy files and use "git add" to track)


What's that "Initial commit" supposed to mean?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
