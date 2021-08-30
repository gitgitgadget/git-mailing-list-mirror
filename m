Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DFC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A8760FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhH3RvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:51:19 -0400
Received: from sender-of-o51.zoho.in ([103.117.158.51]:2049 "EHLO
        sender-of-o51.zoho.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhH3RvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:51:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1630345820; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Ics8L0ceQ4PG2OTPs+xeW5GSWrYXjzHqHzGH+eVwPNmAbwcQ6aTVh53qmP2RuQ0MauWLCOWqkAaUzRGWBfVjScxhsGL27S0Ll/PqqOfHenDgNlZvn8LMIR0DM2tS5TQ6Fnw4AM3d+/zaUenAAMKEA8WOcGkHfOgQ0Reh9+J9ZEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1630345820; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Pp8Bqymb/pbrorRgMFleP9yB3o45of3eYOrxl7iNvQk=; 
        b=OdbgJ9k/Z9FTQoQgrcZ94LLTSv6rpS+sIkIzSIoN96XVcefwZIyDOIuNfLL91hgY1l47sSTZl82YjrEP0cXcOrj0YeOrDyo/VgfNLZyMeW6yRVqcVz9uS0IskebHRFB5alu3GwtlxAwNzCebHpE/1YkUX8y+H3u7sDrMCHdeONo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=pugzarecute.com;
        spf=pass  smtp.mailfrom=me@pugzarecute.com;
        dmarc=pass header.from=<me@pugzarecute.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1630345820;
        s=zmail; d=pugzarecute.com; i=me@pugzarecute.com;
        h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Pp8Bqymb/pbrorRgMFleP9yB3o45of3eYOrxl7iNvQk=;
        b=lD0+nZ0yth2c7E5/bMOaPuDH4fe6V71mWA7UhMlIOJFtbwl6HmBFilUuu08vUf8J
        d0Ox1e4FeWT8hG9WYZyT3qKUl5rG+vumI19LXHAMkwYak+xU0BGJbiCMwBaNaPz0XXt
        RVMtUOkLCED7FtOu0zTFpj2V7hgapXAxrHvthjsw=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1630345818612839.733968541312; Mon, 30 Aug 2021 23:20:18 +0530 (IST)
Date:   Mon, 30 Aug 2021 23:20:18 +0530
From:   PugzAreCute <me@pugzarecute.com>
To:     "git" <git@vger.kernel.org>
Message-ID: <17b982ef1f2.b8f13d4136798.2688982303431691937@pugzarecute.com>
Subject: Bug with line endings on git.
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: High
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, 
I want to report a bug with git that causes "empty" commits if the line ending of a file is changed.

For example: https://github.com/PugzAreCute/RFOEC/commit/31f5189cac3e076252372d634708b875a364dece.patch (patch) / https://github.com/PugzAreCute/RFOEC/commit/31f5189cac3e076252372d634708b875a364dece (commit)

First seen by me on https://github.com/PugsMods/WoneWay/commit/fe58a091498eb5d891e351dba0273fd8e6d4d283 / https://github.com/PugsMods/WoneWay/commit/fe58a091498eb5d891e351dba0273fd8e6d4d283.patch


Happy to provide more info!

Thanks, 
PugzAreCute(Murali H.)



