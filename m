Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739771F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeDJWGr (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:06:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:34669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeDJWGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:06:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEnX8-1fHWvK0qMM-00FxGp; Wed, 11
 Apr 2018 00:06:40 +0200
Date:   Wed, 11 Apr 2018 00:06:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Chris Maes <chris.maes@macq.eu>
cc:     philipp@gortan.org, avarab@gmail.com, git@vger.kernel.org,
        philipoakley@iee.org
Subject: Re: git-gui ignores core.hooksPath
In-Reply-To: <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
Message-ID: <nycvar.QRO.7.76.6.1804110001350.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org> <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JmDt9D/Xo63i5uujHMkRsd6cFcdEKNJFnrbU/o0V1YfpbC3qKSJ
 gY5Gw/69EYiRJ2MmrjEjX91mTq5lQlXJJEUxmWqgck0Olz+9+zUPMMMxSeSZ0QvkOTfT0Hp
 mPhhW1+w+QDN8S6OvsQ1+B53rC0QWR4uSRHcOc7ez9CIsaDix1dh7BZ5ClHzslsCxh5UV9z
 daz4Heco1o4AMJNXb6Tfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pa8dPMbxkDw=:z2sOnUiPpmUE4fFDt7gHYw
 /eAXtPepVtJG8C+EQaJGCz/yNxsGRxoIMwGTQVA01ksPd/oTtnuXgYnQd1vp9HHOn3StyrN1v
 yECumu8jO/t5ydc1vEDKRqhMmQ06Xdza76YRyF5A0zVhZnaTO7HE6r8FXp9R4IKSXJ+cj0CXM
 4tKd/60atWjIS4OPisLNTgwCLAwCmPjNqfctf5V5MAzS3Jbugg+j6A5msWn/cr4iUmuEgKE3o
 gZHQioOCafsvOKXYSZP5ghuZ10FsCwkC4xMyX1dLVxEYLW0N9H4nXngr1ZbN/kvVHqWjicULx
 J27I1cFcDi80EGvhIUJKsM5FIruMyDOFfcn7nltSz9NQQzTrff3d+Owdx2Kjw/ZtnHMl9f9wY
 aIvKzkPcQRE4+VFWgJJwAn/MUxKG3vQhGz6Jal3qtqDbChB7y/ZbXjlQH7gKg63HhoWBvvs0x
 R641UPdg3iTxAmUeb64ygVIVQOzgYQp7petM+eWA2wGUL/MVcwr3/rOhfZoHhg1QJkShvR4bb
 RqA4ymanf8Gj3nJCEJeBH0wwh4EEt9JPEA5fRTIkqDObUhqgRBB8Y6UiqFMQ90cK2Jkp/aRv2
 tE2Ah+uxv6L7PdTvOajyMi7HezkMGlMdRmXIVFzqF9XHMG44WhXM5IHbbNiIz7yx496FnSfSc
 siuxkrfPE+MIuqSq6QilsJdYUXs3e2HcbCfJ/iq4+U0/uv1EbyPZIoaDVNjy6gaa8mO7i1kV4
 7Fwbyk0F7i/ioptVwjwtiPgJXfVWFQPqvVAV8XjtMZf1SFA0GAnf8oCLXgeNXpQLeCESNY9B6
 2AtoYb/B6EGUuCB6hvz4AJoqedhEgEXG/Q4zR/P3RgNA1MBw3w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 10 Apr 2018, Chris Maes wrote:

> using git 2.16 the same problem is still present.

And probably 2.17, too.

> I see that the pull request https://github.com/patthoyts/git-gui/pull/12
> (along with 15 other pull requests) are lying around since about one
> year without any sign of life from patthoyts.

Yes, this is very sad. I hope he is alive and doing well.

As to Git GUI: if you know your way around Tcl/Tk reasonably well, how
about stepping up and reviewing those PRs? Even if the PRs are not merged,
a review would do those PRs pretty good and we could then take things from
there.

> Is there any hope from here that anyone will pick up this / these
> changes?  Will anyone else be assigned the main responsible for this
> git-gui repository?

There is no "assigning" here, not really. What is missing is a volunteer
who earned the trust of the Git developers. Reviewing those PRs would go a
long way to earn that trust.

> Just hoping to revive the discussion here, since the
> https://github.com/patthoyts/git-gui/ repository seems quite dead.

Thank you for doing this.

I also hope that somebody with reasonable understanding of Tcl/Tk and a
vested interest in Git GUI takes up the responsibility of maintaining it.
Judging by the rate the PRs trickled into
https://github.com/patthoyts/git-gui, I think it would be a minor time
commitment.

Ciao,
Johannes
