Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2EC20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 09:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdFFJvC (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 05:51:02 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59580 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751397AbdFFJvB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jun 2017 05:51:01 -0400
X-AuditID: 1207440d-7fdff70000001eab-c3-59367b032a7e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 90.18.07851.30B76395; Tue,  6 Jun 2017 05:50:59 -0400 (EDT)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com [209.85.214.41])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v569owtL013551
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 6 Jun 2017 05:50:59 -0400
Received: by mail-it0-f41.google.com with SMTP id m62so88020433itc.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 02:50:59 -0700 (PDT)
X-Gm-Message-State: AODbwcCHcT1IwvV8dWujGyVZJjOMyPTSEv3Q/Wb5hS1DNwkDdI43PXwL
        IxE4sz+4vne32VIoiTh3oqRy/4+lmw==
X-Received: by 10.36.208.196 with SMTP id m187mr2162453itg.84.1496742658452;
 Tue, 06 Jun 2017 02:50:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.48.212 with HTTP; Tue, 6 Jun 2017 02:50:57 -0700 (PDT)
In-Reply-To: <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 6 Jun 2017 11:50:57 +0200
X-Gmail-Original-Message-ID: <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
Message-ID: <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqMtcbRZpcPuwmUXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDK2vLjHVNAjXHH+9GXWBsaPfF2MnBwSAiYS289MYO1i5OIQEtjB
        JHHrdQczhPOQSaL/9S8WCKePUaLxyH0miJZ8iZefnrFC2CUSv+4dZQGxeQUEJU7OfAJmCwnI
        SbzacIOxi5EDyPaSuN/uAmJyCgRK9B02hKiol/jweiLYFDYBXYlFPc1g01kEVCT27FvIDjE9
        UeLZlelsENMDJFp2TGcEsYUF7CQ+rP8J1isioCYxc9VsNpAzmQWaGSWO3WoDSzALaEq0bv/N
        PoFReBaS62YhSS1gZFrFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERLEvDsY
        /6+TOcQowMGoxMPbEGUaKcSaWFZcmXuIUZKDSUmUtzbBLFKILyk/pTIjsTgjvqg0J7X4EKME
        B7OSCC/jXqBy3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEr3oV0FDB
        otT01Iq0zJwShDQTByfIcB6g4cqVQDW8xQWJucWZ6RD5U4yWHFeurPvCxNHRswFITjmw/QuT
        EEtefl6qlDjvUpAGAZCGjNI8uJmwpPSKURzoRWFeaZAqHmBCg5v6CmghE9BCvksmIAtLEhFS
        Ug2MjI/kLKTEJh26JPfj3PXG2rzYbIlJt5VXabzskfjoFOMh9Hl/2In5N0XmbBESFp79cNpJ
        ee2N7ZFKqlNOx61Q6oyJ6lLa93EPo3WM3NdrsdFJS52V816fuP9Yx/tV5fXiSaapN1Tik0U/
        8EZf2MF0ec8pmUkL7yy95MHyXZtjU470M2etyE3cSizFGYmGWsxFxYkAXWOF+CUDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
>
> > [...]
> >  "git diff" has been taught to optionally paint new lines that are
> >  the same as deleted lines elsewhere differently from genuinely new
> >  lines.
> >
> >  Are we happy with these changes?


I've been studiously ignoring this patch series due to lack of bandwidth.

> [...]
> Things to come, but not in this series as they are more advanced:
>
>     Discuss if a block/line needs a minimum requirement.
>
> When doing reviews with this series, a couple of lines such
> as "\t\t}" were marked as a moved, which is not wrong as they
> really occurred in the text with opposing sign.
> But it was annoying as it drew my attention to just closing
> braces, which IMO is not the point of code review.
>
> To solve this issue I had the idea of a "minimum requirement", e.g.
> * at least 3 consecutive lines or
> * at least one line with at least 3 non-ws characters or
> * compute the entropy of a given moved block and if it is too low, do
>   not mark it up.

Shooting from the hip here...

It seems obvious that for a line to be marked as moved, a minimum
requirement is that

1. The line appears as both "+" and "-".

That doesn't seem strong enough evidence though, and if that is the
only criterion, I would expect a lot of boilerplate lines like "\t\t}"
to be marked as moved. It seems like a lot of noise could be
eliminated by *also* requiring that

2a. The line doesn't appear elsewhere in the file(s) concerned.

Rule (2a) would probably get rid of most boilerplate lines without
having to try to measure entropy.

Maybe you are already using both criteria? I didn't see it in a quick
perusal of the code.

OTOH, it would be silly to refuse to mark lines like "\t\t}" as moved
*only* because they appear elsewhere in the file(s). If you did so,
you would have gaps of supposedly non-moved lines in the middle of
moved blocks. This suggests marking as moved lines matching (1) and
(2a) but also lines matching (1) and the following:

2b. The line is adjacent to to another line that is thought to have
moved from the same old location to the same new location.

Rule (2b) would be applied recursively, with the net effect being that
any line satisfying (1) and (2a) is allowed to carry along any
neighboring lines within the same "+"/"-" block even if they are not
unique.

Michael
