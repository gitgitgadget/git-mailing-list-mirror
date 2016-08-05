Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8F62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936922AbcHEVUG (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:20:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55160 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764596AbcHEVUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:20:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CB22161370; Fri,  5 Aug 2016 21:20:01 +0000 (UTC)
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F0BB61365;
	Fri,  5 Aug 2016 21:20:01 +0000 (UTC)
From:	Martin Fick <mfick@codeaurora.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"Michael S. Tsirkin" <mst@redhat.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
Date:	Fri, 05 Aug 2016 15:20 -0600
Message-ID: <10752620.2J2dEZLIGc@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-105-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <20160804234920.GA27250@redhat.com> <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Friday, August 05, 2016 08:39:58 AM you wrote:
>  * A new topic, when you merge it to the "lit" branch, you
> describe the cover as the merge commit message.
> 
>  * When you updated an existing topic, you tell a tool
> like "rebase -i -p" to recreate "lit" branch on top of
> the mainline.  This would give you an opportunity to
> update the cover.

This is a neat idea.  How would this work if there is no 
merge commit (mainline hasn't moved)?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

