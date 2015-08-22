From: Stefan Beller <sbeller@google.com>
Subject: Re: Submodule, subtree, or something else?
Date: Fri, 21 Aug 2015 17:07:04 -0700
Message-ID: <CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
References: <1440197262.23145.191.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?SsSBbmlzIFJ1a8WhxIFucw==?= <janis.ruksans@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 02:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwL4-0002UF-82
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbHVAHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:07:07 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36255 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbHVAHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 20:07:06 -0400
Received: by ykfw73 with SMTP id w73so86500029ykf.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qQXM/bP4OexNWn4PcroFklrXZQAnJ6WqRIw7WQ8vPYw=;
        b=Wmi5Lp9ZOaWWZy/2CQEEJGYgVZ/AZNk751Jh6jRMD22iOuML8a+a8lEx9bl29yD5db
         j1TVdr7EB7dvLk82QxDA1sC76/jOumgo8g+TeRubMjYJV7fS9wwxKtYY6N8/KrLhHfMY
         x11QHk+w4zekwQoeQ/VLMipEbZP2Qdn8EjdB6szpt8OMnoI3Yi4y0ctBFgSr2XTc28e1
         M4xT56Hm6/0eoXSSDdTn5MG4bHLknFB6w39eH+Toz44SMcdaxsHzv2Da8uO9ZmB77P14
         uW0dnZ4ITz6N1suRXordmPzu0MMbuNjzeunCl2+Je6nRRPGdq7gckSXxEtJMFOTbOwq0
         MFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qQXM/bP4OexNWn4PcroFklrXZQAnJ6WqRIw7WQ8vPYw=;
        b=lBbe7KQeAh9ONk/s1wGcBnIDBdiC01BVjkWBVv0gxlyQ7Qp5QJUIC9wkdiSPv/gha4
         FEibfkAi3Z0Fk2xJKuz37NHeAYdMG0AxfxPu+jOdetnMh5saaWVE2zrvOAZQ8p9VeMNq
         jZlQ2zJCU8anZcKViZ8RGcuYD1weDeVQAky+aIZr7d8NbaXBWTi/YBf6fJtxdI/fMjg8
         bpGhfS+EG6IqlThk1ZcR5t8y+FAQPRK8teRkbebTlbz0DDWQNkkl8O/25sLre/NbUJZe
         Ep3TcGC62pouAmS7z2m8ypWg+/1FADcKwSfFdseXXsqMDM90G9j3yAnxL+tljA+tTAjK
         smDg==
X-Gm-Message-State: ALoCoQnhYSJhsq8fROWHJneByiW1k7k+f3JnAruIGYhM1ncKruh7dPS11Y+/er8DVQ6msTWskSkW
X-Received: by 10.170.205.151 with SMTP id w145mr15809916yke.56.1440202024388;
 Fri, 21 Aug 2015 17:07:04 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 17:07:04 -0700 (PDT)
In-Reply-To: <1440197262.23145.191.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276344>

On Fri, Aug 21, 2015 at 3:47 PM, J=C4=81nis Ruk=C5=A1=C4=81ns <janis.ru=
ksans@gmail.com> wrote:
> Hello,
>
>
> First of all, I apologise for the wall of text that follows; obviousl=
y I
> am bad at this.
>
> My $DAYJOB is switching from Subversion to Git, primarily because of
> it's distributed nature (we are scattered all across the globe), and =
the
> ease of branching and merging.  One issue that has popped up is how t=
o
> manage code shared between multiple projects.
>
> Our SVN setup used a shared repository for all projects, either using
> externals for shared code, or, more often than not, simply merging th=
e
> code between projects as needed.  Ignoring the fact that merging with
> SVN is somewhat cumbersome, overall it has worked quite well for us,
> especially when combined with git-svn.
>
> For external libraries that rarely change, submodules appear to be th=
e
> obvious choice when using Git.  On the other hand, I've found them
> somewhat cumbersome to use, and subtree merging (either using git
> subtree, or directly with git merge -s subtree) is closer to what we
> were doing in SVN.  A major drawback of submodules in my opinion is t=
he
> inability to make a full clone from an existing one without having
> access to the central repository, which is something I have to do fro=
m
> time to time.

Can you elaborate on that a bit more?
git clone --recurse-submodules should do that no matter which remote
you contact?


>
> For internal libraries, the situation is even less clear.  For many o=
f
> these libraries, most of the development happens within the context o=
f a
> single project, with commits to main project being interleaved with
> commits to the subproject(s), resulting in histories resembling:
>
>  (using git submodule)
>
>    A---B---S1---S2---C---S3
>           ,=C2=B4   ,=C2=B4       ,=C2=B4
>      N---O----P----Q---R
>
>  (using git subtree with --rejoin)
>
>    A---B---N---O---M1---M2---Q---C---R---M3
>                   /    /                /
>              N'--O'---P--------Q'------R'
>
>  (using merge -s subtree)
>
>    A---B---M1---M2---C---M3
>           /    /        /
>      N---O----P----Q---R
>
> where A, B and C are changes to the main project, N, O, P, Q and R ar=
e
> changes to library code, and Sn and Mn are submodule updates and merg=
e
> commits, respectively.
>
> From what I have gathered, submodules have issues with branching and
> merging, therefore, unless I'm mistaken, submodules are kinda out of
> question.  Of the remaining two options, merging directly results in =
a
> nicer history, but requires making all changes to the library repo fi=
rst
> (although I am quite sure that a similar effect can be achieved with
> plumbing, similarly to how git subtree split works), and is harder to
> use than git subtree.  Also, all three options can result in the main
> project history being cluttered with extra commits.
>
> Lastly, there is a particularly painful 3rd party library that has an
> enormous amount of local modifications that are never going to make i=
t
> upstream, essentially making it a fork, project specific changes that
> are required for one project, but would break others, separate langua=
ge
> bindings that access the internals (often requiring bug fixes to be m=
ade
> simultaneously to both), and, if that wasn't enough, it *requires*
> several source files to be modified for each individual project that
> uses it.  It's a complete mess, but we're stuck with it for the exist=
ing
> projects, as switching to an alternative would be too time consuming.
>
>
> To sum up, I'm looking for something that would let us share code
> between multiple projects, allow for:
>
> 1) separate histories with relatively easy branching and merging
>
> 2) distributed workflow without having to set up a multiple repositor=
ies
> everywhere (eg. work <-> home <-> laptop)
>
> 3) to work on the shared code within a project using it
>
> 4) inspection of the complete history
>
> 5) modifications that are not shared with other projects
>
> and would not result in lots of clutter in the history.
>
> Repository size is somewhat less of an issue, because each submodule =
has
> to be checked out anyway.
>
> Submodules let you have #3, and #1, #2 and #5 to a point, after which=
 it
> becomes a pain.  git subtree allows #1, #2, #3 and #4, and #5 with so=
me
> pain (?), but results in duplicate commits.  Using subtree merge
> strategy directly gives everything except #3, but is harder to use th=
an
> submodules or subtree.
>
> Are there any other options beside these three for sharing (or in som=
e
> cases, not sharing) common code between projects using Git, that woul=
d
> address the above points better?  Or, alternatively, ways to work aro=
und
> the drawbacks of the existing tools?
>
> Lastly, I will be grateful for any suggestions about how to handle th=
e
> messy case described above better.
>
> Thanks,
> J=C4=81nis
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
