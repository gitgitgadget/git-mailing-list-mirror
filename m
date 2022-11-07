Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4319C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 00:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKGAmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGAmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 19:42:15 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE9BE0E
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 16:42:15 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EA8D1C2F5B;
        Sun,  6 Nov 2022 19:42:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=VpOF+pVaYfK/9DJporLB0kN30vmA3WpVV/6G2Yk
        DR1s=; b=YIWRwKlbCkz8Ux2saTPmxcuBkmnFBCTNt6jmy9AyNG2CXDGCYjcPFw2
        nP+bR97G7NWxdcHgAIw5wCZMvYWmZRvPh1VBZphcDx6lfDjuvOwArqrsEkiZ8oav
        SAljKTZVP9Vdaq3lBlN4z7Io+h05MieFFo05gti7iGR7S5IR08NE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0915C1C2F5A;
        Sun,  6 Nov 2022 19:42:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4EBC31C2F59;
        Sun,  6 Nov 2022 19:42:09 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sun, 6 Nov 2022 19:42:06 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de
Subject: Re: git can not be built for s390x since update to git-2.38.0
Message-ID: <Y2hUXlnKX9QAMjNV@pobox.com>
References: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
 <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
X-Pobox-Relay-ID: 031169FA-5E35-11ED-AFD5-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sarah Julia Kriesch wrote:
> I have seen, that Fedora is excluding many tests additionnally for s390x.

FWIW, those tests are only excluded when building on RHEL-8,
where they fail.  The same tests work fine on Fedora and
RHEL-9, so I have presumed that the issue is due to some
quirk(s) in RHEL-8 on s390x.

The Fedora git package supports building for RHEL largely as
a convenience.  I've got no vested interest in s390x, so I
disabled the tests on that OS/hardware combination rather
than trying to get access to it in order to debug.  :)

-- 
Todd
