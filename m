From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 14:27:21 +0100
Message-ID: <26ae428a0909150627n4e5935bcxdcdf0fdd33a44aa8@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnY4A-0001nS-Q8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbZION1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbZION1U
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:27:20 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:48390 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZION1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:27:19 -0400
Received: by ey-out-2122.google.com with SMTP id 25so785422eya.19
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=/E+/dcGo/bv2DHNdNVBCvf/fdZ3KkR46hwh8Xg79OR4=;
        b=F7wxOKJoCgkMoJBPTt6yzc0n5xBEkyMq2r9+iLAWwXiinaKYhgRzYYZkbbiT1Tce1o
         zof3uXmTxIDRB0wAQucipWlZiNOLPOO7OlMMdOZLzcWRFU+/ka7s5Qv16h/F3w+zsAPT
         qRVkj0pX3MsgQjxpTFOFC7smtBQOitcqPEzFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=vHPFi2C70S1yova7Z1tlGmyLv8S67GMlVysIWhGmPF0lTVQ/VOE09FXxBVvrqT3R4V
         wfsVvajPC7l8JtzSvUzD6AVSBNuCdBH+s5v/agAzOV/4E9zzlbTcRVLp0huR8DFq1e/v
         YlLQkYE7wGlDojIhGtSLxAyCFBrVuHFH567F4=
Received: by 10.216.4.84 with SMTP id 62mr1334725wei.199.1253021241820; Tue, 
	15 Sep 2009 06:27:21 -0700 (PDT)
In-Reply-To: <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
X-Google-Sender-Auth: b82934b619183e6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128543>

What's to stop me.........

* The "wrong" branch just tracks a remote so I can just dump it once I
have this fixed - (delete it and recreate it?)
* after my 'reset' the files I have in my working copy (still the
wrong branch) should be the latest version ('git reset' does not
change the working copy I think?)
* So can I grab these files (they are mostly new), checkout the
correct version, and just overwrite the existing files? I'll loose
some history but not much and I don't care

Seems too easy :-)

2009/9/15 Howard Miller <howard@e-learndesign.co.uk>:
> Martin,
>
> Got as far as applying the temporary patch and I now get a load of...
>
> Reversed (or previously applied) patch detected! =A0Assume -R? [n]
> Apply anyway? [n]
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file
> theme/onepointnine/local.css.rej
> The next patch would create the file theme/onepointnine/local.css,
>
> funnily I didn't think that file had anything to do with it, but when
> I changed branched I got
>
> T =A0 =A0 =A0 theme/onepointnine/local.css
>
> Not sure what the T means :-(
>
> H.
>
> 2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
>> On Tue, Sep 15, 2009 at 2:10 PM, Howard Miller
>> <howard@e-learndesign.co.uk> wrote:
>>> Martin,
>>>
>>> Looked at gitk - yes there is definitely one more commit still on t=
he
>>> current (wrong) branch.
>>>
>>> I deleted the offending file and have now successfully switched to =
the
>>> other (correct) branch.
>>
>> ok!
>>
>> so you have
>>
>> A - The commit you undid, and have in the temp patch. Note that this
>> patch file is missing the file you've rm'd.
>>
>> B - A commit you haven't "undone" on the "wrong" branch X.
>>
>> =A0and you are on branch Y
>>
>> so now...
>>
>> 1 - git format-patch Y^..Y =A0# will export that patch B into a file=
 for you.
>> 2 - git am 0001-whatever-the-name-of-the-file.txt # patch B
>> =A0 =A0this may need conflict resolution - read the notes it prints!=
 If
>> it refuses to apply the patch, do "git am --skip" to indicate you
>> won't use git-am no more for this, and try applying it with the patc=
h
>> utility.
>> 3 - patch -p1 < your-patch-A.patch
>> 4 - find and readd the file you rm'd earlier -- if you don't have
>> another copy, we can get it from git reflog but that'll take extra
>> steps :-)
>> 5 - git commit # you're committing your patch A here
>>
>> Now, review with gitk to see that you have what you want to have
>> there. If it's all ok...
>>
>> =A06 - git checkout X
>> =A07 - git reset --hard # unstich that last stray commit
>> =A0 --
>>
>> hope the above helps. Git pros will see that the process could be mu=
ch
>> shorter :-) I chose this specific path because in exporting your
>> patches and applying them again you can see each step.
>>
>> If we were to start again, and the branches are reasonably close to
>> eachother (not 19_STABLE vs cvshead :-) ) then you can say
>>
>> =A0- X has 2 bad commits that belong to Y, then
>> =A01 - gitk X & # open gitk to visualise the commits, send it to the=
 background
>> =A02 - git checkout Y
>> =A03 - git cherry-pick X^ # takes the next-to-last commit from X and
>> tries to apply it here - conflict resolution may be needed
>> =A04 - git cherry-pick X # same with the very last commit on X
>> =A05 - gitk # check that is all as you want it
>> =A06 - git checkout X
>> =A07 - git reset --hard X^^ # "rewind 2 commits"
>>
>> hth,
>>
>>
>>
>> m
>> --
>> =A0martin.langhoff@gmail.com
>> =A0martin@laptop.org -- School Server Architect
>> =A0- ask interesting questions
>> =A0- don't get distracted with shiny stuff =A0- working code first
>> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
