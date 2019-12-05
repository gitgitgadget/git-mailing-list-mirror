Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DBC2D0BF
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39224249
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLESAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:00:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:32362 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfLESAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 13:00:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xB5I0M5W049263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Dec 2019 13:00:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Nathaniel Manista'" <nathaniel@google.com>, <git@vger.kernel.org>
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>        <047b01d5ab92$159a8240$40cf86c0$@nexbridge.com> <xmqqwobazmzp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwobazmzp.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ISSUE] Stop accessing, storing, and sharing the user's time zone
Date:   Thu, 5 Dec 2019 13:00:17 -0500
Message-ID: <048901d5ab95$dd6d43e0$9847cba0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGSZ87M+0b1HQfUDxVKMhYVkZ/1cgExrlvzAdtD5d2oGfP04A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 5, 2019 12:44 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > .... I currently am
> > running a repository located at UTC+2, with developers at UTC-5. It is
> > driving us a bit wonky. I would rather see only UTC.
> 
> If "seeing" is the primary reason (i.e. you want to compare times your
people
> worked on their commits), you can always do that on the display side (e.g.
> "git log --date=local").  It is not a good excuse to advocate for
information
> loss.
> 
> I also feel that TZ being PII is not particularly a brilliant argument
against
> recording TZ---of course it is PII, so are the committer e-mail address
and the
> committer name.  Those who want to hide can hide but in order to keep
> track of provenance who did what when, we do record them.
> 
> As you can guess from the above reasoning, I am not fundamentally opposed
> to introducing user.tz to complement existing user.name and user.email
> configuration variables.

I rather like this idea. I'm going to look into it when I'm in the
upside-down toward the end of the month.

Cheers,
Randall

