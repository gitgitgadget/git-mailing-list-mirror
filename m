Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6451FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 10:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbdFLKsq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 06:48:46 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36726 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdFLKsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 06:48:46 -0400
Received: by mail-wr0-f172.google.com with SMTP id v111so92019576wrc.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+Rae+OIEWn+fBLBHAXMJDgEDcqPLwb03F0Xvo+PoMU=;
        b=WnFH5I3uRvS4X9yvqU0LOIMZomYnoFxn3JrbrYVKNXy+WmwaU6/VE/7RokTFmQmPfX
         LH+TPQVIxRLvvTnsPoqiWQHPm/QKvd3Hamxe30j43TI3YtCkQxCfs8u3TyW6xSI5XXtU
         X+cRI3svJncHcdS4yWwjboIVvwungqio4DjW79XZt12C2tSKufxP8Wg9gPeeABLD9+rf
         ksZk80vcoUCHcgSkhnsnoy/sqD7b6T6SHfk8K/dC3uS9tvI43y5ibolH6oA4tlEo31j9
         9wjUhtZSQ9Qb7McVd2R4gPLWSUvt2wI9IPmfYH1JbaYH4UIKwRW35OvdYv6+qAQax8ED
         +7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+Rae+OIEWn+fBLBHAXMJDgEDcqPLwb03F0Xvo+PoMU=;
        b=VKRrEPr6hRHxSbK6QBHOH+VYTMBVy5ORVvmh7qHR7nVFC3UZYdh8rJN6za2jbCtahB
         m5cAWzxeQrpp6dsQq36OBhBpk5sJA5a6HokILNzEZvcVMpR6oaus7XFapfzySUjCvZAK
         D8RncdhPwjQUD1URkRl6/J3mZUHgMc+Oxm2MxGmHxYE6aylCjstt1+8Lu4UI6NLhDXT5
         WC2PNbSiyBGOcZmRKGKiLG0/YZvfoHiKE/wNNMVMtF2H5LTw3upYSlDpMh2AN3nXHxbx
         iMAvuTaIpRu8Okn3UovoJs+cF3Xp+nOfWC8kdLQ6pWb79nPX7/inOAWBqn5pfzQjeul8
         CXsA==
X-Gm-Message-State: AODbwcDyhTlfmhs6+tnbNe2qfO+RzlZDmBGSUG0pG7vBAFCS9rdtS8wZ
        MI6K0OLoH8Ed6g==
X-Received: by 10.223.130.37 with SMTP id 34mr7404600wrb.44.1497264524686;
        Mon, 12 Jun 2017 03:48:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:6500:691f:1637:de4f:20c2? ([2001:a61:341e:6500:691f:1637:de4f:20c2])
        by smtp.googlemail.com with ESMTPSA id q16sm8349576wmg.2.2017.06.12.03.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2017 03:48:43 -0700 (PDT)
Subject: Re: [PATCH v2] doc: fix location of index in worktree scenatio
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20170610090719.8429-1-asheiduk@gmail.com>
 <20170610173824.19460-1-asheiduk@gmail.com>
 <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <942bca59-40d4-bfbd-a3e7-a15d399780e3@gmail.com>
Date:   Mon, 12 Jun 2017 12:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.2017 um 12:03 schrieb Torsten Bögershausen:
> Thanks for working on this (and keeping me in cc)
> 
> The commit head line does not fully match my expactions:
> "doc: fix location of index in worktree scenatio"
> "doc:" is OK, but is the "location of index" fixed ?
> Actually something that includes the important stuff:
> 
> "doc"
> "fix"
> "normalize the line endings"
> "worktree scenatio"
> 
> could be more helpful.
> 
> How about this as a header for the commit:
> "doc: normalize the line endings in a worktree scenatio"

Well, my patch does not document nor enhance the documentation
about EOL normalization per se.


> On 10/06/17 19:38, Andreas Heiduk wrote:
>> When setting `.gitattributes` in a second worktree, a plain `rm
>> .git/index`
>> does not actually delete the index.
> This feels somewhat short. setting .gitattributes is (in general)
> independent of the index.
> In normalizing line endings case the user needs to do both, fix
> attribiutes, and re-read the work tree, discarding the index.
> 
> How about this:
> 
> When line endings are normalized in a second worktree, a plain `rm
> .git/index`
> does not actually delete the index.
> Fix a long standing bug in the documentaton and use "git read-tree
> --empty" instead-

Before `git worktree` the description was correct. So what about this
subject and body:

----
doc: fix location of index while normalizing EOLs

When line endings are normalized in a second worktree, a plain
`rm .git/index` does not actually delete the index. Fix the
documentation by using `git read-tree --empty` instead.
----
