Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC61C433E5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548672072D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgGMPPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:15:43 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:1200 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMPPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 11:15:43 -0400
X-Greylist: delayed 967 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 11:15:43 EDT
Received: from [178.112.81.104] (helo=isticktoit.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1juzvY-0004eg-SN; Mon, 13 Jul 2020 16:59:32 +0200
Date:   Mon, 13 Jul 2020 16:59:31 +0200
From:   Tobias Girstmair <tobi@isticktoit.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using
 PATH_INFO)
Message-ID: <20200713145931.GA1059578@isticktoit.net>
References: <20200711203947.23520-1-tobi@isticktoit.net>
 <20200712183329.3358-1-tobi@isticktoit.net>
 <xmqqmu44phym.fsf@gitster.c.googlers.com>
 <20200712230508.GA1000433@isticktoit.net>
 <xmqqa704owwz.fsf@gitster.c.googlers.com>
 <20200713092928.GA1003518@isticktoit.net>
 <xmqq1rlfpj8i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1rlfpj8i.fsf@gitster.c.googlers.com>
X-Df-Sender: dC5naXJzdG1haXJAaXN0aWNrdG9pdC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 07:44:45AM -0700, Junio C Hamano wrote:
>Any other cases that are
>affected by this, or is README the only one?
>

README.html is the only per-repository file, but gitweb has some 
(unset/nonexisting by default) config variables to include more HTML: 
$site_header, $site_footer, $home_text. These are described in 
'man 5 gitweb.conf' under "Changing gitweb's look". grepping for 
'insert_file' reveals them in the code.

	tobias
