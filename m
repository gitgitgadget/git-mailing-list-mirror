Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9116CC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7335B20663
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCSNwh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 Mar 2020 09:52:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31594 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCSNwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 09:52:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02JDqWuA040900
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Mar 2020 09:52:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqa74fj30p.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa74fj30p.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.26.0-rc2
Date:   Thu, 19 Mar 2020 09:52:25 -0400
Message-ID: <01a001d5fdf5$a2b1e500$e815af00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEnKMGmZDWHFe/6HYVfdEyQONYgFamtmUug
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 16, 2020 7:26 PM, Junio C Hamano:
> A release candidate Git v2.26.0-rc2 is now available for testing at the usual
> places.  It is comprised of 463 non-merge commits since v2.25.0, contributed
> by 48 people, 10 of which are new faces.

Test results from the NonStop build:

Everything looks good. t9001 and t9020 fail as usual because they should really not be run on the platform.

Thanks for all of your hard work.
Regards,
Randall


