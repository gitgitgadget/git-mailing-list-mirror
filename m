Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA7420899
	for <e@80x24.org>; Sun, 20 Aug 2017 16:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbdHTQF2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 12:05:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbdHTQF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 12:05:27 -0400
Received: from [192.168.178.10] ([188.103.198.19]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0Ldhch-1dJAGW3grz-00j3gr; Sun, 20 Aug 2017 18:05:23 +0200
Subject: Re: Add --ignore-missing to git-pack-objects?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <7d7a5801-1418-cc03-6d88-c148a38fccec@onlinehome.de>
 <20170820101632.irj22dighcrrcvlv@sigill.intra.peff.net>
From:   ch <cr@onlinehome.de>
Message-ID: <6b2b5649-f8a0-bf1e-3688-8a649b4ee5ad@onlinehome.de>
Date:   Sun, 20 Aug 2017 18:05:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170820101632.irj22dighcrrcvlv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:w0X00deQ0uKBpzDv1zHkwfKh3XuAqvtnvPSyqVOa2Lkp/MspUEF
 ixde9JtZNjfRUdAmupyP7AO5CJQ7PmPe79yd+6Z2ziAb5FMi1nr9DPf2hdoyPJd5WGp0mLv
 WjOEWkH0bPhQEW3ZmV4hpj0+r0vfOLBTQYoLV1j2I/aNB/23EiTlZnb/GS4OJWbZwIbLDKE
 A2TxIBa4b5KKWeY/Hdebg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e+WvAJv5CQA=:0N6l9kBD8SrqSjX8qe2AT/
 oEPzCP7hwW/qBRoU/tOVgsUDyBu1+5TneTq2kHT7+gOgzLJPA3+ue3bXh11YUs0bl7TO4x2LG
 /FkcM+c/7jBavmDGOSbXbtv+pMUSaAi2/9az97yzIgxOEtJOkcqHQb9zcxNKJ/kkh4VrDrq/S
 5iWakdNpG706d6lPixTvIpmbv4y1O6ADYLXwUjt39jDoNW2Dw3wdgwz1IWH1lYkCPwKFDau2x
 FMUZs9j63KRbKRUgSVXP/j8WbpF7cpQ/hN1gYQpIi30FMcNUImh8N3nYoT7sHagF961uVdiDe
 Ud3kRoVJxIYoeQ47vg/R5rC+mHmZBRrylcyIC89H4/c8+e7E3FtHYDbA2lvbgHBAtkH9rLqab
 0nwSYV5JJypPN5wak2MVoDTwmxX397WWyDLaAwjx0OoHsfIQaQD1tVGsVx/CB1jBJjgHnvoX2
 PcZ8R3Tx3uOMX09ff4TM8m3/ZrfEcYGxSeJuhKW+Ae2OpShyUhulRycU5to54dpIp7UXxrq8y
 SxkYBa6LH2CocAc6oZg5jf1nfvGfg5baKRXm2yxCZ4CAOzomMACNMaOx22k/banzyJZRPFhMb
 LReyN32Ow/hytqw0ipXVnLZZk0Sy9FOyqmKi3rsuNqF9XQ5sl9PSDzGOm0gDy13lcl3EPuWUF
 4wukSrjNcrfVq8d9SccNGXKxecOQ8KBpDHYdsLS9c8AWQU49qcWokcTHlcLuFXzp8Hewji7xJ
 Wii0LJJn/dZg9fIyBRnuwKh1q4uYQ9tF2uhdFF2datXEHwGCTF9pePUWavk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff.

Thanks a lot for your response.

Jeff King wrote:

> So if I understand correctly, you are only using these for the negative
> side of the traversal?

Yes.

Jeff King wrote:

> rev-list should ignore missing objects in such a
> case even without --ignore-missing, and I think it may simply be a bug
> if pack-objects is not.
> 
> Do you have a simple reproduction recipe?

Here's a small bash script to illustrate the core issue:

----
add_file()
{
     echo "$1" > "$1"
     git add "$1"
     git commit -m "$1"
}

git init .
git config core.logAllRefUpdates false

add_file "test-1"
add_file "test-2"

git checkout -b feature

add_file "test-3"
add_file "test-4"

git checkout master

add_file "test-5"
add_file "test-6"

feature_tip=$(git rev-list -1 feature)

echo -e "\nDeleting branch 'feature' ($feature_tip)..."
git branch -D feature
git gc --prune=now

echo -e "\nCalling git-pack-objects with (now deleted) ^$feature_tip..."
git pack-objects --all --revs --stdout --thin --delta-base-offset --all-progress-implied <<< ^$feature_tip > pack

echo -e "\nCalling git-rev-list with (now deleted) ^$feature_tip..."
git rev-list --all ^$feature_tip

echo -e "\nCalling git-rev-list --ignore-missing with (now deleted) ^$feature_tip..."
git rev-list --all --ignore-missing ^$feature_tip
----

Both, git-pack-objects and git-rev-list (without --ignore-missing) fail with

fatal: bad object <feature_tip>

on git version 2.14.1.windows.1.
