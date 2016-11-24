Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2571FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 16:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbcKXQbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 11:31:42 -0500
Received: from smtp106.iad3a.emailsrvr.com ([173.203.187.106]:57916 "EHLO
        smtp106.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751095AbcKXQbl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Nov 2016 11:31:41 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2016 11:31:41 EST
Received: from smtp14.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp14.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E686E2541F;
        Thu, 24 Nov 2016 11:25:02 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C9A06253F9;
        Thu, 24 Nov 2016 11:25:02 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 24 Nov 2016 11:25:02 -0500
Subject: Re: [ANNOUNCE] Git v2.11.0-rc3
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <836824f5-79e5-fbbf-dfe0-78cc19af1fb2@xiplink.com>
Date:   Thu, 24 Nov 2016 11:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-11-23 06:21 PM, Junio C Hamano wrote:
>
>  * The original command line syntax for "git merge", which was "git
>    merge <msg> HEAD <parent>...", has been deprecated for quite some
>    time, and "git gui" was the last in-tree user of the syntax.  This
>    is finally fixed, so that we can move forward with the deprecation.

Is this still true, given j6t's recent patch at

http://public-inbox.org/git/e61cc267-a59b-3be1-29db-c49d56f521f7@kdbg.org/T/

?

		M.

