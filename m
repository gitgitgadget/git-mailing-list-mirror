Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A8E1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 08:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbcF2IND (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 04:13:03 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33412 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbcF2IM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 04:12:58 -0400
Received: by mail-pa0-f48.google.com with SMTP id b13so15172963pat.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 01:12:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=3EVsVzCIdzI2c4WSiFnryNemU6saQuZwSqrl2CDzmSc=;
        b=enD4eSPpZhGwpIN1SxOb8RfjVqCbQiJwxGx3lTRC18xuIum7SkRGrl6RmkOFPpMmwr
         Hsw4q67xxL/Wd4ZBvO7f/zIrshlOCPXoQDkQgcJIq6uk99vdJ4Y4x6qveM39TxF7Y4fR
         4DlG40p0MIQe+ip9C/MIaJgU0w4+FqEBnHAUE1/tnTPBj8nABMelEeR6bBumC/i1MMMw
         rdEY4nYhDtRIxrN54cLF8wXvLNe4F1jptWo31EG0uQ833MzDnMG8meu10FoDZ3GYlZht
         kHqkaiKe+DJOLwjdl7rQSel86fDDpIsV1CFTbgHka197ekocWBgISeXiDSeTyU7534lA
         MvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=3EVsVzCIdzI2c4WSiFnryNemU6saQuZwSqrl2CDzmSc=;
        b=T92dICqTDoU7zHZNnnhsMdKYzeA5UC5lm+dkcXDssbiDgGAQ9EfbkjjihRJVrP98Mk
         WEFq9QMQkuQD3qk4BVqLxQ9kbCPHhpUrztkE6dzkNOBtz2hMANZZpUIqVl1LaVDuP+jp
         E2Zq5fgkXlWRjwNlagRtIBEkEPaiR6Eg0lHy7E0ghFRB3ai9+glSWaJKy1gbSfZYca/W
         T1huFTuTUUpAr5FjKSN6zl/rw+9Km9M68VbFzICPihX7P3IG5V91DTM141fMT1krV+Ak
         rA/xyJrYunI+oVjD53yKYj6LlpvJH9ehjfDpl1wKxRzOr5Jrdwd+sj2YlBzvLXd78ceC
         V0+A==
X-Gm-Message-State: ALyK8tKyh+OhayUBta81nj3AN9daPTV7fFCorShuhgNo3GhtWN2kUIywSFrTDsbVl+NXFw==
X-Received: by 10.66.49.134 with SMTP id u6mr9428197pan.118.1467187977885;
        Wed, 29 Jun 2016 01:12:57 -0700 (PDT)
Received: from [192.168.2.11] ([223.207.72.228])
        by smtp.googlemail.com with ESMTPSA id 144sm3548383pfu.83.2016.06.29.01.12.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 01:12:57 -0700 (PDT)
To:	git@vger.kernel.org
From:	Andrei Faber <andrei.faber@gmail.com>
Subject: git gui produces series of commits with exactly the same time
Message-ID: <37a71a23-ded6-9d48-a873-a05f33e802bd@gmail.com>
Date:	Wed, 29 Jun 2016 15:12:54 +0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi everyone,

I've noticed that git history contains series of commits with exactly 
the same time, despite the real commit time of these commits was 
different. All these commit were made using the git gui tool. I'm the 
only developer in this project.

Has anyone experienced the same problem?

(I'm currently using Git 2.9.0 x64 under Windows.)


-- 
Best wishes,
Andrei Faber

