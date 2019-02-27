Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ADC20248
	for <e@80x24.org>; Wed, 27 Feb 2019 12:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfB0MiU (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 07:38:20 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41020 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0MiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 07:38:19 -0500
Received: by mail-lf1-f43.google.com with SMTP id e27so12353803lfj.8
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 04:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wright2-me-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=f49Lp74J+Lj+qVEJEXQJANVUC1IHATPE5SZSqL8Z6pQ=;
        b=sSo/8EtycellkAubI8KBi6DD20Y1EdoLDlYnq1Kpp9MecoIBl4W2So/T+IpxTcjwsk
         Q3p4Il3TeBITHeizg6gWVR/9sNrmnuVvb9bHAdiOqychkGojI0bW9yDuXywTcE7BEH3i
         Y5VySmKslQj/Uv77fKETp7161CNYzU8ZBc8AeeJ70lqAkkh+AyviViWGi109CtoII0wr
         nS1WcsyxTmo/pd9115jx/1QOEujv+uwFsazaaWp0s8Y0VnQSkExZTCY6xJaoIm1pYQrb
         +vukN0NwjKczo4qvrhxIrnN+u0Qwl6j+C165/vXTu/KqnRKp6qjl0oSfxHTux53k8SPM
         Iosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f49Lp74J+Lj+qVEJEXQJANVUC1IHATPE5SZSqL8Z6pQ=;
        b=DkQu01YRSvqkkol+JOp/bbJ6gTpVquI7lDAtoDUme3nw9QAeVr09qYh22tQwy74RPT
         kIvi9bJzGYQJ+OFM8OJEgHUnNbNAsnQqLBrcfP7S99FUJMhpVSbKHAQl1W55dwtn6cYl
         5lAc06ecMpJGoTNzmg3OVjhzcN1cXa24IkBntJHKw5b/1a+tK2RBtOVjkJ53gadAfGMT
         A+rnydY/RCJnUSpsi2IKhkwZ9KQ6r/ltZ4epSHMazEnaQkc0HS+K+HTcJEafho5y4AIQ
         f4wAndH2YdmBntRJCX2GEEtzCoh11TwIMl6fuYzYdQ52BDS+3D0dYLPY/0OLLP+hhGBY
         mAEQ==
X-Gm-Message-State: AHQUAuYBKZFzYmwwB8WOFDE2s0mdUe9NB8mB7sfVJaVS38No5JP+hKld
        0tHCyKZ9ncHtDW+JMxA7J9JHhNukloymRA+jBsZm3vEhM8sVmA==
X-Google-Smtp-Source: AHgI3IZB1d2nHq55huPWp3e5Qn4g61iU6laphsYZBLFopNFGatw6P5uDU/qQjQCjesLYo5nXP+F9BUVIMFQ15xWF6ck=
X-Received: by 2002:a19:691c:: with SMTP id e28mr762662lfc.86.1551271097464;
 Wed, 27 Feb 2019 04:38:17 -0800 (PST)
MIME-Version: 1.0
From:   Adrian Wright <adrian@wright2.me.uk>
Date:   Wed, 27 Feb 2019 12:38:04 +0000
Message-ID: <CA+LT4LV4WBJtgDOene7i9UQmmkB20L0Zrr=XDzs4j197+uC1jw@mail.gmail.com>
Subject: git case sensitivity issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am a  git-for-windows user and have run into issues with casing on Windows OS.

I filed a GitHub issue directly on the git-for-windows repo:

The issue can be found on URL:
https://github.com/git-for-windows/git/issues/2066

See the GitHub link above for more details on the bug.

According to the maintainer of git-for-windows this is a bug and the
bug is with git not git-for-windows.

Are you aware of this bug and are there any plans to fix it?

Thanks.
