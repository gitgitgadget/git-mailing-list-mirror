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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0826B207FF
	for <e@80x24.org>; Thu,  4 May 2017 22:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbdEDWsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:48:35 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35185 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdEDWse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:48:34 -0400
Received: by mail-qk0-f172.google.com with SMTP id q1so23279245qkd.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=fOJ8mg/1mIWXOu1NxjjEX9j764V9F7VSqj/GEFCU5ag=;
        b=CFwt77kxa1yfUCsfvNPpJjVlSnKpkovdH7zTnugpHemHJHH9kAY4QiiiX46biyWZhx
         Rog/TQPhx6qyT6ns2dKmM6LGZahAB+EhYNE8b4j6byRfErW5JpC5DrS4/nbGxezU3Bpy
         jOmkoLvvHyaiaN2SqpO2up5KUOeN6LVYWGrhvzkJVr9U+k7D/mF3nul6C7MrSFblKQUU
         sPlV0dwLkrr/hEn3u5pvmjpbpmVV2+wkwNoMq2hRV8Wf39/qUbVQefiGiTVn+UiylHwi
         u6ACH9ZqneWYZ5fAY/MZezvOtTT04WcYQjXWzL+Uk/AM8Mi8SL7jclYgkwB22Uz8Be75
         DpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=fOJ8mg/1mIWXOu1NxjjEX9j764V9F7VSqj/GEFCU5ag=;
        b=QcSzpSPUO7IVslbyq70w+Bpb/RY+IPIIuiTZbPJzObHE60X7R0L6Q8onJy21fXSOdG
         V1P09GmuRYYvzUvMI8bsKA2LBap/9WhFGiCAyyY3RGonk1+7cuYw1d/EfnS3kI05+dez
         dAPp97t4waqk8eoi5czWYUjqK1uYmY7Krtx218DBRhgBoEN2Q+/NIRGrkCENgo7ADaLz
         hdv9DNVWZqgOnNjK5MH+LIth+85yYWeJzMh0M+pRMxZpA1OB+/Fwy2O4P0iCtjICMbd0
         IwNZWhmTBK0B/pYU5SpiZc/qK1cr751F+6mgYAqo3CcLzsdyXF3bO/DuIIzREMddwr4h
         HEkQ==
X-Gm-Message-State: AN3rC/4PMwN0UkKbu3vJQU51ro5k82EhmIQmcgCpo7kcJMN4lEdRYkS6
        kQM4iYC5hNUXQJV1
X-Received: by 10.55.119.5 with SMTP id s5mr10222210qkc.32.1493938113627;
        Thu, 04 May 2017 15:48:33 -0700 (PDT)
Received: from [192.168.0.90] ([187.104.145.234])
        by smtp.googlemail.com with ESMTPSA id r19sm2092154qkl.54.2017.05.04.15.48.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:48:33 -0700 (PDT)
To:     git@vger.kernel.org
From:   "Soni L." <fakedme+git@gmail.com>
Subject: Delta compression hooks
Message-ID: <b8f1dab4-896f-c9ad-7a89-87aacb2c3e61@gmail.com>
Date:   Thu, 4 May 2017 19:48:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can we get delta compression hooks? I'm working with voxel data as my 
source code (it's a long story...) and git doesn't handle changing lines 
of voxels very well.

Example, I have something from position (0,0,0) to position (0,10,0) and 
I replace it with something else. Git doesn't handle this difference 
very well if the file is encoded in XYZ order (it'd handle it 
exceptionally well if the file was in YXZ or YZX order), and Z-order 
curves aren't much better. It's even worse if the file is compressed.

The hooks/plugins would be required on the sending end and on the 
receiving end, but bare repos wouldn't need to know about them (github 
could show "unknown diff" or something). This is good because such 
plugins would effectively be machine code, so you don't want bare repos 
running them.

Other source-y things that would benefit from this:

- 2D image source code http://esolangs.org/wiki/Piet
- photoshop files
- database files (well uh, I guess this is more "data" than "source"... 
I'm sure someone out there is storing source code in a database, tho)
