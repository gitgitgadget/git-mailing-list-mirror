Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21529C56201
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B066B20723
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sOBD6U4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbgJ0AFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:05:53 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:24485 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437723AbgJ0AEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 20:04:44 -0400
X-Greylist: delayed 8267 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 20:04:43 EDT
Date:   Tue, 27 Oct 2020 00:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603757081;
        bh=sR4ODi3LUSEmhv73E2NcGBCcBKdDSKHmZHrDgdxsLxY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sOBD6U4O4karXlD51HlYRmed+LwmGNVfs5VqyHvDquGGpDGvArX2df6Z9hL5ui2oA
         9wP3cHi9WdAvxoyCR1dAWOdZxDQwSBwvGRU2YBSZQyqy9EQ96XsQz3e2RpCfLr7tO4
         r07CjHrkbfyvcopzuvPVps87Jq24bmP5/uB4K9rU=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com>
In-Reply-To: <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <20201026205028.GC2645313@google.com> <xmqqwnzcd6jf.fsf@gitster.c.googlers.com> <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com> <20201026220228.GD2645313@google.com> <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Monday, October 26, 2020 5:00 PM, Joey Salazar <jgsal@protonmail.com> wr=
ote:

> For instances when `${if_local_config}` is either '' or '! ' then
> `test_path_is_file` will diagnose the directory and print a message if
> and only if the result `is false` goes away.
>
If `if test -n '$pager_wanted'` is checking if pager_wanted=3Dtrue before d=
iagnosing core.pager_used, then would;

For other instances when '$pager_wanted' is not empty then `test_path_is_fi=
le`
will diagnose the directory and print a message.

be more accurate?




