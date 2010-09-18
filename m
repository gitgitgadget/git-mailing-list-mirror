From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 09:58:40 +0000
Message-ID: <AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sat Sep 18 11:58:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuBy-0006Ch-Do
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab0IRJ6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 05:58:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33512 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab0IRJ6k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 05:58:40 -0400
Received: by iwn5 with SMTP id 5so2660759iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gLBpp+UX4AIWEGbHpYUurJniHo2ONVXmFKo0IUvOWH4=;
        b=HvnmACdm7ibl2uwOKE1W6oN1z2bSPEXUSSdOU0RvzHpOm5MvCeJ8TqEZ6ZF/mTCPVY
         e6hCO+n4GaM+ipU4kWauZ+6uUeOAba3We2svpvB/04s1F0qwyAFY6ZAAH813Dj6orYG1
         tj+4MXAFNO1KkRSp8KH0HPfRfaFVRnNEc+iUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H8jDrx/O4PWo5HKRVdo5n9Nv+KvhZLTz7GeXbXTS8AT7Dloo8Olpev2JZBepjM1iMV
         9ShfWIlVPMQ+152sG4ExciIWUpAYYkE9EV9prP/8sf/OtXYL2lZ3zR/07u6ugIzTwJw/
         rQ+Qy/YjVKXzOoGtBy02h6Cznd865HZzra/pM=
Received: by 10.231.173.3 with SMTP id n3mr6737666ibz.56.1284803920067; Sat,
 18 Sep 2010 02:58:40 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 18 Sep 2010 02:58:40 -0700 (PDT)
In-Reply-To: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156449>

On Sat, Sep 18, 2010 at 09:19, Stefan Haller <lists@haller-berlin.de> w=
rote:
> I'm trying to pursuade my co-workers to switch from Subversion to Git=
;
> some of them prefer Mercurial.
>
> One concern that they are raising is that in Git there doesn't seem t=
o
> be an easy way to find out on which branch a given commit was origina=
lly
> made, after the branch is merged back and deleted. They consider this=
 a
> show-stopper. =C2=A0In Mercurial, branch information is meta data att=
ached to
> each commit, so you can easily get this information even after a bran=
ch
> is closed.
>
> Three questions:
>
> 1) Is this not something that Git users miss sometimes? =C2=A0Why not=
?
>
> 2) Is there an easy way to get this information that I might have
> missed? =C2=A0(Typical use-case: you blame a line of code with git gu=
i blame,
> choose "Show history context" to show the changeset in gitk, and from
> there you want to go up to the next merge commit to see if the merge
> commit message mentions the name of the branch. I can't seem to figur=
e
> out how to find this merge commit in gitk, and besides, "Show history
> context" shows me only 7 days of context by default, so the merge com=
mit
> is likely not to be in my current list anyway.)
>
> 3) As a possible work-around, they suggest to require encoding the
> branch information in some format in the commit messages, maybe
> automatically with a commit-msg hook. =C2=A0Does this sound like a fe=
asible
> idea? =C2=A0One drawback would be that it becomes awkward when you
> accidentally make a commit on the wrong branch, and want to rebase it
> onto the correct one.

    You want to do X, and you think Y is the best way of doing so.
Instead of asking about X, you ask about Y.
    =E2=80=94 from Re: sequencial file naming by Abigail

Your Y is encoding the name of the current branch at commit-time, the
you haven't told us. Why do your co-workers think this is essential to
the point that they can't get by without it? What problem are they
trying to solve?

But to answer your question then no, Git doesn't track this
information. Because we think it's irrelevant.

As an example of how irrelevant it is consider my huge ab/i18n series
(you may have spotted it on the list). It's currently composed of 140
patches.

If Git tracked the branch at commit time that series would contain a
bunch of useless metadata. The series is currently composed of commits
which were originally created on at least some of these branches:

    $ git branch -l |grep -e gettext -e i18n
    * ab/i18n
      ab/i18n-add-translations
      ab/i18n-all
      ab/i18n-all-continue
      ab/i18n-continue
      ab/i18n-continue-hi.po
      ab/i18n-continue-more
      ab/i18n-continue-with-hindi
      ab/i18n-for-junio
      ab/i18n-for-junio-with-docs
      ab/i18n-gettextize
      ab/i18n-v2
      debug-gettext-poison
      disable-gettext-by-default-in-releases
      gettext-remove-old-sanity-test
      gettextize-git-in-german
      gettextize-git-mainporcelain
      gettextize-git-mainporcelain-even-more
      gettextize-git-mainporcelain-more
      gettextize-git-mainporcelain-v2
      gettextize-git-mainporcelain-v3
      gettextize-git-mainporcelain-with-perl
      minor-gettext-infrastructure-fixes

But nobody will ever care what branch name I just happened to pick
while I was hacking some patch, why should they? Why does it matter
than I commited some commit on a Solaris box on a branch called
`ab/i18n-oh-man-i-hate-solaris-will-this-just-bloddy-work-already' ?

What Git *does* track however when you do `git merge topic` is the
name of the `topic` branch you're merging into some other branch,
e.g. here (from git-merge(1)):

                     A---B---C topic
                    /         \
               D---E---F---G---H master

Even though A B and C might have been commited on branches called
`blah`, `bluh` and `blarghl` you'll never know. You'll just know that
someone put them all together on a branch called `topic` and that
someone later merged that into master in the main repository. E.g.:

    Merge: A G
    Author: Some Guy <some-guy@example.com>
    Date:   <....>

        Merge branch 'topic'

=46rom there you can *infer* that A-B-C came from the topic branch,
because of that merge commit and that the DAG doesn't meet master
until commit E.

But you can't ever get info about `blah`, `bluh` and `blarghl` back
out of A-B and C again unless you track those branches down in
someone's development repository.

Why? Because who cares about `blah`, `bluh` and `blarghl`, really?
