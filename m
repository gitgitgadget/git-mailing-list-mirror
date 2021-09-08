Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA66C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872E61132
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351895AbhIHO1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:27:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46879 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351908AbhIHO1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 10:27:11 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 188EQ0kw003072
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Sep 2021 10:26:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Neeraj K. Singh'" <neerajsi@microsoft.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com> <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com> <xmqqmton7ehn.fsf@gitster.g> <20210908064958.GA29073@lst.de> <006d01d7a4b9$7cea64c0$76bf2e40$@nexbridge.com> <20210908141322.GA27146@lst.de>
In-Reply-To: <20210908141322.GA27146@lst.de>
Subject: RE: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
Date:   Wed, 8 Sep 2021 10:25:55 -0400
Message-ID: <007b01d7a4bd$72921730$57b64590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEuszLZPnOzWuI9JhEj5nYbH7e2rgGns2uvAVb0vKQCG+V6CgJYIiLUAsQ+7yQA9Po3dQJmrDc/rH9/pIA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 8, 2021 10:13 AM, Christoph Hellwig wrote:
>Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
>
>On Wed, Sep 08, 2021 at 09:57:34AM -0400, Randall S. Becker wrote:
>> possible. I know of at least 3 operating systems where that is a bad
>> plan, and if you did, you would take the test suite down while you were at it.
>
>I've just mentioned a good way to write a test for this feature on a specific platform.  This is absolutely no judgement if that is
a good plan
>on other platforms.

Thank you for the clarification. I do appreciate it.
-Randall

