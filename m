From: gapon <gapon007@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 13:50:38 +0100
Message-ID: <200711271350.38468.gapon007@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <200711271216.25283.gapon007@gmail.com> <fih0cd$d31$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwzuB-0000xO-7f
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbXK0Mus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 07:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbXK0Mur
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:50:47 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:43076 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbXK0Muq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 07:50:46 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1229718mue
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=MsidcaqW2DUcMjAI1ExtM9BoMZ2DdB3jxsX3Vb+9814=;
        b=kRXuj/wyGSEPvSyZ2GFUjrH/AFRe5CtVfKQTYz5aucfxyle+qc/f3BBiqyLn7UvGkQ2bHJnUQtrkZBZNwDZ6fxG077BNZGHaIDJ4QdCuxUS9H/WeFCpxJ7Pj5naCxH6rj3V8VLAeOz2ghr8zeunut2RF51T54BMAbOf6BB1GgSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dJ4CFu6oyiRdHD/9C/1yQLmVvFrs6bIt7Xbyxw5HYvLNVYp6HIxrYhhrcIC8IgrOpXoV5L+h0iF8uvSAdgf2yt62o3MVTb9i0yryP/1h6j3oQiHpFWHD4m18YSqkprNP4yrIU+4lYe1tJ1hcHFzIdxAHhRgftUTLCoISK9LD4gY=
Received: by 10.82.190.2 with SMTP id n2mr10497193buf.1196167844124;
        Tue, 27 Nov 2007 04:50:44 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id 31sm4471615fkt.2007.11.27.04.50.42
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 04:50:43 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <fih0cd$d31$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66202>

Dne =FAter=FD 27 listopadu 2007 Jakub Narebski napsal(a):
> [Cc: git@vger.kernel.org, gapon <gapon007@gmail.com>,
>  Benoit Sigoure <tsuna@lrde.epita.fr>]
>
> Could you _please_ do not toppost?

sure, no problem ;)
>
> gapon wrote:
> > Dne =FAter=FD 27 listopadu 2007 Benoit Sigoure napsal(a):
> >> On Nov 27, 2007, at 11:27 AM, gapon wrote:
> >> > * yes, i know that this scenario is "incorrect" but... it's
> >> > possible and
> >> > therefore i think it should be somehow handled - i tried a simil=
ar
> >> > one with
> >> > hg and bzr and i like their behaviour more
> >>
> >> Would you mind describing the behavior of hg and bzr in this case?
>
> [...]
>
> > bzr:
> > while pushing, bzr tries to merge into the current working copy (of=
 A)
> > -> all changes are applied or conflicts occure
>
> That's wrong, wrong, WRONG! What to do in the case of conflicts?
> Whan you pull, you can resolve them, as they are on your local side,
> but when you push you cannot do that.

i agree - i didn't say that it's correct behaviour - i just said that i=
 like=20
it more than git's one
>
> > hg:
> > while pushing, neither merge nor info message, but new head (branch=
) is
> > created in repo A - so then in A you can commit your changes but it=
's
> > different head (repo A has more heads, use hg heads to list them)
> > btw i filed and enhancement for hg, to let user know that there are=
 more
> > heads in the repo (you have to use hg log or hg heads to discover t=
hat
> > someone else has pushed into your repo and hg merge to merge them)
>
> That is also wrong: how do you decide name of new branch then, and
> woundn't this lead to proliferation of branches?

i don't agree that it's wrong - in the hg log all you see is that the c=
ommit=20
from repo B has different parent - that's all
if hg status (or similar) printed some info about this situation it wou=
ld be=20
enough i would say - but just my opinion/feeling of course
>
> You can do the same with git, but you have to specify new branch name
> in repo A, or just configure remote in repo B.

how can i do it in repo A? i know how to configure repo B but i didn't =
know=20
that i can do it for repo B (or better for all "B" repos)
>
> BTW. how do you want for user A (which might be not at terminal, or m=
ight
> be not logged in, or might use some application using terminal, or mi=
ght
> use multiple [virtual] terminals, or...) to be informed?

quite easily i would say - while doing git status or git commit or so -=
 it=20
doesn't matter if one uses terminal or gui - just let user know that=20
something has changed in his repo
as i wrote earlier - it's confusing (at least for me) that git marks an=
y files=20
as changed (i haven't changed any file) and more, it adds them to the i=
ndex
