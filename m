From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local
 refs
Date: Wed, 18 Nov 2015 10:56:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511181052130.1686@s15462909.onlinehome-server.info>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com> <56431B69.9010007@drmicha.warpmail.net> <CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com> <CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com>
 <564B47AC.7070609@drmicha.warpmail.net> <CANoM8SXrRmXPZQotQgJNNonJcb3rs5LM=JwOYoh4mX4nw2XB-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 10:56:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyzTL-0000by-U1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 10:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbbKRJ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 04:56:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:62474 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbbKRJ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 04:56:08 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M6Ana-1aJPnV1iLS-00yB9m;
 Wed, 18 Nov 2015 10:56:03 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CANoM8SXrRmXPZQotQgJNNonJcb3rs5LM=JwOYoh4mX4nw2XB-g@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7bxx1gMPNS6tjFuglsUfx4tosm4B1Byc9A67AEeAgSyKj1uXQRU
 4J8ULvpien3e+OSjyj8srJjvUWPJSkthW6gg12WxtaZTVpcgF7V8N/AWkaRZDGft9Mvzdc8
 xvnUdunv0Lb8zVfY1DlH3fZdMrere+tMIJ1pw/Usa8sB1gs/BjOmsAh8aEHK7zyCNpxLIC0
 veLc9X/tqwXQKngTC6e9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SDSgOu+iwhQ=:0i+J+jFHtbWE69EeMQWgY5
 fUELPgKJgx9L+6BYxvmibErsqCpKxdENgF0h7bJAXiNBLebYNFKt/GJ6lbuA11TPKttbWLr0/
 cdSfU20CQDZhGE1RGRaeczQquWJ0NYfsIhTwqA/mqglHuVC58lZGX61b3878S1toRXzhYZG5+
 nbsj3rNTuMF+XXFZmodut3ove4OKLcQNGA39W36+3pJQGQUKav0RRSGGqWvbB8pjFWqiGsi9X
 WQoMN2+OrMTsnd0eK8jLKWcnxMougcu+QJyD2ZuMpk3dzD1F3l2gRAnsW2xBIGiOGcMBc32tp
 dpvuQnhSr4iw2zCTTXUjacsRMu0W4g2ZwhLY/mHPfWgXxbKNqY7m0OuCq5FmRXS8yEN/xeNMF
 tif1ufawNSiDlZTaztNRpgMNzdCOj5IR5f1o+MhM9YqwWqb3kcHwSEKCAEHuiJInRIhwOn60l
 WtpTcBl+uJKV0oNWLgicMJAMiBNZWTt/kGJIGGSu/iyO2Ne6NNo3oh2te1mFsDBgkG4cHE3Rl
 MBbkSzWmFveKGDJhuMchUaTdGN7nZ36mioCQsgJEGIdvIpqRcksdUtUdunrNblGY8NJhQfYbH
 /z43K/D/7Yj9XLhlw1Ri3h6tDv/rbFC6RiFcgZedQrq9XZgs/UhEeV1ztqH+7jHKHZ3XWrHWC
 7SAND2yo+nNh4wLU4XCuZerVfm1XHwZaAWGdf4bJrvmb3LNdT556d4lErD3iSbvFqZ9yA+D6x
 m89NMD2cpjUlU/RzItO7Js0RQnp9MH6YYSopHRWNtYC92/cQgDoZqAFvCVT4RkZv9sA1sDgt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281443>

Hi Mike,

On Tue, 17 Nov 2015, Mike Rappazzo wrote:

> On Tue, Nov 17, 2015 at 10:28 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > Mike Rappazzo venit, vidit, dixit 17.11.2015 14:58:
> >
> > I still don't like the idea of having a new command just for the purpose
> > of fast-forwarding local branches from specified upstreams.
> >
> > What's wrong with "git merge --ff-only" once you check them out? We have
> > all the gory messages when you checkout a branch or use the git prompt
> > or "branch -vv". And if you don't - how is forgetting to "ff-refs"
> > better than forgetting to "merge --ff-only"?
> >
> > In short, I don't see a problem that this is solving, but maybe it's
> > because we use local branches differently, I dunno.
> 
> For me I use this command more as a post-fetch:
> 
> git fetch --all --prune && git-ff-refs
> 
> I imagine that the big difference is in the number of branches that I
> maintain, and perhaps in the way that I use gitk to visualize them.  I
> would be happy to add another option to git-fetch for --ff-refs as an
> alternative if that would feel better than a full-on builtin.

I would much prefer, say, `git fetch --all --prune
--fast-forward-tracking-branches` (with maybe `-T` as short option for
`--fast-forward-tracking-branches` and/or a shorter `--ff-tracking`) to a
new builtin.

But yeah, I can see how it is convenient when you have to work with N
tracking branches where N > 2.

Thanks,
Dscho
