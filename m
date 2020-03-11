Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E4BC10F27
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37421D7E
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 13:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgCKNy0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Mar 2020 09:54:26 -0400
Received: from elephants.elehost.com ([216.66.27.132]:45888 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgCKNyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 09:54:25 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02BDsLvo035417
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 11 Mar 2020 09:54:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.26.0-rc1
Date:   Wed, 11 Mar 2020 09:54:13 -0400
Message-ID: <019401d5f7ac$8f5781d0$ae068570$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVv2rKC7Aj3IO8kDwcPkisFoWKjahD2USg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 10, 2020 10:57 AM, Junio C Hamano Wrote:
> To: git@vger.kernel.org
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
> packagers@googlegroups.com
> Subject: [ANNOUNCE] Git v2.26.0-rc1
> 
> A release candidate Git v2.26.0-rc1 is now available for testing at the usual
> places.  It is comprised of 453 non-merge commits since v2.25.0, contributed
> by 47 people, 10 of which are new faces.

For the NonStop platform, v2.26.0-rc1 passes regression except for t1091, for which I suggested a hack previously in 2.26.0-rc0. Other tests, t9001 and t9020 fail without surprise and need not be fixed on platform (no compatible sendmail or SVN).

Thanks all.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



