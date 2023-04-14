Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E1C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 15:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDNPu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNPuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 11:50:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37CCC02
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:50:28 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F1BFFF809;
        Fri, 14 Apr 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681487426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eI8lcNJ+DVrBzT0SB8lWRkc4y8WcgehdbPSgVdGb6qY=;
        b=aBtWDbIngvBnc3Pef4YHlAzHLYxMveostwO/ehMYpbS2xQOk6wRnoHK2Az+w72Qi5F7OvX
        uNi1DFZlAd/eOjRtCY2ftwjpId9iIDpUH1sRF2N6Cr1sKK4IuN9NHARrjKwQqr85VjVQQ0
        jd/JOCSw1py0PU/6EFyUPcfL3W1cUuxWOo2ntfHKt8p9AV0WXdVLFLuAQdoaxWVQYkKxUt
        DQ3BbjhC51wFnktNk4DHw2qouSbFNZ62pypysEn7nDPEIDy6+cLEDLa8zTYvK9LKxu8yPL
        /xHQFwpYAVdzVUd+T9+l3T0cpZ1WhWPMludvlpmS432KBo2zkCJZJp699/E4cw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Apr 2023 17:50:23 +0200
Message-Id: <CRWLJMJDT7JY.1XITLUSCD39O@ringo>
Cc:     "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v4] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-155-ga46e3b9c027e
References: <20230412214502.90174-1-robin@jarry.cc>
 <20230414152843.659667-1-robin@jarry.cc>
In-Reply-To: <20230414152843.659667-1-robin@jarry.cc>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry, Apr 14, 2023 at 17:28:
> +	git config --replace-all sendemail.validateWorktree "$worktree" &&
> +else

Damn, I removed one echo line before sending and didn't test again...
Sorry for the brain fart. I'll send a v5.
