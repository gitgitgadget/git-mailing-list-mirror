Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF402013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBOVGt (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:06:49 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38875 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOVGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:06:48 -0500
Received: by mail-wm0-f42.google.com with SMTP id r141so1320076wmg.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/S+O1tgV9SH7iwFDK8CYUwhoxw/wBhU1H4ZN6peBS68=;
        b=vArSHp2IuW+xi321Zq9uuza45aGVA4MckzyziLNZi45RWO9ULZTy2UY9lU880EOI+Z
         fsH2yjigEC2WToUVpTA7tnx1LTWWc6HBWbaClqxoGRpyC0SKDcsz4eoSy2K+lep4r/Oi
         pZPU4rGtDIK1/DlfKy2gOIaPye0MYO4+jK+HVI7OCenYMRmIyu85ZqJBRErvDtKx4z68
         /wjBwG9q5pCL/MEsR33LS7Ff48YkF+bB7sXLCeoOtspvN7DY49L9/ko6HY/jdyl/S5A9
         JZoL4lQ3SVO+P7j2BOzN64YOA9TWQrIv8mD/MTqMnfwtneSwZv5eDg4kD7ZILnpQx1pg
         pCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/S+O1tgV9SH7iwFDK8CYUwhoxw/wBhU1H4ZN6peBS68=;
        b=N4tfLMTEp3zPWNSb61VWjNFHZyOshHGJAgVYsCrtxeKt3z6UMvxIaWuA3j9ykkKKlW
         amJdCJqvngxcTOFOI+bIFbiWiNZIEJ880PmEMvwr+5NOVh7Rjq8pKmtdIs3C34piRoOr
         H3yAqtYcVWOEW2W8A81BNE+f3ef0e9hfYgez/ROEYDt4EhfDn2AUYvnDF46M+CN0dEVM
         TtgyE7VnDjFPqjUJvkeXJwFyOYoNWuoz49cP+opuoM/uBDJvL922Ia2+EHVgz/uv+nPN
         xTgrB5SInXvcGR5iyXAKoJh3nYZRJjWouunnESefkz4gb8cqNEVvAU58qjenNk13dLmB
         3DAg==
X-Gm-Message-State: AMke39lo/ODjpfAS6fgZfXPNG6BnnukVds8xGWdJtKHXjEM/Qis1Jx2BN8KtItLR8NP1QhHeyjcAyPWvPuVtBA==
X-Received: by 10.28.17.20 with SMTP id 20mr9972967wmr.106.1487192806767; Wed,
 15 Feb 2017 13:06:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.138.211 with HTTP; Wed, 15 Feb 2017 13:06:46 -0800 (PST)
From:   Fabrizio Cucci <fabrizio.cucci@gmail.com>
Date:   Wed, 15 Feb 2017 21:06:46 +0000
Message-ID: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
Subject: Back quote typo in error messages (?)
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

it's been a couple of days that I keep noticing something (very minor)
that my OCD for symmetric things can't really stand.

If you run the following command:

$ git branch --i-dont-exists

you should get:

error: unknown option `i-dont-exists'

Shouldn't the wrong flag be surrounded by two single quotes instead of
a back quote and a single quote?

For the sake of completeness, I'm on Mac running Git 2.10.1.

Thanks,
Fabrizio
