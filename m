From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 16:38:34 +0400
Message-ID: <37fcd2780807170538p50221325n5d57f8491bb1723d@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <487EF519.5070902@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSlo-00039h-VZ
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800AbYGQMii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 08:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbYGQMii
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:38:38 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:2126 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154AbYGQMih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 08:38:37 -0400
Received: by el-out-1112.google.com with SMTP id z25so1213035ele.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9is6ChjUrvotFQLpOtomqwmYPAPbLx7CHujCOIetrNs=;
        b=uSnBkIod2LzTTOHogGEgxUBAF/DXSIUSe/fC9yOeYN9tn71Yu5ajqSI2DUHeR8mpAK
         PXoBRqmYUhn/WwORirHU9/5a3IUyUf1Nv1j/x/zi22dOzpqceKWodxdyWAFcsifHLdQb
         kF09eTSRBqv01lPoTzYdRP1jcf3750kY3blUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IYvVN1PhQUYOurfnYo/KUd+IIvDLBy8FhThRcUQsVFRxfbJyR3lDRVo5YefKfqNIW9
         vIf3EsPV31vO0KBW1ei7nfzgD3IjhqIxICotoC6VFIhsobsm6Zzw2D+Do0SAJJvKb+IJ
         Of6zWys/1UlsP17GYrzOdDTe8W7p4BCvQhuT8=
Received: by 10.142.200.20 with SMTP id x20mr582910wff.259.1216298315144;
        Thu, 17 Jul 2008 05:38:35 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Thu, 17 Jul 2008 05:38:34 -0700 (PDT)
In-Reply-To: <487EF519.5070902@sneakemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88842>

On Thu, Jul 17, 2008 at 11:30 AM, "Peter Valdemar M=F8rch (Lists)"
<4ux6as402@sneakemail.com> wrote:
>
> As a total git newbie (5 days) coming from svn, I *am* bewildered. Ev=
en
> sticking to porcelain, it is a feature-rich new tool I have in my han=
ds!
>
> I'm missing clarity about what is porcelain and what is plumbing. `gi=
t help`
> shows
>
> "The most commonly used git commands are:"  add .. tag.
>
> Is this list exactly the list of porcelain commands? Then say so ther=
e.

There are a few other commands that are considered as porcelain, but th=
ey
are not so often used or used for very specific purposes, such sending
patches by email. So, you do not have to bother about them right now.
In fact, even this list may be too long to be learned at once. It is
better to proceed step-wise, like this:

=3D=3D=3D Getting started =3D=3D=3D
1. Creating your repo
git init
git clone

2. Commiting your changes
git add
git commit

There are also git mv, git rm for those who need them.

3. Inspect your changes before committing them
git status
git diff

4. Inspecting history
git log

5. Synchronization with the upstream
git pull
git push

=3D=3D=3D More commands =3D=3D=3D

6. How to revert my changes?
6.1. reverting uncommitted changes
git checkout file
git checkout HEAD file
6.2. committed but not publish changes
git reset HEAD^
git reset --hard HEAD^
6.3. published changes
git revert

7. Who introduced this change?
git log -S as better alternative to git blame

8. Some useful "tricks"
git grep
git add -p
git diff --cached
git commit --amend
git show
git log -p

=3D=3D=3D Working with branches =3D=3D=3D

9. Creating branches and tags
git tag
git branch
git checkout

10. Merging is easy
git merge
By the way:
git pull =3D git fetch + git merge FETCH_HEAD
git merge branch =3D git pull . branch

11. What is rebase?
When can it be useful?
Advantages and disadvantages.

=3D=3D=3D More "advanced" commands =3D=3D=3D

12. git safety net
git log -g

13. Find the change that introduced a bug
git bisect

14. Short review other commands:
git gc
git archive
git-cherry-pick
git remote
git format-patch
git apply
git am

=3D=3D=3D

> Neither `git help diff` nor `git help ls-tree` say whether they are
> porcelain or plumbing commands. `git help diff` mentions git-diff-ind=
ex,
> which i suspect is plumbing. When I read a man page, it would be nice=
 to
> know whether a command (either the topic of the page or another menti=
oned
> command) is intended as porcelain or not.

I agree, it is very confusing for beginners. The rule of the thumb that
helped me when I started was that commands with dash in their names are
plumbing (there are a few exceptions though).

Dmitry
