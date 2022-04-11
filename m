Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA81C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 10:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiDKKUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbiDKKUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 06:20:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58017A98
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:18:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5so2301483pjr.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+rse62KILGhv11KLGCmCaQfNw8X1MikUXg4bVGiS9pk=;
        b=mkNWCIulbm6UYAr+ebx0fEtfSWcQ6D6j4PkeafGG9uOQlDl3IbJ8GdKml1+9ayXeXz
         DIa3OB3Os/Ewz7OC6Drxjcmbngea4vEcUy5oax8zpwi2sS0rwKPD2EMS4o4hQImDr8s1
         ffFkyuVMkff/sFPyxuK5X9pLeS4jroj6OkEA0fq8EWMovoGF0ccekFMFlMgTDm9Bm2cd
         CH0S98V5cLMhj3nkZ1adj73Z2h0omiOn7h7UuBO4RcEqQKgoSyG60P0goSh42z9j8Qdy
         ogeCbXdhnkQcuAnB9x3idKjdoH8ar09VQtI50cceoO21h2g+mLPVdQ3lKcdqrN0HYksB
         s50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+rse62KILGhv11KLGCmCaQfNw8X1MikUXg4bVGiS9pk=;
        b=T+8l4ToC/6XbTIZXZF4T8jXVHflvZ1ZyC0OOYgczXmo3gutcdgtRFaAyHtWej13xfN
         zkjYYEiGJB2KYvJX7BYEn2D7WJPW0zWoxLjkK8ABW/OeH6mhqRux2ZFKeiySFn3E6D5c
         dFJRXuzxVPBddODv65DivEDZP4cs3xduXFEoEVnKS7yhJ5vhFf9kmGlsjaqXVnRoOFmx
         hAZ5IVXyc0DQwGjc6Ol6nWQ2iQp5jesusOn6wgIuUJYxRwMoRr869MApYLoTklEoybIg
         pIr9J3pkb5R8FHoisVg35Pr6s++AJNUzO3drkyXYATUqih4VPwYT4CjJoGqeqmJfD0Gs
         HS4Q==
X-Gm-Message-State: AOAM532yI5qdc/AYlFuEi0TQ2veTYwTGuodQIHlm83+VfSZcZyr99RPY
        eQ+R3WTW9SbsswKngUpStt0DG5VBEfMMAjJRkrULHqsGj9k=
X-Google-Smtp-Source: ABdhPJx+8+Bf8sPuqt7pZNpBZ4E2tHxpsnXOJ/lMDrJ7Lf0LkyyAuuRAmWvE1+IhuKMrJuMHET1TEWftKslMuevMXWQ=
X-Received: by 2002:a17:902:8e82:b0:151:777b:6d7 with SMTP id
 bg2-20020a1709028e8200b00151777b06d7mr31411541plb.172.1649672311752; Mon, 11
 Apr 2022 03:18:31 -0700 (PDT)
MIME-Version: 1.0
From:   Jorawar Singh <jorawarsingh12@gmail.com>
Date:   Mon, 11 Apr 2022 15:48:20 +0530
Message-ID: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
Subject: Git user experience workshop
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community,

There's been some conversation about holding a workshop focused on
user experience [1]. I've volunteered to work with Jonathan Nieder=E2=80=99=
s
team on organizing this event.
The purpose of this workshop is to help incorporate UX practices into
the Git development cycle.

When?
Anytime between mid-April to April-end.To get a consensus on preferred
dates, including workshop duration and times, please vote
at the google spreadsheet link [2] below by Friday, April 15th.

Next Steps:
Once a reasonable consensus has been reached, we=E2=80=99ll set the date an=
d
time, and ask for RSVPs via email.

[1] https://lore.kernel.org/git/CA+Yb-VSaeKy-g_ywkZzQuEX=3Dk3EXM+Ky-rHOb2az=
0SHGVbdaVw@mail.gmail.com/
[2] https://docs.google.com/spreadsheets/d/1Z2QEveILRG9HEDlMhf50jTVhxaPFh8q=
_yK7K8RUsvdM/edit?usp=3Dsharing

Thanks,
Jorawar Singh
