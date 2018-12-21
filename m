Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6151F405
	for <e@80x24.org>; Fri, 21 Dec 2018 09:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLUJA4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 04:00:56 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:39576 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbeLUJA4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Dec 2018 04:00:56 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 04:00:55 EST
Received: from mxback8g.mail.yandex.net (mxback8g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:169])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 5289E66816E4
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 11:54:23 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback8g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6gT5JCiRpo-sNXmwp1N;
        Fri, 21 Dec 2018 11:54:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1545382463;
        bh=yb9zJ11oaxUy7As0syz20S5tvtN4Nmn9n+q7lDx1QxM=;
        h=From:Subject:Message-Id:Date:To;
        b=GQ73KmbLWlqUijvkyKFHKXyPIz6RLUzXjHDpI+GcdSAJNtA2+I6OypnrA0mi/ub1V
         qEeb/dqgDaNaVneKVJe+6Y2vK3n0XiB8nn5v6CARTUCbEZ9ZzWTzp7VEnMSNHtNMSx
         XMb24WjIghYXLwei3W2y3O8Q57DpCdTjlO5RYCcQ=
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id sedilDKxq2-sM9Saa8Y;
        Fri, 21 Dec 2018 11:54:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1545382462;
        bh=yb9zJ11oaxUy7As0syz20S5tvtN4Nmn9n+q7lDx1QxM=;
        h=From:Subject:Message-Id:Date:To;
        b=AxqYiRblWsMiIqeToyvNEOHjmWZNbJyjdsHN4t9MexGOlV8LNx1Syj7dLaamffXBL
         qpLpYoEk9PHT7scOowhGeJ1IqI7Volfh/W56ciyHqFdQCqtEGJLBqhC1f29mejndmj
         +P69prn5MslO37q/pO3Qam2G8IGsuTSlzkw1NBiY=
Authentication-Results: smtp4p.mail.yandex.net; dkim=pass header.i=@ya.ru
From:   =?utf-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: comment for git-config man
Message-Id: <0E640233-B2CB-465D-9713-BBECE331CA80@ya.ru>
Date:   Fri, 21 Dec 2018 11:54:22 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cite
worktree.guessRemote
           With add, if no branch argument,
cite end

This was very confusing for me. Much be better if =C2=ABWith worktree =
add=C2=BB.=
