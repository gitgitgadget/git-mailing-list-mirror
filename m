Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC481F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDTVcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:32:33 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35604 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeDTVcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:32:32 -0400
Received: by mail-yw0-f178.google.com with SMTP id l133-v6so308640ywb.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sHfx1BzaF0N3e2mZXTgx4fP+ldY68vI/0l8jQ7d7c9c=;
        b=lGrjpUd/rVb+WJnbLkBaZg1uC5awlD54SO8fV8tf0kzIwkWkjaiJSmK8263Lw33xL/
         c0/Rq42BEHxuhcKP6NsBph/TPLfw8Ab/h1PUSD5G4R/vis1SIvF7l2ANPopO4iB1Cr/C
         RNSlmO+x8XK5WKh9k+FvD3or6GfwmYPmf3i5m+7AsOmQU2fm2aLYFEoNV8O2vttrNRGQ
         JUY/vAf/UlKc6I3Bl5j4Q1mXP+xLKwuycZQ4kSlUw5K2tdqgwYdiLr1GrggXtZRIpiEX
         Mbp9kOtvvUvqdZ02heKr1pDvJGsMedHbtZs50aofAZSzQ4mGmz2dYu0p2b4QM5bV/n+T
         VCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sHfx1BzaF0N3e2mZXTgx4fP+ldY68vI/0l8jQ7d7c9c=;
        b=DteOxqpFx3E3aGkdHGqt8G3tsLM0O06SNMXoz08yV9bXYm5WNgepKukmfOmKCjgcOW
         x7IpqGS/rtdgdG3jBDJj3KY8bwNaQLk6IUAyWPrc5G2WHd0JvQP76+AzuLCPJ4iqIkjb
         ROV7c/rrBBkY0WUV4Q1oiNvQ2xyndHYlqde8ppah4kbitqkiPCbxJnnQpfSO7mwIvUkE
         GhwyCrAUirmQiDCEtq9NQt/zz9Ftpgis0AXoAtwH5FKRk0XwNHghUXHcm7B5O+9U6DLu
         0gi3GOEft6LfqPvg6Udzk+ri4yQDWdexbb39sDKdoI/DxEyclfrhLX9Y0Wjj7Dm6KMhc
         d61A==
X-Gm-Message-State: ALQs6tDYXzzyDA4nB0V6J6r8yiOqVhhank9GEXPLXo343kTWwpDEx3TZ
        ldA/DN//7bV0AzbPJhQzlyjRWpw6MBew6btCnUNsRUfG
X-Google-Smtp-Source: AIpwx4+fKEHTrakCTkfc8tT77Rx13ipyYsi6Td1rqfmkPJjLGbSUBMiEJNa8Q+JveZSy611D+2LWai4QiYsnoht8Pfk=
X-Received: by 2002:a81:9ed2:: with SMTP id v201-v6mr6812051ywg.288.1524259951301;
 Fri, 20 Apr 2018 14:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.230.146 with HTTP; Fri, 20 Apr 2018 14:31:50 -0700 (PDT)
From:   Yuri Weinstein <yuri.weinstein@gmail.com>
Date:   Fri, 20 Apr 2018 14:31:50 -0700
Message-ID: <CAMSYVsc7c3Gw7OYLDRi5GiZX1m4Cx=eGJJUutRTX9Bn=z9EDMw@mail.gmail.com>
Subject: Feature requst
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git grep xxx" currently does not follow symlinks.
Please consider adding this functionality

Thx
YuriW
