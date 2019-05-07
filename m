Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2531F1F45F
	for <e@80x24.org>; Tue,  7 May 2019 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEGN5G convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 May 2019 09:57:06 -0400
Received: from mout.perfora.net ([74.208.4.194]:34485 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfEGN5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 09:57:06 -0400
Received: from [10.24.23.15] ([73.253.126.133]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LhMFq-1gt7j309Mu-00mZqg;
 Tue, 07 May 2019 15:51:57 +0200
Subject: Re: [PATCH 1/1] cvsexportcommit: force crlf translation
To:     Junio C Hamano <gitster@pobox.com>,
        Dustin Spicuzza via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.132.git.gitgitgadget@gmail.com>
 <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
 <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
From:   Dustin Spicuzza <dustin@virtualroadside.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dustin@virtualroadside.com; prefer-encrypt=mutual; keydata=
 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
 WlhFAsgIvQDizC4ODS0dD4QZYTc=
Message-ID: <4da677fb-47c3-a1ac-e7e0-6b74cdb7334c@virtualroadside.com>
Date:   Tue, 7 May 2019 09:51:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:QVOEwpInuSgVZzJA88YqjHHCJJyP4p7p9sZ5/MMulHv9Jr+sYYU
 YtncwL8RczxjRMbnCFvpnB9uq1ucFDVot6kc69nbK2sL/NFrYwC9bMmC4Nu/87kGdLxAB8C
 07MmN6RFoHGiwHutF/xrggSjlVqElYJjlEUnvF/Uf/MMUl3Bu/N3nP6AUKbaKfwinS9MiyW
 iUeZSZm/o5CqKy4aMXu8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMIvyYbCeYU=:/iy4IzJ1cbA1xSzVzJ1EXl
 bB0xPT8Eyp9aa52Epp6b0GVxH6bp4vVULXfrT13B4FeN3xs7OuTDabl5o2rcQTbEAukmxziCZ
 Qs/DHNS7rEPaRuEKV3Xkeh5DHsWVkqF10Gz2PeNhmJRo17Zk9EVnMZQ2yUDOAv04vrewhGCol
 lQf4N4a/4mHUfxvuqmhJrqPLlG6Vjh1J7LYzwYwXoTaQPd/7SSC86fIFjggPmlvo8WJAOYeCi
 W6rH/MXA/csfSAy3S9jqEtOnYd4Mhkng4FPsIIMzN1Y8MmgelBipGO+7YHYw/PmSAW/QjPKVR
 rxc/zVyJ/93BBAib0uoZkqcnkGyenlfaDezTJHAJKO09ZiKK5OwOttFtmKNVmMc/ld85jEvG/
 oRnVsAYJ1guOMgK5o4mLn2WkiaFucE8u37YNjm0xQz3ZbnS31tBjcyQd1iFbJLkBNvurfnIHA
 WNZi/MRtXup9b7OPtJm+A00xKBrKevksECGfGUcx2dWXi0/CClvqlmXnrkVDlppGD7076QsCa
 ts8VI/z91/T3r0pippn67vH25WJuNwFAb+veNilXg59uXrSdLtyfcLfRy9GTeBTnnYe3ZqKKX
 UiIqHFIFPYt5RbcqGZC9oKCGSYPZHdlW5ZcfdYw2F2c5Df7+Ty6MTDYJR5iEGhIrZ2dr67kd/
 3qcFFvMR7NyJfJTtygKXgzELc30Ibir3gKpGx2/Bb543Lx83j1YhVt+OtxEXmVpXpkHjEvY3E
 wln1LfTs4/+D+DOOZWmn3mTqm2jVTNBQmY7Xtco8W00MgsPHXod0ZeAdV3oFVYtr8Ehl2mSdk
 d4/w4O4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, your interpretation is exactly correct, even the interpretation of
the uncertainty of the message.

I didn't send the patch to this list though, not sure why gitgitgadget
decided to do so (I've never heard of it before now). The patch was
originally submitted to git for windows (PR #938), with an even worse
commit message. :)

However, I'm not opposed to it being merged elsewhere. As you pointed
out, it shouldn't negatively affect non-CRLF platforms.

Dustin

On 5/7/19 5:22 AM, Junio C Hamano wrote:
> "Dustin Spicuzza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Dustin Spicuzza <dustin@virtualroadside.com>
>>
>> When using cvsnt + msys + git, it seems like the output of cvs status
>> had \r\n in it, and caused the command to fail.
> This is a bit under-explained in that it does not make it clear
> where the right place to fix would be.  From "X did Y which caused
> the command to fail", a possible right fix could be "so fix it by
> telling X not to do Y", but of course a patch to fix cvsnt won't
> come to this list ;-)
>
> I haven't thought things through, so let's think it aloud and
> enumerate what should have been explained in the log message here.
>
>  - With binmode(":crlf"), (i.e. if the platform uses CRLF convert
>    external CRLF into internal '\n'), the change hopes not to affect
>    platforms that do not use CRLF.
>
>  - "it SEEMS LIKE the output of cvs status had CRLF in it", i.e. it
>    is uncertain if everybody on the platform has the same issue.
>    But by using binmode(":crlf"), if some other implementations of
>    "cvs status" on the platform used LF, they won't get negatively
>    affected by this change, either.
>
> So, I guess the change is safe enough that it does not hurt other
> people.
>
>> This fixes that.
>>
>> Signed-off-by: Dustin Spicuzza <dustin@virtualroadside.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  git-cvsexportcommit.perl | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
>> index d13f02da95..fc00d5946a 100755
>> --- a/git-cvsexportcommit.perl
>> +++ b/git-cvsexportcommit.perl
>> @@ -431,6 +431,7 @@ END
>>  sub safe_pipe_capture {
>>      my @output;
>>      if (my $pid = open my $child, '-|') {
>> +	binmode($child, ":crlf");
>>  	@output = (<$child>);
>>  	close $child or die join(' ',@_).": $! $?";
>>      } else {

