Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1590EC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiLSHRD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Dec 2022 02:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSHQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 02:16:54 -0500
Received: from mx1.uni-regensburg.de (mx1.uni-regensburg.de [194.94.157.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2995A2
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 23:16:51 -0800 (PST)
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E840E600004E
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:16:46 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id D42DC600004D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:16:46 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 19 Dec 2022 08:16:47 +0100
Message-Id: <63A00FDC020000A100050846@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.2 
Date:   Mon, 19 Dec 2022 08:16:44 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <bagasdotme@gmail.com>, <git@vger.kernel.org>
Subject: Antw: [EXT] Re: Strange "git stash pop" conflict (one chunk
 out of many)
References: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
 <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>
In-Reply-To: <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Bagas Sanjaya <bagasdotme@gmail.com> schrieb am 17.12.2022 um 02:58 in
Nachricht <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>:
> On 12/15/22 18:38, Ulrich Windl wrote:
>> Here is how the conflict looks (to me both variants seem identical):
>> 
>>         # pre-allocate translations and accesskeys
>> <<<<<<< Updated upstream
>>         foreach my $attr (LD_SEARCH_ATTR) {
>>             $attr{$attr} = [translate_attr($attr), undef];
>>             $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>>         }
>>         foreach my $attr (LD_SEARCH_ATTR) {
>> =======
>>         foreach my $attr (LD_SEARCH_ATTR) {
>>             $attr{$attr} = [translate_attr($attr), undef];
>>             $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>>         }
>>         foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>>>> Stashed changes
>>             @n = (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});
>> 
> 
> Both sides are identical? You can freely choose either side...

Yes, but why do I have to handle this obvious non-conflict?
Couldn't "stash" handle that, too? In fact that was the only conflict I had.

> 
> -- 
> An old man doll... just what I always wanted! - Clara




