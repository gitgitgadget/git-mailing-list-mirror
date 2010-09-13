From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Mon, 13 Sep 2010 17:01:30 +0200
Message-ID: <AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
	<4C8D14F9.90705@borg.org>
	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
	<4C8D3303.1030302@borg.org>
	<AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
	<4C8E33DF.7010904@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Mon Sep 13 17:01:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvAXK-0006os-AI
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab0IMPBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 11:01:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0IMPBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 11:01:31 -0400
Received: by iwn5 with SMTP id 5so5240026iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eeSJ44jBh2Ldc3pD97VJWp8ocoilFtUrAj1hbEl1McA=;
        b=MDEbA5nqOSeHEWRWM/r61aTCuPiEGxdVQzOaCyNjUVLiLA0MMfMSMKB6c90ueDicIp
         PoscWN+ZGkbros3DJJ/W0zdLAMv6uTQcrRNGQMJBwCjVcLklWbTGjl9kBCeYyOdzU2Iu
         L2nEdZ2UvNIeRC6cq+MXC/QjSNKCCb7KEdCnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YfiOLTOnb0O7MG7lHSkgdX4/zvrqiNPHoA4N6QLv8JRY7JzPDatPLAJiZ5/sp1nT9M
         Oi5cEJ/6Y8B/M3XDRbWgpvwRHOjoeP9tby5R9LfNTi07dDsnIeKgpmVrBM+Ay8zSm3P0
         WwmG1F3OrFyzvTWx3iiSYU1U228HAZAMrohxE=
Received: by 10.231.192.67 with SMTP id dp3mr6283310ibb.180.1284390090545;
 Mon, 13 Sep 2010 08:01:30 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Mon, 13 Sep 2010 08:01:30 -0700 (PDT)
In-Reply-To: <4C8E33DF.7010904@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156096>

On Mon, Sep 13, 2010 at 4:23 PM, Kent Borg <kentborg@borg.org> wrote:
> Tor Arvid Lund wrote:
>>> I don't have time to try the "git p4 submit" now, I am going to be =
late
>>> in meeting my wife. =C2=A0Tomorrow morning...will it work?
>>>
>>
>> I'm optimistic :)
>
> Um, not so great.
>
> Two problems:
>
> =C2=A0- I was on the wrong branch this morning when I did the
> =C2=A0 "git p4 submit" (stupid me),
>
> =C2=A0- I realize that even if I had done that right, part of my
> =C2=A0 history is a big lump of Linux kernel files with no history
> =C2=A0 but a sync out of Perforce.

I don't know if I understand what you mean here... If "git diff
p4/master.." gives output equivalent to what you would want to submit
to p4, then that seems correct to me.

> So it seems what I need to do is get on a clean branch that has good
> history and cherry-pick all the bits I want off the branch with the b=
ad
> ancestry onto the clean branch. =C2=A0(And get a good "[git-p4: depot=
-paths:
> ..." in place.)
>
> Then...just point p4/HEAD and p4/master and master to the newest comm=
it
> on that new clean branch. =C2=A0Voila!
>
> Possibly one of my last stupid questions on this: How do I do that?
> "p4/master" looks like a remote, but "git remote" doesn't seem to kno=
w
> about it. =C2=A0In gitg "master" is green, just like a branch I might=
 create,
> so I figure I can delete and re-create it where I want, but "p4/maste=
r"
> and "p4/HEAD" is blue. =C2=A0What are these blue things? =C2=A0How do=
 I move them
> to a different commit?

Well, I don't know gitg, but I can guess that it shows branches as
blue if they are files created inside refs/remotes/*. This is the case
for p4/master and p4/HEAD. They are placed there because normally,
users should not update these refs, nor should they directly do
checkouts of these branches (but your case is not exactly that
normal).

git remote, shows remotes as defined in your .git/config file (the
[remote "someremotename"] sections). git-p4 does not need nor create
such entries.

-Tor Arvid-
