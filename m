From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 12:02:45 -0400
Message-ID: <CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
	<20160509083323.GB14299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:20:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azndz-0004PS-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbcEIQCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:02:47 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33236 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcEIQCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:02:46 -0400
Received: by mail-io0-f169.google.com with SMTP id f89so176585854ioi.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=788ovWyNOzryCdyCazhWIC8y+M4Hkb7iv3elKI1fNqI=;
        b=Qg4Eh6ktD1pFa2haN2siRI4UUR0xfmZrQhcGjlZp5FOhed3Q15jZr8j3ei3s0Jp4mt
         ltioUC5nq9bXyFZJx04k8kHYOkIwBKQfl//rSR5S7R3OXNZeNspR+qGVpaIPdgd7xHxO
         u5QMlY8SwUCSiJKc4Z3blm16NCrSrmf2nUHVtsBCwzvfeWAhhPNSOpG3EBG2vQ9VdSXd
         UAx1BxgfnSU1g3mKckvdFQUaOB9GBFJ452C2fOEdhXgwM6AmHHOXRrkGKZ15IEUynGCK
         QywWSo5RpzxEvQJVqiBcN/PRDg/5hGJMvpyab7kmq7wbnG9qvlUbbkyvGW1bDo7twpoN
         HQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=788ovWyNOzryCdyCazhWIC8y+M4Hkb7iv3elKI1fNqI=;
        b=VeYqAcKdFDF1IOHU1LUGuvUzQeIIZXZDUZKFN/fgeI5rTjyC+SNEQdP8AIWu8rGS/t
         mA0OJomoBma9nB7QKvdXtlmsE1aGwA9G5f65wUOIQL6whHIpcHaTG7PsqjVVbLJL7Rvn
         lVQ/fJ/22y2vQFX29RhbsKktjtWi3cezRQTQ55JE0MN36X5niXTF78VOXU/fJkN2mG+e
         4IAgTJgDnjx3kDAepC+z9Jc4TaHissCufuD8ryJfn1fn+R4Ye2wI6BQsqoGoBIf3+9l5
         K2LAlddTMaRDLZ9uOOMvuSxICuAZ3emkTD3ayiBUvo0zaUbPCOMvCLh3U9F6r6slpSe8
         obSA==
X-Gm-Message-State: AOPr4FWlsHkrqZOJ8XL1gAsCdC1gJISUFMxFpkXcypjJ0crFp0pH2PTqtk2roS31WYuhpPhQtoo8+IsyrmMKog==
X-Received: by 10.107.132.66 with SMTP id g63mr41333312iod.34.1462809765911;
 Mon, 09 May 2016 09:02:45 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 09:02:45 -0700 (PDT)
In-Reply-To: <20160509083323.GB14299@sigill.intra.peff.net>
X-Google-Sender-Auth: l_UZqNm1gcv-ptnci_zxRoKbbMc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294006>

On Mon, May 9, 2016 at 4:33 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2016 at 08:30:51AM +0200, demerphq wrote:
>> > -       perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
>> > +       test_seq_counter__=$1
>> > +       while test "$test_seq_counter__" -le $2
>> > +       do
>> > +               echo "$test_seq_counter__"
>> > +               test_seq_counter__=$((test_seq_counter__ + 1))
>> > +       done
>> >  }
>>
>> Is that perl snippet ever called with non-numeric output?
>>
>> perl -le 'print for $ARGV[0]..$ARGV[1]' -- A E
>> A
>> B
>> C
>> D
>> E
>
> I had that thought, too, but I think it would be an error to do so.
> test_seq is supposed to be a replacement for "seq", which does not
> understand non-numeric sequences.

Although, the comment block just above test_seq() in
test-lib-functions.sh says otherwise:

    Print a sequence of numbers or letters in increasing order.  This
    is similar to GNU seq(1), but the latter might not be available
    everywhere (and does not do letters).  It may be used like:

    for i in $(test_seq 100)
    do
        for j in $(test_seq 10 20)
        do
            for k in $(test_seq a z)
            do
                echo $i-$j-$k
            done
        done
    done
