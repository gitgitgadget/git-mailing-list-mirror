Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E131F404
	for <e@80x24.org>; Sun,  7 Jan 2018 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeAGU6H (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 15:58:07 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19077 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeAGU6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 15:58:06 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w07Kw4Ac037585
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 7 Jan 2018 15:58:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: Request for Assist on Limits for Tests
Date:   Sun, 7 Jan 2018 15:57:59 -0500
Message-ID: <000d01d387fa$36a65300$a3f2f900$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0013_01D387BF.3C981720";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFguiJRzSVx46hxZKF0vDcLiUu7Iw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I'm looking for a proper (i.e. not sneaky) way to detect the platform I am
on during testing so that some tests can be modified/skipped other than
using the standard set of dependencies. In particular, the maximum path on
current NonStop platforms is 8-bit 2048 bytes. It appears that there are
some tests - at least from my preliminary "guessing" - that are beyond that
limit once all of the path segments are put together. I would rather have
something in git that specifies a path size limit so nothing exceeds it, but
that may be wishing.

Thanks in advance,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



