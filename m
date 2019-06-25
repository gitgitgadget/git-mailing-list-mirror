Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD431F461
	for <e@80x24.org>; Tue, 25 Jun 2019 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfFYPhC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 11:37:02 -0400
Received: from 28.ip-149-56-142.net ([149.56.142.28]:48204 "EHLO
        28.ip-149-56-142.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfFYPhC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 11:37:02 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 11:37:01 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: thruska@cubiclesoft.com) with ESMTPSA id 8CF403E94E
To:     git@vger.kernel.org
From:   Thomas Hruska <thruska@cubiclesoft.com>
Subject: Why is part of push origin output written to stderr?
Message-ID: <b9961c7b-dd8e-e08e-99bb-60923a05ce87@cubiclesoft.com>
Date:   Tue, 25 Jun 2019 08:27:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120327
 Thunderbird/11.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As seen from a basic 'git push origin master' where the last part of the 
output of a successful push origin is sent to stderr instead of stdout:

To host:user/something.git
    1f57f4a..1a96eab  master -> master

I don't usually think of a successful push as being a fatal error but I 
could be very wrong.  Maybe git is trying to tell me that pushing is 
actually a mistake.

-- 
Thomas Hruska
CubicleSoft President

http://cubiclesoft.com/

