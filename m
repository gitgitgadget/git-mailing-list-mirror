Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263872082D
	for <e@80x24.org>; Fri,  8 Sep 2017 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755563AbdIHM6w (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 08:58:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755013AbdIHM6u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 08:58:50 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MIj6a-1dsVmx1ZZA-002DVq; Fri, 08 Sep 2017 14:58:39 +0200
Subject: Re: git diff <commit> doesn't quite work as documented?
To:     Junio C Hamano <gitster@pobox.com>,
        Olaf Klischat <olaf.klischat@gmail.com>
Cc:     git@vger.kernel.org
References: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com>
 <xmqqfuby0yll.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <c08ed84a-6c65-4278-851b-439c63c501ea@grubix.eu>
Date:   Fri, 8 Sep 2017 14:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqfuby0yll.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LOvQ1XyHhUDUdYe7GTf/N5oeoTYabSDRgEKYoM5vObFFU9vZJLe
 vo/EASjTml2ZTxIPm9afbJBBr1Qjv8OtF/XwDGF7b4ts4ClH4xCMMiBC60m+Y8ieF/96/IE
 I2Dd8d/HYcrLtDZ21gqVxucj6NRT+ey5Tg+9mUwSa7L9pHLQvduTvAvHQpctiPffBu8ZUX6
 0qqtpdxB0tHSA2Aj1OaLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h/1lxS5vzw4=:IoRxh5W0eZDdVT1ZonrQOF
 RvnmAHP6u66imfmR1KbeaJ2BwBwbOdG4RvGUWPnQKgCmCHRBtMOfDEWbuR0WzV8khBhnYgra2
 0mqTJrOOyGbdVwnyzNTj07p0MhFMw0ZExnj4+qPFfNbbznENlqKriWn4UCQ/p3dJ7FGH91uIk
 p5aKLx+fmePGdV+kDD/zssvCm8Tc1FOQ0AuNUsWsrHKqsWOSqomezwZdgEGm7EHbQHBxb5mIC
 5u4dXsN7DIKb2hTBy+nTMCCikElaHFPfn2W1I0JKAOmytCiqCD3ykhr7xSdhchHo1e1Yad6Rq
 hx1gBS15MqjkZ1zLz+VP5XSCXxT5R3XXJCBHrlVnFaG8TaKWTC/YWlc7fuZsdVcyhanMnFu9I
 zMP0cbFmaRJPWrxuI9KE72O9brrqlZHLvksBRqu6rX/pFeClS+FFfzB4u9WOkmkgmMr5eR5Ic
 GZFWwGwrR7Cy83m1QmhWrJlojlHqiuZS+Oxn7s84gamzm9ZaVpOsTA6CZVf9gCwGTCJ9GlAW2
 r0xsrGoX4B7JLKYYRPSqoz/rGmOeAZXBQo1a3SVMFG/0HT2NDW0SOSBofbKB27afwHh7+D1b0
 4TAoWd0ySViSTZGPfz/9KNc9kXDTvUjJpJdfohVfUBUwb4P0pgS8oU8s/+a+lM3IVGldvaOTq
 DCUw3+8BvdhiE6lxK3vEI2Ksfwq821PZ/JlctS2ishcARQQwvBeQPT6UaKF8grw4fS9JdpMyT
 fCCPRjJt2H5BifIep25Y/BXzD0nS2FxWJnHDkrDZBDJ1i87QwssWPCoSNZ4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 08.09.2017 03:26:
> Olaf Klischat <olaf.klischat@gmail.com> writes:
> 
>> `git diff --help' says:
>>
>> git diff [--options] <commit> [--] [<path>...]
>>            This form is to view the changes you have in your
>>            working tree relative to the named <commit>.
> 
> That help text is poorly phrased.  
> 
> When "git diff" talks about files in your working tree, it always
> looks them _through_ the index.  As far as the command is concerned,
> a cruft left in your working tree that is not in the index does
> *not* exist.
> 
> So when your index does not have bar.txt, even if you have an
> untracked bar.txt in your directory, i.e.
> 
>> oklischat@oklischat:/tmp/gittest$ git status
>> On branch master
>> Untracked files:
>>   (use "git add <file>..." to include in what will be committed)
>>
>> 	bar.txt
> 
> and you have a commit that _has_ that file, then the command thinks
> <commit> has the path, and your working tree does *not*.  IOW, this
> is...
> 
>> oklischat@oklischat:/tmp/gittest$ git diff bar-added
>> diff --git a/bar.txt b/bar.txt
>> deleted file mode 100644
> 
> ... totally expected and intended output.
> 
> Hope the above explanation clarifies.  A documentation update might
> be helpful to new users.

Well, there's a difference between "working tree" and  "working dir".
The wt is "the tree of actual checked out files" per our glossary. So
maybe the doc could point to the glossary (see the glossary for the
difference to the work dir).

But really, this type of misunderstandings comes up often: people try to
understand the doc based on common language terms (which is okay, of
course) and are unaware of the defined meanings of technical terms.
Explaining them in every place where they are used simply does not scale.

Maybe we should make more use of our glossary (extend it, enhance it,
promote it) and somehow mark all technical terms as such when they are
used (say, italics in HTML), or at least when the exact meaning is
relevant like in the case above, and possibly link to the glossary (-item).

Michael
