Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B231BC43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 11:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiFGLtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiFGLtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 07:49:16 -0400
Received: from nmsh6.e.nsc.no (nmsh6.e.nsc.no [148.123.160.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39810F5
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 04:49:14 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh6.e.nsc.no (smtp.online.no) with ESMTPSA id 36B241D413D;
        Tue,  7 Jun 2022 13:49:11 +0200 (CEST)
Message-ID: <6c73ec69-5246-4386-4e20-b2ed852ec4ff@online.no>
Date:   Tue, 7 Jun 2022 13:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220604161333.54627-1-joak-pet@online.no>
 <20220604192606.176023-1-joak-pet@online.no> <xmqqzgipah7n.fsf@gitster.g>
 <592c0133-d6f3-3376-0fe7-3633f3a91377@online.no> <xmqqleu98za3.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqleu98za3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06/2022 19:41, Junio C Hamano wrote:
> Joakim Petersen <joak-pet@online.no> writes:
>> I'll add a clear statement of what this patch does as well.
> 
> I think you already have "Make the coloring of these ... consistent
> by making ..." much earlier, and moving it here would be sufficient.
> 

This comment made me realize there is some additional redundancy in the
message; I'll submit a v7 with a slightly clearer one, incorporating
your suggestion as well.
