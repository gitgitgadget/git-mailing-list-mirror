Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9212082D
	for <e@80x24.org>; Fri,  8 Sep 2017 12:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755811AbdIHMdq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 08:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:62901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755804AbdIHMdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 08:33:44 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Lg9rw-1d4uV33JhM-00nkub; Fri, 08 Sep 2017 14:33:37 +0200
Subject: Re: [PATCH 0/4] Test name-rev with small stack
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
 <cover.1504792601.git.git@grubix.eu>
 <20170907145423.wz3iqxxz2yvxq5lm@sigill.intra.peff.net>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <9b3275a2-7b47-9ed8-6f1f-dac999c3b46a@grubix.eu>
Date:   Fri, 8 Sep 2017 14:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170907145423.wz3iqxxz2yvxq5lm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:sIM3KMGcRaI2Tk+q7/a9/ZS0Hg0rkjOotvkisoaCazLUjxFDyhL
 VKQix/oJO1cS5JY3eUwnpysvy6A1kC9zqEunPWO7jPeRT9n2ygDoQCxREYaZoFk0ZLNFssd
 fclH5mML9GF9iExBOHyxLxLfoYabhyaV8DWBtzMRYZ2gbxjzgBQkfrQ0OTudnkL+f3k+/cv
 oUkFgwf8aV2Ji5ZvU7Mjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v7++341uPIU=:vI85Pu+jsXbGI8bZKnKMAc
 +M/4sVRRxcR5rsD7vqI1zbhs+t4upsal6JH7Ybdvr8NmhWYDQb9gm97LxoLq7h3IGqgSzVh2W
 /+diIwk4wfgl3vN3G0xCHLKh4q2ohpa1GKb88WAb75cMGpOutTFssl0s2H8d2pqM9c7dw+6FA
 kB8dSoLMk/oqmuSMiOg5l/5yQ06XIKDJbxmMOebtc4EmJ8DAuM6KBfDV1ptKVzMqHPhWF7Qof
 7UMp3+y4Ec6pf+VjKVf/B5mq2QmmEOFvgiEIYg5KHPYE/OzuGgT/J1/SiNr3LUTjC+k+fW0u3
 40YeH85wWLMi/s0F2ax7n7enwxXEmxM6fgqB3tU8d2V9p1uuZ4Y4pTR2rmnzfg4gn51/DISSj
 i4vwjjowHz79t1DqyfWcppxkubI1wXbbRR74dDXfFJeWLYLFDPgmHHVP0Y3cbqPuRYCv2ylOV
 Cys3g5FBQ6FGCVmKGSYg0szyYZwe91ij/LZqZ/EfktC0Y7Uo0dZNOBQr3aWEni/zu23XWEP/L
 cYYInSBW1JwdeQ2lY9B+ov3M6sOiR5o5KgYXcP+vvjHV6o3pcmcuCrgUahazYArLtKAmnUj+f
 lk9Mahn13o9q2TCcE4Al/DPXkyyuECnJKWOacYUFdIAYEDk/M7h5HMnJjm7eUZDsQmUoplest
 Oa3aY1jzVXcEQD7xz13Fr2UGPePy0MqSetev7m7Seq4s3F6hOJIQ9UYR+5h0o/NGN5zVR1fpY
 yhA6veSMuRnKIdj6BMRQwvFhq9vehZ4hrxaqDradIj38Y9Fach4zY5ZNGv8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 07.09.2017 16:54:
> On Thu, Sep 07, 2017 at 04:02:19PM +0200, Michael J Gruber wrote:
> 
>> name-rev segfaults for me in emacs.git with the typical 8102 stack size.
>> The reason is the recursive walk that name-rev uses.
>>
>> This series adds a test to mark this as known failure, after some
>> clean-ups.
> 
> These all look reasonable to me. The size of the test case in the final
> one is presumably arbitrary and just copied from t7004. I don't know if
> it's worth trying to shrink it. It could shorten a rather expensive
> test. OTOH, if we shorten it too much then we might get a false pass
> (e.g., if the algorithm remains recursive but has a smaller stack
> footprint).
> 
>> Michael J Gruber (4):
>>   t7004: move limited stack prereq to test-lib
>>   t6120: test name-rev --all and --stdin
>>   t6120: clean up state after breaking repo
>>   t6120: test describe and name-rev with deep repos
> 
> Now comes the hard part: rewriting the C code. :)

Looking at it more closely, the solution in cbc60b6720 ("git tag
--contains: avoid stack overflow", 2014-04-24) seems to be a bit "ad
hoc" to me:

First of all, there is more than "tag --contains" that may exceed the
stack by recursion. So I would expect the solution to be more general,
and not localised and specialised to builtin/tag.c

Second, this is a walk, so I'm wondering whether our revision walk
machinery should be the place to add missing functionality (if any).
That way, everything would benefit from possible or existing
improvements there. For example, I think some of our "extra walkers"
don't heed object replacements. (I need to test more.)

Michael
