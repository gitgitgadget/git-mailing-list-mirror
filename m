Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E211F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfHOVG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:06:59 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:36523 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfHOVG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:06:59 -0400
Received: by mail-yw1-f54.google.com with SMTP id m11so1157587ywh.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LD7lHolqcRHvCJLXcZdtsIEt7qFSgyMtyvrJMBskLMs=;
        b=VvlGlJaRPkGL9BTFpcqta82/1G1+cKE8DmM3In4KJPomFMYvcOwDHKPtPtGwEcgm46
         T/7kZv4ndlfsXs8QzAB36I+Uwcvu0LomxEtvYMkug7PwP2Ai3qZCuMRDiECqLoUexKnl
         IMEeodQ0fzDMDcU6oMXnsUbUSJwejpQilBIet0bAqyuny9hl6cUB8rMRlMC8b9jfKpga
         JV4AVuTCNklViyE2khWRC7vH6JZO4/zg6467YC2vy/GWpJOFl+uOmlQWn0fAmdcC+CZM
         PDfofj7oHYwpY7lEH2uvUvWLvCHi18RsuTe1lTHw8o51go3w8b8AeMMiu1SSEKzkSD6j
         +Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LD7lHolqcRHvCJLXcZdtsIEt7qFSgyMtyvrJMBskLMs=;
        b=dsa40TMHdzukrd/jhpvLvl6WdcFZFkUII59BZzn9WhXRLT9FwEfey0xarHBw7RGF4m
         nOCisvZJke6exJjaxBXPjczsxK3xhxDwlfA2IUg6zKYVi1u+VPx8Jc2vhHvA31QfoUAM
         ORsmaOEUZtLrXb4XIcQCM4oeCYeDamG5+dcGNPfCTvg75wQ+CsQW9krg6SXPZnEEJpYN
         Oo4OVRlwnSm3KXQTgsDFK+u3be8JfFnmV4yNv+ByIxsd37kTs00ygk1NbtWER3nWHVRm
         a/heGt383BGMiCD79xiBv04zwzdB1R25vOmwkaBOy13hLg0cxLZCJdlasiVwGe/ddOkv
         WB+Q==
X-Gm-Message-State: APjAAAW4ol3y1HipAMPA3Fqwmw4hMtBZeb8VfuvHT2rVpgqCQmZK+uzV
        yEiuFJBwTCEHwvT2N+FZPKLjHP6MYz4pF8IT4eY6CWO9
X-Google-Smtp-Source: APXvYqyeqrM/9cTIwqVIeSWzEmnqz1AZKZxihm2+k3nmjkb2iYt8B28ZirJ0MwGWLSc5i8T7Daphq4tbJkIr/4S/RHQ=
X-Received: by 2002:a0d:cb15:: with SMTP id n21mr4641939ywd.130.1565903218338;
 Thu, 15 Aug 2019 14:06:58 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Tillery <rtillerywork@gmail.com>
Date:   Thu, 15 Aug 2019 16:06:47 -0500
Message-ID: <CAAZEOjv+y8y6z_stqqZFAVe6SqCH1upvhYPeqAY=w49EGdzK4g@mail.gmail.com>
Subject: QGit 2.8 for Windows?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QGit's README (
https://github.com/tibirna/qgit/blob/master/README.adoc ) directs me
to this mailing list, so forgive me if this is the wrong place.

Is there a fully built version of QGit 2.8 for Windows?

The latest QGit for Windows I can find is 2.3, from 2008 (
https://sourceforge.net/projects/qgit/ ). That version encounters an
error every time I load a repo (deprecated command "git
repo-config..."), and I see this has been updated between then and
now.

I did attempt to clone and build, using the instructions in the repo,
but after several hours of trying, the binary I produced will not
load, with several error dialogs, which appear in differing order each
time I try to run qgit.exe (and the procedure entry point doesn't
always appear):

"The code execution cannot proceed because libGLESv2.dll was not
found. Reinstalling..."
libGLEv2.dll is present on the system in \Windows\SysWOW64

"...VCRUNTIME140_APP.dll..."
I do not find this on the system, in the Visual Studio files, or
available online (I do find VCRUNTIME140.dll).

"...MSVCP140_APP.dll..."
Same as VCRUNTIME140_APP.dll

"The procedure entry point
?qt_metacall@QProcess@@UEAAHW4Call@QMetaObject@@HPEAPEAX@Z could not
be located int the dynamic link library
C:\Projects\qgit-qgit-2.8\bin\qgit.exe."

Is there a pre-built 2.8 for Windows?

Thanks,
Rick
