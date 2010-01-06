From: Dongas <dongas86@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Wed, 6 Jan 2010 11:55:52 +0800
Message-ID: <60ce8d251001051955x117df3c8t5de7972ce5632c7@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
	 <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
	 <20100105211521.GC2657@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell Steicke <russellsteicke@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 05:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSN7T-0003a1-2i
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 05:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab0AFEDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 23:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694Ab0AFEDe
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 23:03:34 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:51403 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab0AFEDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 23:03:33 -0500
Received: by yxe26 with SMTP id 26so16337044yxe.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O1wvgZLKgTjaSZXK8RmqWhZcZ7U0CW52jbCUr5o/F0k=;
        b=FKbEVe2XF5rYl9nO5hlsvH7kdWqnA8pbuBvkfZblRY1I9LapR4Sf27cSZUysTNLwh+
         Ti2fHGLTLPS/byq0Sf6vTbcTMtlyRolgcMzII+SOn9/fg2aDKJh1Fsu5oHbwA0dRauhf
         vtTQB5WvZrQhRimKej7kHwLcbrgXB+LaTCFMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g2+t+zNNjEM6OsuGBZKUJ2XfRCmfaDihnfh+nUCH8bjdgdyPNFZ1zaGNKW1rFKv23J
         GR9MJdrfOnS3fxLeJxlBNciTWECNpAnSFiLV+56dYOFMOlALb9xBZLBvDENg8lfwlWnN
         4cQx6KJp41eANwV9hiVRfqsmywZ1VmkUUOCvo=
Received: by 10.91.122.9 with SMTP id z9mr1413326agm.20.1262750152750; Tue, 05 
	Jan 2010 19:55:52 -0800 (PST)
In-Reply-To: <20100105211521.GC2657@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136238>

2010/1/6 David Aguilar <davvid@gmail.com>:
>
> Hi,
>
> On Tue, Jan 05, 2010 at 12:30:03PM +0800, Dongas wrote:
>> 2010/1/5 Russell Steicke <russellsteicke@gmail.com>:
>> > On Mon, Jan 4, 2010 at 2:45 PM, Dongas <dongas86@gmail.com> wrote:
>>
>> Thanks a lot, Russell.
>> I followed you instruction but it seemed it needs more changes.
>>
>> Execute your steps....
>> Becomes:
>> root@ubuntu:/work/git-repo/free_monkey# tree -a
>
> Just a note: I would recommend against being root.
> You cloned the repo so you should own it.

Thanks for your advices.

> More below...
>
>
>> root@ubuntu:/work/git-repo/free_monkey# cat .git/config
>> [core]
>> =A0 =A0 =A0 repositoryformatversion =3D 0
>> =A0 =A0 =A0 filemode =3D true
>> =A0 =A0 =A0 bare =3D false
>> =A0 =A0 =A0 logallrefupdates =3D true
>> [remote "karmic"]
>> =A0 =A0 =A0 url =3D git@192.168.1.116:free_monkey.git
>> =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/remotes/karmic/*
>> [branch "master"]
>> =A0 =A0 =A0 remote =3D karmic
>> =A0 =A0 =A0 merge =3D refs/heads/master
>>
>> But the result was:
>> root@ubuntu:/work/git-repo/free_monkey# git branch -a
>> * master
>> =A0 karmic/HEAD
>> =A0 origin/master
>> The 'origin/master' was still not changed.
>
>
> A safter alternative would be to leave the "origin" lines in
> place as a duplicate of karmic:
>
> [remote "karmic"]
> =A0 =A0 =A0 =A0url =3D git@192.168.1.116:free_monkey.git
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/karmic/origin/*
>
> [remote "origin"]
> =A0 =A0 =A0 =A0url =3D git@192.168.1.116:free_monkey.git
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/origin/*
>
>
> At that point you will have two remotes, "karmic" and "origin".
> "git fetch karmic" to get the latest branches.
>
> Finally, "git remote rm origin" to remove all references to it.

It's a good idea.
I have tried and it seemed to work.
(I also did a few more works to make it better)

Below is the result:
root@ubuntu:/work/git-repo/tmp/free_monkey# git branch -a
* master
  origin/HEAD
  origin/master
root@ubuntu:/work/git-repo/tmp/free_monkey# cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "origin"]
	url =3D git@192.168.1.106:free_monkey.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master
root@ubuntu:/work/git-repo/tmp/free_monkey# git remote add karmic
git@192.168.1.106:free_monkey.git
root@ubuntu:/work/git-repo/tmp/free_monkey# git fetch karmic
=46rom git@192.168.1.106:free_monkey
 * [new branch]      master     -> karmic/master
root@ubuntu:/work/git-repo/tmp/free_monkey# git branch -a
* master
  karmic/master
  origin/HEAD
  origin/master
root@ubuntu:/work/git-repo/tmp/free_monkey# git remote rm origin
root@ubuntu:/work/git-repo/tmp/free_monkey# git branch -a
* master
  karmic/master

However there's a little issue:
root@ubuntu:/work/git-repo/tmp/free_monkey# git pull
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
root@ubuntu:/work/git-repo/tmp/free_monkey# grep -wrin 'origin' .git/
root@ubuntu:/work/git-repo/tmp/free_monkey# cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[branch "master"]
[remote "karmic"]
	url =3D git@192.168.1.106:free_monkey.git
	fetch =3D +refs/heads/*:refs/remotes/karmic/*

But 'git pull karmic master' worked well.
root@ubuntu:/work/git-repo/tmp/free_monkey# git pull karmic master
=46rom git@192.168.1.106:free_monkey
 * branch            master     -> FETCH_HEAD
Already up-to-date.

=46or conveniently, i did a few more steps.
Add two lines below '[branch "master"]':
root@ubuntu:/work/git-repo/tmp/free_monkey# cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[branch "master"]
	remote =3D karmic
	merge =3D refs/heads/master
[remote "karmic"]
	url =3D git@192.168.1.106:free_monkey.git
	fetch =3D +refs/heads/*:refs/remotes/karmic/*
Then, 'git pull' worked well.
root@ubuntu:/work/git-repo/tmp/free_monkey# git pull
Already up-to-date.

> That was a while ago (probably over a year ago) and this wasn't
> anybody's itch to scratch in the meantime so nothing every
> materialized. =A0It think this is only the 2nd time this has come
> up in that whole time. =A0Sorry, I wasn't able to find the thread.

Thanks for the info.

> Here's a nice middle ground --
>
> instead of naming your branch "master" you can call your default
> branch "karmic".
>
> To make it the default for "git clone" then you'll need to push
> your local master branch and call it "karmic" over there:
>
> =A0 =A0 =A0 =A0git push origin master:karmic
>
> Then, go to that server and change the repo's HEAD entry so that
> it points to karmic instead of master.
>
> =A0 =A0 =A0 =A0ssh admin@gitbox
> =A0 =A0 =A0 =A0cd /path/to/repo.git
> =A0 =A0 =A0 =A0vi HEAD
>
> From then on, everyone who clones the repo will have a "karmic"
> branch by default instead of the master branch.
>
> To get that branch on repos that were cloned before the change:
>
> =A0 =A0 =A0 =A0git fetch origin
> =A0 =A0 =A0 =A0git checkout -b karmic origin/karmic
>
>
>
> With this setup you might even want to remove the "master"
> branch altogether since it might be confusing to have both:
>
> Once:
> =A0 =A0 =A0 =A0git push origin :master
>
> In everyone's repo:
> =A0 =A0 =A0 =A0git remote prune origin
>
>
> You will need to make sure everyone has either:
> =A0 =A0 =A0 =A0a) cloned from the new master-less repo
> =A0 =A0 =A0 =A0b) run the "checkout -b" and "remote prune" commands
>
> Otherwise someone'll likely "git push" the master branch back
> into existence.

Thanks a lot for the alternative way , it looks good.

Regards
Dongas
