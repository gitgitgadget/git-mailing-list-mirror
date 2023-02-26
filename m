Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741ACC64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 12:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBZM0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 07:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 07:26:13 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60ED1164B
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 04:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=ZadiCC7k3Sf8vIewy/vEmvuSUOH0cJWwjCzYW8N7geY=; b=BaOB2Z
        c1pc1uux4WL0zd2th6TU04Egxmzyz10hEnXAimSKTwKjWdmvssN+ZNY1OfhfiLhBOsYuMJmJ00bz9
        9TwXRO2Ro1kSjSMOvMO/ZTTC2rFOzHLRZtyRXiVZ2QMuCfoKNSoRYGLZk6J4VpOyi1AzwGfhFelsk
        JsaGZmIUDQY=;
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pWG6T-000BIJ-57;
        Sun, 26 Feb 2023 12:26:09 +0000
Message-ID: <3f11a4d5-6774-ddd9-060e-3e95acb84c69@iee.email>
Date:   Sun, 26 Feb 2023 12:26:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Gitk : When the number of commits is small, you can roll up
 excessively
To:     "L2750558108@outlook.com" <L2750558108@outlook.com>,
        git <git@vger.kernel.org>
References: <BY5PR14MB3560879E6CBDD493C873DB18B1A29@BY5PR14MB3560.namprd14.prod.outlook.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <BY5PR14MB3560879E6CBDD493C873DB18B1A29@BY5PR14MB3560.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bit of a late response..
On 14/02/2023 06:02, L2750558108@outlook.com wrote:
> Gitk : When the number of commits is small, you can roll up excessively
>
> Reduce :
>
> 1.Create a new respository
> 2.Make 2 Commit
> 3.Go to Gitk to see them
> 4.Scroll up in the commit list and you can see the error
I cannot replicate this problem (on Git-for-Windows git version
2.39.2.windows.1).

What OS, Git and gitk versions are you on?

I created the repo with the commands
phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src (main)
$ git init gitkfault
$ cd gitkfault/
$ echo test>file;git add file;git commit -mfirst
$ echo test2>file;git add file;git commit -msecond
$ gitk &
[1] 1021

I was visualising the commits (lower gitk window) with the "Diff" and
"Patch" settings.
 
At your step 4, I tried 'scrolling up' both by mouse clicking on the two
commits in the top left window that displays the history, and by using
the left/right arrows displayed just right of the "SHA1 ID" value. No
errors were shown.

(those sha1 arrows are distinct from the 'Find' selection and navigation
capability immediately below the "SHA1 ID" line.

What were the exact errors shown at your step 4?

--
Philip
