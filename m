Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250C3202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 22:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936306AbdKPWkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 17:40:36 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39839 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934167AbdKPWke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 17:40:34 -0500
Received: by mail-wm0-f50.google.com with SMTP id l8so3068925wmg.4
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 14:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=g2tTRtw5MKzgVgZ42LBditoEtCqywVfmBJMWW0EJFbQ=;
        b=tTBatm3+lf4+OtFuDMlW3rd/ng8QbUl5E1QBHg1JP28s+JhquUM09xFta/ShT1VW4f
         uvjLJernakOQwJJ4mUngE1aihBtLbFWE95yfPySvGu25FBPRjiPahTVUCWZH7NjsVLZ5
         xrEplVHDuh+DFpH+GuRrq5BFxRtxDg40xJpKTps7cDZKhNz5P6z5yCNAj8rMilQ20E17
         eGgWXa2AvklEQglurXNa56tJtxmF50AV316kOF0R0q4D8eQWmDK4YlD8JMuS5JAdk61S
         Y7w7Bl0OQMefozx8ugi9MVfS9MXn+taiJHjmxQJQ7CXbVMHMrG8ABXwTXeW82HnOjYCv
         JAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=g2tTRtw5MKzgVgZ42LBditoEtCqywVfmBJMWW0EJFbQ=;
        b=tIExeRusxzS7uKARlcNNmOWuyVLS2gCtZDY+TxUAACAn1qgRB/DxeWEBf+6gVTZsBP
         xDa0sUg4yPt020tO5/uJ/SxKj3/ROvZfVhc+Fb+1qFR4vRfTTuA2SktwZFXJn5oC5qQq
         SJN6jnYis1FZIngJqgX1RuIGs6jUm/siZKn5kdUq8a+QHp2RWJGdoRSTSUzRTgPKKF98
         QROmWv9M7nZFQPQW2MbBUveXC+htx2l005sDSukiH8qTPXbFEc4r8a16WHYRZzuMkOef
         PRHOAllB9218KGyjQg0VQAq1fseb7trxYqHKklvj71x8xNDnjPNDug3E5r02jVhFUMyv
         HtWA==
X-Gm-Message-State: AJaThX5Oyc87FxAv+NQK+g8wespXD4MTUAiXIg7QrmMIBdu9ciAeNyMv
        VzRc4kEqiX7XdbNCjTSsFuUZqqos
X-Google-Smtp-Source: AGs4zMYgbqDiPug5DXTfLDoWfcSpynMdaLT9uL2CfOICrC9xUxXfm1xPc8zJfQ1woeRmxC1AVTznzA==
X-Received: by 10.28.207.8 with SMTP id f8mr2943395wmg.30.1510872033353;
        Thu, 16 Nov 2017 14:40:33 -0800 (PST)
Received: from ?IPv6:2a02:8071:3185:fe00:35e2:b7f3:cb90:ac9b? ([2a02:8071:3185:fe00:35e2:b7f3:cb90:ac9b])
        by smtp.googlemail.com with ESMTPSA id f19sm2231171wrh.64.2017.11.16.14.40.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 14:40:32 -0800 (PST)
Message-ID: <1510872031.23230.7.camel@gmail.com>
Subject: Documentation of post-receive hook
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     git@vger.kernel.org
Date:   Thu, 16 Nov 2017 23:40:31 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think the documentation of the post-receive hook is misleading. When reading
it, it appears as though the post-receive hook is executed even when no commits
are transferred by a git push because it isn't mentioned anywhere that this is
necessary for its execution.

This can easily be fixed by changing

    This hook is invoked by 'git-receive-pack' on the remote repository,
    which happens when a 'git push' is done on a local repository.

to:

    This hook is invoked by 'git-receive-pack' on the remote repository,
    which happens when a 'git push' is done on a local repository and
    successfully transfers at least 1 commit.

Alternatively,

    This hook executes once for the receive operation.

can be changed to

    This hook executes once for the receive operation, but only if at least
    1 commit was successfully transferred.

Imho, the first option should be chosen as it informs the reader about this
behavior at the first convenient opportunity.

-- 
Christoph Michelbach <michelbach94@gmail.com>
