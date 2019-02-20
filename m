Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5AD1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfBTIcG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 20 Feb 2019 03:32:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:33827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfBTIcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 03:32:05 -0500
Received: from android-574c69d4b059187a ([217.149.160.51]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LztHH-1hA4kh3Phz-0155hj; Wed, 20 Feb 2019 09:31:41 +0100
Date:   Wed, 20 Feb 2019 09:31:36 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8Dq9_uFofs40XwjLkmiBNWXCpic96W1MK_tjLQyaF0+BA@mail.gmail.com>
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com> <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com> <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com> <CACsJy8Dq9_uFofs40XwjLkmiBNWXCpic96W1MK_tjLQyaF0+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=drizzd@gmx.net; keydata=
 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
 ot18p18pwfiv+HM8r6TH1/NTwGg=
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
From:   Clemens Buchacher <drizzd@gmx.net>
Message-ID: <49F0F61F-9874-4027-8430-E313AA46C83D@gmx.net>
X-Provags-ID: V03:K1:728sPSlo3++UBp91MzM7NLMdtmEKWuDgbwN1TW1Gqguxpfd0aCz
 77gTEg8pfoJFrXGq6mjqmG6q/YIhUKvj/yPvwHrOr4tnHescpiGxWfTNk42U4/DMrU33adz
 5/+V1z/E9CSdTliCsuekblopCgw2ztn0vMuNAW8YKxPJo22yezLwE+YHZ9mZfis2yCjpNro
 02vcAFf+NoFZ2HDzi9nUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yl0ZPOPyXaY=:IFs1P0e5EoqWHQp6T2qZrl
 K3oqp0ifoiHRKeGXbLzOPpFPNpFVFXvlAoon+jpgofQtkPprpRenocc3OQTnXODfqvdUhhpK2
 YGI1P0NPQYU1duh3Ig9c0yxJVnYFkyzcNYtog4IprspkdsyMNWoQPJfvk+JkXEKCm5jICx4CU
 aN6pzqcubsLU0FKko54oWV+iYYsi1p2Sfhm1psM0jMVRFLqnkrGepN0BZb77ALavHtLNHysHY
 4ZLvrmwz/+YO3rmrbNP4fmPwX4trh2Prg3SwbU1+UllCEfxtpQAugrWOTj927h12igzwPcoel
 VmOQuamYmZDhXwjJFHxwMD+vmuO4ktzUzN5Q4P1mBuTI3c6qHmJJz230Lm6fS3shcT3Upe1ho
 qYKTiYO3607GAsOPynmNzJjubRlzenXPm8YcnKq7yDcgANQk7I3vYivoy3/iOSLWuyKi9IuYU
 l7xZlq6BZ3sDsczAVZkLIfnWBnrWbsP6K7EMfC66R/C6v+lzkwoOZdUv6qXoJJavhzECtEUR/
 CLiOxaItqqW/NUTmdCX/KwrlLeaFBR+Qoe4kcvWJ8FaR6Os9Zj3CNjHsvZ2zSUOX+NgQVUVn7
 2URwA0InHSwabHldCW3/Nqwj41MoTKU1IEHNcBjb6w3NMkyneaa/IBh4gNda53+YsnFZAvmWn
 dRS2Kll5U8WiOGggN9t1ROIGEE+wW9tpgBkyUZSVk7w/8XxNes0XQecjQ59pESmSNKt7HnRWt
 eCSTS9O3dDL0AgT3veC51e+aAfI9/YIIaKqpxkRwFDIRXioC/HZq8QhA733QKtbJrG0p0pGXs
 5EEJ1l8S9WOrOF4HUV7QMt3lYw1y58kz3PT6KigTHMbUooKy6dLfWj5CaSocWdM16fNHWczj9
 b0Z5wRAFeXLCerNKc7bB8DpVCJg4UVJnIpVqvch8WRHVJ9KvN8F/5y0zUkbYFDATec9YivPuD
 un4CAv5mUMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On February 20, 2019 2:35:41 AM GMT+01:00, Duy Nguyen <pclouds@gmail.com> wrote:
>On Wed, Feb 20, 2019 at 1:08 AM Junio C Hamano <gitster@pobox.com>
>wrote:
>>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > On Sun, Feb 17, 2019 at 2:36 AM Ævar Arnfjörð Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
>> >>
>> >> On Sat, Feb 16 2019, Nguyễn Thái Ngọc Duy wrote:
>> >>
>> >> [Re-CC some people involved the last time around]
>> >>
>> >> > A new attribute "precious" is added to indicate that certain
>files
>> >> > have valuable content and should not be easily discarded even if
>they
>> >> > are ignored or untracked.
>> >> >
>> >> > So far there are one part of Git that are made aware of precious
>> >> > files: "git clean" will leave precious files alone.
>> >>
>> >> Thanks for bringing this up again. There were also some patches
>recently
>> >> to save away clobbered files, do you/anyone else have any end goal
>in
>> >> mind here that combines this & that, or some other thing I may not
>have
>> >> kept up with?
>> >
>> > I assume you mean the clobbering untracked files by merge/checkout.
>> > Those files will be backed up [1] if backup-log is implemented.
>Even
>> > files deleted by "git clean" could be saved but that might go a
>little
>> > too far.
>>
>> I agree with Ævar that it is a very good idea to ask what the
>> endgame should look like.  I would have expected that, with an
>> introduction of new "ignored but unexpendable" class of file
>> (i.e. "precious" here), operations such as merge and checkout will
>> be updated to keep them in situations where we would remove "ignored
>> and expendable" files (i.e. "ignored").  And it is perfectly OK if
>> the very first introduction of the "precious" support begins only
>> with a single operation, such as "clean", as long as the end-goal is
>> clear.
>
>I think the sticking point is how to deal with the surprise factor and
>"precious" will not help at all in this aspect. In my mind there are
>three classes
>
> - total expectation, i know i want git to not touch some files, i
>tell git so (e.g. with "precious")
>
> - surprises sometimes, but in known classes. This is the main use
>case of backup log, where I may accidentally do "git commit
>-amsomething" after carefully preparing the index. Saving overwritten
>files by merge/checkout could be done here as an alternative to
>"garbage" attribute.
>
>> I personally do not believe in "backup log"; if we can screw up and
>> can fail to stop an operation that must avoid losing info, then we
>> can screw up the same way and fail to design and implement "backup"
>> to save info before an operation loses it.  If we do a good job in
>> supporting "precious" in various operations, we can rely less on
>> "backup log" and still be safe ;-)
>
>and this is the third class, something completely unexpected. Yes
>backup-log can't help here, but I don't think "precious" can either.
>And I have no good proposal for this case.

Sorry for going off on a tangent here, but I have had this on my mind for a long time. For cases where merge can lead to loss of a non-ignored untracked file (t7607-merge-overwrite.sh), I have the following proposal:

1. Merge the ORIG_HEAD and MERGE_HEAD commits without touching the index or the work tree. This is where we do rename detection, recursive merge, and content (line-by-line) merge. The result is CHECKOUT_HEAD, a tree with possible merge conflicts. For the switch branch operation CHECKOUT_HEAD is the tree to switch to. The remaining steps are the same for merge and switch branch operations.
2. Merge CHECKOUT_HEAD and the index with ORIG_HEAD as the merge base. The result is the CHECKOUT_INDEX. Do this in order to keep staged changes which are not affected by the merge. Do not do rename detection or content merge. In case of conflict, rollback and error out.
3. Merge CHECKOUT_INDEX with the work tree with the original index as merge base. Do this to simulate the work tree update. Dp not do remame detection or content merge. A conflict means that the checkout operation would touch untracked files or files with unstaged changes. In case of such a conflict, rollback and error out.

I believe this algorithm would behave much like the current implementation. But it separates the rename/history/content aspects of the merge algorithm from the checkout operation. It greatly simplifies the implementation of the checkout operation and there are no special cases where we lose files. Implementing step 1 is the tricky part. But it may still be worthwhile because the merge algorithm does not have to worry about staged changes or unstaged changes. The merge algorithm could work on the hierarchical tree structure instead of the flattened index. This makes it trivial to detect directory/file conflicts (no need to do a lookahead when iterating index files). This is also a better fit for detecting directory renames. Maybe this will allow us to focus more on rename detection, such as directory renames or moved functions [*1*]. 

[*1*] Also: moved files where the original file is replaced with a wrapper for the moved file always fools rename detection because we don't detect renames for files which were not removed.
