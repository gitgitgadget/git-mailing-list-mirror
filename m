From: John Tapsell <johnflux@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 16:18:08 +0000
Message-ID: <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9ME-0007O1-Ci
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762189AbZCXQSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761996AbZCXQSO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:18:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:25194 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbZCXQSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 12:18:10 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3500458wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qUNDaDurwze5Bu2YgBZLGztftPtdQCq/xC+w7AuYSsI=;
        b=fUOwosmHXezZ2oGgHzU72vAwU7d1jY8lU41v3co7YTR4SJ7vpTBhrsJfjhH/NiVq3L
         grsbzYWLwV2BjMb7Zf/GBA24XymQS841QmNE/yHMQY7zGVIQWANbrAz8uTPK77TLmwTP
         owu6/IRArnEEHM10zgoPzYmTWB2a6UJN2NfYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WefS4RlYpQQscRVmXPWBitRNnS3304wZTGt5ozigIDwP4PTRiBz8yrzNQdswISg1nP
         VVL0DkYXG9HqzTjFy534Kt+axuB1/9Ft/IZ2+GAQ75Y3FQwLEa0J3XDp1HqVV0gd3OSb
         sZFCOJPIHxWwce2Iis2xs24i5RpM+s7bfKSLE=
Received: by 10.142.237.19 with SMTP id k19mr3460486wfh.68.1237911488153; Tue, 
	24 Mar 2009 09:18:08 -0700 (PDT)
In-Reply-To: <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114470>

2009/3/24 Irene Ros <imirene@gmail.com>:
> Hi all,
>
> I've been using git for some time now and haven't run into this issue
> before, perhaps someone else here has:
>
> I have a branch that is ahead of its origin by a few commits:
>
> $ git status
> # On branch myBranch
> # Your branch is ahead of 'origin/myBranch' by 10 commits.

Tried running: git fetch   ?

=46or some weird reason  "git push origin mybranch"  doesn't actually
update origin/mybranch.  It's more annoying :-)

John

> Oddly, when I try to do a push, I get a message saying that everythin=
g
> is up to date:
> $ git push origin myBranch
> Everything up-to-date
>
> Looking at the log for origin/myBranch I can tell those commits are
> missing, but I can't push them up, even with a --force flag. Any
> ideas?
> Here's the config entry for this branch:
>
> [branch "myBranch"]
> =C2=A0=C2=A0=C2=A0 remote =3D origin
> =C2=A0=C2=A0=C2=A0 merge =3D refs/heads/myBranch
>
> There's also nothing to pull from this branch, I'm the only one worki=
ng on it.
> I use many other branches in this particular repo, and its just this
> one that's giving me trouble.
>
> Thanks so much!
> -- Irene
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
