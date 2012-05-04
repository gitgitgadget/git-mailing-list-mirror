From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 22:45:12 +0200
Message-ID: <CAMP44s0DwRZT2yEWVh89LeVPU1seu+SJwEdt-jy=4gssCedegg@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
	<CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com>
	<7v4nrvadzq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 23:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQPrf-0005l2-RM
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab2EDUpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 16:45:16 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33992 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204Ab2EDUpO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 16:45:14 -0400
Received: by wibhr7 with SMTP id hr7so1735606wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=G8ZnzHIXZs7RIFSJ8oge5RQ4NcGQ5nSVnycRZx7f7ls=;
        b=oB/g/20Er+DU7GOrch5xtZ3SL/+rWPQBOZr34Kk4IOmxDjiIvv0gkebBku09Jjo255
         /BB+t3+AawoAc/twf5xaejIRkY9qMa3QCfVJiRI/VAixWdRvc0CQtLZORqLx2aUU/c63
         utk8OqEQbqyJgCLUNENpieqzoek+XZ8EnWt+fPuh47UIMkFQMCwEYvQtYLDHlLpjd+zH
         AXCc2V7SwPP4ilxfPVfA+kodvfVbVutvy3H85qIzQf+B4LNewbnNzA2s488XFbU6Llns
         tofnJ/rb3j+Fgy1rOndaDgfLp+3EzzuJXsqirzfNvSPKyejvvSi9B5YPg9PR4f6rSHLC
         MB9g==
Received: by 10.180.24.35 with SMTP id r3mr16071078wif.7.1336164312414; Fri,
 04 May 2012 13:45:12 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 4 May 2012 13:45:12 -0700 (PDT)
In-Reply-To: <7v4nrvadzq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197074>

On Fri, May 4, 2012 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 3, 2012 at 9:13 PM, Rich Pixley <rich.pixley@palm.com> w=
rote:
>> ...
>>> =C2=A0$ # ...do some work...
>>> =C2=A0$ hg push # assume this collides
>>
>> % git push
>>
>>> =C2=A0pushing to $uri_for_cache_repo
>>> =C2=A0searching for changes
>>> =C2=A0abort: push creates new remote head 6d2eb0a6a278!
>>> =C2=A0(you should pull and merge or use push -f to force)
>>> =C2=A0$ hg push -f # the pull and merge case parallels git, so let'=
s use push -f.
>>
>> This is stupid, why make everybody else's life difficult? Let's merg=
e here.
>
> Doing "hg push -f" _regularly_ is probably stupid, but you need to st=
ep
> back a bit. =C2=A0There is a valid situation where you may sometimes =
want to
> publish unmerged work for others to see.
>
> The person who is trying to push here may be quite junior, and may no=
t be
> yet familiar with the areas of the project outside what he has worked=
 on.
> In his attempt to "pull and then push", he can end up having to resol=
ve a
> merge conflict that he is not capable of handling correctly. Regardle=
ss of
> the VCS used, you would want to give a way to this junior developer t=
o ask
> for help "here is my work; while I was working on it, the baseline ha=
s
> been diverged greatly and I need help either merging it or rebasing i=
t."

Sure, but is 'push -f' the right solution? If a junior really has no
idea about what he is doing, I wouldn't want him pushing another
'head' to the master branch. Can mercurial really do a rebase only on
a specific head of a branch? Even if mercurial can do that, the result
can be quite messy; one guy doing a rebase, another guy doing a merge,
another guy doing a different merge, another a different rebase; if
they know what they are doing, they will avoid 'push -f' and revert or
rebase their changes when they notice somebody else tried to do
something similar, but maybe one of them is a slightly more advanced
junior and actually does 'push -f', and we go into yet another round
of conflict resolving.

It doesn't matter how you look at it; 'push -f' is not ideal.

In the git world there's many ways to resolve this; push to another
branch, push to another repo, allow ssh access to your machine, send
the changes by mail, copy the git repo to a shared location, etc.
*All* of those alternatives are better than 'push -f'.

It seems to me that this *huge* thread basically boils down to Rich
wanting 'hg push -f', when clearly that just creates problems, even in
mercurial.

Cheers.

--=20
=46elipe Contreras
