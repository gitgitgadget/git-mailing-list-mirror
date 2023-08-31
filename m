Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FEC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjHaLEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjHaLEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 07:04:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A4CFA
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 04:04:48 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id CBFF824282;
        Thu, 31 Aug 2023 07:04:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qbfTj-El1-00; Thu, 31 Aug 2023 13:04:47 +0200
Date:   Thu, 31 Aug 2023 13:04:47 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?B?Vu10?= Ondruch <vondruch@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Message-ID: <ZPBzz3vvv9Ryn2tz@ugly>
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 11:49:10AM +0200, Vít Ondruch wrote:
>$ git extract-filenames-from-patch 791.patch
>
>0001-Fix-Minitest-constant-name-in-tests.patch
>
`git log --pretty=format:%f` does that.
of course you need to apply the patch first for that to work, which is a 
bit inefficient and arguably inelegant if you don't intend to do that 
anyway.

>P.S.: Please keep me in the CC
>
that's this list's policy anyway.

regards
