Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6522082D
	for <e@80x24.org>; Thu,  7 Sep 2017 07:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbdIGHTM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 03:19:12 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35238 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754422AbdIGHTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 03:19:11 -0400
Received: by mail-wr0-f172.google.com with SMTP id m18so853552wrm.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=39fTRJTWZ7V655rYb0k/k26M57g7v+ffF83ZZyQtnXA=;
        b=nxoa2cOWQ7Q4WdTXlt8AuS68rTMBTktmeH+j003dNe8wuutC4rOal5hb71P/nrEaCp
         OjvwYLEpeuDhNHzbbUmEZyAKUBYzUfFo1Y46O4w+mn85M916Rxt19hFi4cTlEM2cRGwf
         p9qjVNDKPIEnJh8YSnjDpviDR8nZ2CdOs4WdCKmv+8zIm4tpDLP5cV3BxtrpYgSeUprM
         8otSy9ybWAykclS73JHEbDrUTyZWF6GeNPgsVmqBLcET/M0Eva4HLXgQ0G2jU85XT3fu
         UkAxgLTtM36cVCFfjv9qx8Fuh/c9xA50aWPic36ubeSLYmKQvF6bRR6bK7sXAdi8MCqg
         +N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=39fTRJTWZ7V655rYb0k/k26M57g7v+ffF83ZZyQtnXA=;
        b=MHDG966ssyzPvoJrIGTr7JKJa0GDHvEXOj4gZlJteQxbbHnQQCgxtkDF3HLf2COAvZ
         dPAz3AOenIBj3fU83HF+gvZKyCTaOiVw+tTFJ3xPouShhn082WO2RxZ3l2RjbVtFQNEr
         nwCy+aeZ7k66NWFKF8dyjtHWwWYUsj1z0I8J+GkzG34m2xEX5XpyX8Wgd6HBxaNCcztO
         j71PdD6xNUjDa4ZpOFJ/xSHl5Ctace14p4A8evygYAKM73AeT8WMEeae89aXYcyVMD0c
         gOrcX5MOIaWpAUhOypGbH4BDTHsUWgzJ156Ab8rRTu21NUWO2Cw+dcqMbRH4LylYkz3T
         pxmw==
X-Gm-Message-State: AHPjjUhz1S1+RM+3ca71yd0kcwblsxl9VfKxcuFALB7Y8czbFyJFRgL2
        p80erbE624f5hvym
X-Google-Smtp-Source: ADKCNb7tG15UEvdPebccKApt4JxGaIuIcdBs+Ly4TgvwJOxu9D3wwYiZPrOe7wBIg3SAfr/Kth+Krw==
X-Received: by 10.223.157.3 with SMTP id k3mr1069760wre.122.1504768745208;
        Thu, 07 Sep 2017 00:19:05 -0700 (PDT)
Received: from [192.168.1.106] ([81.184.5.176])
        by smtp.googlemail.com with ESMTPSA id q6sm1187641wrc.14.2017.09.07.00.19.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2017 00:19:03 -0700 (PDT)
From:   Norike <norike@gmail.com>
Subject: How to include references to subfolders
Reply-To: norike@gmail.com
To:     git@vger.kernel.org
Message-ID: <d15333d0-d9eb-a106-592b-47635fd1cb66@gmail.com>
Date:   Thu, 7 Sep 2017 09:19:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've been searching what's the best way to include a reference to a 
subfolder/subdirectory from a (secondary) remote repo into a subfolder 
of my (primary) repo.

Here I found some approaches:
https://stackoverflow.com/a/30386041/509369

Where the first 3 options don't seem to support sending changes back to 
the mainstream; and the 4rth is replicating the whole repo.

Ideally:
- The reference is stored somewhere in the (primary) repo so when 
someone clones it, the referenced folder (from the secondary repo) is 
also cloned.
- You can pull changes from the remote repo into the subfolder of your repo.
- You can make changes to the subfolder directly from your (primary) 
repo, and push them to the remote repo (of course depending on the 
privileges of the remote repo).
- Allow multiple remote subfolders.

Extra: it could be more complex, but what about single remote files?

I'm not sure if this is possible with the current set of git tools, if 
it can be added in a future or if it's just a no-sense question.

Thanks in advance!

-- 
Salut,
Yeray

