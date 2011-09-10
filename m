From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Branching strategies
Date: Sat, 10 Sep 2011 11:18:51 +1000
Message-ID: <CAH5451kn5WD4+S3_SGMarGyoUs6NA6Xvz9Pb8Wdpt9v0nY+Uow@mail.gmail.com>
References: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 03:18:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2CDh-0006yU-W7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 03:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab1IJBSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 21:18:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55493 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab1IJBSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 21:18:52 -0400
Received: by fxd22 with SMTP id 22so1168237fxd.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A1IWQK+35v0zfmXlbZ+GlUetZmM6G0vaI+hotI04rro=;
        b=S0FsIoc+InEGP9WAPaWgfwP75bMnDe6RrkY1QSS1F11q/FdEe/iLbtTkN/P4gyhvj7
         XRVzue61ke0ux+uukNJzos8X1wNf38kA4RLNq8xL1pKOSQRe2yOomYB2IRd3nvvLks29
         FdG6PLN1TvJqEe61jZ5ZOJ88QL1c57ZZS3+Wk=
Received: by 10.223.101.2 with SMTP id a2mr420726fao.2.1315617531138; Fri, 09
 Sep 2011 18:18:51 -0700 (PDT)
Received: by 10.152.8.226 with HTTP; Fri, 9 Sep 2011 18:18:51 -0700 (PDT)
In-Reply-To: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181134>

On 10 September 2011 09:01, robert mena <robert.mena@gmail.com> wrote:
> Hi,
>
> I have a project where I have to do a continuous integration, adding
> features/making changes on a daily basis. =C2=A0Some changes are one =
liners
> with no functionality just, for example, textual changes or a new
> button. =C2=A0 Some are actual features or bug fixes.
>
> So today my developers do their business and publish the changes in a
> beta site where the customer or the qa takes a look. =C2=A0The proble=
m is
> a standard one. =C2=A0Sometimes features stay already developed (wait=
ing
> for review) for a long time and other changes/features get approved
> first.
>
> Since some of those can touch the same files how can I make this a
> little bit better (manageable)?
>
> I am considering doing feature branches. =C2=A0 The customer requests=
 to
> add feature A I open a bug tracking issue and create a branch 1276
> corresponding to the bug id.
>
> In my simply view I'd have a master/live branch and every time I need
> to create a new branch I do it from here. =C2=A0When the developer is=
 happy
> he merges his branch with a beta branch where the Q&A/customer review
> is done.
>
> When this review gets an OK he merges his feature branch with the liv=
e
> one, redo the tests and publish.
>
> I'd really appreciate feedback for this specially for the weak points
> and known problems of my approach with alternatives :)
>
A very interesting read is
http://nvie.com/posts/a-successful-git-branching-model/

It may not be perfect for you, however it does discuss some very
interesting issues, particularly how workflow is just as important as
the branching model.

Another interesting read is the maintainer's notes from the git
project. The branching strategy is a little different then the
previous one, and will perhaps give you a better understanding of the
practicalities of such a strategy. They normally can be found at
https://git.wiki.kernel.org/index.php/MaintNotes but kernel.org is
down at the moment so try
http://code.google.com/p/git-mirror/source/browse/MaintNotes?name=3Dtod=
o
You can also look at
http://git-blame.blogspot.com/p/note-from-maintainer.html and in the
source repository at Documentation/howto/maintain-git.txt

Hope that helps a little.

Regards,
Andrew
