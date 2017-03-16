Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B0720323
	for <e@80x24.org>; Thu, 16 Mar 2017 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbdCPQfR (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 12:35:17 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38509 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbdCPQfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 12:35:10 -0400
Received: by mail-it0-f41.google.com with SMTP id m27so50608831iti.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Aq6C6Zd42DrrQnzhNYIwUcs/+YZHloEvnNbJRfz9o/0=;
        b=aw2i4GeJzK9FnoS25zgvXdpXXs12o+vhe4LKmt3QJYn6YdEbfQcgaOAWmA1cHg1Je1
         IruNOnmXSXin/JHO9qj5PbaSYYGOBTqQbQ/KCF5dqKCz8kJ6A3qUqjJbMZ6SMF3IS9dm
         F8Y//Yo+zYPNiT2gan/Ujiev5k5hdrkRrCn2CSJgTdjkEdYbWvjsTGTNZfvUfWFyyFmR
         5hnQixe6UsRslkl3mkcToFdIJ7zc3fPvgjbRvyjOaLKzkyBg2ZBAGuyj3FLZehPgn6xk
         25Lg9Pl7NPnKt+HepTdUxeaI4o5Wjl+jJDSi8V0B3XSEqrEeTZBG430Te9k84wpNMgrn
         HcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Aq6C6Zd42DrrQnzhNYIwUcs/+YZHloEvnNbJRfz9o/0=;
        b=s+T+2H1zfqtIJQ4w23n9016Cf2uiONOPLb/+4b6BeBGYZeB01N+hixnJAZVETsvBt2
         UTIH8tvgx2Dno3f+rktap8Sr+lxtj0gM50a10ayIP1NNTRlRX1cuBg+z3Zb4fEYY+84O
         LL5bECcjSzH4adYkI+82RrzxO0Sk18w3zP3Njt25LQiv3leXM+M473BZPSqtYErQmLv9
         jFCLTIiimqrwq7mVKhv6tHFjGM3jeeqTNBJugbD9zwRwu91cJC+cGZ8YJpXS9uVk5SaE
         HwZNzfkS4UdFizg56/jgbjir/CrbbcI8LLcS5WIf4NfCu6mugnGtISq2ej1ctoJsOHFH
         9Ogg==
X-Gm-Message-State: AFeK/H3VhtC64AqYK9Ngj8XjMiFhBWWDrMGGsuxtg2025WojbKgCPw+gY1HckKbZIJb8LKH8jbBlSffD+FGC6w==
X-Received: by 10.107.19.222 with SMTP id 91mr11898353iot.211.1489682095749;
 Thu, 16 Mar 2017 09:34:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.144.198 with HTTP; Thu, 16 Mar 2017 09:34:55 -0700 (PDT)
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Thu, 16 Mar 2017 16:34:55 +0000
Message-ID: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
Subject: Viewing untracked+stashed files in git stash show
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If you have some untracked files and your run `git stash -u`. Then
`git stash show` doesn't show the untracked files. Is there a flag
that can be passed to git stash show to report untracked files?

Thanks,
Okash
