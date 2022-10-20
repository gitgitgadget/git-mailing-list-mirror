Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3067C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 19:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJTTkV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 20 Oct 2022 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJTTkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 15:40:17 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9D129097
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 12:40:15 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29KJe8IE031752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Oct 2022 15:40:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'Mat=C4=9Bj_Cepl'?=" <mcepl@cepl.eu>,
        <git@vger.kernel.org>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu> <Y1GJAart+/yFc5MR@coredump.intra.peff.net> <xmqqr0z2s7w4.fsf@gitster.g> <xmqqk04us77b.fsf@gitster.g> <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net> <20221020190117.va67kbrmvg4xxit5@meerkat.local>
In-Reply-To: <20221020190117.va67kbrmvg4xxit5@meerkat.local>
Subject: RE: git-send-email with GPG signed commits?
Date:   Thu, 20 Oct 2022 15:40:03 -0400
Organization: Nexbridge Inc.
Message-ID: <004901d8e4bb$c3338360$499a8a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIRzb+dllOXoYkOY8HC8P+aLK64fAJf9nrWAcqIiy0BM0EUqgK/xQyqAxm5nHStTCB6kA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 20, 2022 3:01 PM, Konstantin Ryabitsev wrote:
>On Thu, Oct 20, 2022 at 02:31:41PM -0400, Jeff King wrote:
>> Yes, like bundles, it is losing some of the flexibility of an
>> emailed-patch workflow. I haven't played with b4's attestation too
>> much, but I think it slots into a patch workflow better. You are
>> signing the patch, not the commit, and commits which are made later
>> can refer back to the emails, which people can then verify. That's not
>> a signature on the commit, but it is a paper trail that can be followed.
>
>That is accurate -- I've looked into attempting to preserve git commit signatures via
>sent patches, precisely so they could be applied back into the tree. However, the
>consensus among developers was that this is almost never useful, and since we
>were already providing a robust paper-trail framework in the form of public-inbox
>archives, it made sense to keep patch-level attestation and git-level attestation
>separate.

As I see it, if git commit signatures become a requirement (maybe resulting from supply chain discussions), then using existing capabilities may be the most practical alternative. This would involve submitting signed commits in pull request via GitHub instead of emailing patches. I know this is not a desirable position for the git team, but it is currently available technology. In a pinch, that could satisfy the requirement.
-Randall

