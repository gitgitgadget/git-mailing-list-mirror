Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09F31FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbdFJRY4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 13:24:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35757 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdFJRYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 13:24:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id g76so13195662wrd.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GsDY1M+qwptOZ6Rwawkj+diGKprImxrSEdhP9ibtab0=;
        b=TUtiTQ/405ciJ7wcqEXbIaX8FMWf5tpnRvNpsMYgrzJztAX4HmfJnERTAhWoCVbDDv
         rJl2Qd8uyAFKvWvB16C1IXITmfotEUqzqIOGu92ZlYD2E3SSgrk8w6shmLXu9cvVBrGy
         3fpMu6l9qVbG3IPvVaV/ztVMO8Dw6L05/I8bQok68eD9yMsohElBLXxC/ccY7+G0JwVG
         JhOO8m3AVPbRpEQlhF4NBvrWLYXtSkBWHDh79i973F+QOi2gdH5ICjwo5axv15dKJ+Pu
         HswHkiAE4wGmvSrL3ooqJaw0KE26IpPVSuta+mA8BGlPiSrYusPdiyo8yqneZo9xYkuz
         aqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsDY1M+qwptOZ6Rwawkj+diGKprImxrSEdhP9ibtab0=;
        b=FCvvf9134vocCYiHLTrE/KpruoshfFO3ZvqMs4WZRFQwH4xdvlDARNYMIeZbSShErO
         oISqA+/TWhLSdY7xd3+FtEKZGT1esdiMgZdlYO3PfYZ+aI54J1YpSn7wOF5hbKTLysbC
         xeGeVQTs6HWtlXJzHCLz8PKhAZI15W4Ke36tB4Rkthsh2AixUtfeaIVuO+u1C6ZY5VsR
         M471odkIvyXSK4vvmyXl7z/oCVYkgMo+5zpE4Gp3nxq/r2IG3WBdMtyn+g/pfNkyg2qR
         eEPKP52PAq1qKMq6+9BLtlbE92ofvxyTtb1MNn+mTFq7zY/wE7aKe4FV3XnhRgQw7lfJ
         3ctg==
X-Gm-Message-State: AODbwcDtxQdZWV78re3jngZxhWhr7woIokRPizGDvOGsAQt/lZG/hp+K
        I7SchEXVCVqpbw==
X-Received: by 10.223.143.35 with SMTP id p32mr2341956wrb.120.1497115493845;
        Sat, 10 Jun 2017 10:24:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:3439:7300:99fb:6818:11d2:739? ([2001:a61:3439:7300:99fb:6818:11d2:739])
        by smtp.googlemail.com with ESMTPSA id m40sm4670594wrm.4.2017.06.10.10.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2017 10:24:52 -0700 (PDT)
Subject: Re: [PATCH] doc: fix location of index in worktree scenatio
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20170610090719.8429-1-asheiduk@gmail.com>
 <xmqqmv9g1487.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <d2b21102-eb32-7061-14ee-aa8906fe9eeb@gmail.com>
Date:   Sat, 10 Jun 2017 19:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqmv9g1487.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.2017 um 13:17 schrieb Junio C Hamano:
> Andreas Heiduk <asheiduk@gmail.com> writes:
> 
>> When setting `.gitattributes` in a second worktree, a plain `rm .git/index`
>> does not actually delete the index.
>>
[...]
> Right.  
> 
> I however have to wonder if we can do the same without futzing
> directly with the "index" file as a filesystem entity.  With or
> without your update, what is taught in the document feels like
> munging a disk block with binary editor to correct a corrupted
> filesystem X-<.

IMO `rm .git/index` is like munging a disk block WITHOUT a binary
editor but with plain `dd seek=... skip=... count=...`, `hexdump`,
`ed` and back - every step is clear in principle but painful and
dangerous. :-)

> For example, can we do this "empty the index" step with things like
> 
>     $ git rm --cached .

That would be `git rm --cached -rq .`?

Executing this in the git repo gives me an index file with 2.1kb. I
don't know whether or not this index still contains something relevant
for this case.

> or
> 
>     $ git read-tree --empty
> 
> instead?

Nice! The `index` file contains 46 bytes.

For me THAT one is like a nice binary editor apt for the job :-)
I'll queue that.
