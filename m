Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E24C32767
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF0D215A4
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 00:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jfq3CjAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAEAuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 19:50:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:58027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAEAuC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 19:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578185401;
        bh=r055V7rr8LfISrstgjCbLtiuHKQ2+gJaTfOyxpN5+50=;
        h=X-UI-Sender-Class:Date:To:Subject:From;
        b=Jfq3CjAtWYtIy0OoPrEdzPL01U+kHeJHIWZtdqifbylsWwoDSm51eqiL+6Ci1buzG
         UCmQHI+KmuMCbpS8sMoHXI4IarbCYsB1YsiacaXoIyRVLGZnhplEZJR8TXG0aXeaPA
         H+7EUfH6E7jC2zOzlpgnG5vh6uuocSCNQAbKark0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([79.255.13.170]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1jO4Lc0nun-00aofa for
 <git@vger.kernel.org>; Sun, 05 Jan 2020 01:50:01 +0100
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Date:   Sun, 05 Jan 2020 01:49:56 +0100
To:     git@vger.kernel.org
Subject: git repo on NTFS mount
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   "Lukas Schubert" <lukas.schubert@gmx.de>
Message-ID: <op.0dv9xiwp1jamlk@localhost>
User-Agent: Opera Mail/12.16 (Linux)
X-Provags-ID: V03:K1:FGXBQ1JazNX3YjFa10zdjLDwopDBpBd8qBoJ/SEgYKsCDHsXvlz
 52u8RAaW7Yp0Yva7E+iHLhsmcsNVtkFZktgYocssdi/7CCwXhWA5DNWktiliAh7wNMArJgH
 4ym4z9/NJeLt41mtHwnMqnCmgi7crZHpNe/25F3xbrkIC0uE3l9n1Z9rIEWMiwrcE7KsnsE
 itVhhcJfxxcZV6gfw2OxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMOcpF2oRFE=:Rnj+4Of47cRg+XhXAQRGVR
 4oZlZ8VooGjjtThqnnnAIMt+ReG1MmCGhojpurY1nyxQq4VYYZmbOyJv6yVWP25UdHYoPFv0D
 Msc6cewCJ3XZI8pFD7XwL4G/UmOPP++cDqhWwy75OPmEN0HRdeiuOaiXfCCYGl4JDKVThjku0
 3D3aOFEm3PST5To9h4LlE4KUOecDf/sZKKfm8hw+engmN/2js4eWU5YaNOIdigC1mfhYrtG7T
 jd2jF/3LxNcOAzs6wzeIUL7SjnwNj0nPDHN1vDUfCI/l1ci2jylRLqOV96Aemsp3+/WwlP6e4
 TZKXmkEO1U+Ci7xldKtosdRImEx+UFwPPZkQuHravPSsnumRKYopsI6bLlsKcM52mInVz1scn
 0aVyzTStMqYNg6zlZ+VWRTwTuXjPvAqPfnQ0a1NzXlD5m2UidZkYjmpfflCLki+OhDDfDokD7
 RLEjVEi7WATpVM/2W3Ng8XpGzuFvu2QD7OrRuAN0SE2SPbbJMcDVNgEwCCR6wt5xKud67ahWd
 RGfIa/BgBf0zj9vdN5D8XHA0SSIVazAxoLqZCPgi2/1Ab0NJ7M4kQEi2dg8PggdBptYYcb0W4
 GcewbfQiC9DQLLgrKIqFCXn1PICDWpZ2XPsu0tfzA7LfCnhWGkLjWqqvXlqjQK0RsYAkkypSu
 VnavP7Z5Eo8SwqL3GUyiYNV0eZAxbBYVth3OOab7iTQKDZZsgphilPO8LUuCoHTbXQTm/CciM
 1RsJpsnj/ggrghaDlunhCWHlE06Y55mZ68Jet7/go+UMD6Y68YzMhmPWkiqJWaHPIViME2T+i
 RvvhRvdIS8E6eHCAqAh5Ugieu0z3l7iYW57XT1mwVRVLnfKYUxtkdXxzee3HP9VSHWar9mqyo
 pFdLK1Lsqeb21IKW6Cjlvwjjrp0mgF2E4HmjgTfFgISqTOaZmzJXNqyLLj/3J9YTImn/eFz1B
 O8sURhj75KO+oIzqyAp3gSSQLhlm/PLr5cBaG4UyZHZvnxS3W/gzOJ1emapmofhWHIZ5U6MzA
 3QkjESY4di573bL+KQ4zChFshzyLZSR99En6iBr28vOBYhM1YChYFMm4AsrilUcEwLEbIUV6+
 fnZxqGmcoA1En2Cx5dhiHApb1HvSj2NT6zkgNnmP5G/mDD0UVFNYUmW7dDN7PrjuiekD2RMYC
 ZudQ8mvezAAEnsnYD+wmaxXkyVOuqWrpo3k+K0PemXeIzNEFDsvaPbxzmzXWm0Jk9VrRlK921
 4y2FCqyh3cn4k+/zcCs41E9uD5vCe9OdSbFejPscBQeEc+vqwXEGLI/U4D2s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

for historical reasons, I keep the data that doesn't belong to any
specific user on a harddisk that is formatted as NTFS. Some git
repositories are there, too. Some time ago, I upgraded from Linux Mint 17
to 19.2. That upgrade brought a change in data partition's mount options.
Old:
UUID=3D20D0WHATEVER	/mnt/DATA	ntfs	defaults,nls=3Dutf8,umask=3D000,uid=3D1=
000,windows_names
New: UUID=3D20D0WHATEVER	/DATA		ntfs	defaults,umask=3D007,gid=3D46

Now I want to initialize a new git repository
user@xxxx:/DATA/Projects/LearnPython/wxGlade$ git init
error: chmod on /DATA/Projects/LearnPython/wxGlade/.git/config.lock
failed: Operation not permitted
fatal: could not set 'core.filemode' to 'false'

Since there already are repos on that drive, the initialization must have
worked before. But in
https://www.linuxquestions.org/questions/showthread.php?p=3D6074034#post60=
74034
I've been told that using git in linux with repositories on NTFS is a
recipe for disaster.

Given I change the mount options to what worked before the update, can I
escape certain doom if I stick to a certain subset of git commands? Or is
the cathastrophe inevitalbe due to subtle errors that culminate but stay
hidden until it's too late?

Thanks


Lukas
