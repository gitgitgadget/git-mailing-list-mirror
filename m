From: John Tapsell <johnflux@gmail.com>
Subject: Re: setting up tracking on push
Date: Fri, 6 Mar 2009 03:17:58 +0000
Message-ID: <43d8ce650903051917r2919becckf13171c8e015b652@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 04:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfQav-0006Gd-MS
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 04:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbZCFDSC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 22:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZCFDSB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 22:18:01 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:13582 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZCFDSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 22:18:00 -0500
Received: by rv-out-0506.google.com with SMTP id g37so268896rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 19:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7L7tAgfx5amp9gTJ/DT2PAdgyh/XFERICDLFoEHwm6w=;
        b=XPkbkWbcRj1YxMKeDStncU5VUb2NEQQZWoCn51Y1hlXZ+rbvyWE8ppBJXGCiG+Orz6
         wtZU1rPDHfxwt2T3yGu6D7vVYqwc7jNWQmTSR5M3CJs6J3t3u1XZC0BUM4XJ+sk6KCu0
         a/AfwIxVDFdv1HC5ou55sGAgr5AQ9eufLz2Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PiAkm+WDoolB1d39cjRQFn2GBJ2IsY/lOx544nGBsPVmGczIyrjl7H46LGvVqwPaAY
         mjW+dj0Il98jFwmOOgtz3XwOED3ag7YG27cu/Xz3tENKrwTdEoM/O5p6Pv2B8gJ1uGZG
         63+oGeKiuSYf1rCkHf79Q1aNPZgS3m6JdjVfc=
Received: by 10.142.125.9 with SMTP id x9mr861876wfc.85.1236309478443; Thu, 05 
	Mar 2009 19:17:58 -0800 (PST)
In-Reply-To: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112373>

2009/3/6 Miles Bader <miles@gnu.org>:
> [...sorry if this is a dup -- my previous attempt didn't seem to take=
=2E..]
>
> Is there an "easy" way to set up tracking for a branch which starts o=
ut
> locally, and is eventually pushed to a remote?
>
> E.g., I create a new local branch "grognul", and then later propagate=
 it
> to my remote site using:
>
> =C2=A0git push origin grognul
>
> That works great (creating origin/grognul), but to set up tracking, I
> currently edit .git/config (not insanely difficult, but vaguely
> annoying). =C2=A0This is as opposed to a branch which starts out remo=
tely,
> and is pulled, where one can just use "git branch --track" or "git
> checkout --track" (or use a config option to do so by default).
>
> I vaguely feel like I should be able to do:
>
> =C2=A0git push --track origin grognul
>
> [I do this particular action -- creating a branch locally and then
> pushing it to origin -- very very often, thus my desire for a handy
> option.]
>
> What do other people think?

I got bitten by this too, and there's no clue given how to set up the
tracking.  I'd like it to even ask the user when pushing:

$ git push origin grognul
Pushing blah blah...
 Do you want to track this? [Y/N/?]

:-)

John

>
> -miles
>
> --
> Inhumanity, n. One of the signal and characteristic qualities of huma=
nity.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
