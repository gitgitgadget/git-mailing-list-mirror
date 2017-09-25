Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676E520281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934798AbdIYKyb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:54:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:61647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934746AbdIYKya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:54:30 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MTtH3-1dnoB40Zeb-00Qitx; Mon, 25 Sep 2017 12:54:23 +0200
Subject: Re: [PATCH 3/4] merge: --no-verify to bypass pre-merge hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1506081120.git.git@grubix.eu>
 <bdc45cade9a8d108b7d11d66c0eecb27c2f23af6.1506081120.git.git@grubix.eu>
 <xmqq60c9j7sx.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <b5aa26de-46db-271e-e86e-bc9ba9c67fb6@grubix.eu>
Date:   Mon, 25 Sep 2017 12:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60c9j7sx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:FSxSr9pkX2GR2SD0934uJ94BxFZu8UPsE5T1GqiBA2Cv16ZIMlv
 fsSN4P/4rBWQNo2EKlVfuODy+jecJmPR3ncGvNd0g/X+BreVU3USZGrb8klPO5b7FKH3+Ec
 bhIkee26yy0ahiHnOOLoLsEqzFuYTPSKUPgbWxS0a53oWDd+TGnmAaVl5Tdxq5ceg0VMRWF
 wN7ztCCdGl2fLl9IQRrXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ms5bZUcvqfo=:i1E9nxFSHb3phltWVqbnWs
 a7jH243FgQJBXMMIy7yvjOKL9gmNb5OE5qe/d1xxG03lfhjJRBFHk6bxw1xOhbEtfFB7UKxzK
 XW58HtSibHLTm2ySIET62DkrpVwMQElUK98wVu+i31tkzt7ShbVKVN8a6HtW14SEs0vaqgqgO
 dl/jzoBOTM0YtwI+yJtzPvUqFO/H2E7OI9gr+GtZ1RICW//x0xO70e6FfUuOd6icSOd6LgDxd
 TZKNBeNm4GvVz5nEW+iGG6thJvRPCORC+vwXXhuQZ+0aNQstZJ9pgSQg38IU0CbWciDGZECY2
 M6CzKXmziRgLD3i3msc5jeqimUdB0MKvbmgOQXOdWB+LmzwAfPmZyqXFE0OWMGsAds713NNVK
 DNGqZ7ABWqWheDPE+OwTUR5q38G8npr/XUQyb2X6KErEsg/oiyObSkEwnphn+AsI70kMMbrem
 rHPveU/cxJRJlf+XFnvX5DoiAXWm3VWJkSuMltscPOWCQXg0LbHI+cTQVOexWtlg4AKkeUJCY
 8tkTcbQAwpMT5Hf6uEHRq/x+VC6dz//bB8xbbNOas+GkOLnP23sh3AXxgfhlXJaWBXe8xjNN3
 eZwYgGpkrRYF32KX6SXZXxK+S0teOB7K8j5sQatUJPnD/D9PoLmPzg+s3bIZL5tx61yW0i/ly
 u4Rhc1bQ195HoHUPNE0ZDf8QaW7BrnNBqSz93DWybcnbVseeDLuGcHrSoKMFQOjVMPELTSsUK
 ZVb192EIQGXCU/6eqoA5J3fZL6HBVTehp1jL5qS6g64OyFzaHXkzmJm2nnQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 24.09.2017 01:48:
> Michael J Gruber <git@grubix.eu> writes:
> 
>> From: Michael J Gruber <git@drmicha.warpmail.net>
>>
>> Analogous to commit, introduce a '--no-verify' option which bypasses the
>> pre-merge hook. The shorthand '-n' is taken by the (non-existing)
>> '--no-stat' already.
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>> ---
> 
> It appears that some of the pieces in this patch, namely,
> D/git-merge.txt and D/merge-options.txt, belong to 2/4, where we are
> fixing up an earlier addition of --[no-]verify option to the
> command, to be updated to only add mention of pre-merge hook in this
> step?

Oh, sorry, rebaser error. I should also rewrite all commits to my
current e-mail.

> The end result looks good regardless, I would think, though.

Pending restructuring and attending to the other comments...
