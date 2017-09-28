Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6581320A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdI1W2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:28:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35159 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdI1W2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:28:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id n64so3386200wrb.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q8QfsWrhcx8gKC/P4pMu26Y1z5l4a56Ka32YrTQfHNc=;
        b=SIDATDwjtUW5mRqVudeyfXHALjcci/WP5ibZmEjZRMSI851l00hwdxYCxLWVCpzXcR
         u1F7xZcC34AkmcHLMuaMXeJka1glhi/DqBx7g1644o+epjaZueE+VpX5lOysrMxHvjjX
         DZZSbrpu4RS5L0iYRYjIvYYsKSjp/qrBYvySyriaDpfUSibGIZX9XdCihgvTLZ/QKtXA
         k10LKjWrOUUi9lZ6FZqtZywxMh4baWqwf2lBUWBpXtzxdjb4fI191UUYtoxSk5JieUz/
         pn+MMiTQwjv+oOGUks+R36Z214c+g/L3kUQd2QMql9k1Vu78s/MeBl13GF8OYTsxcopR
         K26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q8QfsWrhcx8gKC/P4pMu26Y1z5l4a56Ka32YrTQfHNc=;
        b=qNgne1+w2c7wSqlTMXU2A8MgSABkoie0ENqF4cu7RNTlJ3OjprqFfQSKgfWztnlYOD
         +HgV806opJnCtaHdvq0pzfMupiDnj42v/H2KhD3VAW9+Ngs78AqDqfuFPGXTe2qQ+SLv
         lzOEzMax8ai2/9fZFoucwtO/bzp9mUEACEvzERgjjKy5fV9Q4nqclIL1aD4l7cnl9xVK
         qJwRgwiix61tqxb+UMdIFxvnznEi5+AduadT97jnRj/L1yk41gWOMTZ5FdyVnwvca7eo
         itR+OCCk6f5Z1XjV7dH/2mcUQnCOMLczDUxZSRLj4O613IyO0+qBKOVZ2g2r1TLO8RHR
         eyPQ==
X-Gm-Message-State: AHPjjUhZvb2k9q6cULnO4rstHKKcW2d1PsfcSo2QeWj5ZKvAH2uvP8LW
        jx9cjkzZyR/b6A4pq1ps/J0CvA==
X-Google-Smtp-Source: AOwi7QC5v6CCbT8lmRfL4a6JiLt9fVvaWnmFWa5rVoe6QwH/lLzX1kvp5Oo+HTQWuID8ka363ClS4Q==
X-Received: by 10.223.134.23 with SMTP id 23mr5751498wrv.93.1506637702977;
        Thu, 28 Sep 2017 15:28:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:1015:7101:55e:6494:f4c9:167b? ([2001:a61:1015:7101:55e:6494:f4c9:167b])
        by smtp.googlemail.com with ESMTPSA id d9sm3928721wrd.37.2017.09.28.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 15:28:22 -0700 (PDT)
Subject: Re: [PATCH] doc: correct command formatting
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
References: <20170928140648.GC9439@dinwoodie.org>
 <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
 <20170928193412.GB174074@aiede.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <0635cfc6-e5ce-c0eb-d0e4-636fb57fbe4f@gmail.com>
Date:   Fri, 29 Sep 2017 00:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170928193412.GB174074@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.09.2017 um 21:34 schrieb Jonathan Nieder:
> Andreas Heiduk wrote:
> 
>> +1, Thanks for spotting.
> 
> Thanks for looking it over.  Can we add your Reviewed-by?  (See [1]
> for what this means.)

Well, I'd like to see the following occurrence of the same problem
solved in that patch, too. Beyond that - your welcome.

>>
>> Documentation/git-format-patch.txt:	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
>>
>> But here the space IS relevant but asciidoc does not pick up
>> the formatting. Perhaps that one could read like this:
>>
>> 	`--subject-prefix` option) has `<SPACE>v<n>` appended to it.  E.g.

...

> In some output formats, the text with backticks surrounding it is
> shown in a different background color, which makes something like
> `{space}v<n>` tempting (with appropriate definition of {space} in
> the attributes section of asciidoc.conf).  But that feels way too
> subtle.
> 
> How about something like
> 
> 	has a space and `v<n>` appended to it

Well, in the original text "<n>" is already used as a replacement
marker. Therefore "<space>" seemed obvious to me as another replacement
marker which avoids exactly that problem.

> 
> ?
> 
> Thanks,
> Jonathan
> 
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/9cd6681cb1169e815c41af0265165dd1b872f228/Documentation/process/submitting-patches.rst#563
> 

