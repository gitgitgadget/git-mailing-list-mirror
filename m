Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89CE92718
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 16:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjJEQRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbjJEQPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2217EFF
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 07:31:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 48C801C0004
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de-weerd.name;
        s=gm1; t=1696516316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bdOqD1VkKaIXpxPArBYrkpSoK7zBww9S9HuUV31PyP0=;
        b=EieXlzVpwoM66zXIM4xOs7ka0wnZ7lY3JvoYrgK7Wou7EDvuI/cFJD5KDf7FU/rVmK3x2N
        309Bhegw5wJ/mNWV5OgRf6eX35uMkbSnwHp3r/x4kZ0xyv0qUve5b+6cD0VeyOiykgOYJY
        1cN+fuTm2hUHAKzXJOCt8zEMpdSzggg2QV3E1Ujv73plWRFPEbBJMdF54dm8kHPVHsVdUo
        sY75sq0emTU38z9qiBQKfyGx/4ioYkAxHPHZqF3Yr27BYslp0K1nlw41zQHBPA8oKITSrs
        wuRTT9KmyusIbdMwQVl9J2Tz+6OjLUhIgqUJV+dIHSPZUd/yXdBcUl+qccZtXA==
MIME-Version: 1.0
Date:   Thu, 05 Oct 2023 16:31:55 +0200
From:   MDW <mdw_git_vger.kernel.org@de-weerd.name>
To:     git@vger.kernel.org
Subject: Wording "fetch" to change to "pull" or "merge" ti suggest the proper
 action to take when pull fails?
Message-ID: <3d513e04f7153e676c7e0b4f6f1e1fa0@de-weerd.name>
X-Sender: mdw_git_vger.kernel.org@de-weerd.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: pub@de-weerd.name
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I noticed that the working upon a rejected pull request is "fetch 
first".
However, AFAIK fetching will not help with the pull.

So I suggest to change that wording.

Example:
```bash
$ git push
To ssh://git.exemple.com/user/repo.git
  ! [rejected]            main -> main (fetch first)
error: failed to push some refs to 'ssh://git.exemple.com/user/repo.git'
```

Kind regards

Mario

-- 
GDPR: Personal data is provided only for this communication.
I refuse unsollicited subscriptions to mailing lists
and I refuse commercial use of this personal data.
