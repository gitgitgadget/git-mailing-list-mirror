From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 04:15:21 -0500
Message-ID: <CAMP44s2xH9yi+EvsVnV6JW0gPPistBbvg8Jj_62hXmZAAvC1cw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<7vsj2od841.fsf@alter.siamese.dyndns.org>
	<CAMP44s0q4k+bjQDhWAiYoj2P+7PJqFRs9s0arhy+F7YDO50dZg@mail.gmail.com>
	<vpq61zk8er7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:15:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USkwC-00019E-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab3DRJPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:15:24 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:38172 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab3DRJPX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:15:23 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so2350444lab.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5Minn0P0JhW3zaRbbxYVJFE2kDo/tui4X8jEM4I7pVc=;
        b=smmCr0hjAOcc7X6M+eG4QcLCz2QFq4CmTtVKeHJW9ZYmnjOfxhhqpyVeLJpg1ZLzRd
         Run0UjYtsiP95DjCsur2VRfOq1mRCTKywxfwtutg7NTbHlxDQ/E6bdJDji1gVy18mJ+s
         mXVoTm0CJVY5rnAefrqox6mjFkGVJr70sYySt8Y6SAj+3isaHGCRG90usPVCKG1aw+Kk
         7r9KS6oNZBAOopuymEYwGGh0BNx+9krQ/8qt2dFLLl2SsP3OKcyK3vS6p2NqEqaYUyxQ
         UELSBdG7wXMoJRTqzTEATgKj9YW1YHRl2LGhgLE0N1vqjj9aLnULCK2nQ2v6tQn9wdjX
         stvg==
X-Received: by 10.112.163.6 with SMTP id ye6mr5340590lbb.59.1366276521221;
 Thu, 18 Apr 2013 02:15:21 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 02:15:21 -0700 (PDT)
In-Reply-To: <vpq61zk8er7.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221629>

On Thu, Apr 18, 2013 at 2:44 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> * How many times have you tracked regressions in transport helper's
>> import/export functionality?
>>
>> Hint: zero.
>
> The real question to make the situation non-hypothetical would actually
> be "how many times did you track a regression that bisected down to
> *this particular commit*". Any regression that ends up on another commit
> is irrelevant.
>
> I guess you realize how stupid my argument is. But how is yours
> different?

I did not make any argument (stupid or otherwise), I made I claim; I
won't waste my time with hypotheticals.

> You do realize that your claim that nobody is ever going to
> bisect down to your commit is as hypothetical as other people's claim
> (if you think it is not, then try to point us a proof that nobody is
> ever going to need a good message in the future to understand what I
> mean).

Yeah, they are both hypotheticals, the only difference is that your
claim is very easy to prove; all you need is *ONE* example.

But I'm very happy to withdraw my claim, as long as you withdraw your
claim as well, and we go back to the default position: we don't know
if anybody will every look at these commit messages again.

> We're trying to make all the code and all the commits clean. It seems to
> be a consensus here that review is good. I see no reason to purposely
> make some commits less good than others based on the fact that they may
> not be used in the future.

You have to prove first that they are "less good", and the best way to
do that is provide commit messages of your own, if you do that, they
can be used instead, but if you don't, what do you propose to do? Drop
the patches?

> Search your favorite search engine for "broken window principle" to get
> more arguments in this direction.

More like broken windows hypothesis, which is not without its critics.

>> * How many times has *anybody* done so?
>>
>> Hint: other than me, quite possibly zero.
>
> If you want to be the only developer, and avoid being disturbed by
> others, then why are you pushing your changes to git.git? Why are you
> even discussing on this list?

Doesn't matter, it's still *HYPOTHETICAL* that anybody will every hit
this in a bisect.

Now, if you agree it's all hypothetical, the next rational thing to do
is risk analysis: how likely is it to happen, and what would be the
impact if it does? The answer to both questions is: close to *ZERO*.
So, considering the nature of these patches (a remote-helper in the
contrib area that is relatively new), and the active developers (me),
I'd say it's much more important to get the fixes in, than to document
every little quirk, detail and reasoning behind them. It's the balance
I think it's best at this point, and it is my time, and it is my
decision what I do with it.

It might also help to compare oranges with oranges, and with regards
to remote-hg transport helpers, I do believe the one in
contrib/remote-helpers has the best commit messages:

msysgit's remote-hg:
---
commit 6bbd5365988d63780acc2ab407878eef8c19b47c
Author: Sverre Rabbelier <srabbelier@gmail.com>
Date:   Sun Aug 22 01:22:14 2010 -0500

    git_remote_helpers: add fastimport library

 git_remote_helpers/fastimport/__init__.py     |   0
 git_remote_helpers/fastimport/commands.py     | 469
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git_remote_helpers/fastimport/dates.py        |  79 +++++++++++
 git_remote_helpers/fastimport/errors.py       | 182 +++++++++++++++++++++++++
 git_remote_helpers/fastimport/head_tracker.py |  47 +++++++
 git_remote_helpers/fastimport/helpers.py      |  88 +++++++++++++
 git_remote_helpers/fastimport/idmapfile.py    |  65 +++++++++
 git_remote_helpers/fastimport/parser.py       | 621
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git_remote_helpers/fastimport/processor.py    | 222
+++++++++++++++++++++++++++++++
 git_remote_helpers/setup.py                   |   3 +-
 10 files changed, 1775 insertions(+), 1 deletion(-)
---

gitifyhg:
--
commit 4b364563cd705dc5e69082e6b80d304fe50b9c9c
Author: Alex Sydell <alex@dropbox.com>
Date:   Sat Mar 23 23:46:33 2013 -0700

    Report correct (instead of unknown) hashes when importing refs into git

 gitifyhg/gitifyhg.py   | 27 +++++++++++++++++++++------
 gitifyhg/hgimporter.py | 20 ++------------------
 gitifyhg/util.py       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 test/test_push.py      | 31 +++++++++++++++++++++++++++----
 4 files changed, 94 insertions(+), 28 deletions(-)
---

And of course, the best place to discuss the lack of good commit
messages, is in the patches themselves, which are after all, sent to
the mailing list for everyone to review.

Cheers.

-- 
Felipe Contreras
