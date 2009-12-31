From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Need some help with git rebase
Date: Thu, 31 Dec 2009 10:02:12 +0100
Message-ID: <7fce93be0912310102x53755120o31e42c4a7a92a709@mail.gmail.com>
References: <4B38B3A7.6010900@steek.com> <1262211866.7068.1.camel@kheops>
	 <CB5B49CA-0C66-4384-9B47-3675E517E203@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 10:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQGvG-0004eo-Ee
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 10:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbZLaJCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 04:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbZLaJCO
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 04:02:14 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:12297 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbZLaJCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 04:02:14 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1894029eya.19
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 01:02:12 -0800 (PST)
Received: by 10.213.97.14 with SMTP id j14mr1224885ebn.52.1262250132807; Thu, 
	31 Dec 2009 01:02:12 -0800 (PST)
X-Originating-IP: [82.233.66.33]
In-Reply-To: <CB5B49CA-0C66-4384-9B47-3675E517E203@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135938>

On Wed, Dec 30, 2009 at 23:46, Wincent Colaiuta=A0<win@wincent.com>=A0w=
rote:
>
> Look at the "git-rebase" man page, particularly the order of the argu=
ments, what they mean, and the usage examples of "--onto":
>
> =A0$ git rebase --onto 12.72.1 master feature
>
> Means, "replay these changes on top of 12.72.1", where "these changes=
" refers to commits on branch "feature" with upstream "master", which i=
s what "git rebase" did for you.
>
> If you actually want the "feature" branch to continue pointing at the=
 old feature branch rather than your newly rebased one, you could just =
look up the old SHA1 for it and update it with:
>
> =A0$ git branch -f feature abcd1234
>
> Where "abcd1234" is the hash of the old "feature" HEAD.
>
> But I don't really know why you'd want to do that. The purpose of "gi=
t rebase" isn't to copy or cherry-pick commits from one branch onto ano=
ther, but to actually _move_ (or transplant, or replay, if you prefer) =
those commits.
>
> Maybe I misunderstood your intentions though.
>
> Cheers,
> Wincent
>

In fact I want to backport the commits of the feature branch into=A012.=
72.1.
I used git rebase because the drawings of the man page looked like
that I wanted to do and it does except for the part it resets the head
of my feature branch.

But the good behavior would be to cherry pick each commit of the
feature branch and apply them into 12.72.1, right ?

Thanks for your answer.

Regards.

--
Sylvain
