Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EB01F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDYMcr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:32:47 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:38206 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDYMcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:32:46 -0400
Received: by mail-lf0-f43.google.com with SMTP id z130-v6so25213884lff.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dRJKr23jR1kZjfnBYPt2GHrswC64WHl/FP92leUvzuw=;
        b=mwZj/YKmQKtnmmVKzAnY3M/mBqADRb1e+4/uHN3zysmmRf8QfwMNWqAwvp5b64vmO3
         wsu6SfeXaNqdCuaSDHIaacY8LeeF4whXSsRTT2FPh38wgEvsBS7S7+U+qtlEB8goaKSW
         fD05CT2ulXHXciqJI3IyCO+ObyT6WuYn1B3jSL33bbiMKZr0SUsmVkviQtWjgPmI8NU5
         s+BY/nkJTe3GN1kkKagHDB3rFTUeaPXxx039bFnTJ7q6D51XTRJaXMwDRN1T48pR1LrV
         oqfVwXkPaC4vbeYQInTiIVEeiiFRg7TN9SEdNOWazfewPta8aZAcZpHMOF5ICTrO3nbY
         643g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dRJKr23jR1kZjfnBYPt2GHrswC64WHl/FP92leUvzuw=;
        b=qyYE0gjS/UhAYBXxi56oMfk19x3lJ9okW29Qtul8YxGaJh2rKPCF1oyXZkpjgsBv7U
         UQM8tqqChmPahv1bDj3cez6sJdgflb/n7sPjFHb4aY8V/UVRo4c/FGDXFkAGzFaa8IPI
         d0jxfRoMs3tSByVVdtrljIoAxonRXr794iyMFtb+nzXJvqLUS8X7T2FSt51QM+9mhIyj
         SOb4uS6UZGE0/0HZitgMm94ddHmNCFfdHvXYxOgJ9uFE5HRf8EYnkiOGxbqPYTIoVgw5
         dq997gek5u9OVs+Rs/AlrGt71yzVS/xJIMxuURtX+ekVzLfWgl2fQLUQvxnbiR1hfbo3
         3LYw==
X-Gm-Message-State: ALQs6tCbjYvRNh+yQ8VR7134+tCxckJM6zq7cX/t5DI0uGJXvhmqMm2s
        3cdzwFl0+k0r8RscmdMFvVzPQO1d
X-Google-Smtp-Source: AB8JxZqEhOMGj5l3Q50lP/1GZWnUA8Cc3hSF7+qc+NJMgkg7vCoTPUfAHOjGn+1Er3DKpdaBgdWrjQ==
X-Received: by 10.46.153.153 with SMTP id w25mr4889686lji.34.1524659564717;
        Wed, 25 Apr 2018 05:32:44 -0700 (PDT)
Received: from [192.168.10.169] (c-3bd6225c.08-157-6c756e10.cust.bredbandsbolaget.se. [92.34.214.59])
        by smtp.gmail.com with ESMTPSA id r8sm977188ljc.8.2018.04.25.05.32.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 05:32:44 -0700 (PDT)
To:     git@vger.kernel.org
From:   Abinsium <abinsium@gmail.com>
Subject: `iconv` should have the encoding `ISO646-SE2`
Message-ID: <6e8c0ae9-c699-6f39-014f-2008888722c8@gmail.com>
Date:   Wed, 25 Apr 2018 14:32:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I installed from `Git-2.16.2-64-bit.exe` from git-scm.com. `iconv` is 
included in this package. I think `iconv` should have the encoding 
`ISO646-SE2`. Ubuntu 16.04 has this encoding. I use it to read old 
Swedish text files, which there are a lot of e.g.:
`curl -s https://www.abc.se/programbanken/abc/abc80/asmkod/basicii.txt | 
dos2unix | iconv -f ISO646-SE2 -t UTF8 | less`
`ISO646-SE2` is used by e.g. the retro-computers Luxor 
[ABC80](https://en.wikipedia.org/wiki/ABC_80) (1978) and 
[ABC800](https://en.wikipedia.org/wiki/ABC_800)-series (1981). At my 
university we only have Git Bash and not Ubuntu for WSL in Windows 10 
computers.

(Not clear where I should report this, but one should be able to report 
issues with the configuration of the other programs than `git` in the 
package somewhere. If there is a better place, please let me know.)
Originally reported at https://github.com/git/git-scm.com/issues/1199
