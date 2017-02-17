Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72131201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbdBQXWs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:22:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:61321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964851AbdBQXWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:22:31 -0500
Received: from [192.168.178.43] ([92.76.250.75]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1ckweo3z10-007Bo1; Sat, 18
 Feb 2017 00:21:37 +0100
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>, git@vger.kernel.org
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
Date:   Sat, 18 Feb 2017 00:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Z0QzWlga40iBnS48s4o8wjNWQ/0uxT6kxr/A1HxPD8pbJMCVql1
 H7WsNDGVqOytueYlxZyAeoSLwcoq6fb9Aua3SEfSBKS+S/yHvtqB9GVfMqH7q1mnGBiTEtC
 W0uyUIrSPbj7uaVxBo5KA8NVzL0MJ7OKIzzfBUBu2Dw5eDiiQZ8DWU0MBB3Oy79gg9t5gU+
 VqmqrWBb3wxg/We4zVVuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uaFLbOxxj1o=:Lso8rG7+WLGze1WIvmO993
 hbRbOnhLOYciqUzvRE77NLQsLxLyeIK0wK+AqQdI0MBGu0lRG9I6FAz4h1UwBMUToEZIheh+9
 i+iFzJc2opiPaYGFj/EoX1HM4Yx8p4ZOluV4xqhvjXyxxp5naiJ3o6dhxOJgqWjUCrlhhlGuk
 S1hiKcV5uWoIpoXQqcMPvjSOi4biH12O9YhvQji9Om1lTUINBflZa4Z1paQ5aOElNjC1X4TqC
 fqw6WBNjh4jqIjZ5SqFj6UpGUByPIMcW14N8VRZWC6yWzE4PhCcSVETBCeVLIpBR1EbB2f/Yp
 3nCMIFflxQ9YRskIaGcgUWFr32tHS1FRFSNPi+KRM36s2Gz8iwI7CZiVhJ3mTQfIxN4nQA7Jh
 oyIu/eN5t4nNy/P8Kg5ow5XcEQTfYKpb+O4j3bcaHeTmwSttkSLsmIJAAcNnYFEBlBkm58UA7
 Djc6j1rS0ITn12KZBfGg7Nv8KfzDn28o6m41AU3iDosA910iaPqYxNSv4UtI6lV1Kj4Kp1WDJ
 Je5SWumzhZa0w+pSTCM8to4Uymz7J4RZjDayCep+o8c6IeVOPezakCu7mJZpAWhf1Uf/Oo/VP
 72qoZrB29NjVlekZpaxxVTl4OpLIIXLy3STv12469hEqDsnlDc8s4UVmArVFWq9gj323qiibK
 KDRllycGfRMJVoktaGP3GjqbR38fPr6gzhmah/D7kxehEHsNyZPBgEkfn0bJkmlNMQt2r/IJZ
 g19abKzjNKNFvZuYE4glaJvJ67OcoGaMEWDnvPo5xLLY5BMP1hgyGFxEziL3d7IahL1um2l/Z
 OeurVrJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 02/17/2017 11:29 PM, Alex Hoffman wrote:
> According to the documentation "git bisect" is designed "to find the
> commit that introduced a bug" .
> I have found a situation in which it does not returns the commit I expected.
> In order to reproduce the problem:

For the others who are too lazy to clone your repo and run the scripts,
the history is like that (read from bottom to top) and I marked the
commit found by git bisect and the on you expected:

*   7a9e952 (bisect bad) <BAD>
|\
| *   671cec2 <BAD> <--- expected
| |\
| * | 04c6f4b <BAD> <--- found
* | |   3915157 <GOOD>
|\ \ \
| | |/
| |/|
| * | f4154e9 (bisect good) <GOOD>
| * | 85855bf <BAD>
| |/
* | f1a36f5 <BAD>
|/
* 1b7fb88 <BAD>

The <BAD> and <GOOD> markers are set by your definition of what good and
what bad commits are.

> First of all this is confusing, as this commit cannot be reached
> starting from "v.good".

Hm, IMHO it shows that your example is pretty artificial (although you
might have come across it in a real-world scenario): you introduced a
new feature in f4154e9 (and it worked) and you broke that feature by
making the merge 671cec2. However, the feature (that broke in 671cec2)
did not even exist in 04c6f4b; so a test on the feature would not fail
(leading to "bisect bad" as in the example), it would not exist (leading
to "bisect skip").

And if we are not talking about passing or failing tests but about
crashing, bisect finds the right thing: f4154e9 was not crashing, but
04c6f4b is crashing. Yes, it's not the commit that introduced the crash
(which would be the first commit in the repo) but it's the first
crashing commit after the one marked as good.

So I'd consider this a feature or rather correct behavior, not a bug.

In other words: bisect assumes that your repo is usually in a good state
and you have a commit that changes it to a bad state. In your case you
have a repo that is in a bad state and you have a commit that switches
it to a good state and later you merge a bad-state branch and you have a
bad state again. It is not made for that use-case, I think.

Cheers
  Stephan
