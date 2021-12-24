Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFAC433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 10:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352515AbhLXK7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 05:59:32 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:38437 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352511AbhLXK7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 05:59:32 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n0iIL-0005dl-Fk; Fri, 24 Dec 2021 10:59:30 +0000
Message-ID: <3c5ef210-8908-e96f-e201-a7d8e79985fb@iee.email>
Date:   Fri, 24 Dec 2021 10:59:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC] squelch log4j inquiries
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmtkq6frf.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqmtkq6frf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/12/2021 23:52, Junio C Hamano wrote:
> I wonder if we should do something like this, for limited time like
> a few months or so, so that we have something prominently shown at
> places like https://github.com/git/git/
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  README.md | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git c/README.md w/README.md
> index f6f43e78de..76e99fe5bb 100644
> --- c/README.md
> +++ w/README.md
> @@ -7,6 +7,9 @@ Git is a fast, scalable, distributed revision control system with an
>  unusually rich command set that provides both high-level operations
>  and full access to internals.
>  
> +No part of Git is written in Java, hence it is not susceptible to
> +the log4j vulnerability that has been causing sensation recently.
> +
>  Git is an Open Source project covered by the GNU General Public
>  License version 2 (some parts of it are under different licenses,
>  compatible with the GPLv2). It was originally written by Linus

Would it be worth adding a section to the SECURITY.md file that could
cover these 'non-issue' concerns. The README could point to the
non-issue section. Just a thought.

Philip
