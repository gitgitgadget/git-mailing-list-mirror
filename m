Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB4EC77B7F
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 11:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjD3Lwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3Lwo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 07:52:44 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FD1712
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 04:52:42 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id BFD4E23EA1
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 07:52:40 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pt5bc-26w-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 13:52:40 +0200
Date:   Sun, 30 Apr 2023 13:52:40 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH] t/t3501-revert-cherry-pick.sh: clarify scope of the file
Message-ID: <ZE5WiFr7ChhymlOe@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2023 at 12:00:34PM +0200, Oswald Buddenhagen wrote:
>The file started out as a test for picks and reverts with renames, but
>has been subsequently populated will all kinds of basic tests, in
				 ^^^^
				 "with", obviously.

>accordance with its generic name. Adjust the description to reflect
>that.
>
