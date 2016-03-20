From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 00/16] git bisect improvements
Date: Mon, 21 Mar 2016 00:20:38 +0530
Message-ID: <CAFZEwPPon1q_iW_xNfmVxiQhyaQh_pZpk2jzoyzi3RjJd998pg@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:51:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiRM-0002TR-Vb
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbcCTSur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:50:47 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34983 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbcCTSuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:50:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id d21so5037097ywe.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dgPw8z8/ma50smklq0PdyK1X9RQIvNK3EfTKiZUYQ8M=;
        b=xn3QkG2/5Xk+Cj6T3Chkxbt7HZ8erEmd2h5SQyElJpsDl9mTNxKS+u7uHzVXHCM3Iw
         5vXGJ/eqd7KR9PK9/3gkOtfMkPO7bKqak7GBxylfZpdD4iwX6e0ewgT6xkpe9wgwHBbo
         jwIygNEUWK0qi/f0rvcQckXRH45DZRnugNS9oD/Vqpy+V2bJ42n+J8+oqoBx+tdB/czL
         NiNoflxP7mIL6lavKvd+unUZISOzRuuYPai8DPJHICyzzruWHUyLnuMgCrj92aI5n6pR
         1u5G+IxlbpPhEoj/tiIjKI8s49cmKiWMWQTHjDYz0RI7Ft4LS+Iiva8RFkvFo7bPRu9f
         0S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dgPw8z8/ma50smklq0PdyK1X9RQIvNK3EfTKiZUYQ8M=;
        b=EskHPWEY5B3q9RaYujkjKRQ4UMMkPNtwlaZ0CULotGGOgrthB2HOaaXa5KALPab76G
         kB5xPZzgZaKWyYDTLZ2N2oJo1pGbJTGPjlHuYcStT3Ie3Cp2FSrSoAH+AJSCd4+oTevU
         uNobFEHTAHeCqgY/LohN/fQsB25EMUtiON9y4MlMTd0vTQUFFaklNUDduEe/bpLGYeY0
         kZ4om73lMVrWmLEsUMNwMxRoxac5IyWEM1g6WZ1Q/RR/hDzNh6k7gSFCHJtJfo9CK1CC
         jOd0y+de5qp5WfLrk1+chs2A43yZDmSl43AzdVrPlxO5/5FKUlfB8Mb85sevzp3l+IIX
         6x3Q==
X-Gm-Message-State: AD7BkJIoD9C8YzMoJyelHx/6jSwKtH1TxhQpoQUg822GmEuL/yz3Q0KAKYjY/NmsBtNgP7avSE4ATLrpg4wczQ==
X-Received: by 10.37.12.195 with SMTP id 186mr12332897ybm.154.1458499839092;
 Sun, 20 Mar 2016 11:50:39 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 11:50:38 -0700 (PDT)
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289378>

I have been recently following this series of patches and it seems a
bit stale. These patches haven't been followed up with improvement
patches. If it is okay with you then can I work more upon these
patches in my GSoC project. These really seem interesting and Git
could really benefit from this.

Regards,
Pranit Bauva

On Fri, Feb 26, 2016 at 7:34 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> this set of patches provides improvements for git bisect.
>
> Quick summary of changes
>  - relevant for users:
>    - `git bisect next` is documented and motivated
>    - git bisect implementation becomes much faster
>      (or: is now working) for big repositories**
>  - relevant for developers:
>    - a test for the git bisect algorithm is added
>    - fix: bisect.c compiles also if DEBUG_BISECT is set
>
> The ** marked change is the most interesting one.
> To be more accurate: the use case is when you want to bisect in a
> repository with a huge amount of merge commits (and having these
> merge commits relevant for the actual bisect process).
> For example, a bisect in the whole git master branch took
> ~50 seconds, now it takes ~4 seconds.
>
>
> Note that the patches have finer granularity (especially the performance
> improvements are splitted into several preparing commits).
> For some patches, there is some more patch-related story as
> "cover letter material" in these patches.
>
> Btw: I also wondered about the internationalizaton: no string in bisect.c
> is marked for translation. Intentionally?
>
> Cheers
>
> Stephan Beyer (16):
>   bisect: write about `bisect next` in documentation
>   bisect: add test for the bisect algorithm
>   bisect: make bisect compile if DEBUG_BISECT is set
>   bisect: make algorithm behavior independent of DEBUG_BISECT
>   bisect: get rid of recursion in count_distance()
>   bisect: use struct node_data array instead of int array
>   bisect: replace clear_distance() by unique markers
>   bisect: use commit instead of commit list as arguments when
>     appropriate
>   bisect: extract get_distance() function from code duplication
>   bisect: introduce distance_direction()
>   bisect: make total number of commits global
>   bisect: rename count_distance() to compute_weight()
>   bisect: prepare for different algorithms based on find_all
>   bisect: use a modified breadth-first search to find relevant weights
>   bisect: compute best bisection in compute_relevant_weights()
>   bisect: get back halfway shortcut
>
>  Documentation/git-bisect.txt |  25 +++
>  bisect.c                     | 473 ++++++++++++++++++++++++++++---------------
>  git-bisect.sh                |  15 +-
>  t/t8010-bisect-algorithm.sh  | 162 +++++++++++++++
>  4 files changed, 502 insertions(+), 173 deletions(-)
>  create mode 100755 t/t8010-bisect-algorithm.sh
>
> --
> 2.7.1.354.gd492730.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
