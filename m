Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006EFC4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiLaTUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaTUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 14:20:19 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20AA65BF
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 11:20:15 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BVJJqMG005245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Dec 2022 14:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672514404; bh=zVQy2AAXRTGUJPCJqS1aTj/GebNLJn3vQVq+NHehc/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=U6w592vNIIit3Nm89APYj73vj/bTwuoLEqTD0Tu0Co4oC5Nv8tQKi+tX5xRcOvXdJ
         sna07jHDZkE0fMCMHyZ2OLq5GORqkGGfWKD16Ryde1mGdggbTDs22GLc+X85TzWilI
         nhNO7ynEgJ401TkO7X7l+qtC5A8peUKZXYyAaqTwzFKz6cPfseehmNzl/aVNdR8122
         bgmKRroGJmTbA/aHzy3cRiPT8YOZx9oKrEt6fFSlVEETtnjCNCy6QcJKxDdNP+AiCy
         aTtD3m8U6HLen4VTXsnOMhPomSDH2GXgnqRK51eo+hGRY6N8ggHf4P1Y2B8ZJrsD9c
         vvYONniC3H5Eg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id D78FF8C0363; Sat, 31 Dec 2022 14:19:48 -0500 (EST)
Date:   Sat, 31 Dec 2022 14:19:48 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Filip Lipien <aaa@164.ooo>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <Y7CLVESLXqy1ZLCn@mit.edu>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2022 at 06:11:17PM +0000, Filip Lipien wrote:
> There are more than one million questions on Stackoverflow related to the usage of Git.
> This is not normal.

Incorrect.  As of this writing, there are 146,090 quetions[1] tagged
[git] on stackoverflow.  Compare that to the 161,963 questions[2]
tagged [windows], or the 2,084,537 questions[3] tagged [python].

[1] https://stackoverflow.com/questions/tagged/git
[2] https://stackoverflow.com/questions/tagged/windows
[3] https://stackoverflow.com/questions/tagged/python

The fact that there are a large number of questions in stackoverflow
is more a measure of a tool's popularity than anything else.  And if
it's popular, it's probably because a large number of developers have
found it to be *useful*.

> Git is in its current state not a tool that's made for humans.

It's made for developers like me, and last I checked, I'm human.  :-)
It may not be made for you, but that's OK; you don't have to use it.

My personal opinion is that it has probably *saved* a net total of
billions of dollars of developer time, for those who know how to use
it.

Best regards,

						- Ted

P.S.  I would commend to you Neal Stephenson's essay, "In the
beginning was the command line".  It was available for sale as a book,
but as it was published a while back in 1999, it's since been made
available for free download[4].  Unfortunately, because it was so
popular, the resulting download traffic crashed his publisher's
website, and it's no longer available there.  The best place to get it
is here[5].

[4] https://www.nealstephenson.com/in-the-beginning-was-the-command-line.html
[5] https://github.com/danielmkarlsson/library/blob/master/Neal%20Stephenson%20-%20In%20the%20Beginning%20was%20the%20Command%20Line.pdf

It's a short read; only 60 pages in the PDF.  About midway through the
essay, in section 11, there is a comparison made between Linux and the
Hole Hawg, an industrial drill made by the Milwaukee Tool Company.  If
Linux is the Hole Hawg of Operating Systems, then perhaps git is the
Hole Hawg of Source Code Management systems.  If it's too much SCM for
you; there's no shame --- you can always choose to use lesser SCM's
for your own personal projects.  :-)

