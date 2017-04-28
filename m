Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7ED207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 05:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163633AbdD1FN4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 01:13:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33825 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163614AbdD1FN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 01:13:56 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so9110173pgv.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 22:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=1aNQW5aAl7PFiMVdPUyjeWhDemwEMP6HK1/+Y2a6/Fk=;
        b=P4ht0r+OPAvT33+dXONXbMlBXfmKROFt3v9dz+GGaCOnYwOA9Euj2OPEjFZ/7kKUBR
         +/hfTC5m4oAFYXXwGLjMOT+bvMaQzc8YAczh5D5tsm20IgSr9LzRKOdNL8QjR+2DqgSM
         ta5xBuhFHOFVYlb5JVrcNVsUXHsphTeDLu5tbNy1+WsS35DNIxXJnnhasqHMzgdaEfPa
         vN4q9gMHAZMPzq+IespNcV1AO7KNTfNnK82n5GHYugjcy+Dcl4jyESHrwjUUK7P1FEcF
         pua9LMf+IXWtZcgoUWUDQouwhE+OkrQ2bI3hi1IWz4xXfpRiBLCIcI4b/HaONdhEuS3G
         9hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=1aNQW5aAl7PFiMVdPUyjeWhDemwEMP6HK1/+Y2a6/Fk=;
        b=TlGKRjUwybh4dbViI3Wj5lk1DTzR/T2EYe6lq+T4c6GVE8lK4oa6jrzV/gfRgyw97/
         EFaJXrzedIYXqJp5M65CD/9YoXmpupcsvKRSxW1oD8iG0PinIXonfAu3jhINBvEBw6/L
         zKxZGaBedJJR8+KZhbFSrz+VclONuykAhfqBhmrx6j+JoZwNR7SB38uXd8E00WdpnxI6
         zxDDcC1ers5ElgQe2S3V7pF9c02ypLwk/yRoIFikk1tY9qTKsCDXVkIAgcFe71JFKG+K
         zMBBM8PpF0RC0hdmEgUYRet+RbqGEHvogzMbig2N69YlsJt9A3UuayMnTj3kjjgY1B/h
         ydzg==
X-Gm-Message-State: AN3rC/6MTfbVdltG92STljeju4dK/ZXoXXGO0SaqlfqR6vE+4SdaX7nH
        gv0EUcnjJZ2AryagQSg=
X-Received: by 10.99.44.82 with SMTP id s79mr9938224pgs.219.1493356435192;
        Thu, 27 Apr 2017 22:13:55 -0700 (PDT)
Received: from ?IPv6:2405:205:820a:8c42:300f:745a:edbf:912a? ([2405:205:820a:8c42:300f:745a:edbf:912a])
        by smtp.gmail.com with ESMTPSA id q1sm7513297pfl.89.2017.04.27.22.13.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Apr 2017 22:13:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [Suggestion] Alternative way for displaying help menu of patch flow
Message-ID: <b55bd985-be6a-7fd6-1744-7ffb9d8b4ce8@gmail.com>
Date:   Fri, 28 Apr 2017 10:44:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello community,

I would like to state about a small issue I face when I use the `git add 
-i` command. I guess it's expressed easily with an example.

**** Start ****

Imagine a situation in which you accidentally made a reasonable amount 
of change to your code from your last commit. You would like to put them 
in separate commits and hence you go for the `git add -i` command and 
choose the `patch` option. You choose the file which you want to update 
as patches.

Unfortunately a hunk (of reasonable size) in the file seems to be having 
changes that you would like to be in separate commits. So, you would 
like to split the hunk into smaller parts but you forgot the correct 
option for it and you use `?` option. In most cases you wouldn't see the 
help menu completely. Moreover, if the hunk's size is reasonable enough 
to take up the whole screen of the terminal you would be seeing the same 
screen as before as the help menu is hidden above the hunk and you need 
to scroll to see it (only if you knew it's up there in the first place!)

**** End ****

I guess it would be better to display the help menu in a separate flow, 
like when the user click the `?` option in the `patch` flow then the 
whole screen is cleared and the help menu is displayed in some 
appropriate place and after the user has viewed the help menu he could 
quit from the help screen (probably by using a key like `q`) to continue 
where he left off. I think it would be better because, in general, a 
user would want to see the help menu when he uses the `?` option in the 
patch flow, not the hunk that gets displayed after it.

Is it a good suggestion or is there anything I missed?

Quote : "You don’t change the world by doing what you’re told.” — Joi Ito

Regards,
Kaartic

