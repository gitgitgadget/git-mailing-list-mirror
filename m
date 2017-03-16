Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08828202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdCPFUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:20:13 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34949 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdCPFUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:20:11 -0400
Received: by mail-qt0-f195.google.com with SMTP id r5so4485245qtb.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSJuWaNUK5PmzBWhm6cbHI8KcRjMAPHkzg9Oyx0/H/k=;
        b=L1ysbLCp+6hif3ejCur9MpLzM4NPGTO4hA9lPpXV/ROKb5ny+nZctwLj+g9Z3opaSa
         8LpfU+KiQvbBTAB6+8MolYt0W9+hVkv7QK5cQNibMRJJ1MlHBRbary+h6nAchmnoPZxb
         usrAgipWZH0JAmUXdNoRDwUXLNHQKPveh2NilZRdnjLLb3WhmZGST5aIveNv7H9hTK2H
         pRdn1LeQyYoUUANaBLCSXB6MdfXA1JLrOiGxbM2HbF6GWDGHeABO79iMlPOZCKWR8dr+
         GJ3PlbO9kjSfHfSEf+5KWswlvkk3H4H+yYNwkwWqKljqn9GNB3VuG/FEvKOUMkdDwTYg
         gr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSJuWaNUK5PmzBWhm6cbHI8KcRjMAPHkzg9Oyx0/H/k=;
        b=GClKYF1ZkZERAe1t4WG1lDnhTabzTL8AtUFybkyk8s2Gj87nMmw0M/LUMsZlfIV2CQ
         XKINvD5+AJQiQaQNZL6fRAuSXmO8VQBfYN37qeUQy0gAczWMJC1EWKMnG83pdbGFHLS9
         3sfouI+046eBjgVRv3Yc9aADSc49zDdVb/QeNqImGpOHOVm66rCG+WqhLEi3X6qgrVQR
         vrHIwQANy8z4HsKAopAWz/Z6400wgIWoHGTMDK7qIgc5ZKXh5k17haCsx26JQSWRr9Rk
         E4voNig4M5rjs9OpiwOP3y2iG3QtACGEoaiBizFutvi2L9kbsPW0DzIitvdYBGWX8FiY
         2IvA==
X-Gm-Message-State: AFeK/H0MvOwSK5cMIyCvUgy+tk14oOJYwGIo9wLq4sPngUjv2ikMQNRRy9bUL2n0WaB3Sg==
X-Received: by 10.237.33.46 with SMTP id 43mr7202997qtc.72.1489641515470;
        Wed, 15 Mar 2017 22:18:35 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id y52sm2913833qty.60.2017.03.15.22.18.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 22:18:35 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [GSoC][PATCH v4 0/4] Moving credential-cache socket to xdg path
Date:   Thu, 16 Mar 2017 01:18:23 -0400
Message-Id: <20170316051827.97198-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170314003246.71586-4-lehmacdj@gmail.com>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I implemented all changes from the previous reviews and also wrote a few
tests.

-Devin

