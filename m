Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD61AC83F2A
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjH3S3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbjH3LKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 07:10:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38738CC9
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693393842; x=1693998642; i=johannes.schindelin@gmx.de;
 bh=f21FnhcmRBqFo4MWa2t2KWjOSMdVjhUXG3rrZNFXsls=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=GZ29Da34JO0zNsMmFAoNqiE5IfoLWPlf5ZtQFrxyEHIkzNr3RIrCoFnSoNb7Mr0D+NxVURT
 Bsw5Mn2NowukoBnxjHRLonfP8kQrlHdiiZs2JJazBqyy0vynARYiEoNKK6vfj25gPxqwomxWR
 WcqBUtrluHwam7bweUDfSvoDkme7Ve4MMJuJp0ULHEd6udWEqztIyT0YXnYpC4d9577pSkWFU
 uh0uyN8OMzvtlBmJ/SKPehHXCmdwTTJ4lYDTmTeJIzLcNcqeiQ0TupY46v+BBtBkDY9jr68pl
 BVI/Wbpkwo98ztXRanq+qdWtr7kT14kkyBD265V6BluQLK0mSSkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az585-898.501l53qtsreu5c51wanflvb2vb.jx.internal.cloudapp.net
 ([13.66.78.82]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MNKhs-1qLS0334l0-00Oo5g; Wed, 30 Aug 2023 13:10:42 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.42.0(2)
Date:   Wed, 30 Aug 2023 11:10:39 +0000
Message-ID: <20230830111039.3679-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:k3amfqE/hLoY4y5cKNPzjrkv06tF2NBMEzk71OhI1Bsk43SnaU+
 YpQv7030wJfcIDRqegQfTyaW7JPi+8M4C0oytW0KfEBjBAKxBqXgEIGwyzP7LnHdnQwhXgg
 IoEqtnpG7J6oBvDQHU6uy/t2vviV8G0qdfIUXlzIIaIRpBNeIkWo7oRGflJXbSF+0cFZpFs
 5Y5mkEuWtUSvj4jYjH/Ug==
UI-OutboundReport: notjunk:1;M01:P0:tQ+H/A8mb6E=;FnPXNtrGOKZYqgTh9rRpj8dE6h3
 dgb9GsABlj3fAl3gcTBfJ1L9Q53hoKImgRJlr98ptR29UD5K7RPU9z72YYM3gRt/O2lIPu0xS
 I+qAdpnAxsvPhb6TG5J8bTAszw1zTj+FWQkDdaHS+d7ae/y4ZMgvZZGjPMMenIiLJHIwTWviK
 HzGty3mK7CGiWM8QLon4raH/SEtfE4bZGbg8HY4kA/My16F22liCh2utwRNfySkJWQ3u6p+5c
 CaPREixl246FvCcTA/TKN0XaoSL1KTXKYnvv6po6beYLm1n2+HFg0hYIIthGFYM/bilNdOUa3
 IefzGdUAJdu0G++Mw85Fi/u+jhAV2wzdjlt715Mk58SsgnjSnGjHXLr2Ekq9fYkdAwEKGHL9I
 aKRfYtO1OOdqtAkiGtEfRgijySlGPtzXwR6Pe2fPaUwmPA/EzJ17OnPtb2L2p97DnMPlUf+AR
 dIS53TyfFrl1DQCZCh4tGuuAtKuz+8NLnNL8xYEe7nFaO1pNPS24ZYT+zkqFPAajSSfSkwJ27
 lZ3WuWwCDyVIYcg2uC1fRljEsoeFAQvuItc1XMEy1PpzS0m2fjWfH3WzO0WYHI32EIoEVSu35
 y88CF05/qbKnMJxjN/RBWttzlN9Tti9ON1jVG+4FXz32JrZMdlHej18jnkVWrpA93+hEXSuGf
 +xyt0m3m7giKZp11ZWgGm70tHnWv0o7dXcGS4f70RxGdlCpOb1/LOUUfhyT8/B8IZgVmQKTNI
 Iyr+poRT15FCNeMjrnLZPxEyZlEa5UXQibiySNL4yYmw0J/yPwfjg+IiwSQ/SAig89kpr1ay3
 kEe9ofKPnWJHamoN6nuH2dHVhkuymxoyFUT8o1rj64rwqwsTYwLsD6xU/ck9daWi4GznXRH3J
 bxmZIC22x+9xQ5olLa3evpjpGdFmztcxzN7lLVZAnjtVZlFxJdGjdlQT09ftLghZQBvgwSYEt
 I1fZcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.42.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.42.0 (August 21st 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out.

Bug Fixes

  * Git for Windows v2.42.0's release notes claimed that it ships with
    Git LFS v3.4.0, which is incorrect and has been fixed in this
    release.
  * The installer option to enable support for Pseudo Consoles has been
    handled incorrectly since Git for Windows v2.41.0, which has been
    fixed.
  * Some Git commands (those producing paged output, for example)
    experienced a significant slow-down under certain circumstances,
    when running on a machine joined to a domain controller, which has
    been fixed.
  * As of Git for Windows v2.41.0, when installed into a location whose
    path contains non-ASCII characters, it was no longer possible to
    fetch from/push to remote repositories via https://, which has been
    fixed.

Git-2.42.0.2-64-bit.exe | bd9b41641a258fd16d99beecec66132160331d685dfb4c714cea2bcc78d63bdb
Git-2.42.0.2-32-bit.exe | f2b6257d00127dd484d94e52ea9bada743cf333fb02398260419dbc0fff10a09
PortableGit-2.42.0.2-64-bit.7z.exe | 9254a4a0c597f1c4700cb607cedd83aef2215c289a3b2b1b7475cf58d51c005e
PortableGit-2.42.0.2-32-bit.7z.exe | 213e48d5d0e86f4cf2da2d5d1012e477d58ea03f16d7008b6751c32f731080c1
MinGit-2.42.0.2-64-bit.zip | 7139f2c13667c70facd6c105d955a4bbd034b807535963b5f6fc6ed026bb53a3
MinGit-2.42.0.2-32-bit.zip | 7569cf510d1e66c0a976f617994662eb314f7e7f35edcf51caea2758a6c2a6a9
MinGit-2.42.0.2-busybox-64-bit.zip | 1cef42a21205dc53a91e2ce219f2a9eeb71665dec4901e520a7fd445044bb69d
MinGit-2.42.0.2-busybox-32-bit.zip | 9583598523a56957ff71920fafeac9e15cdcdf25010098afd59d43a6af26478c
Git-2.42.0.2-64-bit.tar.bz2 | c192e56f8ed3d364acc87ad04d1f5aa6ae03c23b32b67bf65fcc6f9b8f032e65
Git-2.42.0.2-32-bit.tar.bz2 | 64cd27bebd457592a83c2aa8bf0555ef6501675769f330b7558041d17cbb52fa

Ciao,
Johannes
