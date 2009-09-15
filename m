From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 13:10:07 +0100
Message-ID: <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 14:10:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnWrR-0002my-W1
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbZIOMKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 08:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbZIOMKH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:10:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:28762 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbZIOMKG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 08:10:06 -0400
Received: by ey-out-2122.google.com with SMTP id 4so602357eyf.5
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=271VWHcLhwgCu+42M/WhVSc2rKAxmPY4h99Yz9eB4/w=;
        b=pdPTz1otpyZjZLEazOPwE3qVinC0xuzaOQW8uQfyk6VswgTUyPTTXL54pHCRHwr/zb
         xW/i3D+SvJesbBElLoa5t563GA79YYKOyzJ9+Z/YHfqGHja1wOb4SpOHnTEwccZvlOhp
         gU7hlZUISRqB7y10mN2PJVOY4EP6R5Ev6x4VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CBtpiAEF2/FzvJBwNnpJPpj9vj4UarAzz3A2DreGc47JTR/ElIk8j0tVdiHv76nBX/
         ffwINcQPagkDifcmNdCwgpk4Vdcg8qp2MAkbvwlbJpVk2X1Hb0zQQm5Wb/cuXsN0znHv
         XkQLULUgdiUjMklkTgDaeoeYBPRQRrgkolWqw=
Received: by 10.216.89.138 with SMTP id c10mr1951393wef.47.1253016607990; Tue, 
	15 Sep 2009 05:10:07 -0700 (PDT)
In-Reply-To: <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
X-Google-Sender-Auth: ee1616a64a7e039e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128534>

Martin,

Looked at gitk - yes there is definitely one more commit still on the
current (wrong) branch.

I deleted the offending file and have now successfully switched to the
other (correct) branch.

Howard

2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
> On Tue, Sep 15, 2009 at 1:05 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> I'm pretty shocked how difficult this is... still...
>
> No prob. It's only hard at the beginning :-)
>
>> I'm finding git logs and reflogs pretty difficult to read and
>> interpret (head melting) - in particular telling what happened on wh=
at
>> branch -
>
> I found gitk enormously helpful to visualise things. Try
>
> =A0gitk # will show you the current branch
>
> =A0gitk X Y # will show you both branches
>
> gitk is a ton easier to visualise. git log is pretty good but won't
> show merges, so it's limited.
>
> git reflog is confusing, but it's mostly a tool to help when there's
> been a mess and you want to diagnose WTH happened...
>
>>but looking at the reflog (which I assume is showing me the
>> actions on the current branch, but I'm not sure)
>
> Don't worry about the reflog...
>
>> =A0I think I must have
>> made two commits on the wrong branch so the reset has only 'popped'
>> the top one. Other than that your interpretation is correct.
>
> Ok, so looking at gitk, there would still be one "wrong" commit. Can
> you confirm?
>
>> I cannot currently change branches - it only complains about one fil=
e.
>
> If you did follow my previous instructions (specially doing 'git rese=
t
> --hard'), then this should not happen. Except...
>
> Except when you have a file that git is not tracking, and it exists i=
n
> the "other" branch. The commit you undid earlier probably added that
> file. So just rm that file, and change branches.
>
>> I'm a bit worried about that - I would like to understand why this i=
s
>> a problem but I don't.
>
> About the file? It was "new" in the commit you un-committed. So when
> you do git reset --hard, git makes sure all the files it is
> _currently_ tracking are "unchanged". If that file was new, it ignore=
s
> it. Just rm it and be happy.
>
>> So I am now a little hazy on how to deal with previous TWO commits.
>
> Just review gitk and confirm if there are more commits to unstich --
> and we'll =A0work from there
>
>
> m
> --
> =A0martin.langhoff@gmail.com
> =A0martin@laptop.org -- School Server Architect
> =A0- ask interesting questions
> =A0- don't get distracted with shiny stuff =A0- working code first
> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>
