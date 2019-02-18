Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EE91F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfBRUYs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:24:48 -0500
Received: from p3plsmtpa07-03.prod.phx3.secureserver.net ([173.201.192.232]:42372
        "EHLO p3plsmtpa07-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727682AbfBRUYs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 15:24:48 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id vpSygnepphQaCvpT4g47zy; Mon, 18 Feb 2019 13:24:48 -0700
Date:   Mon, 18 Feb 2019 22:24:40 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Max Kirillov' <max@max630.net>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Message-ID: <20190218202440.GA3373@jessie.local>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
 <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
 <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
 <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfGDNovhFmWVclcmGXYHA3ohUDs5KIkxZ6AhDP81GDJ0S+7+uCKcgZKwvRhp53nATBwq8AsdMPNQyE8Ff51Wp+nDO/+smeQS1qgGrFiY+JZKs8E5Z6jYB
 EhSXN82pya0s6CC1UbrYPxSfC4b8SXw0bxdsZBot8Kr2vaOp4t2qH1ItK4VYS60oi8G8kt+BZmRWrdBoNs15cV9Q924mi14xfYh1PmQsX0eIV7T/9J9O8BOl
 sN2Miv+H+Eq+rp7FnpqZBKBoTSZghQHIVl/G7C+t4aAXFhSGidudWt/7AZH7IkcMC22UA6vWG4ykZuGDR9sFzhegZfvoJDgPkmVCiR9XNnw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 16, 2019 at 10:57:52AM -0800, Junio C Hamano wrote:
> I'm inclined to
> 
>  - keep b46221ff in 'master', not reverted.

from the branch, cc95bc2025 "t5562: replace /dev/zero with a
pipe from generate_zero_bytes" could be replaced with [1]
"t5562: do not depend on /dev/zero", for simplicity. I
cannot however test the issue as I have no access to the
platform in question. As far as I understand, both should
work.

[1] https://public-inbox.org/git/20190215164237.12250-1-max@max630.net/
