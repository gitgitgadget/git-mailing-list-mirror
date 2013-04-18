From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 04:53:58 -0500
Message-ID: <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlXb-0005KE-JE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966767Ab3DRJyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:54:02 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:61132 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966220Ab3DRJyA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:54:00 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so2356464lab.39
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ndyFCN0YqTdZ5VTtVxPjQzC6z1GoQRzbFcvWSP5VSaM=;
        b=xFal4LHwGblX87oFPg0rEnppqihdyU6d3+vneXVc8qmp30H2fmZDFWwWEMPsv/Ihk8
         EQGE2P3fmvCv4CgZ5YBHSYw3S2JGHeA3XTrwKConCZDyYlKvG0d2RmERp+1WicYhuu5n
         MMaI4KbuRoyDmzedrrIVQPu0c32YwJPKinF/0e8U0p2JaLlawmnD7O7VVa5ukocOi22d
         b5dwIqPojrTbZDCEZJMOc1VKtbO2kMfSYAHdrxPyDLkic4X0GTYivbv5ZaRs3VXCT9av
         J8FfyfE5TpV2ZVXiWteUNskmdT5uFRbLNUMRNVeR4gbTY0lVOpVnohlszw03yojHGZb9
         Xmdw==
X-Received: by 10.152.18.164 with SMTP id x4mr5439750lad.38.1366278838842;
 Thu, 18 Apr 2013 02:53:58 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 02:53:58 -0700 (PDT)
In-Reply-To: <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221635>

On Thu, Apr 18, 2013 at 4:19 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I think the commit message is fine, you don't. So YOU go ahead and
>> write the proper one. If you don't, all you are doing is being an
>> impediment to progress.
>
> Hey Felipe.  Let's get a few things straightened out first:
>
> - We all act in our selfish interests, and write code to scratch our
> personal itches.  I don't write code or commit messages for anyone
> else, and neither should you.
>
> - However, we're not working in isolation.  We have this giant mailing
> list where we all post our patches.  It's like a bazaar where we
> compete against other patches for developer attention and potential
> reviewers.  In other words, it's a free market, and we're selling our
> product: if it fails to sell, will you blame the market or your
> product?  I write clear code and beautiful commit messages exactly for
> this reason: I'm fighting for attention!

Except the customers are not git developers, it's git users. Git
developers rejecting patches because of the commit message is akin to
distributors rejecting products because they don't like the
transportation packages; they are only hurting themselves, by hurting
their customers.

> - We have to learn to interoperate with others' code and conventions,
> if we want to be part of the community.  That doesn't mean that we
> drown out our individuality, but it means that a our patch series has
> to conform to some minimal, loose, and evolving standard.  Now, you
> can argue that many of the existing conventions are outdated (I do it
> all the time), but it cannot change overnight.  Your influence on the
> community will show up over an extended period of time.

And the only way it can change is by discussing.

The only one that gets bitten by fixes not getting merged are git
users, not me. So if a discussion of a commit message impedes the
merging of the commit, I don't get affected, but when we have agreed
to disagree on what constitutes a good message, and the patch is still
on hold, then there's a problem.

> - We are not an old enterprise who blame breakages on a few
> individuals, and fire them.  We're a community where all of us are
> equally responsible for all parts of the code.  I am as responsible
> for the remote-hg code in master as you are, as I had every
> opportunity to review it when the patch series came up on the list.  I
> might have chosen not to, but that doesn't relieve me of
> responsibility.

I don't think so. Unless you added your Signed-off-by, you are not.

> -  We don't practice division of labour.  There are no managers,
> "testing people", "documentation people", "code-writing people",
> "commit-message writing people" etc.  Everyone has to do some portion
> of all these tasks, although we try to keep the boring work/ technical
> debt to a minimum.  Don't ask other people to write commit messages
> for your code.

I am not. Neither should they ask me to write the commit messages they
want. They can make *suggestions*, and I can reject them.

When two persons have different ideas, often times both are wrong, and
the middle-ground is best, but sometimes a person reaches the
middle-ground, and sometimes one person was right from the start.

But when everyone shares the *assumption* that there is never a commit
message that is too long, you know the wrestling mat of ideas is
rigged. I wonder if I should write a commit message as long as a book
chapter for a one-liner, only to prove a point, but I'm honestly
afraid that it would be committed as is.

And remember what started the conversation; do you think a patch with
a possibly incomplete commit message should not be merged to pu
(proposed updates), shouldn't even be mentioned in the "what's
cooking" mail, and thus shouldn't even be considered "cooking"?

Cheers.

-- 
Felipe Contreras
