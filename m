Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AEBCA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjILH53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjILH5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:24 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210510F1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:57:13 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3E68824152;
        Tue, 12 Sep 2023 03:57:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qfyGl-2sd-00; Tue, 12 Sep 2023 09:57:11 +0200
Date:   Tue, 12 Sep 2023 09:57:11 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 02/32] doc hash-function-transition: Augment
 compatObjectFormat with readCompatMap
Message-ID: <ZQAZ19gyvt8ab7f6@ugly>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-2-ebiederm@xmission.com>
 <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
 <xmqqy1hdi6hp.fsf@gitster.g>
 <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>
 <87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 06:46:19PM -0500, Eric W. Biederman wrote:
>+The difference between compatObjectFormat and readCompatMap would be that
>+compatObjectFormat would ask git to read existing maps, but would not ask
>+git to write or create them.
> 
the argument makes sense, but the asymmetry in the naming bugs me. in 
particular "[read]compatMap" seems too non-descript.

regards
