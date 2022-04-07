Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E9C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiDGWLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiDGWK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074CF10C1
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649368460;
        bh=C5mlsy34jAa18iw2uvOuTGWjZUizrPZ8CAwcZqKscTg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZfQSSad2sC9sqALfs9IuIjrfIo2JDGM8XBRfJtq3wEMC5Q+a0b4W8D4iStsMPp265
         Kyb64wtpH20VPspbS7bWrm5UJ6oFSYgpKMrjuwAFqvidNS46FaMJcruugUfq6AOCM7
         whzlhvQ9rOC0zCYVpeflcndIlLbaU6u2m1DV/IUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.212.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6lpG-1nd6Ru01jq-008Gis; Thu, 07
 Apr 2022 23:54:20 +0200
Date:   Thu, 7 Apr 2022 23:54:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <ttaylorr@github.com>
cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
In-Reply-To: <YkcmtqcFaO7v1jW5@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
References: <YkcmtqcFaO7v1jW5@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CgA5FO2P46qKDLQX4Sx2g13Dy7XKCmR4bK5EwJliV7M/znBeKN9
 Z07wTox16UO85wTo5JnaVPSYDFWl2wVSw3CY7PBYcQfzPu+Gb0FTaCEyBG2EIPD9Lmiy0cq
 w0AXiKz62++y0t5GFKQepARGXRgSy8IgY4lHWZT6/6ViDFN8oHMcpV7etH+IkrFzO2ffr+g
 eF0N/oNUAJqXFKWmOuxDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJwP5uTqZqo=:RiRBhjVXL1gcAxgzxwHCDT
 boJATGHzBv741p48wp9799deZHPgZKbEM7YuurNvLeRtjfvRPb4F3yEbG6g7AYSljEGcsk7tZ
 lU+W/7ne08si0VtC+JLUKscSS8vKMoCMQlUN2e/ZPSBBvy5NWF91FSg3akukpYy9iaPc2cYx5
 jh2v9p50u+u7FS7C0/REf4vayMBgl8GkItoNGkEeeJ9u0P7SVaXJ3GZVzcnSM/ttc2sQkcAV1
 AM8VIKNym6Lh7mTXW/BDQ5Qd/WzwwrutZc/j+tQVXxX+HU4vVbCpJaH9pifb+Qf4o9qWEvakT
 tJc/fFFHNXrcuDXzK2m/BZeqxlFWXLHJ8jjhsxHbn92Ffk4zFlDeyA18Fyjrf5gVvdai7Dm2m
 V0ki8SvzgkS1KgtA56K1by/xfShRE/TsIEo7nC1HfEfs/VZfhZJt9Fb6WWliECIvInQoKUtN8
 YDVmeOQO0EISv3tb90hEL5uFgY3lNbRkFQIFb6dgS/4chXh+e8A5mYNObMzvGbJ8JhNBm+qFw
 8EfkTypOYFsVC5juh9K1O7507b09R82ZqMN7AXgpD910oIs/MDL+g5JKiuRkU8HmustXSF0sq
 Ug1otzwgEACLeCLjh4jRigBGuB8d7tyhlPCEpA84wW9AQzOJNgeVXto3I55B6+GEAceXzHqQ/
 kDWbm7pB0n/m+BfofZTRgBe2XwPmgHmMYPODwzBWP7XhFgicY9OZNBbMjCTDpwhq4VvONE8HF
 9GYVE1SF2WV/4aR/Y6+18vGM01oS1rS2h6LMnr2LTdVdLEb8cq7qWjcy7rdx0NdiqwoSICdtB
 ZnTkO2lnpwjwx2PoSlPauqQxeVB0+ewDHi0C6twHAA8a4+cSa8+gMlz+WxQV872XGHxmpZ5Tr
 APG3Lc5Im9jxaBb2ILLnLetwi/aNnFS5vN8Evn7wiSZbHBXbep6wk0IiYbBAw/M3RaZx8JKCv
 C1ipeAtfc9x+IewRi+4vvMcdblVXIYzhSdihnzjm3Wl1SxYtoO8RtkpEEnroHnrePDehiHU/J
 iZqV8om1XYsJUbg2h3ZmuM40gx1fSGdHAyL8Ic0CMAusRBzyppSJoI7l70H+pWZg5ln+Z2tb8
 MQeVRZhiKt7zCY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 1 Apr 2022, Taylor Blau wrote:

> As some of you know, we have a website at https://git-scm.com, which has
> served as the Git project's de-facto homepage.
>
> That site is hosted on Heroku, which has graciously provided the Git
> project with hosting credits for many years. That, combined with support
> from Cloudflare has meant that the maintenance cost for the site is
> effectively $0.
>
> Unfortunately, Heroku no longer provides free hosting credits to
> organizations and open-source projects. I have been in an ongoing
> support thread with them, and their stance is pretty clear.

Thank you for all your efforts. I frequently point users to git-scm.com,
be it for the manual pages or for other resources, and appreciate that you
keep it running so smoothly. While it is understandable that the free tier
is going away, it is nevertheless an unplanned work for us, and I thank
you for doing it.

> To that end, we have a few options about what to do with the website in
> the future:
>
>   - Convert the Rails application into a static site that could be
>     hosted elsewhere for free. The non-static portions of the site would
>     have to become static in one way or another, and we'd have to come
>     up with an alternative search mechanism to replace the existing one.

This is my preference (and I would love to contribute the time, but am
quite short on that resource to help much).

It looks to me as if the only blocker is the site-search, and there are
ways to pre-generate an index e.g. in a Jekyll site (which we could host
on GitHub Pages, incidentally, which would be a very nice setup indeed).

The other thing the Rails app does is to regularly poll for updated
versions, e.g. Git for Windows and Git for Mac. This strikes me as
something that would benefit from the transparency provided by having a
GitHub workflow to perform said polling instead of the opaque Rails app on
Heroku with no public log of when it ran and whether it was successful.

Please let me know what you think, and whether you already looked into how
automatable/parallelizable this conversion would be. Hopefully I _can_ be
of use in bringing that about.

Thanks,
Dscho
