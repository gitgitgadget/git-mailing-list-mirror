Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A286A2023D
	for <e@80x24.org>; Mon, 22 May 2017 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760796AbdEVRxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 13:53:01 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33791 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760790AbdEVRxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 13:53:00 -0400
Received: by mail-vk0-f42.google.com with SMTP id x71so45039363vkd.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3WfyIJv42i4Fbd1TbOgTsaZrQ5K7DtRl8c5Tlm9B7CU=;
        b=IvNsukZK9uamGEErC64aoUxTXXjGMGrNSDZ3024PT3Wki3vj9S2ZnRcSnkqwIJ9pj9
         Q7YI/owk5pKMNijy2eFNpthiaHx0vwcwMeXVIH+ToMmq1PPGvdhZYvXH45Lq0PJ9+4Z/
         QLH0HUkMezYTBazj0CopoOTPz2c4KRR6SQb9kKgEhQ+kbAJO9bDtT64FLt5JO4+SISNC
         kpbnF5JcBAPIQUswyEBkBABKYn/P99mBL0k1ToSzSKXMsuw1z0VRYbaqGFKagsiQUFHA
         jhvLE5o0DdPCBhwjCOS+Fi9i9xK8uTOXuphqN0wHEtKujtPNbWawv9r53EWfGCVVyIIp
         9q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3WfyIJv42i4Fbd1TbOgTsaZrQ5K7DtRl8c5Tlm9B7CU=;
        b=lihmNekI1Tz1/TTrmBCoxEQq1CuguJeRBlM+akA0ryJM73O85vwEa53sewUZTOWHeA
         PZWm2rbqg9wdeA+Q8JLwvSRCVR03dbeShKC+64VCPs53cFZcV6fUaKp1r4az6xGVSa0D
         JApFq2LnG7Fwf9/vW2uilJwf6Pha6zmojdn1YdXsY4L1m63jWvfUh9Eylnsb8zYcMQCC
         Abj4cuv7v05DnHUd135Og7xVaQaWkLRVldmsWGxUI1QV081ATQGpdbgG/qeLLdHlp/Cx
         Tz22RpLgqMMYG3qFwWJjPgbKxnpjvVbiCV2aRJHuqlOZScIMKYjKXIfl8JlD/r+OPgNo
         DHdg==
X-Gm-Message-State: AODbwcBa5O8Dugvwfru/r+3z4QWSsYWxxQl317MAPMdmts/PW5LyVVIH
        uy9byf2YlE3t+/KfSvfuRQKbU3XY1P9I
X-Received: by 10.31.9.204 with SMTP id 195mr8953320vkj.115.1495475579661;
 Mon, 22 May 2017 10:52:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.38.44 with HTTP; Mon, 22 May 2017 10:52:59 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Mon, 22 May 2017 23:22:59 +0530
Message-ID: <CAME+mvUJSdEyvNho=WwC+9gXaG7_emoHEACznx2goFzPp+t+KA@mail.gmail.com>
Subject: [GSoC] Update: Week 1
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

As planned for the first week, I continued working on completing the porting
of submodule subcommand foreach. As suggested in the previous patches, some
additional changes we made to the patch and an updated version of the patch
is posted on the mailing list.[2][3]

Also, porting of submodule subcommand status from shell to C was carried out
in this week. For this purpose, first the function set_name_rev was ported
from shell to C, and then the subcommand. A complete ported version, which
passes all the tests is posted on the mailing list for reviews.[4][5]

PLAN FOR WEEK-2 (23 May 2017 to 29 may 2017):

In this week, I plan to port submodule subcommand sync from shell to C and
post a version of the ported function on the mailing list asap.

Also, I'll get started with porting the submodule subcommand summary in this
week itself and will try my best to port this as well in this week.

Along with this, I'll continue improvising the present patches, which are
currently on the mailing list for reviews.



[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://public-inbox.org/git/20170521125814.26255-1-pc44800@gmail.com/
[3]: https://public-inbox.org/git/20170521125814.26255-2-pc44800@gmail.com/
[4]: https://public-inbox.org/git/20170521122711.22021-1-pc44800@gmail.com/
[5]: https://public-inbox.org/git/20170521122711.22021-2-pc44800@gmail.com/
