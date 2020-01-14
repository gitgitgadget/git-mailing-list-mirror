Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9253C33CB3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1CC222C4
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 13:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgANNVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:21:36 -0500
Received: from fallback-relay4-2.ilait.eu ([195.201.62.118]:51168 "EHLO
        fallback-relay4-2.ilait.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgANNVg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Jan 2020 08:21:36 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 08:21:34 EST
Received: from smtp1-1.ilait.se (smtp1-1.ilait.se [82.99.18.58])
        by fallback-relay4-2.ilait.eu (Postfix) with ESMTPS id 47xrTH0jrDz1qs5g
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 13:12:03 +0000 (UTC)
Received: from Queen-of-the-Damned.local (h-113-140.A444.priv.bahnhof.se [158.174.113.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: iwillneverusethis@tele2.se)
        by mail.tele2.se (Postfix) with ESMTPSA id 47xrTD0yqVz103D
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 13:11:59 +0000 (UTC)
To:     git@vger.kernel.org
From:   Kim NEVELSTEEN <kim@nevelsteen.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kim@nevelsteen.com; prefer-encrypt=mutual; keydata=
 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
 4sqmZvuEnHGp4VrtQsUFMbON
Subject: git apply and error
Message-ID: <c8efd09f-c0a4-57b5-db5c-6a13143ebac0@nevelsteen.com>
Date:   Tue, 14 Jan 2020 14:12:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git community.

I have noticed some irregular output with "git apply".

When including git in a bash script, I noticed that "git apply" does not report an error when
failing because it is in a git repository.

Example:
QotD:home$ cd src
QotD:home/src$ git apply --stat --apply patch
 patch |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

Again:
QotD:home$ git init
QotD:home$ cd src
QotD:home/src$ git apply --stat --apply patch
 0 files changed

The problem is not that it doesn't work, but that no error is reported.

QotD:mcp940$ git apply --stat --apply patch || echo "ERROR"
<<nothing printed here>>

Cheers!
-KiM

