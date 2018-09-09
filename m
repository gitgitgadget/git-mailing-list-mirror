Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90DDA1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeIISUx (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 14:20:53 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35145 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeIISUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 14:20:53 -0400
Received: by mail-io1-f50.google.com with SMTP id w11-v6so4912271iob.2
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8ceTm+Id6KP4ifGFQEM9cDR0uqmXl2t587JU6us6dWA=;
        b=L77wCW0TOuIrenLEHwaD1yh1AYeJ4zFuvaHH7+R2mQcnrRGNvWa1fSKmRxnC4IUD/C
         xzDO7yKgcvVroVSyF5Q3k60ovc8UDyDfzASGIoxUnEv1/GMKCE/0JCwMXDLVCQXtl25l
         vxTVYzIr0rTfPJbgSlHePK5dimNhirvnBwFE3X2LBe90mqpVHjgDCglWpwKt721XzVKG
         8BuzLGuj9NVNuojzTEV9gkcHWNwYO0f/wFq02nOQLleffsQFxRIq4AK5+pESsGk3QKDK
         Z+Guwg8RQPsmuyKZiowkk388NyCFI4BOGf4JPJSF87buah9dijGUUzQlXUw1aQf9JBBf
         QsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8ceTm+Id6KP4ifGFQEM9cDR0uqmXl2t587JU6us6dWA=;
        b=tlcN8XC7mK9lpF3BO+qg6EHRehwv1AVs0UsmAOHeT2AZ2Y571GC2oWcDCJMpMx+O1Y
         i+gRdafmMCSRPGlP6QIyhHMqTZCInku0pxGWYLvInmMEIf7Mhdd2/9QZDvJOts6RNNVJ
         YFpx6Qch0e4MlVLs6VGGaf6O2q5EefxJJVwuJ9aitf55EpRj5EHz/NHcJVnJVM6Wqwr+
         klcvqzwB1OLCJ14FkOEMSdgLiP5pLf70DNw7ZM/CfQ4C/4aPWxeaEQN+EpDsNeSbAs6i
         DI12drFYNMbgv5IIffpA/nRrTJDBlsDcGMRPtv2t8arDIMvuReWqmxQu9JYgwGyk1HxJ
         apJA==
X-Gm-Message-State: APzg51DRSMZCS3KPGLbdajjp3KhKQmJg/f/grN51OdYpprOYVWPcWcDK
        wVfX3vEs92zPElip1OotVhv3OxuuYQwIg8Xh0YwHTA==
X-Google-Smtp-Source: ANB0VdYhV4R/+namzFt+7OdVyKW5/O61oZ8rtZTaXxqAuTCMyBx4QjyGP0YkaGfo6ARgZYQ0yo7QUSfacGCotV1Bohk=
X-Received: by 2002:a6b:1f4d:: with SMTP id f74-v6mr12902436iof.206.1536499870272;
 Sun, 09 Sep 2018 06:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
In-Reply-To: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
From:   Dylan Young <dylanyoungmeijer@gmail.com>
Date:   Sun, 9 Sep 2018 10:30:59 -0300
Message-ID: <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
Subject: Fwd: [Possible GIT Bug]
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Works:



git show -C --find-copies-harder  055f6c89fa4506037d1621761f13430f469b8029

git show -C --find-copies-harder
055f6c89fa4506037d1621761f13430f469b8029 --name-status





Doesn=E2=80=99t Work:



git show -C --find-copies-harder
055f6c89fa4506037d1621761f13430f469b8029  --  PATH_TO_MY_COPIED_FILE



i.e.

--- /dev/null

+++ b/ PATH_TO_MY_COPIED_FILE





Hope that=E2=80=99s self-explanatory!!!



Best,





Casey Meijer
