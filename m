Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD971F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfA3SgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:36:17 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:32808 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733011AbfA3SgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 13:36:17 -0500
Received: by mail-io1-f52.google.com with SMTP id t24so470431ioi.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UYyL0oeQl3wIhRM3KmnkhDP+EsAnZwTsWsl65uWAuK8=;
        b=YeVvzhtVKpRo1QGsd9HBy4lENSzps0vg6tQenrzh2HQnxOrqCgSod4BKRo84cDi53y
         deHkQgzSFxXiv0bzsVo2BUk/MZcrkXakQ4WzLVD5OPDX+q/NF7xTP1N0KBpJcS+KbMFD
         QeiYpKyA5rT/gcDOrFVGolmLnR7Yt1pBB7k4pP7ev4fPi8ZexdQb7KM36uiHhN0BvPaH
         DHjrviQwvtb+OX/y9t9uFgpFJlNGW2Alo3KzjlDhk0s19YMkgL3mEng8GTe0g0NUTt5A
         N1vaCYcJw+28f1InLIBZH35fe0UVjRpcofyOMrwOGAv1WdZSsi+E1A4R1+hRK/NKJd/+
         pjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UYyL0oeQl3wIhRM3KmnkhDP+EsAnZwTsWsl65uWAuK8=;
        b=eBFwoX0k8EPV4bGzuWLceF+Qf4IJp0S7PZ2qHJPJ39rWLq4P2ptvSX2RRqjoGNzcoA
         3Uv86/2NhFHJrEUcZZ9UVb1CYtyCUnhmP/5i9SheyUDUh3blZUPd2sLIhq/OlmXTObTJ
         RSRGUmEqFkueYutn4Xa8JfoZrAXxW62KOXnVFQpkZGcVvjlkbfQujAu16WuXjsFCyfBi
         BeYWlisX4AJQjAM9qh8HZ7a/5Z7f9rkRF9vIr00U3QzGE/IYJ7Uge+Vf96DrRLkDxA4V
         SqMh4rZcgk/Ufv2ECMoYQICLlmn24To9PTRSuzl7lRC1i4kZEQxaaorGAxfxivBRxOrS
         z+JA==
X-Gm-Message-State: AHQUAuZvYp7Gw0ud9tu2Wz5bqlJLsY+oFOwHOFNhDbHr00XyYDl0DmSj
        Y5EXVn9ljaL7mhU+aUzXEu9Pyw+4bwCQi8iLWLrVJJMSK/k=
X-Google-Smtp-Source: AHgI3IYEwQ3h2Egb171ieQc3aTZyXFNH09YhJKDHDmVKXDsHiHIZcrApLyGgEt4/Z/LJG78RhFsbGEYgYOKZC1ApmV0=
X-Received: by 2002:a6b:6e10:: with SMTP id d16mr161430ioh.232.1548873376675;
 Wed, 30 Jan 2019 10:36:16 -0800 (PST)
MIME-Version: 1.0
From:   Alireza Alipour <alirezaalipour517@gmail.com>
Date:   Wed, 30 Jan 2019 22:06:05 +0330
Message-ID: <CAOYf8At-gCD-Ctm9RevPLSkrfo+B0fj8oXtC1uzxAcntPp9ggA@mail.gmail.com>
Subject: =?UTF-8?Q?What_is_=E2=80=9Cunable_to_open_object_pack_directory=3A_=2Egi?=
        =?UTF-8?Q?t=2Fobjects=2Fpack=3A_Not_a_directory=E2=80=9D_error=3F?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone

I have asked this question in Super User but I have not got answer. I
have described details in the my question__ link in available in
bottom__ but for more information I add following info:

I checked one of my past projects and I notice that
".git/objects/pack" directory exist but there is not anything in it.
Now I want to know that what is causes of this problem? And what is
work around for this problem? And also I want to know that can I
continue to commit on my current project and push it on my GitHub
repository without any problems?

My question link on Super User: https://superuser.com/q/1398971/660238


Kind regards,
Alireza Alipour
