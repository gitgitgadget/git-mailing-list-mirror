Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197F01F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbfJ1ORy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 28 Oct 2019 10:17:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55697 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfJ1ORx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:17:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x9SEHlBu085338
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Oct 2019 10:17:48 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <021601d58c32$4f632a10$ee297e30$@rogers.com> <20191028114850.GR4348@szeder.dev>
In-Reply-To: <20191028114850.GR4348@szeder.dev>
Subject: RE: [ANNOUNCE] Git v2.24.0-rc1 - Test Summary for NonStop
Date:   Mon, 28 Oct 2019 10:17:42 -0400
Message-ID: <026501d58d9a$7938e730$6baab590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLdihXENXoEOiqyyq50Po38ZKjU4AIJRwFIpU/WDyA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 28, 2019 7:49 AM, SZEDER Gábor wrote:
> On Sat, Oct 26, 2019 at 03:19:37PM -0400, randall.s.becker@rogers.com
> wrote:
> It may or may not be conincidental, but there happens to be 7 tests in t0500
> that use 'test-tool progress --total=<N>', which was affected by an
> endianness bug that got fixed in 2b6f6ea1bd (test-progress: fix test failures
> on big-endian systems, 2019-10-20).  It would be interesting to see whether
> t0500 failed before that fix as well.

Test output provided in a separate thread: https://public-inbox.org/git/026401d58d9a$2bbe7600$833b6200$@nexbridge.com/

Regards,
Randall

