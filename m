From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Support marking .git/ (or all files) as hidden
 on Windows
Date: Tue, 10 May 2016 10:41:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605101036460.4092@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <cover.1462603453.git.johannes.schindelin@gmx.de> <xmqqposvw4fs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 10:41:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b03Eo-0007tc-7x
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 10:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcEJIln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 04:41:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:51924 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbcEJIlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 04:41:39 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Md3li-1bIGbT3IGo-00IEZK; Tue, 10 May 2016 10:41:21
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqposvw4fs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Xu6VRrf+9kl0igUtzoi1b+OGZGkh+Gc3Svbjr8OSoyoCde6KZxC
 UAtkpXvaWWYTJryyxNSjf+kYCvnY4VFw8xJZvG/R8Bo2nBHx0C3VC8fn5gTXrhJUXrGR+fL
 rZHIXZ1paSCvZKRYTuKjXG1vZnBN/9FgzhRNcPSo6VKF6CAd3Fa9Yxtj8Xd+vtyxswTumrJ
 UMngn//cO+mXG/TGe2woA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ozijfLGMyEI=:oOjXP9eN0z7a4uV59/dlCK
 +KJYPvwKP5TIESxC842p6JQ5IDCPcY10x/8qlft1KZ12VjgJDTB2OJ6ojjmVmVspPXFTb2bkZ
 4rcTcpnA+gzSXf8YlXB7yWPXokOGxDttXVnsuse0qAaqKWFGJ+EpEhwvGEfjU03bkXAUGBZ6K
 WcU4HaKA809OQR7V15vw5II6zBrCJwyQVZ8BeIx8aJXooBiVL92BPCaVIKx/fwU6Rxs4ppBNM
 X34N8NjZTjhAZNp1UMiGhmp0/xxoS9KHW3G7MFbzhVImszOg5gdVdBmC54AtRO4lrGly6ESrB
 VnA5zs3P0GZ9saYXzXEoknuyxZrY+fqXT4UQJCYhWORv06Ld3S93QeMoKBy7WneW6on/em5Jw
 75KgyWYyh1/LpVfk/yFUglBd7eEZtwyiD1xevY/w+aboqqf1MOEQkZ8TVpg0DKUPxyqig5rJZ
 WoloMI0Nobjm/ucjhH8EKM4gfzAt/3Ckuj4DFXWFd5AcNWmbDzma2Y9osM7+Fy3ILQxsjfsB9
 3oAAvHZKOS2F1FGN3Ul7PjWa4w4pumosXu+3Qh53Tva7McDK7VXgo/I/kmXCgYkUYFoyXjlFa
 Zu3NccqCENkqmlHfEPSAtRDLg+Hj8wUeQwsaJYe3CheUZlEmZxrApsPesDevSX6UrApyfEmwg
 Z7RmY+fxJ5nQAjYExRSlAW6ob4WAE1uBdGproexOdHhDB4tHlmowgz130y6H2NtpRJM2KPSSQ
 1BTICg/ahmtfBpOpVBtx1qwwb9IafSBUjRMn0OBX/MMxuIje0dvDVNJyej1gX5SX+041TjGD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294115>

Hi Junio,

On Mon, 9 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is a heavily version of patches we carried in Git for Windows for

s/patches/patched/

I wish I had a penny for each time I wrote this particular typo.

> > way too long without submitting them upstream.
> >
> > In this iteration, I also claim authorship for the patch because by now
> > Kusma's changes were so contorted and mutilated beyond recognition by me
> > that I do not want anybody to blame him for my sins.
> 
> OK, so what do you want me to do with this "heavily modified
> version"?  Earlier you responded:
> 
>     > I have a huge preference for a code that has been production for
>     > years over a new code that would cook at most two weeks in 'next'.
> 
>     I agree. However, it does not fill me with confidence that we did not
>     catch those two bugs earlier. Even one round of reviews (including a
>     partial rewrite) was better than all that time since the regressions
>     were introduced.
> 
> So do we want to follow the regular "a few days in 'pu' in case
> somebody finds 'oops this trivial change is needed', a week or two
> in 'next' for simmering as everybody else, and finally down to
> 'master'" schedule?

Well, I plan to include this patch (replacing the original version) in
whatever Git for Windows version I release next. I guess that we can go
with the regular way in git.git. You could just as well merge it to master
right away, it won't matter much as far as Git for Windows is concerned.

Ciao,
Dscho
