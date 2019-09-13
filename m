Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BBF1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbfIMWBm (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:01:42 -0400
Received: from smtp76.ord1d.emailsrvr.com ([184.106.54.76]:48710 "EHLO
        smtp76.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390241AbfIMWBl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Sep 2019 18:01:41 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 18:01:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1568411597;
        bh=2CSzLefJyYmzfQCHN8qoK/t+3uv3/dMlailZ8nJ7JtM=;
        h=Subject:To:From:Date:From;
        b=i0PxtDAPIJlj04JXRogsiyGBVkf1v5f8Kha5BRWtLFCT9KXcOVgnP14PnAlrCTEux
         XKeQa9SwaTW8JxW9xvGNgO/z6lSmmvNpbvPZqBKH1gYMTuszQ6XBHWbCm0l+yA+f/7
         qtIyXrDZEuvGpbE+E1pOBThwxDIVtIzTzW52t/CE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1568411597;
        bh=2CSzLefJyYmzfQCHN8qoK/t+3uv3/dMlailZ8nJ7JtM=;
        h=Subject:To:From:Date:From;
        b=e4YjO3C/s5vHW6txLPPzGM5BTHbq1SuunAayGtjoh00HUNQ4JyfarqktL5/QhToaY
         rl64CVzNJfrgqBGpvlefOGJrtV/YenzL159nmAdYWUlHN4HKLpQCSctuJDDCFvJWO0
         BeLzBppQvPe8K6r8bNOvH24dpSZ5nx6LrhbQJeLg=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6AF2CA01B7;
        Fri, 13 Sep 2019 17:53:17 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 13 Sep 2019 17:53:17 -0400
Subject: =?UTF-8?Q?Re=3a_Git_Gui_-_enhancement_suggestion_-_Can_a_double_cli?=
 =?UTF-8?Q?ck_on_the_file_name_in_the_=e2=80=9cunstaged=e2=80=9d_area_move_t?=
 =?UTF-8?Q?he_item_to_=e2=80=9cstaged_changes=e2=80=9d?=
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Allan Ford <allan.ford17@gmail.com>
Cc:     git@vger.kernel.org
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <3fac912d-9e3c-bf19-e1e5-2691a835b151@xiplink.com>
Date:   Fri, 13 Sep 2019 17:53:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-09-13 10:32 a.m., Pratyush Yadav wrote:
> On 13/09/19 12:24PM, Allan Ford wrote:
>> Dear Git Authors,
>>
>> Not a bug, but a suggestion consideration for “Git Gui”
>>
>> Can a double click on the file name in the “unstaged” area move the
>> item to “staged changes” .. (rather than having to click on the small
>> icon to the left of the file name?)
> 
> It has been something on my radar for some time. Shouldn't be something
> too difficult to do.
> 
> While I like the idea in general, I have a question that I'd like to ask
> other git-gui users:
> 
> If we implement something like this, what happens when you single-click
> on the icon? Do we treat that as a stage/unstage command? If we keep the
> legacy behaviour of single-click on the icon stages/unstages, then a
> part of the row is single-click and the rest double-click.
> 
> If we make an entire row of the stage/unstage widget double click, it
> messes with people who are already used to it.
> 
> Is partial single and partial double click behaviour acceptable? Or
> should we make the entire row double click only? Or something else that
> I missed?

I've always felt this was a bit of user-experience failure on git-gui's 
part.  Single-click should not behave differently just because you click 
the icon.  I've seen many new git-gui users find this (mildly) confusing.

I'd be happy if the click behavior was consistent across the entire row: 
single-click to select, double-click to stage/unstage, and there's 
nothing special about clicking the icon.  I personally don't think it 
would be hard to adjust to that.

I guarantee you that if double-click support is added while preserving 
the icon-single-click, users will get tripped up when they double-click 
the icon and accidentally stage two files.

		M.

