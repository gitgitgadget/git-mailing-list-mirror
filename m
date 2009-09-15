From: Daniele Segato <daniele.bilug@gmail.com>
Subject: R: Commited to wrong branch
Date: Tue, 15 Sep 2009 15:45:04 +0200
Message-ID: <9accb4400909150645g72e3d78bhd1621e48d3857d99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLz-0007XQ-1H
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZIONp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbZIONp0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:45:26 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54838 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZIONpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:45:03 -0400
Received: by bwz19 with SMTP id 19so2795041bwz.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/PrRRJD3EIJj90wRXv5NY3pfI1uPegdOQ3QOQ5O5Yi8=;
        b=ddj90ucBmB2eMAeZW6vcvaXpyA7K2hA9EKnCd4MiDWTJjLlFrXSz1niac3CBUyJlyR
         xTtJ8edigrxe0Pj+m0Wnf285L98cVQtHbJ4ZQoh3xSjWEAtbyJEhP/N/husQfZ0VANjA
         xdTtyrjGlvlJzsKilOcbXthsa//JD7ByZZqB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Hjp9p+MomaMPAEytBQwjovQopPYQqRC2PN+CelzrqpG+sz8+A4V5q/dl6d9h9jyysE
         RzwMRwxKqWHHpCkrHfw6OcKvzTZcQpOX6qOt2hgaXX+Ge7vT/81I91dQtDpZpAhxqPIZ
         lJoiZ8jgJkg4WcpVjf2eM3R0R/i2GZFtpB6Ok=
Received: by 10.204.152.144 with SMTP id g16mr6166209bkw.189.1253022304129; 
	Tue, 15 Sep 2009 06:45:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128559>

I replied to Howard directly without CCing the Git ML (as a mistake)

anyway he solved the problem on his own now.

this was my first reply that didn't reached the list


On Tue, Sep 15, 2009 at 12:31 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I had made some changes to some files and then done a commit. Only
> then did I realise that I had the wrong branch checked out. To make
> matters worse I then did a 'git reset HEAD^' which means that I can
> now no longer switch branches. I am stuck. I had some advice (thanks!=
)
> but it was not complete. I'd appreciate some more help.

I think that explaining what you did and what happened along your
modification will help you to understand.
It's not that hard, really :)

so this are the steps you followed (confirmed by your reply to Martin)

=C2=A01 - you were on branch X, thinking your were on branch Y

Branch X point to a commit which is the last commit of branch X:

you can visualize the situation like this

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BRANCH Y
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
c1 - c2 - c3 - c5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c4 - c6
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BRANCH X (and your cur=
rent HEAD)

the cN stuffs are commits

BranchX, BranchY and HEAD are only pointers to a commit

=C2=A02 - you worked on on branch X

modified some files/added new one/whatever

now you may have some untracked files (new files)
and some untracked modification (modified files)

untracked means that those files/modification aren't in the git
repository, they are not indexed

=C2=A03 - git add .

You ask git to index the modification to prepare a commit: we say that
files are "staged"

At this time HEAD and BRANCH X are still on c6 commit (see graphic abov=
e)

=C2=A04 - git commit

Ok what happen here?

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BRANCH Y
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
c1 - c2 - c3 - c5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c4 - c6 - c7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BRANCH X=
 (and your current HEAD)

you created a new commit and moved the 2 pointers.


6 - you realized the mistake

now what you want here is to make your Branch X point again the c6
commit and, probably,
save your modification for c7

but you actually panicked :)

and you did:

=C2=A05 - git reset HEAD^

Let's see what happen to the index:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BRANCH Y
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
c1 - c2 - c3 - c5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c4 - c6 -c7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BRANCH X (and your cur=
rent HEAD)

seems right uh?

no you have a lot of untracked files in your directory

that's because git reset doesn't change your directory content
it only work on indexes.

So what you now have in your project directory is what you did on the
top of your initial Branch X

try a
gitk --all

it should show you that


Now you have 2 options:
1) discard what you did for the wrong commit c7 (and restart again on b=
ranch Y)
2) try to backup your work and migrate it to branch Y

the 1) is the easiest one: just execute
git reset HEAD --hard
the option --hard ask git to give you a "clean" reset modifying your
working directory to be exactly
like the indexed c6 commit.

then checkout branch Y:
git checkout Y

and restart to work on that branch


if you want to recover what you did to avoid re-doing it then the
things became a little harder but not
that much :)

there are many way to do it because git gave you a lot of tools

we can help if you calm down :)

for now: question about this?

regards,
Daniele
