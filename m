Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A380620951
	for <e@80x24.org>; Wed, 15 Mar 2017 04:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdCOEvy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 00:51:54 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33221 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdCOEvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 00:51:53 -0400
Received: by mail-vk0-f48.google.com with SMTP id d188so3051818vka.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RcYH8q3W3YCpBcOgYTyZJbx4fEU17yXUa4eXy7oUeR8=;
        b=UoX/md7K9q7+Iwac1Q/UQkKjRIqes+uTqPC9Dkkq/PYJA2eRNZrVLZjD3yDp1wtN/v
         iu2++eIbmxOZ7F34jgkeosmA9N4engHvCBCkmOT0rFqJ8JkKfIpDfav3ms53RXLbWNtV
         uMUOEDPb5/ACjl8WfX8Hyyy5kj019yunOizgOp0+qrOCPW/psgnKyOW7prIKZt3SnbHk
         W0IWH8nxfgjGT0B2+79EQnZ4uNMImIIqxNy39csideaqoT1NwxhTU5og3yX1jNyAtXin
         P8129891BgAppdRhhgF+hbZWSxpgd5ZJjPHp1PTAJqNg5PcMp+aMM0eCIXJC01HbqjkP
         YUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RcYH8q3W3YCpBcOgYTyZJbx4fEU17yXUa4eXy7oUeR8=;
        b=DH5voLV03LvgRnkCmy6PDdGHCmBa0f8F3dGVSD4twBO9lak/fpUqNwEEp7veWVXPdM
         YMeImPs01S86zlYVFicpt2iQHr8aR1D9OHrwA34DdYHC02c55LT6v2sw+0bM66WM+Awt
         dMn7owQIpNt3ABnR6n9MVm0GVIcw/I3Hj5JHB/29ke0AKVWOfGmZ299edldCLvHrOyy3
         ii7Fqhk9iRVfpB/Kp8P7HDD+uBecdKhCPqbxnXKLJCYlNyNgawkAG9lJfyvTgQASOc4d
         6nV7CzysL67R6d4R/DLCk0wMd1iT871GZCN5RXimqgTuvF6AGg6nQ2YSLnJ/FPqN7Wyo
         YfXA==
X-Gm-Message-State: AFeK/H2kR9UFGlKiSIGESeJ7DBWRmYV5iUhqhIZt7lZuD7/fx4L9VMI9Zn6o8AdkFyt2mHpZeQvbJH7KHGxGPg==
X-Received: by 10.31.106.198 with SMTP id f189mr369923vkc.149.1489553512376;
 Tue, 14 Mar 2017 21:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.8.135 with HTTP; Tue, 14 Mar 2017 21:51:12 -0700 (PDT)
From:   =?UTF-8?B?RMWpbmcgxJDhurduZyBNaW5o?= <dungdm93@gmail.com>
Date:   Wed, 15 Mar 2017 11:51:12 +0700
Message-ID: <CACHUE0-MyuL+8wvt1BeKMtxNUdg7AK0bDAg4BSeoj5aHjLARMQ@mail.gmail.com>
Subject: [Bug] Unicode display
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git team,

Thank you all for create a great tool.
Last week, I updated the last version of git (2.12.0 x64-Windows) and
all Unicode characters are display un-correctly. You can see:
http://imgur.com/a/eriKQ

-- 
Dzung Dang Minh - Software Engineer
Email: dungdm93@gmail.com
Phone: (+84) 94.505.1024
Skype: dungdm93
