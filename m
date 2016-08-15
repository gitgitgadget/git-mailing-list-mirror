Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5006A1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcHORyF (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 13:54:05 -0400
Received: from smtp146.dfw.emailsrvr.com ([67.192.241.146]:53380 "EHLO
	smtp146.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbcHORyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 13:54:03 -0400
Received: from smtp19.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
	by smtp19.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id D5649402BC;
	Mon, 15 Aug 2016 13:54:02 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp19.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 893F5402B8;
	Mon, 15 Aug 2016 13:54:02 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Mon, 15 Aug 2016 13:54:02 -0400
Subject: Re: BUG: indent-with-non-tab always on
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
 <5338959f-985f-d1b3-7287-eccde559d2c3@xiplink.com>
 <8191B8FB581F44AAA7E2467A845C7532@PhilipOakley>
 <5eda6874-43c8-7383-bbb3-b482a388370d@xiplink.com>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <114095ef-e267-c9bb-c5fc-52bdb5598fe6@xiplink.com>
Date:	Mon, 15 Aug 2016 13:54:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5eda6874-43c8-7383-bbb3-b482a388370d@xiplink.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-15 12:55 PM, Marc Branchaud wrote:
> On 2016-08-15 11:00 AM, Philip Oakley wrote:
>> From: "Marc Branchaud" <marcnarc@xiplink.com>
>>> On 2016-08-12 07:45 PM, Philip Oakley wrote:
>>>> These are the quick fixes to Marc's comments to patches 5,6,11,
>>>> and a consequential change to 12.
>>>>
>>>> Only the changed patches are included.
>>>
>>> Looks good to me -- no further comments!
>>>
>>> However, I still don't understand why git says 11/12 has "indent with
>>> spaces" problems.
>>
>> I'm guessing it's that the text is monospaced rather than tabbed, and
>> it's flagging that.
>>
>> I'd noticed that it was highlighted in the Git gui (which I use to
>> visualise both the diff, the message and the part after the three dashes
>> at the same time).
>
> Actually, it looks like an indent-with-non-tab problem, which is
> supposed to be off by default.
>
> Git doesn't complain about the patch if I set
>     core.whitespace = tabwidth=11
> presumably because the patch uses 10 spaces to indent the offending lines.
>
> But explicitly disabling that check with
>     core.whitespace = -indent-with-non-tab
> doesn't work.
>
> Unfortunately, I don't have time today to track this down.

Gah, never mind -- didn't realize it was turned on in 
Documentation/.gitattributes.

		M.

