Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ACC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CB060FEA
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhGLWZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:25:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31853 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhGLWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:25:21 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16CMMSNk031938
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Jul 2021 18:22:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <003701d7741e$550b6510$ff222f30$@nexbridge.com> <xmqqk0m0brq1.fsf@gitster.g>
In-Reply-To: <xmqqk0m0brq1.fsf@gitster.g>
Subject: RE: [Question] worktree vs. gitdir in [includeIf]
Date:   Mon, 12 Jul 2021 18:22:22 -0400
Message-ID: <013601d7776c$65f901b0$31eb0510$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK3SQbvmkVoL9DL4YlGVMllr3mw1QEu7AHWqXbOlWA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 8, 2021 2:12 PM,  Junio C Hamano wrote:
>Subject: Re: [Question] worktree vs. gitdir in [includeIf]
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>> I am wondering whether there is, or are plans for, something analogous
>> to [includeIf "worktree:path"] with a similar semantic to [includeIf
>> "gitdir:path"].
>
>I do not think there currently is an implementation, nor a plan, but I offhand do not see downsides in a feature to let you
conditionally
>enable some configuration based on the location of the worktree.

I have a patch set available, but am having some issues convincing the combination of git, OpenSSL, and my ISP to talk to each
other. Specifically, I'm getting "ssl3_get_record:wrong version number", on every system I'm using. Probably an operator error. I
might have to manually post the patch files.

