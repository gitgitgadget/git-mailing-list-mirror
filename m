From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 00:15:25 -0700
Message-ID: <CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: linux-gpio-owner@vger.kernel.org Fri Mar 18 08:15:31 2016
Return-path: <linux-gpio-owner@vger.kernel.org>
Envelope-to: glg-linux-gpio@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-gpio-owner@vger.kernel.org>)
	id 1agod7-00086d-QG
	for glg-linux-gpio@plane.gmane.org; Fri, 18 Mar 2016 08:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbcCRHP1 (ORCPT <rfc822;glg-linux-gpio@m.gmane.org>);
	Fri, 18 Mar 2016 03:15:27 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37983 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcCRHP0 (ORCPT
	<rfc822;linux-gpio@vger.kernel.org>); Fri, 18 Mar 2016 03:15:26 -0400
Received: by mail-ig0-f178.google.com with SMTP id ig19so15122689igb.1;
        Fri, 18 Mar 2016 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=39sZ5pzEdjuzYCJfhp0kdt495hR/GUVVCpBcEXu5g30=;
        b=A9bXfB67DvjD0NtrnCbEY407mFuimpGZOWkIs628O/xLbKM5JwGHGH88cmgCmrMrcC
         niJS6tdIMynk9N6chekya/OOhL51ED5tV/boZMLWFktybcZb1LADo0wx1o/Bn8KdaMDH
         Y8RKHQH5BBsXHdNDZZJi9Yj6fzn2tybqDnu4PUwn+4LEIDnidSNDgTziDbdSpfDH9knG
         TdaAnzBu0I7MutKMwDW0mr+TWMm1TsZnweTHGZ8lxmhoi3vl0AEAv4Nc5RwbpePPFGG4
         PM+IcCgpZ/KzTpia8Y2fF8w9MVpvCyCHotgplv98Pt4SIUZ/7q6Nt/PLJnYoaIfR+V8+
         0lNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=39sZ5pzEdjuzYCJfhp0kdt495hR/GUVVCpBcEXu5g30=;
        b=USVWgQsrdZaF9GeYRewV8lDmrEEN1C3p2IxwCRPAqrNthibjlTlVvEK/lF5M4tx5fc
         OWY+jJts3aKoVtODQk4cx3qcUZmqN68ANzKP/LCc21St4oACnAui2iP5pjo4GytEYtNd
         GujrAVP2eEE2u8BAktX1mBsfqh1gzlcwsKGcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=39sZ5pzEdjuzYCJfhp0kdt495hR/GUVVCpBcEXu5g30=;
        b=jnErFO12sDy1Pw8uDH/SAr2ACxAd7u2rB1hVT2RL8drbPG2vs/I02/SZ0+nl3tA3U1
         QonbXYvmwDAfNCBKSnXTBl9zDHItRSOFLec7TfHKNA7v49KNrVbGl0WicZifP/Q1Q6YL
         ivT7Z3tg+hvD7600KW/nahj7BJDFRouscNzrxCFXtTH/tvWGK3GX1OUh9RbvVLeP03V4
         CZLhPpsyZeLVIkgII9vg5bWbZoGlY0ZFGihwGpxdgiSaQAwYtzD93LIjXNX9GWDOkhuy
         O5ygB4VVfzbj5KgvhEl9UU4hqHNaqblG8xT3ZMw8pLpJ8yU/HHSdM+4ON1lxneHteh1h
         Z2sw==
X-Gm-Message-State: AD7BkJJqkFYBuE4nQibyp2iCSz/ONlyyW72ll10HN8Zo9Y5ykXMD5KalnBf9rTIh8vN1SaOn6H5wfJNvpgRtoA==
X-Received: by 10.51.17.38 with SMTP id gb6mr15805352igd.45.1458285325241;
 Fri, 18 Mar 2016 00:15:25 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Fri, 18 Mar 2016 00:15:25 -0700 (PDT)
In-Reply-To: <56EB9B0C.4050507@nvidia.com>
X-Google-Sender-Auth: zEoByBlAHF9jeOIaKP_g1g2_w48
Sender: linux-gpio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-gpio.vger.kernel.org>
X-Mailing-List: linux-gpio@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289207>

On Thu, Mar 17, 2016 at 11:07 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
> For creating the repo and branch, I just followed the instruction from wiki
> https://help.github.com/articles/create-a-repo/

So you shouldn't have created a new repo at all, you should just have
cloned an existing one (that gets you a repo, of course).

You basically ended up starting a new project.

But I guess the github connection explains why there was a crazy
README.md file there, and I can see why that documentation would make
you think it's the right thing to do.

Oh well.

Just a "git init" wouldn't have done that kind of damage, the github
documentation is just misleading in this respect.

We may have to make it really really really clear for the kernel that
people should not use github in any way except purely for hosting..

> I jut use git (git version 2.1.4) for pushing the changes in github repo.
>
> There is no other tools used.

I thought git didn't merge two branches that have no common base by
default, but it seems it will happily do so.

So once you made the mistake of starting a new project, git merge
ended up "helpfully" allowing you to merge the remote tracking branch
into that new project, and we ended up with a silly new root.

"git pull-request" will complain about not having a commit in common,
but "git merge" apparently does not even warn.

Adding Junio and the git list. This seems like much too easy a way to screw up.

Junio (and git people), the problem is that github seems to have
caused Laxman to think he should start a new project, and then git
happily merged the new root just because nobody knew better. And
sadly, I didn't notice the history screw-up until too late, so now we
in the kernel have a third root commit (the first two are
intentional): commit a101ad945113 was merged by commit e5451c8f8330.

So how about a patch something like this:

  --- a/builtin/merge.c
  +++ b/builtin/merge.c
  @@ -1398,7 +1398,7 @@ int cmd_merge(int argc, const char **argv,
const char *prefix)
                     NULL, 0, UPDATE_REFS_DIE_ON_ERR);

          if (remoteheads && !common)
  -               ; /* No common ancestors found. We need a real merge. */
  +               die(_("No common ancestor - not merging"));
          else if (!remoteheads ||
                   (!remoteheads->next && !common->next &&
                    common->item == remoteheads->item)) {

(the above is explicitly whitespace-damaged on purpose - it's not
meant as a serious patch, because we do want the *ability* to merge
different projects across different roots, and there are even git
tests for it, it's just that I think it's too easy to make this
mistake and not even realize).

So the real thing having a special option required to merge
non-related projects? Or at least a humongous warning?

You can recreate (for testing only!) this by doing this in a kernel repo:

  git checkout a101ad945113
  git merge 3cf42efc3479

and you'll see how it happily ends up creating a merge commit with no
common ancestors and no warning that anything might be wrong. It will
take a while - walking all the way up to the root to not find the
common object - but it will happily merge those two totally unrelated
branches without complaining at all.

Now I'm starting to wonder just how many github projects have lots of
separate root commits..

            Linus
