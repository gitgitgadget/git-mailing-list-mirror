Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6017820323
	for <e@80x24.org>; Wed, 22 Mar 2017 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935462AbdCVQlS (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 12:41:18 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37175 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935387AbdCVQlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:41:10 -0400
Received: by mail-it0-f45.google.com with SMTP id 190so27145353itm.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=8QubPoVfptVFBz2heni1Wckg3lfQqvv309D8uJK36s8=;
        b=asVqvXYOdm9ozNL84rVequy3Wv+LZAmg+E3lslbFAMWawb/KVJxHnduBAdipKMvT3s
         c4TTX4YnLCzv9THQfxbafAG42nqfWWkGI+DFxsSfaWuLv1EcQpU3LbPCpDZAQS2CVetd
         To+8ybDe1wfeomf0AqIRerPfVCDU9G7iBhR7fzEkzfFbfCqEHwOjPGvdQfuEZP9Hih5k
         vF3Knh9njJEOwGrZgJYBZGuhZC7bjBCM2uqn5UVbxEb+lxcGgIz+y0z1bTrXyeVRoM5r
         mxVmq3poJnhivT33C7ekr4P0hkyMvIaWP9ThN4/4cYWOj/OjadawFS5IW8jS9s/XCnYP
         YhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=8QubPoVfptVFBz2heni1Wckg3lfQqvv309D8uJK36s8=;
        b=FQUkGzLJsFcoLvv8nd0TvelrimxmBCEcDN3zhit46TksVrBZzADaPg7X9mRJTaBikh
         2oZDhraV7PokIHk95gy51/6BJKodN5UX7+qqWv316g5k9WPe5fYOAs+4LcqE7RWgkzqc
         YhyIO3G70R596szUQYE2bHlakjMsQHljdC1BJTE2S4iAcu6xzMKMQt3GCNGbKZzqF3KN
         R+VDDwQSl/1Ck9HRiWD3iDB5hT/JTAn8r6H0WF/ewJBX1zkfkx0y6K1VmOMfDtY7lDkz
         5v/jo9hlGuiit2IPCZADp3nv32KWjHfohaoPcYAE8QXYAFVtbqR/vZTk+4u8jxUBXeU1
         BXUQ==
X-Gm-Message-State: AFeK/H0VYeQ+3z/acuckvclCqhkYzNYg3dGXccpGareEefRSN7ByXLIMPc2rT+QdnUjMvg==
X-Received: by 10.36.89.211 with SMTP id p202mr9170124itb.97.1490200869174;
        Wed, 22 Mar 2017 09:41:09 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-100-81.home.cgocable.net. [24.150.100.81])
        by smtp.googlemail.com with ESMTPSA id k66sm1034879iof.30.2017.03.22.09.41.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 09:41:08 -0700 (PDT)
From:   Raman Gupta <rocketraman@gmail.com>
Subject: Article on the branch strategy in gitworkflows(7)
To:     git@vger.kernel.org
Message-ID: <92db69d3-ca38-45da-47dc-0fb612a16e8d@gmail.com>
Date:   Wed, 22 Mar 2017 12:41:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several years ago, I contributed [1] to the gitworkflows(7)
documentation, because I thought the process by which git.git does
branching was really interesting.

Since then, I have found it odd that gitworkflows has mostly remained
under the radar. Other, in my opinion, lesser flows, have become very
popular, like GitFlow [2]. I have written an article explaining the
"why" of gitworkflow in contrast to GitFlow and others:

https://docs.google.com/document/d/1cGNujRNVzeLV2SXkVlKwai6qJmlVT3LwlOsVYNr0FZo/edit?usp=sharing

This article is not published yet -- its still a DRAFT and only
visible via the above URL.

I'd love to have input on the draft from the experts in this
community. Feel free to suggest changes and add comments in the
article via Google Docs.

Also, some explanatory illustrations to accompany the article would be
excellent, if anyone feels like contributing. Visuals are not my
strong suit. I'd love to include something similar to the graphic [3]
that was a big part of making GitFlow so popular. The article can be
partially rewritten to match illustrations, if any are contributed.

[1]
https://github.com/git/git/commit/382e54312220ac02586a3cbb06b0e4eb7789f043

[2] http://nvie.com/posts/a-successful-git-branching-model/

[3] http://nvie.com/img/git-model@2x.png

Regards,
Raman Gupta
