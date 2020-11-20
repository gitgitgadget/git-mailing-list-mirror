Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1227DC56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAE022252
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 15:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgKTPkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:40:01 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:29787 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgKTPkB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 10:40:01 -0500
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2020 10:40:00 EST
Received: from [138.232.236.227] (helo=[172.25.205.98])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1kg8CS-0007nP-Gi; Fri, 20 Nov 2020 16:19:48 +0100
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using
 PATH_INFO)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200711203947.23520-1-tobi@isticktoit.net>
 <20200712183329.3358-1-tobi@isticktoit.net>
 <xmqqmu44phym.fsf@gitster.c.googlers.com>
 <20200712230508.GA1000433@isticktoit.net>
 <xmqqa704owwz.fsf@gitster.c.googlers.com>
From:   Tobias Girstmair <tobi@isticktoit.net>
Message-ID: <e1b06774-4449-06a2-8c0e-72eabf17b86c@isticktoit.net>
Date:   Fri, 20 Nov 2020 16:19:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa704owwz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: dC5naXJzdG1haXJAaXN0aWNrdG9pdC5uZXQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2020 06:34, Junio C Hamano wrote:
[...]
> And without this patch, the src URL needs to know where this
> repository appears in the site's URL namespace?
> 
> If that is the case, the change makes quite a lot of sense.

Hi, this patch probably fell through the cracks. Can it please be 
considered for merging again?

As a reminder, here's a link to the patch:
   https://lore.kernel.org/git/20200712183329.3358-1-tobi@isticktoit.net/

Thanks,
	tobias
