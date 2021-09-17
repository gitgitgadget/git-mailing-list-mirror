Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51294C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FD5611C4
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbhIQRAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:00:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54786 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237058AbhIQRAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 13:00:21 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mRHCS-000Byw-Fm; Fri, 17 Sep 2021 17:58:57 +0100
Subject: Re: diff-index --cc no longer permitted, gitk is now broken
 (slightly)
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
 <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
 <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
 <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
 <xmqqzgscqgmv.fsf@gitster.g> <87bl4rk7bh.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <61ffe5ee-dcc9-4308-7ced-430c3891e898@iee.email>
Date:   Fri, 17 Sep 2021 17:58:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87bl4rk7bh.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/2021 08:08, Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?
>>>
>>> My only point here is that usage of *--cc* in *diff-index* is entirely
>>> undocumneted, and that needs to be somehow resolved.
>> It was a response to your "historical status quo that is a problem."
>> I do not think there is any problem with "diff-index --cc" (except
>> for it wants a better documentation---but that we already agree) but
> Ah, now I see, but it's exactly lack of documentation (and tests) that I
> was referring to as the "problem of the historical status quo" on the
> Git side, so I was somewhat confused by your original response.
>
> Also, it's still unclear, even if not very essential, what exactly that
> "status quo" is when seen from the point of view of gitk. Does gitk
> actually utilize *particular output* of "diff-index --cc" for better, or
> gitk would be just as happy if it were synonym for "diff-index -p", or
> even if it'd be just as happy if --cc were silently consumed by
> diff-index?

Did Johannes Sixt's earlier answer
https://lore.kernel.org/git/cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org/
help clarify the choices?
>> I wanted to give you some credit for having worked on "--diff-merges",
>> an effort to generalize things in a related area.
> Thanks for that! More to follow )
>
> Thanks,
> -- Sergey Organov

