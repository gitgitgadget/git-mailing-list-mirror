Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FB51FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbdFMPzc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 11:55:32 -0400
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:59584 "EHLO
        smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753428AbdFMPzb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 11:55:31 -0400
Received: from smtp37.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp37.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id CDB0E6490;
        Tue, 13 Jun 2017 11:55:29 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp37.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8BDE16286;
        Tue, 13 Jun 2017 11:55:29 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 13 Jun 2017 11:55:29 -0400
Subject: Re: proposal for how to share other refs as part of refs/tracking/*
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
References: <CA+P7+xrMX+gxQrsB9kcy3RkDL=eDXb_TQ-V+2vH+ir0Sbef8Xg@mail.gmail.com>
 <48064f67-6d88-8c14-853e-fd9214d26647@xiplink.com>
Message-ID: <010f8a1b-cab3-fada-0f38-1f0726283f5e@xiplink.com>
Date:   Tue, 13 Jun 2017 11:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <48064f67-6d88-8c14-853e-fd9214d26647@xiplink.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-06-13 10:41 AM, Marc Branchaud wrote:
> 
> So I like your refs/tracking proposal, and hope that it aims for 
> mirroring a remote's refs, to eventually replace refs/remotes entirely.

To be extra-clear:

I think a refs/tracking hierarchy that starts with notes and maybe some 
other bits is a good first step.

I *hope* such a first step can eventually mirror all of a remote's refs, 
including heads and tags.

I in no way think that this effort should begin by tackling heads and tags.

		M.

