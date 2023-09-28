Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EECE7B10
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjI1Jk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjI1JkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 05:40:10 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535791725
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 02:40:01 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 9605B242CE;
        Thu, 28 Sep 2023 05:39:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qlnV0-r27-00; Thu, 28 Sep 2023 11:39:58 +0200
Date:   Thu, 28 Sep 2023 11:39:58 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
Message-ID: <ZRVJ7pjQ35Stw9X4@ugly>
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
 <xmqqr0mtcosy.fsf@gitster.g>
 <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
 <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

just language nits on the commit message:

On Tue, Sep 26, 2023 at 10:58:43AM -0500, Eric W. Biederman wrote:
>Not supporting commits, tags, or trees has no downside as it is not
>currently supported now, and commits, tags, and trees being smaller by
>design do not have the problem that the problem that index_bulk_checkin
				     ^^^^^^^^^^^^^^^^
				     duplicated!

>was built to solve.

>A version of index_bulk_checkin that supports more than just blobs when
>computing both the SHA-1 and the SHA-256 of every object added would
>need a different, and more expensive structure.  The structure is more
>expensive because it would be required to temporarily buffering the
							     ^^^
							no 'ing' here.

>equivalent object the compatibility hash needs to be computed over.


>A temporary object is needed, because before a hash over an object can
>computed it's
>
"be computed, its"

>object header needs to be computed.  One of the members of

regards
