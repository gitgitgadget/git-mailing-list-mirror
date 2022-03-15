Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDBEC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351449AbiCOVFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiCOVFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:05:35 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CC3204E
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:04:21 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v128so233208vsb.8
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jsl3yk3+tI57JsNRSzcn9SBeKoBcy029dPuXvSEIwps=;
        b=ESPA6yzA9RPVC8DPtKPWf2RYvWiFr3xTwR1v05iUHOnMORbv19UZ5aiOs07ilorVZk
         9fyGqVuMvuPHK+PDvmkoGIQ40jEOAvcK5amEdQwQDmP6S9th1adf1wg49wFv3TMeHr1+
         xJVHlTVdpxLiDOrpehVcjGrNIyNO8iFbFqpQJbzrhG6H1HDYZaGov9Ljk+INuWZJV76r
         C8T9iwXjycYPm/mWNeTbQQj2iPtXj6f+85c0zcTxkvogWcMUY4OYzBCyMU+4sgTjjWba
         C8eHHCXVFYKw18F+WHSR7jXZQTsU7vxJnUHIvkBPgvm55rU/1H0gc9TN4q6c1XUqnsvi
         /joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jsl3yk3+tI57JsNRSzcn9SBeKoBcy029dPuXvSEIwps=;
        b=sG1s/WfM1AxibyxdkM2I/vFzCUEOyPSP8+uAXteyFJ8XY2CuNAy+M0flkUMLDEGRPi
         XA18TZSyGi7fshtHdzxSQqRoDnDWm7dbrjvgdG2To/384IZadnOcKY/u9M1poIbzA/XS
         pcwlrEbow6ZI6tO5BqtIIZ/6SqoljDOiiea0AQoz1tLMvKslkSe7qzAuTuCjA3VEExVa
         pP0duHet55IHhaqFnK406PpoGRuJUtZnXnlHdCq57CkTq+yIhMOD5yKS1Why8ddlbY4l
         S6h61McTX91nsgn4YtZSv4YLECJcJrgDnfX5qeBZoZLuzHGwnPACgTT+AaU6vdfLreI6
         o9bA==
X-Gm-Message-State: AOAM531jZFUe2Bv/XJzJxkSq9Gza+vfdE7ZE/EKUw1aF+5YCsldxG/vE
        Plx/Av6Wwb0p/JNN2LhLudj/2Pe7oagpRbwBNcGtPfnGUULnNg==
X-Google-Smtp-Source: ABdhPJwuL9trK7hKQ4FPBBOy5KkpwDH+X7T8qEaUj3ivAPAYCyAFLwZckttFURKffAmikJT1YfpDfOLTxmquwr5ksf4=
X-Received: by 2002:a05:6102:284a:b0:31e:c455:5dee with SMTP id
 az10-20020a056102284a00b0031ec4555deemr11152944vsb.27.1647378260061; Tue, 15
 Mar 2022 14:04:20 -0700 (PDT)
MIME-Version: 1.0
From:   Alice Merrick <amerrick@google.com>
Date:   Tue, 15 Mar 2022 14:04:09 -0700
Message-ID: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
Subject: Let's have a user experience workshop
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

I=E2=80=99m doing a 20% project with the Git Core team at Google. I've been
encouraged by Emily Shaffer and Jonathan Nieder to reach out to the
Git community to help incorporate UX practices into the Git
development cycle. My goal is to 1) gauge interest in improving Git's
user experience and 2) recruit interested folks in organizing or
attending a workshop where you can learn more about what UX is and
discuss ways to bake UX into the process of making changes to Git to
improve the experience for all users.

Some additional context about me: I am a UX (user experience)
professional at Google. I have experience applying UX and
accessibility practices[1] to developer tools for searching,
reviewing, debugging code, etc. For the past couple years I=E2=80=99ve work=
ed
with the Golang project on their websites and helped set project
priorities by collecting community feedback through their annual
developer survey[2].

Interested?
* Join the git UX Google group (https://groups.google.com/g/git-ux) if you
are interested in participating in an event.
* Reply directly to this email if you are interested in organizing the
event to discuss git UX (scheduling the event, sending invites,
communicating with invitees)


[1] https://doi.org/10.1145/3411764.3445544
[2] https://go.dev/blog/survey2020-results

--=20

Alice Merrick | UX Researcher | amerrick@google.com | 206-785-7532
