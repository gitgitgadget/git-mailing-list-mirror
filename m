Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E545202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 04:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdGKEOh (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 00:14:37 -0400
Received: from mout.web.de ([217.72.192.78]:49328 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdGKEOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 00:14:36 -0400
Received: from [192.168.88.159] ([194.47.243.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUkU-1dhWWd2xs6-015t5P; Tue, 11
 Jul 2017 06:14:33 +0200
Subject: Re: Weirdness with git change detection
To:     Peter Eckersley <peter.eckersley@gmail.com>, git@vger.kernel.org
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
Date:   Tue, 11 Jul 2017 06:15:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GkyTDD2rHI2Hi8/yTKRI+3eWr7p+d7rEzXK+ARzcPumT96CQbQl
 lhCKFEkU6BLc0rc3pcE7M8uEXoiIAAScVH45wtj7Ej3QBH/DnasDp+9+DCztaQHVZ1iD7v7
 Sa1jz3f0UzET7ADjpc8PxeYkKHqrU1g6oLoLlJm4wRuZJsWUCCnaLkwgOEgbYLlxp6k6wzx
 j9MV6ErN91om/oE2/dlUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8Wisa37N1F0=:SEHW2k5scRxHzHWrdg2irP
 jY0TZwch8M7vUJQAWqLmNwXFIZG7ClyOw8nHFdqVXou3Pb0uB7oiMEQcJP2lvf2C4jrX33qoT
 jW7EnFeZ2qAY9n1uWZxXFSG05+Ue0z720PgBclZJxtmKcMLij+TbaCRS2p81CjDvrHuCR2ivo
 nec0z9jenWcd2MLobF1OniqqHJ7H5nRk9niHf4PPPHfqSi+/9v8JQ3lkND2RJTe5N+00oFBI1
 6o16uQkxenga30uckt453dqWWsiqi+1Ll2k7DuQ219B5SAutOFH7h9dlbaBaPlFDrx0OCa3NE
 QwHUa+NTqpV2S6B6T1DLrh/ssBaSP7FtiiseQw5yt7pJS07VkNdMVhdMH6AH2/HxnIW4dnLui
 DhVIUk3PNk39L7E+0+jK0zyHuCiGLwGKyqziQxYF2wXIbQ2/Nv4f3NoIEtwzVb06APiJ3EuGD
 F6joepq/xlDT4nOVbo4mfZy8i+gzvj1GQFffGP+YEYD41SBGJkB0Xa19pCMP0CLAayqbNVI0W
 0y3xEFE315xYjvvuhCoy10mxSd1sb8oSSOB16ueJ71d7NerXB5wjP/atbIGiKY5wPcyMtnZEz
 LdCweXOiWLA/zF1pzmMVVpFHcDzX2gNlTF9q4gKKZ4p0ZUE+nPk7ZirydxJoIN7JzUS2pCsKQ
 UUfoXM1v05D7i+pB94/urfujmYQKaxRVk0fLB5rOJuyfuWmYB7ThiD/nOoh1BFKuR6sM1mYXf
 iEm2IQ0pvB2Oays7i6TpmeC95JT24B7QLoGeuCbC3IeLFl0DSNHIszvERzpzCrviTl9zT+fyt
 CPSPZrr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/07/17 01:45, Peter Eckersley wrote:
> I have a local git repo that's in some weird state where changes
> appear to be detected by "git diff" and prevent operations like "git
> checkout" from switching branches, but those changes are not removed
> by a "git reset --hard" or "git stash".
> 
> Here's an example of the behaviour, with "git reset --hard" failing to
> clear a diff in the index:
> 
> https://paste.debian.net/975811/
> 
> Happy to collect additional debugging information if it's useful.
> 
If possible, we need to clone the repo and debug ourselfs - in other
words, the problem must be reproducible for others.

It the repo public ?
Which OS, Git version are you using ?

