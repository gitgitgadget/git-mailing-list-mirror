Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CF4208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 12:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbdIGMR0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 08:17:26 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:64668 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbdIGMRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 08:17:25 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MIv6n-1drqcM25fN-002Xp5; Thu, 07 Sep 2017 14:17:15 +0200
Subject: Re: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
 <xmqqbmmo8pp6.fsf@gitster.mtv.corp.google.com>
 <6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu>
 <20170906133519.amlc5yunx4yfl5u3@sigill.intra.peff.net>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
Date:   Thu, 7 Sep 2017 14:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170906133519.amlc5yunx4yfl5u3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9QwA5SKaosGHnP2A0uNvmC54AS0HBe4IPC50jmy3LiJ/vzkExYl
 8y5p4fAcCVZV7beobpdwpte/OpglwhpDSQNg8x5Yxz83tWFtE+TwJYASiCbR4ynuBB5XldO
 lgsPmX1823qV8GCDj0h0vcu8O3DqkTJ33aCRQb7e1KVi6HKv6E4V6RHlLlezP89Qav8EYY8
 7sJys5scJRso0+lc/Do7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BEHM2o95/Bs=:ryMu8rBVTKrzreGSOuY+Ba
 JWjvZrXEdLLJttGSZ9hYx57JQl3HdfCbdTBzCK6TjNDQMbOHSfWgtUU0q8Tpuba8vGQRiNpyn
 D2Kmd/1zN90AlBuDkH/+HpfDjsCumcc8Kxk1RR9v0G4FF2d0D95hRd9FR01WQU56ZnNCqG+VN
 yuXGgwUbHhE+m3FaAKYnJUOWtEC9ANW/LFe4hzZ9zhLvHv7opEaNgYxcRbLU47hF4BrpGl0Tv
 IqSq59EeAbQvf9VpvHV72KsPDgbFgZzzENl3/BfoDawC62N0l0TUYST0Ao7g3ZqP7C4qGGYiF
 TgGsNJ/xWmDgby8W+ObitzXn5o5mj4A3XVwlHoqjiAfkxiuW+OEVlE1cynKdDRXSYpAs3XcW/
 6Mt0h+SejxFpgBH2ZPvRGyfjAsL10aeuUiz74pd3OaUT9f2NFIDnYlSCsvevnVG4C5wzyUh9i
 kryta92cnX6GBjm2mHygtSYpwQStqESWfJWwQJSlHCS+jjePiG/Fif9gJrmf3C4605OH3RTSA
 uDcCxRGCXlHQnNZyuaNYrHmZbO6DiiNrUaOlwrjfe3+Urde/r/+/JEOGpvtnnhcLGzKGUs962
 KWRpwN7imjiAIygFypxfOeph3sMMmqCy9a7qnV/fLObIxhVwr86RrEjxFAud08FVagZIE2Za0
 hMoPar8sR3WIyHmKrK437YH+Py9V9d4+OO69xd31QtAahCb7AXgVLJuE5MX0YcBWDAPydw9CV
 hPi7/E+FAWt5DC6BwZsqkWNDdzhuVRO8kuFubpb9cTTrRsLyIBpX1Rb6XNQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 06.09.2017 15:35:
> On Wed, Sep 06, 2017 at 01:59:31PM +0200, Michael J Gruber wrote:
> 
>> BTW, there's more fallout from those name-rev changes: In connection
>> with that other thread about surprising describe results for emacs.git I
>> noticed that I can easily get "git name-rev --stdin" to segfault there.
>> As easy as
>>
>> echo bc5d96a0b2a1dccf7eeeec459e40d21b54c977f4 | git name-rev --stdin
>>
>> for example.
>>
>> That's unfortunate for the use-case of name-rev to amend git log output.
>>
>> The reason seems to be that with "--stdin" or "--all", "name-rev" walks
>> and names all commits before beginning to use that those names for even
>> a single commit as above.
>>
>> That segfault bisects to the logic changing commit in
>> jc/name-rev-lw-tag, but I think the changed logic simply leads to more
>> xmallocs() the segfault sooner now. Or something that I dind't spot even
>> after a few hours.
> 
> The segfault seems to be due to running out of stack space. The problem
> is that name_rev() is recursive over the history graph.  That topic
> added a parameter to the function, which increased the memory used for
> each level of the recursion. But the fundamental problem has always been
> there. The right solution is to switch to iteration (with our own stack
> structure if necessary).
> 
> We had similar problems with the recursive --contains traversal in tag,
> and ended up with cbc60b6720 (git tag --contains: avoid stack overflow,
> 2014-04-24).

Cool, thanks for the pointer. ulimit -s is a great way to test this.

Michael
