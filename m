Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C002C203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 03:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcGYD44 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 23:56:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34603 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbcGYD4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 23:56:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id g202so11159421pfb.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 20:56:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=M9iXPY3IRB4feQlDslCX9KNLsJLH3RKohBqbMhXO58U=;
        b=UDRpz7VlgZorleImutrJq6ANEpLs1tbsplc1mJK/vsoP2vedwtbMeHTOFaLWk300W2
         +7q4LZvrud34qdLH1299Rnwci0Mf7pKTuIXPi0P8bxzLXAxdgVJzFrbxueY08A5AWrpU
         tcoS2n/tCl5BVLsGDzeZ0MbogCbN/fz2CrLr36hYKaforksEYYmLziGh3zWoebQz1AAn
         kLfvJpqNZuGzIoUsuEl2X4rvncFMn66vO3hFHH6r4SCE6ffe1/XS+aMN4LTT/nLfyXpg
         8Hm9mBN5r+Fy4AJZpieYEfl3i4SNrpSLyawhkSnfGxZ01KkWVxHPEiZjH6fO3uRdFNSQ
         UXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=M9iXPY3IRB4feQlDslCX9KNLsJLH3RKohBqbMhXO58U=;
        b=kkl2+79HSVizTBUlDwcro7Nm70Bs5y7bvUKkul6i6dOggI9Z2nJY00+VubNyH4S/CL
         7AYno39ryhjBf/y+x6/4oLicGPJqA8zkdNTOFHDVM72Gn2cDR6UXhPfuuMSysYTriuxV
         WdXUjtlkxF7e/QxCyW1ZBjdCmCyHru7U2EshNnbAsXRHCWYgLT34vMnmI7CFcJL9OYlc
         dIaoT6mGxNqsXUHRLW2D0Q6r3YqpOtsBR8rj2Jthr9mhFTR6tK+dlcAVtM8ZLbYC99qy
         ewpui4+wMIGfre9A00ttB3VcQMOiSSReP1ImCRMGG3x73/pNwcqUm24+xZkBvDrEUfRV
         vchw==
X-Gm-Message-State: AEkooutVy4jofdHRQSfmrkJfxYZ/gxUMrR+tHb9O/H1VbFLYhiqOLZc89n86bXvyvnUnwA==
X-Received: by 10.98.74.201 with SMTP id c70mr26036625pfj.113.1469419014841;
        Sun, 24 Jul 2016 20:56:54 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id q1sm35647425pfd.48.2016.07.24.20.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 20:56:54 -0700 (PDT)
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <nn30dv$5sn$1@ger.gmane.org> <57950D12.2000607@gmail.com>
 <cfff11c9-e212-88a1-c00b-3e7a361e0db9@gmail.com> <57952834.60706@gmail.com>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <a2910716-efda-51f1-da80-42f6b2d3adb0@gmail.com>
Date:	Sun, 24 Jul 2016 20:56:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <57952834.60706@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


>>> Another possibility is to set authordate and committerdate to some
>>> specified time by the way of appropriate environment variables.

To follow up, Jakub's approach works great without
requiring any changes to Git.

For example, the following test script always
produces the same commit ID:

----
export GIT_AUTHOR_DATE=2005-04-07T22:13:13
export GIT_COMMITTER_DATE=2005-04-07T22:13:13
mkdir -p /tmp/test
cd /tmp/test
rm -rf .git
git init
echo "Test" > README
git add README
git commit -m "test"
git log
----

As expected, commenting out the 2 export lines results in
different commit IDs each time.

Case closed.

Thanks, Jakub!

Jon Forrest

