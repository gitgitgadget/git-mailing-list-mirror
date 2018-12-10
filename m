Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D7820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeLJMkw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 07:40:52 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55839 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeLJMkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 07:40:52 -0500
Received: by mail-wm1-f45.google.com with SMTP id y139so10710682wmc.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pP2J0SGneSe8AAKeQJpjkW39jC2WlcBaJ48o6i4M0l4=;
        b=WPfWDlf4YXitC1nZppLPTwyik51RvZn+slVH04L5iQqOCKXGrDnP5Q4ll0BtFABjLV
         tiJ/mEzP+zlqjmcVepBvHBbH3lTVfcXdZbawdnkyjl8/nZHnoxHzQ0mVVjjhwzBpK89k
         mKVA8FaMUj1c8Y026tr1XacDS4ELCHPqWSugp2HWaV+ZEkr/01z/LtEg4ZMpHy3XpcIX
         tnW/E8dXbzCu8oYinfJA60IVE1D+DxrVky4tmZE1eWlzilAQcVwYVosqYDj0q+aMnXtR
         cZNUcyQZ2ksO7bx9pmt13PuRr3+FA5Si29RJK6a74egs3cp2vJp62MV6hT+BVfa+oPf0
         BGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pP2J0SGneSe8AAKeQJpjkW39jC2WlcBaJ48o6i4M0l4=;
        b=ryUi27ICju4BL9X6kTkkbJWIhmYps+wgwQWu0fPVtYjXC5KBiPl3jdalyqU9DN5/H5
         NexDq/on1Jg0xYc4lpoLN7TO1++VlFMjCKbaRG10tNmHViKHjCSaQB92zcP8+V6vnGNx
         14MQ1gvwCDqj2+o9sfuguoZcKb8mR1DHNBA7O3Tk9KGWnL+bX6jiuKoirmz5KXU5Qgol
         VoX4r8K4jSvK1QMt+fm/eO8XZZExDuPI8Z6QHgOrsi9aD5kFahAoVM4xEzk3wC7kXYMs
         ozosgMoS82pzBHxcm9iWQxoImSJeOEwbPWdn+88JRGzkJHs9qhASHK4wkfS30FG1Zf9m
         7EiQ==
X-Gm-Message-State: AA+aEWbUdTNbs8fMns1Laao/uX0TINcVfxG0EUA/J7ykZASWcNIlEKBa
        kNROrVPkaTVNbVKfr4IG4VAULdpB
X-Google-Smtp-Source: AFSGD/XDTp+G7HyH0VUJQJ1RNAkhlVJVy4hqWk+eMbZCP69bngZ6tOEoZxEfijzU6I2UP7i6/anG9w==
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr10137000wmh.124.1544445650219;
        Mon, 10 Dec 2018 04:40:50 -0800 (PST)
Received: from [192.168.1.7] ([31.223.156.164])
        by smtp.gmail.com with ESMTPSA id e17sm11476133wrs.79.2018.12.10.04.40.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:40:49 -0800 (PST)
To:     git <git@vger.kernel.org>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: [Outreachy] My blog
Message-ID: <9771c0f1-4a46-7a1a-ea88-5efe1f3d9dde@gmail.com>
Date:   Mon, 10 Dec 2018 13:40:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I am one of the new Outreachy participants for Git.
I'll be working on project "Turn git add -i into built-in", with 
Johannes Schindelin as mentor.
You can read my blog here: https://slavicadj.github.io/blog/.
There will be new posts every one or two weeks about my experience as 
intern.

-Slavica Djukic

