Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA7C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 08:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiCMIDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiCMIDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 04:03:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFED3CFFF
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 00:02:31 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 993FF168EFC;
        Sun, 13 Mar 2022 04:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jbXIRtwk9cVB+vd1ArRDZlSttMZmVVtGlSNnSD
        IWj0U=; b=ycWlfbqK7hdBUa4+GwixSubCCIHEt5Z5DXOYO9vgFsJqF6n4BXeGi5
        5iQXlRFOc8WEo8NVj7AhuaUI7gRLNw1+Oe1He59vtJX21miZJD2LBX6+WgMp0mGN
        zV6Zi3Z9GuwjOXUDdkRsuxIJo5yhpNwll363XdT36QQOlCe05EnGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92E49168EFB;
        Sun, 13 Mar 2022 04:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16BEF168EF9;
        Sun, 13 Mar 2022 04:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/16] Builtin FSMonitor Part 2.5
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
Date:   Sun, 13 Mar 2022 08:02:27 +0000
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com> (Jeff Hostetler
        via GitGitGadget's message of "Fri, 11 Mar 2022 21:14:47 +0000")
Message-ID: <xmqq35jmwa98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECFDFEA0-A2A3-11EC-B418-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I'm calling this series part 2.5. It should be inserted between parts 2 and
> 3. I'll send a new version of part 3 after I send part 2.5.
>
> This series is a bunch of "fixup!" commits for part 2. It addresses feedback
> on part 2 that wasn't received until after part 2 had graduated to "next".

Better late than never, but I am sensing that part 2 was
under-reviewed and we pushed it too hastily?

> I was originally planning to include them at the beginning of part 3, but
> since there are so many, I thought it would be easier to add a fixup series
> in the middle.

I think that is prudent.  Let's give part 3 (which ought to be more
interesting than part 2.5) a more solid ground to build upon, and to
prepare for that, let's first avoid repeating the mistake of merging
a series in an under-reviewed state to 'next'.

Will queue (but not tonight).

Thanks.

