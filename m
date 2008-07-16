From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 14:51:30 -0400
Message-ID: <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJC74-0007lE-Tf
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYGPSvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYGPSvc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:51:32 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:40555 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYGPSvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:51:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so80907and.103
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uRkRHvgXQplSh2tb+J6ebSB0JzCQx4G3R/Ue0vTkfNM=;
        b=fOn3BAQruq4dxObpWVCExkwyr42GSSkPkKkQp9CAQx2pmUf+PKM6WY7S+I1C7jiOca
         5A6OZezqZRYfZV1uQo3qn1FIKEuPLqv9wPZbTAjdHq9Fv/iXa8XqkvxbdADQePLmoZlk
         ZWSqGgPVCDdpfeDfogbJsfhLQo0InxcR2fH1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YNzSo9qxz19JPizdy+NDn1LLnonwdqpoGOrnDIoPeCHs/WL4eVyjid2g+INY2Jr4zY
         itKuoeebih2RYaAYrjBPwQlpcJK5jJkH8PMLKGyCtaCpRsSfBl6JTmDmCOZN/XKSPLA+
         Hv+V0KYZD7lBFQz3cakewNv2vpqPLIt3Kz4uo=
Received: by 10.100.108.20 with SMTP id g20mr2588128anc.105.1216234290474;
        Wed, 16 Jul 2008 11:51:30 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 11:51:30 -0700 (PDT)
In-Reply-To: <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88716>

On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>  >        git diff :{1,3}:path/to/filename
>  >
>  > Which is a great command, but svn definitely makes it easier to do the
>  > same thing.
>
> I've never seen anybody who finds "diff :{1,3}:path" *useful*.

Dunno.  I use it frequently, and it works great for me.  Perhaps my
brain is just poisoned by svn.

I've never tried "git log -p --merge".  I'll try it next time.  This
is certainly not common knowledge, however.  (But to save Dscho the
trouble: git usability in general is not the subject of this thread.)

>  > Even if you have a repo with widespread push access, git's log looks
>  > annoying compared to svn because of all the merge commits.  That's a
>  > primary reason why rebase was invented, of course.
>
> Please don't talk nonsense if you do not know history.  I invented rebase
>  primarily because I wanted to help e-mail based contributors.  There is
>  nothing about merge avoidance to it.

Sorry, I mixed up git-rerere and git-rebase.  From git-rerere's man page:

       When your topic branch is long-lived, however, your topic branch would
       end up having many such "Merge from master" commits on it, which would
       unnecessarily clutter the development history. Readers of the Linux
       kernel mailing list may remember that Linus complained about such too
       frequent test merges when a subsystem maintainer asked to pull from a
       branch full of "useless merges".

Nowadays, I'm pretty sure people use git-rebase to avoid this sort of
problem (or "git pull --rebase" presumably wouldn't have appeared),
but I can now see how git-rebase was not written *for* this problem.

Anyway, my point was that git-rebase (or at least git-rerere and
git-reset) are needed if you want to avoid a lot of merge commits.
And, to relate it back to this thread, git-rebase cannot possibly be
understood without understanding git internals, and git internals are
easiest to understand by learning the plumbing.

svn avoids these excess merges by default, albeit because it puts your
working copy at risk every time you do "svn update".

>  You can skip merges with "git log --no-merges", just in case you didn't
>  know.

Perhaps this is mostly a user education or documentation issue.  I
know about --no-merges, but it's unclear that this is really a safe
thing to use, particularly if some of your merges have conflicts.
Leaving them out leaves out an important part of history.  Do you use
this option yourself?

Have fun,

Avery
