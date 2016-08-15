Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3BF1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbcHOOaW (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 10:30:22 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:36689 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932233AbcHOOaV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2016 10:30:21 -0400
Received: from smtp17.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
	by smtp17.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id E6870602B1;
	Mon, 15 Aug 2016 10:30:20 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A04D06020D;
	Mon, 15 Aug 2016 10:30:20 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Mon, 15 Aug 2016 10:30:20 -0400
Subject: Re: [PATCH v6 00/12] Update git revisions
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <5338959f-985f-d1b3-7287-eccde559d2c3@xiplink.com>
Date:	Mon, 15 Aug 2016 10:30:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812234522.7792-1-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 07:45 PM, Philip Oakley wrote:
> These are the quick fixes to Marc's comments to patches 5,6,11,
> and a consequential change to 12.
>
> Only the changed patches are included.

Looks good to me -- no further comments!

However, I still don't understand why git says 11/12 has "indent with 
spaces" problems.

		M.


> Philip Oakley (12):
>   doc: use 'symmetric difference' consistently
>   doc: revisions - name the left and right sides
>   doc: show the actual left, right, and boundary marks
>   doc: revisions: give headings for the two and three dot notations
>   doc: revisions: extra clarification of <rev>^! notation effects
>   doc: revisions: single vs multi-parent notation comparison
>   doc: gitrevisions - use 'reachable' in page description
>   doc: gitrevisions - clarify 'latter case' is revision walk
>   doc: revisions  - define `reachable`
>   doc: revisions - clarify reachability examples
>   doc: revisions: show revision expansion in examples
>   doc: revisions: sort examples and fix alignment of the unchanged
>
>  Documentation/gitk.txt             |   2 +-
>  Documentation/gitrevisions.txt     |   6 +-
>  Documentation/pretty-formats.txt   |   2 +-
>  Documentation/rev-list-options.txt |   4 +-
>  Documentation/revisions.txt        | 125 ++++++++++++++++++++++++-------------
>  5 files changed, 88 insertions(+), 51 deletions(-)
>
