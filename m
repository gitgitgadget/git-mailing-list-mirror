From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 13:58:32 +0100
Message-ID: <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 14:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXcL-0001PU-2c
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZIOM6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 08:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZIOM6b
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:58:31 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:46976 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZIOM6a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 08:58:30 -0400
Received: by ewy2 with SMTP id 2so429144ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=uPNJqD71EQJGSPVKigQ62ndsYu/jXiKIpAL0vPIoKTo=;
        b=m6pbr+EUmmcT8tRvihB9tJDoiDV/rDu/tScICK/2UrESr4sHWO9BsWrRfvsJf5oPhm
         olYqhsVqSEHr68kRfTfiTOinqkGLT+nRWZGUD0wzcLQMW9IvNlsPLLgBWr5IunEt9/Df
         DumicPNvYAOVMGMuRxcfYNGrSOyhfKM8vhTF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=KKYieUSRMFE6ayZCelFZolocZ6Ys3vhCy8QxlRQjlXOVp1fprKy1Dlrbws149VEhdf
         OiVqyzp+xxwgO01INYORfvRbRe85LGfWjEUcDRjs9xopLG7QcYp0A4TJqU0H9JjyBno6
         zFiYXAVW5Obccb06dsQbVZJHKZEG2ARM56SYU=
Received: by 10.216.88.18 with SMTP id z18mr1898773wee.78.1253019512738; Tue, 
	15 Sep 2009 05:58:32 -0700 (PDT)
In-Reply-To: <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
X-Google-Sender-Auth: 4e22755ff0e2d022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128538>

Martin,

Got as far as applying the temporary patch and I now get a load of...

Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
theme/onepointnine/local.css.rej
The next patch would create the file theme/onepointnine/local.css,

funnily I didn't think that file had anything to do with it, but when
I changed branched I got

T	theme/onepointnine/local.css

Not sure what the T means :-(

H.

2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
> On Tue, Sep 15, 2009 at 2:10 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> Martin,
>>
>> Looked at gitk - yes there is definitely one more commit still on th=
e
>> current (wrong) branch.
>>
>> I deleted the offending file and have now successfully switched to t=
he
>> other (correct) branch.
>
> ok!
>
> so you have
>
> A - The commit you undid, and have in the temp patch. Note that this
> patch file is missing the file you've rm'd.
>
> B - A commit you haven't "undone" on the "wrong" branch X.
>
> =A0and you are on branch Y
>
> so now...
>
> 1 - git format-patch Y^..Y =A0# will export that patch B into a file =
for you.
> 2 - git am 0001-whatever-the-name-of-the-file.txt # patch B
> =A0 =A0this may need conflict resolution - read the notes it prints! =
If
> it refuses to apply the patch, do "git am --skip" to indicate you
> won't use git-am no more for this, and try applying it with the patch
> utility.
> 3 - patch -p1 < your-patch-A.patch
> 4 - find and readd the file you rm'd earlier -- if you don't have
> another copy, we can get it from git reflog but that'll take extra
> steps :-)
> 5 - git commit # you're committing your patch A here
>
> Now, review with gitk to see that you have what you want to have
> there. If it's all ok...
>
> =A06 - git checkout X
> =A07 - git reset --hard # unstich that last stray commit
> =A0 --
>
> hope the above helps. Git pros will see that the process could be muc=
h
> shorter :-) I chose this specific path because in exporting your
> patches and applying them again you can see each step.
>
> If we were to start again, and the branches are reasonably close to
> eachother (not 19_STABLE vs cvshead :-) ) then you can say
>
> =A0- X has 2 bad commits that belong to Y, then
> =A01 - gitk X & # open gitk to visualise the commits, send it to the =
background
> =A02 - git checkout Y
> =A03 - git cherry-pick X^ # takes the next-to-last commit from X and
> tries to apply it here - conflict resolution may be needed
> =A04 - git cherry-pick X # same with the very last commit on X
> =A05 - gitk # check that is all as you want it
> =A06 - git checkout X
> =A07 - git reset --hard X^^ # "rewind 2 commits"
>
> hth,
>
>
>
> m
> --
> =A0martin.langhoff@gmail.com
> =A0martin@laptop.org -- School Server Architect
> =A0- ask interesting questions
> =A0- don't get distracted with shiny stuff =A0- working code first
> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
