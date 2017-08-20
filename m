Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD1420899
	for <e@80x24.org>; Sun, 20 Aug 2017 17:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdHTRmQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 13:42:16 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34861 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbdHTRmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 13:42:15 -0400
Received: by mail-wr0-f176.google.com with SMTP id k46so6135033wre.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pWlpkpZF9rbXDDHXUjN3gPON8/tVZBN7bQLTiy+J3tw=;
        b=SLVCSkgdELR3SludpQCz6qjaxSB1oOKVM/bA3rl6ErI2wb1W5cz8MYlhnlv7hMnbzx
         ZLeNa4Lcs0aeQD/l9B3BC9/T8Blj8fxqlwyJHk+vd5f/ug5jlEyg0yvyF5sT2kmAmcIn
         U4bVyTwsHKgSbj6JGsc2JOkg4GqVsXIBZD7/CTwNjoAichW3VBGjfRjz5OSGdEYFjuRl
         EbyJY7HbSXB5Lx3A1LH8lpEAntJNY+GjQpOK5rcfI5sVN8zOpG/673FR6AxAAgekThPT
         PB5ZdRLQnoOyeC2pSUvTDCjv6gF9cscy6qwwYuVD7cpUpn/9kCMGpFYUmgTlNcu07jr7
         803Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pWlpkpZF9rbXDDHXUjN3gPON8/tVZBN7bQLTiy+J3tw=;
        b=m5ksEc3K+yrESCqJEVkf0H55UDnKjp0Vz86hT9w+mbwHkfn+v+r+Oge8oDjOMHoGpc
         LtXmscVAuW+xxIqumGh/toiOeHJKgsb5OvOm8oap65k8Anavl/dw4nTF3nTEHA4gX+Xj
         QOaO8nXWm9VByc8TDYNST9scJc5gsGxqMMmaCuLHRbh/YoIh1+sNVdozEDHsB5iSau2g
         Ud9/+ARDDaO3ThY3l5Rpty4B43k369sq5Gs66IMOcMgN2sYcHCNqvDYTPK0c8jksmVW1
         am4EENYAjhqTuvnwypT9LpWqANldwakuDfY2JuipM0abZasbUm7giiK/j8ZqEPQqYmuW
         k6vQ==
X-Gm-Message-State: AHYfb5jBxk6vncsRhAleWLANDrkndThQisFmLUrp+Cva1C/jUta/MaBa
        pIyVjHTUin65qg==
X-Received: by 10.28.64.197 with SMTP id n188mr1474946wma.135.1503250934246;
        Sun, 20 Aug 2017 10:42:14 -0700 (PDT)
Received: from p2003004d2c4cd6c7a02f4fdc39678fd0.dip0.t-ipconnect.de (p2003004D2C4CD6C7A02F4FDC39678FD0.dip0.t-ipconnect.de. [2003:4d:2c4c:d6c7:a02f:4fdc:3967:8fd0])
        by smtp.gmail.com with ESMTPSA id s86sm6991448wma.10.2017.08.20.10.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 10:42:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: git-svn: Handling of branches created from subfolders
From:   Jan Teske <jan.teske@gmail.com>
In-Reply-To: <8c910a5b-ed96-41d4-d157-f138af51011f@gmail.com>
Date:   Sun, 20 Aug 2017 19:42:11 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74EA70E5-0B8A-4D34-B5EA-8C97A10F3D0F@gmail.com>
References: <1ED00C5D-177C-4F95-8261-BFB7345B7C08@gmail.com>
 <8c910a5b-ed96-41d4-d157-f138af51011f@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20. Aug 2017, at 12:27 , Andreas Heiduk <asheiduk@gmail.com> wrote:
>=20
> Am 19.08.2017 um 14:45 schrieb Jan Teske:
>> Is there any way to fix such branches from subfolders in a way that =
they integrate correctly with the converted git repository, without =
losing any (or at least too much) history? If this is not possible with =
git-svn directly, maybe I could prepare the SVN repo or post-process the =
converted git repository somehow?
>=20
> You can use `git replace --graft` to connect the first commit of the
> loose branches with their source. After all connections are in place =
you
> can use `git filter-branch` to make the replacements permanent.
>=20
> This will not change the content or directory structure of branch1 or
> branch2 but the diff with their parent commits will show up as a huge
> delete/rename operation. So merging/Cherry-picking between trunk and
> branch1/branch2 will be ... challenging.

That=E2=80=99s really helpful, thanks!

I even solved the problem of the challenging merging between the =
converted branches and trunk by using another filter-branch to rewrite =
all the commits in branch1/branch2 to make all their modifications in =
the respective subfolders (effectively fixing the directory structure to =
fit trunk). This answer was helpful for how to do this: =
https://unix.stackexchange.com/a/280229

So, for future reference, the following post-processing seems to work:

1. Use filter-branch to move all the commits the the correct subfolder.
2. Use `git replace --graft` to connect the first commit of the branch =
to its correct parent commit.
3. Use `git replace --graft` to add the missing parents of any merge =
commits the branch was part of.
4. Use filter-branch again to make the replacements permanent.


