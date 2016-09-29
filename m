Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAF5209B1
	for <e@80x24.org>; Thu, 29 Sep 2016 06:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbcI2GeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 02:34:20 -0400
Received: from mout.web.de ([217.72.192.78]:60617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754810AbcI2GeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 02:34:12 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M413W-1azBRY0UYE-00rW3G; Thu, 29 Sep 2016 08:33:54
 +0200
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-11-larsxschneider@gmail.com>
 <20160910062919.GB11001@tb-raspi>
 <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
 <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de>
 <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
 <5E675A29-628F-4076-A5D9-E359CCF04295@gmail.com>
 <xmqq37l1nd42.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <30461d2d-5a9c-4b0c-25a0-aa3327622764@web.de>
Date:   Thu, 29 Sep 2016 08:33:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq37l1nd42.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:a1lCuCW/I0mDc78MhMKxWoHvqwuoZm+B0uJ9ZcK3vwMiYOQRbsB
 gHXW4bI2lPfwQSVyyrVYoxevWJvRiHazKuH3l79eQp0l5WJ+qpEkxjO/0tooORK6bZUEEXl
 uKLtpq2KFonEZcn8VTdjCnsD0phibjFvaDCeN7YDuwpXeXxoDrFNa4urTit7f/Q64mjj1SF
 SDTj0X0gKbnZu4vNHS6Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ybQKDloTaG0=:nlrJySIOr8qTkNPxAHL/J4
 JC20xllLxKsNQZnhgJiLTwWXnDbF6egQAdDe1iFKCW7mNa51ODBwbZUcw2Awji7Bfl8Au3HCr
 1sLxBVQE3bOF4kOXaj4IH/bogJkG32wX484QB92ARkKuGtSvH6Brh5SaTPluvDxyCUo5T1yIt
 /r4S4seUeNEx34AKGJMTtmnNjGYORK5WZyhc03uBGYS48apCgviqlDzBOzEiUtpb0ye7Pi6U5
 pLzyVZU2kBeOLQSs81GHEijp18Y/p4MhMyL2hEajdcWmMiLrFkzUL1vVINkqQJTRLriaMOmMT
 oK5N0047jJ6ArX+m756WscRE4CflJwNTi99mkGy47nYRi1Y7OSEbOfB5L0n2E2O1ExBN97vFe
 gxnUNcBpd0HUAn5oi6waZHKHiw+WxoTGJbkdID/wjddQWZP6wZtRBozC49kLRExcyMRHnylr0
 r05OSBIz/QFagbONjj60gCmvUJtVOjRZOIldzAkdkdvj3tNLhyHiGIefHqGudZW4UwE+gD54w
 wzY5qSMwPFzsr1SyG2XIqs7keKscAPv0pcglWF33cYgSVs3oPrMYY6GiUqt5XbLbljN1TVVEg
 zUyZE6o3RuHqmEKlPKFxfR2Hedi91IKrPxwmvKrKZYs54v9PoJiYB1sLGpeu/0BKPN6p3F2Rq
 ZrGXqykNb8XYME9SpzAEjsn+EGPPNQTsS+6NXvtf9iytScdgMnaIcW2yKLTQ2sT20e44wTohL
 mbVRfp16Vx3HYV9alisYmPgyeD6EY7ghnYMBfCCQyGXSD9szGYU7JaiZ2mPOOLWYeo54AjHVe
 3PDTBvr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.09.16 22:04, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Wouldn't that complicate the pathname parsing on the filter side?
>> Can't we just define in our filter protocol documentation that our 
>> "pathname" packet _always_ has a trailing "\n"? That would mean the 
>> receiver would know a packet "pathname=ABC\n\n" encodes the path
>> "ABC\n" [1].
> 
> That's fine, too.  If you declare that pathname over the protocol is
> a binary thing, you can also define that the packet does not have
> the terminating \n, i.e. the example encodes the path "ABC\n\n",
> which is also OK ;-)
> 
> As long as the rule is clearly documented, easy for filter
> implementors to follow it, and hard for them to get it wrong, I'd be
> perfectly happy.
>

(Sorry for the late reply)

In V8 the additional "\n" is clearly documented.

On the long run,
I would suggest to be more clear what BINARY is:

--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -61,6 +61,9 @@ the length's hexadecimal representation.
 A pkt-line MAY contain binary data, so implementors MUST ensure
 pkt-line parsing/formatting routines are 8-bit clean.
 
+Each pkt-line that may contain ASCII control characters should
+be treated as binary.
+

