Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96181F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeBSV6S (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:58:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:33383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeBSV6R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:58:17 -0500
Received: from minint-tb4pce7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MC4VE-1ewj8X00XY-008u50; Mon, 19 Feb 2018 22:58:13 +0100
Date:   Mon, 19 Feb 2018 22:58:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
In-Reply-To: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
Message-ID: <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NynTsZ5uzZSYJFSW+szZi8avu6xC1psXS2s55Av+/Zj/oLD2p1r
 bewB3w96FKFwwzeOvWY8npc1/GniSgnovLgpzimuQJ5wuBmh084OY54z+ifDtu5Tz8RUE67
 otQ0nis3PEWuUOdZTvA0H8Tl5bMAiDrTVmhUBFfoeumOE7JcqY4pX19k/IaLGd+QVD8oJbX
 +vRIHzXVRZ+A1TdAVHJAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WJg7tA1S1kg=:G4g82BQNRArRgqCHFMrKo2
 3RUwyrY4o6TqM7FaZ+EG8q3NZJJsJhQoqh2H5dGGNi7DXM12y7yynF6//arLwZQKFdHMdM/qN
 2oGQA1pvhrk2PK0K1DYxhbDgy0h/sJs1WSJj3V6XcJH6B8M4VO7uO+X1utw0TBciSpkuPwFDw
 7icwNdtLVXcoXGhgD9z1K9u5Z3kbqgo7rJg60FGpqA3ITLF79pDxd8hT6rDyADQX4L8yHjdvA
 k4G/9imeqDgM0i/qViFgRhZkSDqKfHAwItusRhxGvjVHvRAM+QdacwcJ9GPPPGHxZhnxqRMeI
 7gpAuteaDjZd0M+s+fMM0RD9d38Apf6O3ghw4JVsxBOgHwBV3sHtt96jcB8ypChKQ4U5Lg1ph
 ekMwW7GJzH5XM/qBzxyvPMVHKkXiZDdHGHXyr+JP8Q9QVzJE/7a8REuFngMXZoVwJR1hqr5f9
 9zvP1AJtRQCPXQ27hA3gShOeYgJia7+istvSudrafLqzy54mnktgOzJbWQCxTk6ZmMz/TIE2i
 6iCywZbVzbPxofhqZ4lC6lHiO2mN/EwCsJdVu9hFjW85OfY8BFxQrdDaN1ZAO+6pWm80ih5m6
 bO0g7JCRSoyHSEGawWK962nJ3K7vtFWA4ZZVrc0WPqbQkZUOK8THwhz/HprCSvkWDMn03uzqX
 Md9e0RxP9EN5eM2ZOiFPUcEN3aHEduIHAcAYR1K1UFJ+qAEeyzOHM7MQmeu50dbqcMFaZWfOh
 /c8zmC4ov4Ll/E7/VNKklBk1S0pcVpBvXZOfJLaXmkyPpfNsh4U+XS5NSa05yG/v/khWOksll
 avW/0lVAzou7LXAseIEuyLuXEraWf5Pr0mYOxJ2L6/m8XrX3BA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Mon, 19 Feb 2018, Peter Backes wrote:

> please ensure to CC me if you reply as I am not subscribed to the list.
> 
> https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preserving_modification_time_on_files.3F 
> argues that git isn't preserving modification times because it needs to 
> ensure that build tools work properly.
> 
> I agree that modification times should not be restored by default, 
> because of the principle of least astonishment. But should it be 
> impossible? The principle of least astonishment does not mandate this; 
> it is not a paternalistic principle.
> 
> Thus, I do not get at all
> - why git doesn't *store* modification times, perhaps by default, but 
> at least on request
> - why git doesn't restore modification times *on request*
> 
> It is pretty annoying that git cannot, even if I know what I am doing, 
> and explicitly want it to, preserve the modification time.
> 
> One use case: I have lots of file lying around in my build directory 
> and for some of them, the modification time in important information to 
> me. Those files are not at all used with the build tool. In contrast to 
> git pull, git pull --rebase needs those to be stashed. But after the 
> pull and unstash, the mtime is gone. Boo.
> 
> Please provide options to store and restore modification times. It 
> shouldn't be hard to do, given that other metadata such as the mode is 
> already stored. It would make live so much easier. And the fact that 
> this has made into the FAQ clearly suggests that there are many others 
> who think so.

Since you already assessed that it shouldn't be hard to do, you probably
want to put your money where your mouth is and come up with a patch, and
then offer it up for discussion on this here mailing list.

Ciao,
Johannes
