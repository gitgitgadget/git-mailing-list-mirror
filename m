Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB289C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 12:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiFWMzV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 23 Jun 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiFWMzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 08:55:18 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926E48E52
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 05:55:14 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25NCtAEH057338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Jun 2022 08:55:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
Subject: v2.37.0-rc2 - Additional Breakages on NonStop x86 (was RE: [ANNOUNCE] Git v2.37.0-rc2)
Date:   Thu, 23 Jun 2022 08:55:05 -0400
Organization: Nexbridge Inc.
Message-ID: <002401d88700$7908f6d0$6b1ae470$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdiHAFVNfsjxeOBrRBKaO8kifH0rew==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 22, 2022 3:32 PM, Junio C Hamano wrote:
>A release candidate Git v2.37.0-rc2 is now available for testing at the usual places.
>It is comprised of 378 non-merge commits since v2.36.0, contributed by 64 people,
>19 of which are new faces [*].

RC2 had numerous new test failures on NonStop that were not present in RC1, RC0, or prior git releases, ignoring the @2 problem previously reported. Failures are:

t5516.113
t5601.8
t7031.3, 11
t7421 (all subtests)
t7500.46-50
t7528.4,5,8,15,16,20

This does require additional investigation as to what is happening, but as it stands, I do not think we can add this to our official package set.

I am sorry,
Randall

