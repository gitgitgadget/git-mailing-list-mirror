Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4481F453
	for <e@80x24.org>; Sun,  4 Nov 2018 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeKECXJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 21:23:09 -0500
Received: from mout.web.de ([212.227.15.4]:37747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeKECXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 21:23:09 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPp0k-1gEPv11dMg-0050rI; Sun, 04
 Nov 2018 18:07:29 +0100
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPp0k-1gEPv11dMg-0050rI; Sun, 04
 Nov 2018 18:07:29 +0100
Date:   Sun, 4 Nov 2018 18:07:29 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Adri=E1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181104170729.GA21372@tor.lan>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:NUwKt60/Wy7lSgdG8X6vj8AHimJStreY1AcBJTYJG1HlAKqumuw
 rZV9qJxc3TH48lIS9A/xohNhht07SQNVZR+Y/TjYk6F+X06dgnVDeBmZL0XR7eSeKiSMR4B
 zCEgy7P50OJIzkpm8aCMMI26hQEiP+JlCTj2U6Va3H3tBzg4pimirSPDL433A8D3ec2+OZB
 CCtD40qzqvcpYF41lWuFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WpEjevuG5pw=:1hRAPFcqsMxJcLHipHJE5l
 xycGZsvEgE0qQyiqUOPo7a3BtqhE10YEktgyP64j/QMFP5GpXK5Ad5BCjcUj3DukaMJ11Dd6l
 WZKrKryeqYW91YHYm9L/9yh0Y5Hz2o+jUkbb6/qcbu/UlW4y0JTMfVZVchtA7JlEGzF8EE+tU
 q5h/SjJBBVELbGbmabKc/LP2P3caxcRJ5MEK8AlC4zlisiNCJHWm9KLq8P+fcTg1ZG2KM6KNd
 U0lReC5+s2ztB62u4jam2mWUGDIPIwNLMSplkDpUEexc5NxTZn8FRx0QL1mPInxkno8NAo6yf
 CbuvGH44r21tkCdEXKRKD9CZD8ny1PeFttjwDvHd0VSzZISyurc9mL0SXBJZ25kzTrG7A9tUz
 8AeesglJczKTx3rV6QT114LgMb0lVJ83T05jeVRd+d7eVvJNqrCN3djzXyn4hLG9d7rHbsPEZ
 DSnBRJ5mDkuZY72MI9n0EXjoybBB7S07sox+Ij0WZTuGfFaZ8jSaBSTO6EhrQjlF1aPfmHRdq
 gjkaDBJRInn7BqgVGN512urgbh1f7uhzmEKXsjDElgCWSNi81U4aQTb7LzJYH+dYnMQCXsYUE
 hMcyGRtsF3N5KHn7w7FzNQZ9kOi9wFqFgxwZPDXPNgPgHMjEWc+koRVLG/P8nx7vyzdnj6tgW
 PwY0wYq0vCCfsaKXYHqjgj5CS4dZcJuxQxo4qSqvF5h5bsw5oxicIFE1ObDPdCL6tGrUhJk0v
 JxZ3+SyJ5WKSMAME1jJzvt2tP0zNiGWfksk8aa10TlOzIUq5D6bbvGqIyLmSUdHd9lGu/YH7t
 obrThQnF1S+OWs6MLb7A7Tc4Kpe9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 03:30:17AM +0100, Adrián Gimeno Balaguer wrote:
> I’m attempting to perform fixups via git-rebase of UTF-16 LE files
> (the project I’m working on requires that exact encoding on certain
> files). When the rebase is complete, Git changes that file’s encoding
> to UTF-16 BE. I have been using the newer working-tree-encoding
> attribute in .gitattributes. I’m using Git for Windows.
> 
> $ git version
> git version 2.19.1.windows.1
> 
> Here is a sample UTF-16 LE file (with BOM and LF endings) with
> following atributes in .gitattributes:
> 
> test.txt eol=lf -text working-tree-encoding=UTF-16
> 
> I put eol=lf and -text to tell Git to not change the encoding of the
> file on checkout, but that doesn’t even help. Asides, the newer
> working-tree-encoding allows me to view human-readable diffs of that
> file (in GitHub Desktop and Git Bash). Now, note that doing for
> example consecutive commits to the same file does not affect the
> UTF-16 LE encoding. And before I discovered this attribute, the whole
> thing was even worse when squash/fixup rebasing, as Git would modify
> the file with Chinese characters (when manually setting it as text via
> .gitattributes).
> 
> So, again the problem with the exposed .gitattributes line is that
> after fixup rebasing, UTF-16 LE files encoding change to UTF-16 BE.
> 
> For long, I have been working with the involved UTF-16 LE files set as
> binary via .gitattributes (e.g. “test.txt binary”), so that Git would
> not modify the file encoding, but this doesn’t allow me to view the
> diffs upon changes in GitHub Desktop, which I want (and neither via
> git diff).

Thanks for the report.
I have tried to follow the problem from your verbal descriptions
(and the PR) but I need to admit that I don't fully understand the
problem (yet).

Could you try to create some instructions how to reproduce it?
A numer of shell istructions would be great,
in best case some kind of "test case", like the tests in
the t/ directory in Git.

It would be nice to be able to re-produce it.
And if there is a bug, to get it fixed.
