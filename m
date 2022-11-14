Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF85C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiKNXIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiKNXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:08:01 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C951DA67
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:05:14 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2AEN4m1s098795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Nov 2022 18:04:48 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Moss, Adam David'" <admoss1980@gmail.com>, <git@vger.kernel.org>
References: <CAMTDv-8kxu-vwtCgz-VGBhYEbUX8edXzyaQK4szg2bmMJLjF4g@mail.gmail.com> <Y3LFF9EFVlCn4Lt2@tapette.crustytoothpaste.net> <Y3LGYvgEsqPsAo0F@nand.local>
In-Reply-To: <Y3LGYvgEsqPsAo0F@nand.local>
Subject: RE: Annotated Tag Hooks?
Date:   Mon, 14 Nov 2022 18:04:43 -0500
Organization: Nexbridge Inc.
Message-ID: <013601d8f87d$7edc0ae0$7c9420a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIYGAv9mcMlFMX6d49z98y7fCn4SgKA9DnOAkqVvfytmm5P0A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 14, 2022 5:51 PM, Taylor Blau wrote:
>On Mon, Nov 14, 2022 at 10:45:43PM +0000, brian m. carlson wrote:
>> On 2022-11-12 at 11:10:38, Moss, Adam David wrote:
>> > Hello,
>> >
>> > Is there any way to use, or are there any plans to introduce, an
>> > equivalent of the `prepare-commit-msg`, `commit-msg`, and
>> > `post-commit` hooks but for `git tag` events?
>> >
>> > I would like to make use of `git interpet-trailers` to automate the
>> > inclusion of some additional information into the tag annotation in
>> > the same way we do with commit messages, but am struggling to come
>> > up with a nice solution at the moment.
>> >
>> > If there is a better approach I could use I'd welcome suggestions?
>> > Alternatively I'd be willing to help implement such a capability if
>> > anyone would be willing to mentor me through it?
>>
>> Without speaking for anyone else, I think such a feature would be
>> beneficial and I'd be happy to see it come in.  I'm not personally
>> able to mentor you on this, because I have limited time to work on
>> Git, but perhaps someone else on the list would come along and be
>> happy to walk you through it.
>>
>> I _would_ be fine with being put on a CC for the patches to provide a
>> review, however.
>
>Ditto for both ;-).

This feature is of interest to my community as well. Please CC me also.
-Randall

