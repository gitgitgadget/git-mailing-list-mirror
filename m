From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 12:05:35 +0100
Message-ID: <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 13:05:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVqy-0008Do-Jp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 13:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZIOLFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 07:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZIOLFf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 07:05:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:50547 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbZIOLFe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 07:05:34 -0400
Received: by ewy2 with SMTP id 2so337631ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=MwpqHo4LgYtT2vGNwrADTwu1vnyqpVLuybzdAXFhGxI=;
        b=VoqvSh88Wg1asbElnWdUct1q4QLbfuE8YyTVqeEo5PzWYt3bd4v0acNtjynHY72jO/
         WXyU3Jmwtbm9095LJni4Nu/MOfUGP0d8FGFgBQmRzr+PMMy7oCIa2Jh+xlU7mw4kNlDm
         pvIvOmri8vB/z+uXMdufF0JhujzKNMPlqFI6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Hr+UjRxXWCXOnlgtamRHz2IlhLDsFi+etqoxBVckmV0PcAuIOmrfpsyRLo9hCYDAII
         6gMjme+2t/E+GrT3TBQeICALueQcVUYU4nGKEhKS+oRbFUpzWC+KLxjmbxOb7R9b4fq3
         Cps8+xb+jzw+a3Hv+jJWF6rxzE4yTPXfNVf8M=
Received: by 10.216.87.136 with SMTP id y8mr1951517wee.70.1253012735128; Tue, 
	15 Sep 2009 04:05:35 -0700 (PDT)
In-Reply-To: <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
X-Google-Sender-Auth: 16826cf005f24631
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128527>

Hi Martin,

I'm pretty shocked how difficult this is... still...

I'm finding git logs and reflogs pretty difficult to read and
interpret (head melting) - in particular telling what happened on what
branch - but looking at the reflog (which I assume is showing me the
actions on the current branch, but I'm not sure) I think I must have
made two commits on the wrong branch so the reset has only 'popped'
the top one. Other than that your interpretation is correct.

I cannot currently change branches - it only complains about one file.
I'm a bit worried about that - I would like to understand why this is
a problem but I don't.

So I am now a little hazy on how to deal with previous TWO commits.

Sorry for misery.... I've lost the plot a bit here :-)

Howard



2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
> On Tue, Sep 15, 2009 at 12:31 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> I am resurrecting a discussion from a week or two back (been on
>> holiday). =A0As follows...
>>
>> I had made some changes to some files and then done a commit. Only
>> then did I realise that I had the wrong branch checked out. To make
>> matters worse I then did a 'git reset HEAD^' which means that I can
>> now no longer switch branches. I am stuck. I had some advice (thanks=
!)
>> but it was not complete. I'd appreciate some more help.
>
> Hi Howard,
>
> just to make sure I understand your issue
>
> =A01 - you were on branch X, thinking your were on branch Y
> =A02 - edit, diff, commit, realised the mistake
> =A03 - git reset HEAD^
>
> so if you now run `git status` and `git diff` it will show your
> changes as if they were uncommitted and unstaged.
>
> (Before you start with various attempts to recover below, a great
> trick is to make an instant-backup in case things go wrong: cd .. / ;
> cp -pr moodle.git moodle-backup.git ; cd moodle.git )
>
> You can now try do do
>
> =A04 - git checkout Y
>
> and if the changes are on files that don't change between X and Y,
> then git will change the branches and keep your changes there. If the
> files are different between X and Y, it won't work.
>
> What I can recommend is to save your patch, as follows
>
> =A05 - git diff > tempchanges.patch
> =A06 - git reset --hard # this will discard your changes, careful
> =A07 - git checkout Y
> =A08 - patch -p1 < tempchanges.patch
>
> The patch may not apply cleanly :-) -- note that patch is more
> tolerant of iffy merges than git's internal implementation ("git
> apply") -- so it will succeed more often... but the results need
> review.
>
> There is a more git-style approach that is to use git-stash -- it use=
s
> git-apply and may not do what you want. The steps are
>
> =A05a - git stash # will save your changed files into a "stashed comm=
it"
> and clear out the changes from your working copy
> =A06a - git checkout Y
> =A07a - git stash apply
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
>
