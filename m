From: gapon <gapon007@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 15:06:14 +0100
Message-ID: <200711271506.14980.gapon007@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <200711271350.38468.gapon007@gmail.com> <200711271431.21516.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix15J-0002Xx-UB
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbXK0OG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 09:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbXK0OG0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:06:26 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:20839 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbXK0OGZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 09:06:25 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1253029mue
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=AfR8vRZjrIhSwMYPcYsrZ3zZKwTlSLDTxGmKbBj5e0E=;
        b=dIm/ulQwQbCWlSBMbb1SfaDVyeg4Q0hnvL6iX1qq8aide8HaDzg4l3pZM2UXG4ZWBzOjX+GrcbVpeoGr6fh6zJIYjwk4ZgJSbKF4uNB2nfTJlAFu/75LytGzRYYmuK1kYaBc1UJj4uWQflBuA+6lkjvr0LhLpc10TQs9/1kYfoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MpvpQ1qP8YJE7yD+RbsusHsxV+8AexUNHUejVtK8cXkMC75sO+miRy2n1gmKmT/ZeQYK5oAfVZrxOuEOI5gHJho3MQk25W2bZ9t3FXjlCqNmw/SPDDBzfIN54Q+o5+1z/BCrsJhPeVWcrNasuA5OVeI3HgRJSgwywBbrPcAMMeA=
Received: by 10.82.112.3 with SMTP id k3mr10689037buc.1196172382674;
        Tue, 27 Nov 2007 06:06:22 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id y18sm4567318fkd.2007.11.27.06.06.20
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 06:06:20 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <200711271431.21516.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66211>

Dne =FAter=FD 27 listopadu 2007 Jakub Narebski napsal(a):
> Dnia wtorek 27. listopada 2007, gapon napisa=B3(a):
> > Dne =FAter=FD 27 listopadu 2007 Jakub Narebski napsal(a):
> >> gapon wrote:
> >>> bzr:
> >>> while pushing, bzr tries to merge into the current working copy (=
of A)
> >>> -> all changes are applied or conflicts occure
> >>
> >> That's wrong, wrong, WRONG! What to do in the case of conflicts?
> >> Whan you pull, you can resolve them, as they are on your local sid=
e,
> >> but when you push you cannot do that.
> >
> > i agree - i didn't say that it's correct behaviour - i just said th=
at i
> > like it more than git's one
>
> I think it is just wrong and it is hardly any other be worse.
> By the way, don't current git _refuse_ to update checked out branch?

what do you mean exactly? i will try it
>
> >>> hg:
> >>> while pushing, neither merge nor info message, but new head (bran=
ch) is
> >>> created in repo A - so then in A you can commit your changes but =
it's
> >>> different head (repo A has more heads, use hg heads to list them)
>
> [...]
>
> >> You can do the same with git, but you have to specify new branch n=
ame
> >> in repo A, or just configure remote in repo B.
> >
> > how can i do it in repo A? i know how to configure repo B but i did=
n't
> > know that i can do it for repo B (or better for all "B" repos)
>
> git-clone sets up repo B (the clone) for one direction of transfer,
> from repo A (cloned repo) to repo B (the clone). If you want to push
> to repo A, you should configure repo B to do so.
>
> See also comments below.
>
> >> BTW. how do you want for user A (which might be not at terminal, o=
r
> >> might be not logged in, or might use some application using termin=
al, or
> >> might use multiple [virtual] terminals, or...) to be informed?
> >
> > quite easily i would say - while doing git status or git commit or =
so -
> > it doesn't matter if one uses terminal or gui - just let user know =
that
> > something has changed in his repo
>
> There was an idea, and even preliminary implementation in 'pu' branch
> (proposed updates) to have BASE extension in the index (or in refs,
> I don't remember exactly: search the archives), and check when commit=
ting
> if for example push didn't change the repository, didin't advance cur=
rent
> checked out branch under our feet so to say. This allowed for the beh=
avior
> you want.
>
> It was abandoned, for the following reasons as far as I know.
>
> First, there are legitimate situations, created by current user, wher=
e
> branch (HEAD) changes: reset, amend, checkout -m, etc. It would be ha=
rd
> to avoid annoing false positives (false alarms).
>
> Second, it was complicated to do correctly, as it affected quite a bi=
t
> of git codebase.
>
> Third, it encourages a wrong (CVS braindamage inspired) workflow. The=
 last
> thing you want when committing changes is to have to resolve some
> conflicts, and/or check if [automatic] conflict resolution is correct=
=2E
> Blind merging is a bad, bad idea.
>
> > as i wrote earlier - it's confusing (at least for me) that git mark=
s any
> > files as changed (i haven't changed any file) and more, it adds the=
m to
> > the index
>
> You are welcome to ressurect BASE extension to index file :-)

jakub, thanks for explanation - now it's clear that it's not easy to ha=
ndle=20
such case... unfortunately
