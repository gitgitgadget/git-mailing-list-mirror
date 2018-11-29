Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A7B211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 11:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeK2WzY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 17:55:24 -0500
Received: from wp069.webpack.hosteurope.de ([80.237.132.76]:53428 "EHLO
        wp069.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbeK2WzY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Nov 2018 17:55:24 -0500
X-Greylist: delayed 2331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 17:55:23 EST
Received: from b2b-130-180-70-234.unitymedia.biz ([130.180.70.234] helo=[192.168.122.201]); authenticated
        by wp069.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gSKEF-0004YY-IA; Thu, 29 Nov 2018 12:11:31 +0100
To:     git <git@vger.kernel.org>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: Git Tags
Message-ID: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
Date:   Thu, 29 Nov 2018 12:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1543492218;0f9247a9;
X-HE-SMSGID: 1gSKEF-0004YY-IA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I have done this (on box A):

git commit -m "Message"
git tag -a 0.9.0
git push origin master

In my local repository, when I run "git tag" it is showing me "0.9.0".

Then I did (on box B)
git clone ssh://user@host:/path/project.git
cd project
git tag

Now git tag is showing nothing.

Why is the tag only available in my local repository?

Also when I try to
git clone --branch 0.9.0 ssh://user@host:/path/project.git
it tells me: fatal:remote branch not found in upstream repository origin

Why is the tag not available in origin?

Thanks,
Stefanie

