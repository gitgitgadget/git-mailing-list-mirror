Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4175C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJVQ7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 12:59:13 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E492BCA
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 09:59:11 -0700 (PDT)
Date:   Sat, 22 Oct 2022 16:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666457948; x=1666717148;
        bh=yqZjrhqvghRMYweBWZcwVjEdt582drVx8wU1ikck7GU=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=Zuwfmwo+6wqSeQUqFmU5t0Yi98hAwMRAo2V0T3zJUBlFK8nBN2RlvRsVlyQEU6z35
         GcfkLy3cSd4u3h08Tnf+edF1gvK08fP66XskwSRIvFDCPeIOuHjNX36pT7IJugQahD
         pb2bRfFywweKtig3echBlZ2O8NJEv9B7shE/HC0g1HRxJDe6sYYPsgdgnFsRUhdXP3
         g4PhIRWn5DDJOrO+qiuheBglUR7saJWhQCOy3u9RL9M65JjX9PW1Bukf3cP+oRyXvq
         fnfx2gYnJLZh+wzzeKpmpD26k7lC3rYQ9thCMupJ4SZgfzjC+nntRvJvVNPpdup0rA
         md272xyQJdJ3w==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Sergey <sryze@protonmail.com>
Subject: Adding --force-if-newer flag to git push
Message-ID: <491oWe6HDMJXQK2Ru2VbzFrlUajNlVhnIErZZ1dxUaPpCElsgpASAEQFc2Zi1R4G53hAIMHopETEJn7E_TzeeC6uOzGBffQDRK2AWYPIxKQ=@protonmail.com>
Feedback-ID: 7198644:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Would it be a good idea to add a new flag  --force-if-newer to the "git pus=
h" command, so that force-pushing would succeed only if the last local comm=
it's date is newer than that on the remote branch?

Sometimes I find that a feature like this would be useful when I work on mu=
ltiple different computers and I want to just push all local branches to th=
e repo at once to sync it with whatever is the latest version. I know that =
using --force is kind of frowned upon in the Git community, so this is prob=
ably not the best idea because it would promote usage of this feature among=
 the users. I just wanted to know your opinions and see if someone else wou=
ld find it useul or it's just a dumb idea.

Thanks.
