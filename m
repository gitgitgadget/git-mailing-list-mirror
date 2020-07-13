Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501E8C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342A020758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 09:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGMJ3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:29:34 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:49201 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJ3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 05:29:34 -0400
Received: from [178.112.81.104] (helo=isticktoit.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1juum9-00069u-Lb; Mon, 13 Jul 2020 11:29:29 +0200
Date:   Mon, 13 Jul 2020 11:29:28 +0200
From:   Tobias Girstmair <tobi@isticktoit.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using
 PATH_INFO)
Message-ID: <20200713092928.GA1003518@isticktoit.net>
References: <20200711203947.23520-1-tobi@isticktoit.net>
 <20200712183329.3358-1-tobi@isticktoit.net>
 <xmqqmu44phym.fsf@gitster.c.googlers.com>
 <20200712230508.GA1000433@isticktoit.net>
 <xmqqa704owwz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa704owwz.fsf@gitster.c.googlers.com>
X-Df-Sender: dC5naXJzdG1haXJAaXN0aWNrdG9pdC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 12, 2020 at 09:34:36PM -0700, Junio C Hamano wrote:
>And without this patch, the src URL needs to know where this
>repository appears in the site's URL namespace?

Exactly. Sorry if my lack of proper terminology made this confusing

>If that is the case, the change makes quite a lot of sense.
>
>Thanks.
>

	tobias
