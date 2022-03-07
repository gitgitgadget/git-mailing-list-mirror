Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD4C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 23:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiCGXfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCGXfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 18:35:33 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8D275C3
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 15:34:37 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nRMs7-0004T6-9K;
        Mon, 07 Mar 2022 23:34:36 +0000
Message-ID: <473ef11a-38d5-3bb1-6965-21050d90ae96@iee.email>
Date:   Mon, 7 Mar 2022 23:34:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] string-list API: change "nr" and "alloc" to
 "size_t"
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
 <patch-v2-2.2-6db8ab7a121-20220307T152316Z-avarab@gmail.com>
 <9c9ca557-122e-3bcb-db4b-3b5ba7bf9369@iee.email> <xmqqy21lqyrk.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqy21lqyrk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/03/2022 20:43, Junio C Hamano wrote:
> It would have been better if you culled the parts of the patch you
> are not referring to, by the way.
Oops sorry, I'm not that great at deciding which parts to keep/cull to
ensure sufficient context for other readers - it wasn't something that
was desired when I was working (too many 'Outlook' influences).

I'll work on it.

Philip
