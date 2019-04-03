Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F13202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 22:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDCWP0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:15:26 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:52201 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCWP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:15:26 -0400
Received: by mail-it1-f173.google.com with SMTP id s3so543504itk.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oMYqm0+Mt/7AA6b0sOS5oIkMKvXW0mryuoo86NRtBAk=;
        b=NHFKZRIteYlYtXLNFWpy6pQUePKz0vchEGGDqwQTaM2w/OFnvDh+q1AgRobud/kuaf
         pz28lGyeX4Ty+8HsV8v9FdbG4CKEPpi2GccenSBu2nnG4fo+TKziHCgAwME/fewKO67r
         oa8SqbK6Ko/cBfKMcmOMqxaE/YFAlb41M8kbv70qiq6c37t8+6WIxlWqXrPaIEc+8tZb
         X9ZcVnlOdh+XR++axomRWhrCww8HJG4p8ZBc+kzwOI+3v/ADmh9jGkNjHls5iKJMNdyc
         utyC8LKieNtvon5LE5MDt4JMSjBCFFlru4s8XlbUPwQDS7k+7ZjxKqH2cV2KNZ2O0dDC
         +D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oMYqm0+Mt/7AA6b0sOS5oIkMKvXW0mryuoo86NRtBAk=;
        b=S88SRZpljQtatiY6D/1tdZ2VSQM82Jc4NJ47b/zDQbVePDKmODYlLxQ2iTHGBfq/Dk
         +4vQXWsCwF3Qr7P70QDrVnIo455Q6swaiTlPgHG0OdsIabtt6p0/zYoyJX2eZTror40F
         jijmOCc7uC5x3eunbsOhe/MYF05ZFjlY4y4DY4/GNJ1vQXoEnG0GTEqsAmDcXZzDoRQD
         vFizi0l+4orIldi3RiiZG0nv9TTBOy46Qnh+FSUDSUw0olqGv3DpGxVPBM9440+90S/l
         uAid6nVIkWOXuOjOYdlXZKKe9SyfuXilgqiI0EUAxekrYS+P6EsrNyfrQKUUHB+Al4zi
         Hx/A==
X-Gm-Message-State: APjAAAXwFWO/E2sKyRIhQ4pBsqKXZnNWy2cz1Xgjui4SVcD7ssWyY8lb
        tIBi+ENt3KmFa9nFJSkFIKIohEI7IaonaKKttsqnUAW6QoE=
X-Google-Smtp-Source: APXvYqwlHLu5oC0dSQQs6/o5KdLRKGDFEP7ODwA73WubEM5f+j3gnekl+vbYj3CLw6CKdAsCR0B0k025fIrIbAGucNg=
X-Received: by 2002:a02:b38f:: with SMTP id p15mr2318406jan.103.1554329724824;
 Wed, 03 Apr 2019 15:15:24 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Kharitonov <mark.kharitonov@gmail.com>
Date:   Wed, 3 Apr 2019 18:15:13 -0400
Message-ID: <CAG2YSPzAiJW1tH7xm9bqh00VYZrpFS4RQLZ4HK7aWoPm2RxD0g@mail.gmail.com>
Subject: fatal: ... is already checked out at ...
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Please, observe:

C:\Dayforce\56 [release/r-856 =E2=89=A1]> git --version
git version 2.18.0.windows.1
C:\Dayforce\56 [release/r-856 =E2=89=A1]> git worktree list
C:/Dayforce/tip    c80539e06d [arch/shelve/532684]
C:/Dayforce/55     1362776f49 [release/r-855]
C:/Dayforce/55WFM  0000000000 [wfm/855wfm]
C:/Dayforce/56     f9c36d3a2b [release/r-856]
C:/Dayforce/56     f9c36d3a2b [release/r-856]
C:/Dayforce/hf56   5f1837a3f6 [hotfix/856]

Item #1 - how come I have two instances of release/r-856 in the git
worktree list output?
Next:

C:\Dayforce\56 [release/r-856 =E2=89=A1]> git co onboarding/r-856/james-con=
fig
Checking out files: 100% (2055/2055), done.
Switched to branch 'onboarding/r-856/james-config'
Your branch is up to date with 'origin/onboarding/r-856/james-config'.
C:\Dayforce\56 [onboarding/r-856/james-config =E2=89=A1]> git co release/r-=
856
fatal: 'release/r-856' is already checked out at 'C:/Dayforce/56'

Item #2 - why cannot I checkout release/r-856, if I am already in the
right working tree? I suppose it is connected to item #1
Next:

C:\Dayforce\56 [onboarding/r-856/james-config =E2=89=A1]> git co -B
release/r-856 $(git rev-parse release/r-856)
Checking out files: 100% (2055/2055), done.
Switched to and reset branch 'release/r-856'
Your branch is up to date with 'origin/release/r-856'.
C:\Dayforce\56 [release/r-856 =E2=89=A1]>

This is how I forced the checkout.

Does not seem right. Is it a git bug or is it something we are doing wrong?
Thank you.

--=20
Be well and prosper.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
"There are two kinds of people.Those whose guns are loaded and those who di=
g."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.
