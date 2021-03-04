Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE3C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EA264F21
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhCDP2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:28:52 -0500
Received: from mx.kolabnow.com ([95.128.36.41]:42142 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233616AbhCDP2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 10:28:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id CD81BBCD;
        Thu,  4 Mar 2021 16:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1614871587; x=1616685988; bh=JQZJoflvvfq8p8tHV8w
        XAEZ9rRIIVrCRIMUuZCKTdhc=; b=QLLwB1b5Arr1iBGVUcg8s1AxejKLUJD66ff
        9YDKPxgCxYD1aJxqA4evQGKkN5TtmE3UP9E0gNRLdUxd1riDeYPErDw6mZvkH+sR
        zYk5nJ4ZnRybsA71eXwi+HKp/ZfvFLTTBUUE/LbAJe/wWYVfF9vTY1L7Ks7w5BJK
        pnIk8Ld3LmYZWVy51h05m3HsjeHXTIziRBj/mN1/sQYhL0EnRCGi+hYDtSkYKbg6
        B4HwZ17hqxdMpOpmfOtRBLzGGqTGsiJAfBM2HnhvhDCKaRkhWPz/AbCg8rGXe9P5
        drcQoihSHFraQXtFis1d0PEmLPbFU850J5MLyCkv6X8Hg4xae3vOhK+DpxYb+zv2
        vPXAk9brnIoPk99bRboFuEOHtAVuQXWkxHiGNTno45rJwGmln6ZcT+k6VxtskXRi
        rRNQCMM1uskA4tJ6D/VMTkNj3QgZejsmtV1yQEstoWAhzkFDxAwafkJH3xiwbRom
        plo+blCCfeQrM0/tT/G57SmmoSmPXv8oa2bKmxoFXzSSFprmoHjEkCgFUcPEBdBg
        gxJoQXxxIgo27WKJhXJ0efwy06qi6xPD22tXTXfm+4hO2EEhMyv/rY7ro8AlFRqK
        AWW6iUMWhQYoQH/s6tP4WoGhySEDuzROioFOHlf20pQp8T3fWN97kb+yutTDPJJb
        bv9htGaM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ye-iO-PnBC3; Thu,  4 Mar 2021 16:26:27 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id F1763BCC;
        Thu,  4 Mar 2021 16:26:26 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 87186310C;
        Thu,  4 Mar 2021 16:26:23 +0100 (CET)
Subject: Re: [PATCH] Update 'make fuzz-all' docs to reflect modern clang
To:     Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
 <YD1tJlY/mqZOmTNm@google.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <094d75bf-707a-5b0d-fead-5c9ad08e0a18@ahunt.org>
Date:   Thu, 4 Mar 2021 16:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <YD1tJlY/mqZOmTNm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/2021 23:39, Josh Steadmon wrote:
> Thanks for taking a look at this! This looked correct to me, but when I
> tried to run the fuzzers I got an error about
> "-fsanitize-coverage=trace-pc-guard" not being supported any longer.

Oops, I realised I was accidentally using clang 7 (instead of 11) 
locally. I can reproduce the same error with my copy of clang-11. Thanks 
for catching this!

> Looking at the LLVM 11.0.0 docs [1], I see that it recommends using
> "-fsanitize=fuzzer-no-link" instead (the "-no-link" is because we're
> also building executables that have their own main()).
> 
> So we'd also want to change CFLAGS to
> "-fsanitize=fuzzer-no-link,address".

I will fix this too!

I suspect that when I built without fuzzer-no-link, the fuzzer binaries 
included libFuzzer, but were missing whatever fuzzing-related
instrumentation clang should have added. (Fortunately oss-fuzz seems to
be adding this to the CFLAGS automatically [1].)

[1] 
https://oss-fuzz-build-logs.storage.googleapis.com/log-74f40f33-f384-475b-b141-0e44afb272f5.txt
