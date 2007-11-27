From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 14:31:21 +0100
Message-ID: <200711271431.21516.jnareb@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <fih0cd$d31$1@ger.gmane.org> <200711271350.38468.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0Xy-00078Z-2Q
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbXK0Nbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 08:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbXK0Nbd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:31:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:56839 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbXK0Nbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:31:32 -0500
Received: by nf-out-0910.google.com with SMTP id g13so948412nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fZsjvcSXYqIgMVYlOE3kf7KjSRp2Eghcpnudq1pVhPA=;
        b=PaiSklq9WRkbHK7Col4llJvUKrRIagn6kzgGqEVY5TFCi96aRaOt9I4RAW2aPscMnR3a0jHTgAtbpu2+z2SaajmgBNogUcIsexu9C2J6O94i13hj8ybYwkMVxpc6crQKh4UmPaoHTQ8I15SUKjWy2DuGsiLGBWkWYjkgI8mH2LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ner1YBalwLlurFd7ze0I61Qjelv7e/EuSSOSNp4tb7wOtZhKWKu26KUrkYQcSQXrog/R3a1gy8cxfG9RHTK1qNJIN1YKZ/xyawtZ3EPFxAYasx35hL9ez7EVcIT4gK9MIZrQVwwASnwusAe+J4+ptqEK8Cb/IcS8QMR+ke3mWL0=
Received: by 10.86.26.11 with SMTP id 11mr3843751fgz.1196170290994;
        Tue, 27 Nov 2007 05:31:30 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.114])
        by mx.google.com with ESMTPS id e20sm3705744fga.2007.11.27.05.31.27
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 05:31:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711271350.38468.gapon007@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66206>

Dnia wtorek 27. listopada 2007, gapon napisa=B3(a):
> Dne =FAter=FD 27 listopadu 2007 Jakub Narebski napsal(a):
>> gapon wrote:

>>> bzr:
>>> while pushing, bzr tries to merge into the current working copy (of=
 A)
>>> -> all changes are applied or conflicts occure
>>
>> That's wrong, wrong, WRONG! What to do in the case of conflicts?
>> Whan you pull, you can resolve them, as they are on your local side,
>> but when you push you cannot do that.
>=20
> i agree - i didn't say that it's correct behaviour - i just said that=
 i like=20
> it more than git's one

I think it is just wrong and it is hardly any other be worse.
By the way, don't current git _refuse_ to update checked out branch?

>>> hg:
>>> while pushing, neither merge nor info message, but new head (branch=
) is
>>> created in repo A - so then in A you can commit your changes but it=
's
>>> different head (repo A has more heads, use hg heads to list them)
[...]
>> You can do the same with git, but you have to specify new branch nam=
e
>> in repo A, or just configure remote in repo B.
>=20
> how can i do it in repo A? i know how to configure repo B but i didn'=
t know=20
> that i can do it for repo B (or better for all "B" repos)

git-clone sets up repo B (the clone) for one direction of transfer,
from repo A (cloned repo) to repo B (the clone). If you want to push
to repo A, you should configure repo B to do so.

See also comments below.

>> BTW. how do you want for user A (which might be not at terminal, or =
might
>> be not logged in, or might use some application using terminal, or m=
ight
>> use multiple [virtual] terminals, or...) to be informed?
>=20
> quite easily i would say - while doing git status or git commit or so=
 - it=20
> doesn't matter if one uses terminal or gui - just let user know that=20
> something has changed in his repo

There was an idea, and even preliminary implementation in 'pu' branch
(proposed updates) to have BASE extension in the index (or in refs,
I don't remember exactly: search the archives), and check when committi=
ng
if for example push didn't change the repository, didin't advance curre=
nt
checked out branch under our feet so to say. This allowed for the behav=
ior
you want.

It was abandoned, for the following reasons as far as I know.

=46irst, there are legitimate situations, created by current user, wher=
e
branch (HEAD) changes: reset, amend, checkout -m, etc. It would be hard
to avoid annoing false positives (false alarms).

Second, it was complicated to do correctly, as it affected quite a bit
of git codebase.

Third, it encourages a wrong (CVS braindamage inspired) workflow. The l=
ast
thing you want when committing changes is to have to resolve some
conflicts, and/or check if [automatic] conflict resolution is correct.
Blind merging is a bad, bad idea.

> as i wrote earlier - it's confusing (at least for me) that git marks =
any files=20
> as changed (i haven't changed any file) and more, it adds them to the=
 index

You are welcome to ressurect BASE extension to index file :-)

--=20
Jakub Narebski
Poland
