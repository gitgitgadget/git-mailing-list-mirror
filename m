Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A4A209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdFFNbz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 6 Jun 2017 09:31:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19254 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdFFNby (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 09:31:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v56DVpNH071451
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Jun 2017 09:31:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'rajdeep mondal'" <justrajdeep@gmail.com>, <git@vger.kernel.org>
References: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
In-Reply-To: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
Subject: RE: Feature request: Please add support to stash specific files
Date:   Tue, 6 Jun 2017 09:31:11 -0400
Message-ID: <002801d2dec9$2cd49dd0$867dd970$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6VrXXRS2g/LTJM4z0lTeWHspk66HI44tw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On June 6, 2017 9:23 AM, rajdeep mondal wrote:
>Work around found in:
>https://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git
>Workaround is not very optimal. Please add this support to git.

Instead of using stash as part of your normal process, consider using topic branches instead. Before working, switch to a new topic branch. If you forget, stash, switch, apply, then go forth. While on the topic branch, you can use add and commit on a hunk or file basis to satisfy what appears to be the requirement here. You can then merge the desired commits from your topic branch into wherever you want to merge them either preserving the commit or by squashing commits together.

In my shop, stash is only used for the "I forgot to switch to a topic branch, oops" process. I try to encourage people not to use it. I also discourage squashed commits, but that's because I like knowing what's in my sausages 😊

Cheers,
Randall


