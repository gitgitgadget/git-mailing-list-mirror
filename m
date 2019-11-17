Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16ECF1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 11:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfKQLH6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 06:07:58 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45964 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQLH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 06:07:58 -0500
Received: by mail-wr1-f49.google.com with SMTP id z10so16072639wrs.12
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEI3p0N6wHHs5ASlPHywfAaZ2tTy3NJa483mQ8YBAGo=;
        b=UsjN+NOzKfTRznIVtMcOCcvrdKBZhbnRre0OePiZ+bxJPUH3NFqxEDN8PZiBBK+PV7
         nZ1VnszEgGHGhOSELrQy75Vwnv8fiyP7ThxEhGvRhVKEePtcu6BHGX9u5OoodaohHDQr
         Wf6/yPNy4O+Yv8ydkFqnxgAfvLcB8HUcp3+9C0e4QoUeH9r/6a5+v1NqJj10AbSVhZvr
         PZo76AQg3wohKGUXSPmsxYCGo+5REqgPjwxCgSmDkzvJa3hdT5nYu425rf5Q9FuxoDMo
         mKwxxIW0lDmeC78zTfuVt1NTZeakPOFmcBXL25szFkBm9IxMjf+YR3SumjyRBwqQOIwc
         NSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEI3p0N6wHHs5ASlPHywfAaZ2tTy3NJa483mQ8YBAGo=;
        b=p8ZudVq2Op6V62UswameSyRPlxZegG2vTM1Feyee0YfMLoUBh6XMMjFKP0v2s++mkh
         nBqcCf25RYbNE1NRMfUzopQFNgagFr6yTbrMO3Wmeup6ngS4clvCI9zTkP+MmOwZtrHA
         UnNM/B9bxz9derkpU/1Npd9ezSRrBCsHdDBov4lNF6GvSKvMTIZ7d65r/cntvWe8/EFI
         eeg9xjPsEH7oFsKeNEWhoictZJxDs+VTPgzhKv1xumTIGp3OaItr7ZgZFPFxuzzYzDB8
         eqq08cf4MPyRB8E+l3TR6c62WfTxhV3kEA+usAoxKnK6+wJx1rpfAH0KMvqeId90TjBk
         dlmQ==
X-Gm-Message-State: APjAAAXB34Qvp6wPbh6Ig/qoZdAZYZrKyExq+lm9X5hweqcZfS1urTjt
        3tgv89CfbDaiu5F3tlhYNmg4WVIlfMxIFqANppa/6dfJ
X-Google-Smtp-Source: APXvYqytFlAz6CzVcBSUSK4jGockip+JhlLkpVWAVXfth7GJwp2FOZ2kAh0uIjp/FDf/+k0h4nzyTjMXX5p347+PDWI=
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr15682961wrr.177.1573988876058;
 Sun, 17 Nov 2019 03:07:56 -0800 (PST)
MIME-Version: 1.0
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
In-Reply-To: <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Sun, 17 Nov 2019 22:07:45 +1100
Message-ID: <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
Subject: Re: working directory status
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Thank you so so so very much for responding quickly. I am learning git
to assist my teams skill up on git.

My current version is v2.23.0 which I downloaded and installed a month
ago. Nevertheless, I have downloaded and installed v2.24.0 and the
problem still persists.

I have the following environment variable set
GIT_DIR=C:\GitRepo
GIT_HOME=C:\tools\Git

Please find below output from my command.

C:\test\Local_Newfeature>git branch
* Local_Kumfeature_branch
  Local_MyTest_branch
+ Local_Newfeature_branch
+ Local_SGSfeature_branch
  Local_feature_branch


C:\test\Local_Newfeature>git worktree list
C:\GitRepo                (bare)
C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]



C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
On branch Local_Kumfeature_branch
Your branch is up to date with 'Lakshman/feature_branch'.

nothing to commit, working tree clean


Your assistance is greatly appreciated.

Thanks
Lakshman


On Sun, Nov 17, 2019 at 6:29 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 17/11/19 11:55AM, Sivanandan Srilakshmanan wrote:
> > Hi,
> >
> > I am new to git. I have been reading the documentation on Pro Git.
> >
> > I have checked out two working directory (test1 & test2) using the
> > "git worktree add --checkout" command.
> >
> > When I run the "git status" in either (test1 or test2) on the checked
> > out folder, the "On branch <branch name>" displays the branch name
> > from the latest checkout (ie branch associated with  test2).
>
> This behaviour does not happen for me on Git v2.24.0. When I create
> multiple worktrees, 'git status' in each worktree directory shows the
> correct branch. What version of Git are you using?
>
> > Could you please provide the correct syntax to display the branch name
> > associated with the respective folder.
>
> You can use 'git worktree list' to see a list of all the worktrees. The
> output of the list has 3 columns: path to the worktree, commit checked
> out, and the name of the branch checked out in that worktree.
>
> Example output:
>
>   $ git worktree list
>   /home/pratyush/src/git  50b2267a2a [next]
>   /home/pratyush/src/foo  50b2267a2a [foo]
>
> The first worktree is in ~/src/git and has the branch 'next' checked
> out. The second is in ~/src/foo and has the branch 'foo' checked out.
>
> That said, running 'git status' should still show you the correct branch
> name. Try updating Git to the latest version (v2.24.0), and try again.
>
> --
> Regards,
> Pratyush Yadav
