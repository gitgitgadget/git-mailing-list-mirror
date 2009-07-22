From: Tim Harper <timcharper@gmail.com>
Subject: Re: How has learning the advanced features of git helped you to write 
	software more effectively?
Date: Wed, 22 Jul 2009 15:21:26 -0600
Message-ID: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjGt-0002aF-6t
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZGVVVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbZGVVVq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:21:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:35461 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbZGVVVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 17:21:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1331210rvb.5
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=kXAESoQQ7D82BQJ13OcWZ3vchF0iS0XVMW1w5iuSdss=;
        b=HjeZcpZ86hOur9TgkLke5jZUtB8jAcLLO4a7FgPjDhSHD4Y/o0To92rMxW2wL4s2g5
         YPpsmcxC5tx63pFisCPf1z1aKdXJaEsHZHqlGqSyTu+Olo0sAtW+GkIGL6x32JA/pSz3
         3R2+JcISDref5BbuItl1ki0MjRJyIDseLAIt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=LP72B4xGRjN4VILUT/y0VdvoUmHc4NFnCnL6zh82OgVYMkR/JyYsB+SMorbkawe230
         CWWkE8A1J9Fka/5bKAkIRnFmJnwrRF6hXqBJJld2XQFVyQQ2o1+tcmBaqmULWPiVHMkg
         X5s4pzKowvHTxJ7Cy2wmNmFb4AqTD/gMszciY=
Received: by 10.141.34.12 with SMTP id m12mr880514rvj.269.1248297706125; Wed, 
	22 Jul 2009 14:21:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123776>

On Wed, Jul 22, 2009 at 3:07 PM, Dmitry Potapov<dpotapov@gmail.com> wro=
te:
> On Tue, Jul 21, 2009 at 11:08:31PM -0600, Tim Harper wrote:
>>
>> How has mastering the advanced features of git helped you to be a
>> better programmer?
>
> I don't think that features itself make as big difference as the fact
> Git provides you much more flexibility in choosing a more appropriate
> workflow than you have with any centralized VCS. (Yes, you will still
> find many Git features handy even if you work with it as you did with
> CVS, but you will miss most benefits of Git).
>
> To really understand what benefits Git offers, you have to realize fi=
rst
> what is wrong CVS and CVS-like VCSes. Unfortunately, it is difficult =
to
> explain just in a few words. Some implementation deficiency of CVS is
> obvious (and it was addressed in some CVS clones like Subversion), bu=
t
> more fundamental problems are far less obvious even for people who us=
ed
> CVS for many years.
>
> To be fair to CVS, it is far from the worst VCS. There are some insan=
e
> lock-based VCS, which were so painful to use (mostly due to these
> exclusive locks but often due to some other insanity too) that anyone
> who worked with may think about CVS as a really nice system...
>
> In some way, CVS was really revolutionary for its time, because it us=
ed
> the copy-modify-merge paradigm instead of excluding locking, which wa=
s
> dominant before the CVS era. Those exclusive locks not only could not
> work over the Internet, they were so excruciatingly annoying even if
> everyone was sitting in the same room... Despite some initial skeptic=
ism
> about essentially the lock-free VCS, I think it is safe to say now th=
at
> the copy-modify-merge paradigm won. Period.
>
> However, if you look at the support of this paradigm in CVS and other
> centralized VCSes, it is very limited in every aspect:
> - copy: you can have a copy only one revision. (it may not be a big
> =C2=A0issue unless you like to work offline and to look at history).
> - modify: there is no problem with modification itself, but you canno=
t
> =C2=A0save your changes without committing that to the official repo,=
 which
> =C2=A0is not such a good thing if they are not ready yet or were not =
reviewed
> =C2=A0properly.
> - merge: well.. I don't think there is any sane person who enjoyed
> =C2=A0merging branches in CVS... The only merge that was _relatively_=
 easy
> =C2=A0to do was merging your worktree with the upstream. Even that is=
 not
> =C2=A0perfect in CVS, because you cannot save your changes before mer=
ge. So,
> =C2=A0if you made a mistake during 'cvs update', you risk to losing y=
our
> =C2=A0work... Also, there is no possibility to review the merge later=
 or to
> =C2=A0delegate to someone else when its resolution happens to be tric=
ky...
>
> The above limitations have further consequences with negatively affec=
t
> co-operation among developers. For instance, it is very difficult to
> organize the review process with any centralized VCS. Typically, a
> review process may require saving and share your work with reviewer
> without committing it to the central repo. Also, this work should be
> split into logical steps to make review easier. The only way to do th=
at
> with a centralized VCS is to use some patch management system on top =
of
> it.... and at that point you may ask whether you want to learn two
> systems with overlapping functionality and not so well integrated wit=
h
> each other?
>
> Another important reason why feature branches are so useful is that t=
hey
> allow to postpone the decision about integration of some feature to t=
he
> master branch to the time when you convince that it is ready and usef=
ul.
> In a "centralized" workflow, people often commit as they progress to
> their goal, but some ideas may not so good as they initially appeared=
=2E
> At the time when you realize that, your changes already intervened wi=
th
> other people changes. There is no easy way to remove them cleanly. An=
d,
> some work even if it is useful may be not ready to the time when you
> planned to realize a new version. This results in unnecessary delays =
in
> release.
>
> There are more problems with the "centralized" workflow used by CVS a=
nd
> alike. They may be not very noticeable on small projects, but it tend=
s
> to get worse as any project growths over time.
>
>
> So, the main advantage of Git is not in the number of features (and G=
it
> has plenty of them despite of efforts to limit them to only truly use=
ful
> for many users), but its conceptual wholeness and flexibility, which
> allows you to choose the appropriate workflow for your needs.
>
>
> Dmitry
>

I agree whole heartedly with you that git is the best SCM in town.
It's my favorite, and I completely agree that CVS and SVN are
fundamentally flawed in how they implement branches.  I'm not looking
for why you should choose git over another tool :)  Let me rephrase
the question:

:: QUESTION REPHRASED ::

Out of the shoot, you get a lot of value learning the basic features
of git: easy branching, merging, etc.  How has learning the advanced
features of git (bisect, rebase, rebase -i, add -p, etc.) helped you
to write software more effectively?
