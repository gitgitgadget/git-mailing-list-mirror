From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Tue, 15 Mar 2016 07:53:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603150746490.4690@virtualbox>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com> <alpine.DEB.2.20.1603101417590.4690@virtualbox> <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
 <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 07:54:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afirk-0000ob-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 07:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbcCOGx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 02:53:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:54937 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbcCOGx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 02:53:58 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJFBe-1ahNoz2Cza-002mGn; Tue, 15 Mar 2016 07:53:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KK0L35AJ7ZdgAaVJwSF05XD9zPYigYqTwRHT095TiVYy9x9dvFc
 3qbJmH3i4vcwPPnDmxY4OtNP3Qay9+KJV2chnSL+TIg4zkSbrEKWezEoUf6W4V8Eo2Ly+WP
 0T+5jpET5H4K1TuNkTeep0aLgTEe0cXONYfLzpQM3HfBeVXZO2RE09LLHctmQK+nSe4eGXO
 KELqJA8wQQgyErTomiTYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ux4gklhPgZk=:2DeXjM4zI68ZK0O53Ft5Fx
 npvidKM66AyXNu4AZ7NtXK3OrjxiVO0zOaXqG83/5RPI2KK/ectUnA0gnqGZHVUOll8UEyqDt
 QZZkaa+GX4Sat8m6wYklNQmfGj5b3X/LSfonYsm8BHcuNtb/a10uSMK51tgMcYOVyUFQecdD4
 Xif6Y4WMOw2znsKb3+ZpJT6TGU4QAUdJ9SutChhcPXimtoHc8IMPjStEoz+qM45L2Cymob7up
 dVZhC9ChjIgyHYVO3ucIj0lalC0ddPyB5CPrE+qk6sygMaH0V9IbmrH6z67LVrEE1XeDt3xSC
 TgfcjPvH/web/xF8lhTltsxsn7EG4g5uXWrs5J07uCpqlvdlRrw/ITxf05NOuvIPbErB53BQF
 dpgVdrPMiVPa5V2W2qLYu5yBXZB5KVWc6TlVkx0LupY72+OnFbO5y432f8N0cO7aTh18Zh/MC
 +SNP7SM9InMECP5oRPNY3OpHKy9fZjHmfIIR3FWWKUD8w5gnxIeTFF1ljuMnYB5Wb+o9ARaIj
 DeTTv/HAby7G/WkcYwjL0nTd7FhQS5UzMWiGJWttNuRY/ViWMRDRLBQ4fnd3aIxy2EqfiMxhQ
 QLt6TdS2bD1PUB6kl0GkNjogPZcHkBcjx1YljlQKJJR0ND96AyoFivcKB++VZYOeZ0hXsbFQx
 usAW7B3D87dT0rwZyzDAdOwP+ZSgf67VYzkESpMHkxZYLtIXxuVX4tF8x4nNuqNMZ26L+xL6r
 Qg/BvJpZd5fg1Iwdz7yc8isH5wNhEEsUogRL33eNqzBXLNA6b+mVusA/CLCWA5SGOVzdDS4Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288835>

Hi Junio,

On Thu, 10 Mar 2016, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >> Granted, "git worktree remove" should be the work horse. But why not have
> >> two ways to skin the same cat? I, again, would prefer the short 'n sweet
> >> "git branch -d -w pull-rebase-prefix" invocation.
> >
> > If you put effort into making it happen, I'm not stopping you :)
> 
> I actually would ;-)  If I had to choose between the two, I'd prefer
> to see this new feature as part of the "worktree" subcommand, simply
> because "branch" is a fairly basic feature that can be used by those
> who are new to Git without knowing that the "worktree" feature even
> exists (hence not having to have one extra option description in its
> documentation that talks about "worktree" is a big plus).

I, in contrast, think it woild make for an excellent way to let users who
are in the dear need for the worktree feature (like myself) find out about
it.

Nobody reads release notes, but at least some people read man pages.

> Personally, I think you are better off implementing this set of
> features as a set of shell aliases (be it bash or tcsh).

True, if I was simply selfish, I would use shell aliases, too.

But I want others to benefit from my work, too, hence the patch.

> That approach to implement the UI that directly faces the end users
> via scripting would let your users choose layouts more flexibly.
> Some people may want a repository and its worktrees next to each
> other, some others may want the worktrees embedded inside the main
> repository, yet some others may want layouts other than those two.

Having the worktree in a totally different location than the associated
repository is *very* confusing. Unless, that is, you work on a single
project, ever, of course, which is a luxury typically only awarded to
maintainers, albeit not this one.

As such, *recommending* to have it elsewhere really is nothing but a
workaround for some bugs that should still be squashed instead.

Ciao,
Dscho
