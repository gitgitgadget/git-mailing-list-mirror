From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Newbie grief
Date: Sat, 5 May 2012 00:05:19 +0200
Message-ID: <CAMP44s0x5gomoYtF1-qdyGB2f1LnT_LYHhu8D4f-O-sSocK=gQ@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
	<CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com>
	<7v4nrvadzq.fsf@alter.siamese.dyndns.org>
	<CAMP44s0DwRZT2yEWVh89LeVPU1seu+SJwEdt-jy=4gssCedegg@mail.gmail.com>
	<4FA44A38.1070704@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Sat May 05 00:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQQcz-0004ER-AP
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 00:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759883Ab2EDWFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 18:05:22 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53624 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824Ab2EDWFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 18:05:21 -0400
Received: by wgbds11 with SMTP id ds11so1559691wgb.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mwVTj0uJvp4mgaXPMTSWnHecWshrBxKVMNkG8HY9nH0=;
        b=f2WfhcWlyPXEk42ZjeUvkoicDkkdvDhgNulbBRict1yJOZUUOQ03YQB9/2XMIyMqPu
         truU2LzJMZtwzH2iKXPnigFAKqOcByL+4Ar7YrqqZQMtH1AXaRhHkmqnzPwuzqhHBrbb
         zCULvF3pDhlwCjJdG2DjV2ETfgDzNyi0pjEgrD+dSGxERcr72IlR9lg5bLSrNCETBB2s
         JYbNVCnJpAc8sVqNEY3iNgKTWctsmdQosY3galpvZt3L0xNj/+/18ON300jvONloL/vv
         vkTlo4ocB+pfe2/zMzSr6dQpbIzP5y+9WpUStIXvoQcSaDforROpOokX3mNLdJllfOC2
         MlfQ==
Received: by 10.180.107.101 with SMTP id hb5mr16589404wib.7.1336169120052;
 Fri, 04 May 2012 15:05:20 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 4 May 2012 15:05:19 -0700 (PDT)
In-Reply-To: <4FA44A38.1070704@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197076>

On Fri, May 4, 2012 at 11:29 PM, Rich Pixley <rich.pixley@palm.com> wro=
te:
> On 5/4/12 1:45 PM, Felipe Contreras wrote:
>>
>> It doesn't matter how you look at it; 'push -f' is not ideal.
>
>
> Push -f offers an alternative

A crappy alternative.

> that is available in other source code control systems, (not just mer=
curial),

Which other systems? monotone? That doesn't say much.

> but not in git. =C2=A0It's a bit of a culture
> shock to discover that it's not available in git.

If you don't find a crappy problematic feature in git that you rely
on--that's your problem.

>> In the git world there's many ways to resolve this; push to another
>> branch, push to another repo, allow ssh access to your machine, send
>> the changes by mail, copy the git repo to a shared location, etc.
>> *All* of those alternatives are better than 'push -f'.
>
> In your opinion, and that's fine. =C2=A0I don't need to argue this po=
int any
> longer. =C2=A0All of those other solutions are also available in the =
other source
> code control systems too.

And they are preferred, even the mercurial documentation says you
should avoid 'push -f'.

It seems you are the only one that thinks 'push -f' is ideal.

>> It seems to me that this *huge* thread basically boils down to Rich
>> wanting 'hg push -f', when clearly that just creates problems, even =
in
>> mercurial.
>
>
> Actually, I wanted a work flow that was functional for me and support=
ed a
> shared branch between multiple repositories. =C2=A0I think I have a p=
rocess for
> that now. =C2=A0The key things I've learned so far are:
>
> * Git can't cope with repository collisions, (in essence, because it'=
s not
> willing to ever create multiple heads, but also because it doesn't tr=
ack the
> entire pedigree of a branch, and because destructive rewrites on the
> repository are common in typical git usage).

Wrong. Git copes with collisions just fine; you don't need multiple
heads, multiple heads are bad, even in mercurial, even mercurial
documentation says so. You merge before you push; easy.

> The usual way to deal with this in the git world is to use geographic=
al
> branches and triangles everywhere,

Again wrong. The usual way is to have feature branches:

% git checkout -b rich-reorganize-foo
% git push origin rich-reorganize-foo

> but using "mege before push" can provide
> a way to use shared branches within git, (provided you can live withi=
n a
> fair number of restrictions, which I probably can.)

That's the preferred way in mercurial too; it's the sane way to do it.

> * That that cryptic message means that git would need to cope with a
> repository collision, which it can't do. =C2=A0It doesn't actually me=
an that the
> repository is corrupt, which is what I took it to mean.
>
> Frankly, if the cryptic message had been clearer, I probably would ne=
ver
> have posted here. =C2=A0I'd likely have figured out that git had this=
 restriction
> and found a way to work around it on my own.

Stop thinking your opinion is truth, and stop playing with words.
Mercurial has the "restriction" that you can't push to a repository
where you don't have permissions; that might be a restriction to
somebody, but using the word restriction to describe that situation
would be a cheap rhetorical device to be abrasiveness against
mercurial.

In mercurial and in git you should merge before you pull, if you don't
like to be forced to do the sane thing; go use mercurial and be happy
with the pain you create to yourself.

And BTW, this is the clear message from mercurial:
abort: push creates new remote head 6d2eb0a6a278!

Not cryptic at all!

Personally I don't care, I know a collision when I see it. If you want
to help improve the error message, feel free to participate in the
other thread that is meant for that. As for the workflow it's clear
that the git workflow is a bit simpler than mercurial one, you just
want to make your life difficult with 'hg push -f', and if you want to
shoot yourself in the foot, you have mercurial for that (even though
it's not recommended there either).

--=20
=46elipe Contreras
