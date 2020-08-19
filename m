Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC900C433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD502078D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSTXk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Aug 2020 15:23:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:65292 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHSTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:23:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07JJNTS7031047
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Aug 2020 15:23:30 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Lukas Straub'" <lukasstraub2@web.de>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>        <04aa01d67659$2dc217b0$89464710$@nexbridge.com> <xmqqimdetpuw.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimdetpuw.fsf@gitster.c.googlers.com>
Subject: RE: [RFC PATCH 0/2] Allow adding .git files and directories
Date:   Wed, 19 Aug 2020 15:23:24 -0400
Message-ID: <04c401d6765e$3868e450$a93aacf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJUwsi1t0kYcCu+MG1WzKjrMbhjgQKo5EueAejmVwAB/vjPsKgOsIAA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2020 3:09 PM, Junio C Hamano wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Lukas Straub' <lukasstraub2@web.de>; 'git' <git@vger.kernel.org>;
> 'Elijah Newren' <newren@gmail.com>; 'Brandon Williams'
> <bwilliams.eng@gmail.com>; 'Johannes Schindelin'
> <Johannes.Schindelin@gmx.de>; 'Jeff King' <peff@peff.net>
> Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > Just putting my CSIO hat on here. We would need a system-wide setting
> > to prohibit users from using this capability.
> 
> Or just discard this patch, which is a lot simpler.  I don't see any need for this
> one.

If I was a committer, that would be my take on it too. 😉

