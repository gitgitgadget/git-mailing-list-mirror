Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B2F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933510AbcHJSSR (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:18:17 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37636 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbcHJSSP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:18:15 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so121899802wmg.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:18:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k5OUuef5CBTZg7xjgjMmL/OWI9HXNT0gcsng+Vn/KK8=;
        b=UQWkpZsO5Ot2nzkvkHCKP3aeUVAy8JL7lH3G7lxFKioRytj/zXtd01j0zN7PQvKZgo
         cSArRy03Zfn+Y/+g4yhGd49Si5o60wmakuJ/n5SI5VcqFyZp801OoBlIu1Q7zvqLW+NT
         1pEF3g4+ACIXiwYuh+CCM7OwUtHO2Yij8J++eAl01YJaEE9lpgoIsJh2eIY3LLVp5PGa
         fR5ATYFWV1r8I8G/o+DDcvRvEXRFC2e8ltTZr9LaqXU5aXTH4nRJCPG9l/oo+bRoj1RU
         q5WVWP/igDhVHDHUV3bfcYfK0Sw4Jwzb00cUwdOk/pYW/bLb1TW9knr96oDQyqmC7pIf
         PSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k5OUuef5CBTZg7xjgjMmL/OWI9HXNT0gcsng+Vn/KK8=;
        b=OzGCMqx7Cf31YW89S2dGSNFzh5ABbNiEvjdly0gu7sM5n62RHFWfDWFKzX6tkrkoWR
         6GY1xJ7TNXe2t1WHr7JKe2bycLHmq1Xv0fLisCrPTHU3jhmI+3l0NcVKPSBBUZLvzVP4
         JaJK6/NUIqDhEVKs9BBPCJrfRTwBK1kI7clf3mpeEGAl+7y/2BQuotjyUE+/LvP12Ird
         FN2hWEljPXnLFheaVRmsrVBAswTf7lDSeI8LAPUHyyJKvqE/SMEF8g5h6KDRkW5eTxZN
         UW6xbgGmGJ1LMDqodExB8tVtwtZIGzCh7hZ1+xq4uP5A+smOyOhtzaVgI1gLlu0Ot1q1
         88OQ==
X-Gm-Message-State: AEkoouv8dwcugrmcfSLc5ne9O5zJIYGt4dvEb8YrfU5uer3AXyXDEmuy7E5XBfS6rn9OVg==
X-Received: by 10.28.139.144 with SMTP id n138mr4648072wmd.71.1470851217672;
        Wed, 10 Aug 2016 10:46:57 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h7sm44101804wjd.17.2016.08.10.10.46.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:46:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kai3V=pVMOsas6P9wSCyF=BXwVf2Piuci9CNt5BN=K7Wg@mail.gmail.com>
Date:	Wed, 10 Aug 2016 19:46:55 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4A236012-9645-424D-8E07-9E64DCFC2FFB@gmail.com>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com> <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com> <CAGZ79kai3V=pVMOsas6P9wSCyF=BXwVf2Piuci9CNt5BN=K7Wg@mail.gmail.com>
To:	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 19:36, Stefan Beller <sbeller@google.com> wrote:
> 
> On Wed, Aug 10, 2016 at 10:30 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> 
>>> 
>>> * sb/submodule-update-dot-branch (2016-08-03) 7 commits
>>> (merged to 'next' on 2016-08-04 at 47bff41)
>>> + submodule update: allow '.' for branch value
>>> + submodule--helper: add remote-branch helper
>>> + submodule-config: keep configured branch around
>>> + submodule--helper: fix usage string for relative-path
>>> + submodule update: narrow scope of local variable
>>> + submodule update: respect depth in subsequent fetches
>>> + t7406: future proof tests with hard coded depth
>>> 
>>> A few updates to "git submodule update".
>>> 
>>> Will merge to 'master'.
>> 
>> I think "t7406: future proof tests with hard coded depth"
>> breaks the tests on OSX:
>> 
>> https://travis-ci.org/git/git/jobs/150779244
>> 
>> Cheers,
>> Lars
>> 
> 
> 
> error: pathspec '4' did not match any file(s) known to git.
> 
> not ok 46 - submodule update clone shallow submodule
> 
> #
> # test_when_finished "rm -rf super3" &&
> # first=$(git -C cloned submodule status submodule |cut -c2-41) &&
> # second=$(git -C submodule rev-parse HEAD) &&
> # commit_count=$(git -C submodule rev-list $first^..$second | wc -l) &&
> # git clone cloned super3 &&
> # pwd=$(pwd) &&
> # (
> # cd super3 &&
> # sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
> # mv -f .gitmodules.tmp .gitmodules &&
> # git submodule update --init --depth=$commit_count &&
> # test 1 = $(git -C submodule log --oneline | wc -l)
> # )
> #
> 
> 
> Is it possible that the "wc -l" produces  SP <NUMBER> on OSX,
> such that the
> 
> # git submodule update --init --depth=$commit_count
> 
> contains "--depth= 4" which means empty depth and 4 as the pathspec
> for the update command?

Consider this:

~code/git git:(master) ▶ ls | wc -l
     747

Apparently `wc -l` adds 5 spaces on OS X...

- Lars

