Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987AC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391E621734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gufh8gDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgJHIkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHIkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:40:23 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Oct 2020 01:40:23 PDT
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D6C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 01:40:23 -0700 (PDT)
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 389D0940296
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 11:33:21 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2o.mail.yandex.net (mxback/Yandex) with ESMTP id QoxAWi74dn-XKYqpHt5;
        Thu, 08 Oct 2020 11:33:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602146000;
        bh=IknnKMYFab1IJgrCv1tLmI3cHRjjgonObLow+lU9GCg=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=gufh8gDS/PENYmDNlZJOMwyN7QyJIyr15hJp/8ZW10bWJoCTdrJ/9EQIuemE2myxj
         gENWHkNiQwDq0D2aMXGvQ6iAQtKwjHRABYVknSmQUD4I+h/57dltBibULNTVbet8n9
         QaM+US7OAwBUWlBBHvwCbmUOjjmuY5pwG55OVAK8=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-094cfe5c1616.qloud-c.yandex.net with HTTP;
        Thu, 08 Oct 2020 11:33:20 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <1468141592259947@mail.yandex.ru>
References: <1468141592259947@mail.yandex.ru>
Subject: Re: Job: implement visualization of intraline differences in git-gui
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 08 Oct 2020 11:33:20 +0300
Message-Id: <582641602145871@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



16.06.2020, 01:41, "Konstantin Tokarev" <annulen@yandex.ru>:
> Hello,
>
> I'd like to see [1] implemented, however maintainer of git-gui doesn't have
> a time to work on this feature. Is anyone here willing to take it?
>
> [1] https://github.com/prati0100/git-gui/issues/31

Bump. Payment is negotiable.

-- 
Regards,
Konstantin
