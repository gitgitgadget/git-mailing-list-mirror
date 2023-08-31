Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BDC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 12:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjHaMqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHaMqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 08:46:09 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889FCF2
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 05:46:05 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 7057224215;
        Thu, 31 Aug 2023 08:46:03 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qbh3j-H0L-00; Thu, 31 Aug 2023 14:46:03 +0200
Date:   Thu, 31 Aug 2023 14:46:03 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?B?Vu10?= Ondruch <vondruch@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Message-ID: <ZPCLi5iiYsf6XQc6@ugly>
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <ZPBzz3vvv9Ryn2tz@ugly>
 <3a7837fa-d7fb-1a85-dc67-94e94f4058c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7837fa-d7fb-1a85-dc67-94e94f4058c6@redhat.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 02:13:30PM +0200, Vít Ondruch wrote:
>Dne 31. 08. 23 v 13:04 Oswald Buddenhagen napsal(a):
>> On Thu, Aug 31, 2023 at 11:49:10AM +0200, Vít Ondruch wrote:
>>> $ git extract-filenames-from-patch 791.patch
>>>
>>> 0001-Fix-Minitest-constant-name-in-tests.patch
>>>
>> `git log --pretty=format:%f` does that.
>> of course you need to apply the patch first for that to work
>
>
>That (applying the patch) is the problem actually. I am looking for 
>functionality like this in the context of  Fedora packaging, where we 
>work with source tarballs. Therefore I don't typically have an 
>repository around.
>
well, you can just `git init` and add and commit the entire tree.
less inefficient would be creating a dummy repo, and cutting down the 
patch to be empty before applying it.

of course these are ludicrous suggestions in practice, and just 
replicating the cleanup function with a few regexes in a perl one-liner 
should do.

regards
