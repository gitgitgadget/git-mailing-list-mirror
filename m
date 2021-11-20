Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5143C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhKTQSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 11:18:43 -0500
Received: from wes1-so1-redir.wedos.net ([46.28.106.44]:52411 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKTQSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 11:18:42 -0500
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Nov 2021 11:18:42 EST
Received: from [192.168.1.150] (cgnat44-pool1-237-189.poda.cz [193.165.237.189])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 4HxJLK1zBlz37R
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:06:17 +0100 (CET)
From:   Martin Bruzina <martin@bruzina.cz>
To:     git@vger.kernel.org
Subject: Emphasize that assume-unchanged and skip-worktree bits are not
 propagated to origin with git push
Message-ID: <3df2bcbd-fac2-b36d-3f50-d52e573fc803@bruzina.cz>
Date:   Sat, 20 Nov 2021 17:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

General overview of the idea:
Reference https://git-scm.com/docs/git-update-index describes 
assume-unchanged and skip-worktree bits and should include clear 
information on whether they are propagated to remotes with git push or not.

What problem will this solve?
 From https://git-scm.com/docs/git-update-index it is unclear, how 
assume-unchanged and skip-worktree bits work in relation to remotes - if 
they are local only, or propagated to a remote as well.

 From other documentation - 
https://git-scm.com/docs/git-sparse-checkout#_sparse_checkout or 
https://git-scm.com/docs/gitfaq, it might be deducible, but it would be 
convenient to mention it in 
https://git-scm.com/docs/git-update-index#_notes as well.

Have I thought about other solutions?
Use Google - it's not easy to find the fact by Google
Search for the information by on-page search - 
https://git-scm.com/search/results?search=skip-worktree and 
https://git-scm.com/search/results?search=assume-unchanged top results 
are not helpful, but I admit that from the bottom ones it is deducible
Write a blog about it - 
http://blog.stephan-partzsch.de/how-to-ignore-changes-in-tracked-files-with-git/ 
already posted the information: But no matter which option 
(assume-unchanged and skip-worktree bits) you choose there is one point 
to consider: The chosen bit will not be propagated by git push.

-- 
S pozdravem
Martin Bružina

