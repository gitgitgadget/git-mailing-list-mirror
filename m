From: "Rob (gmail)" <robvanb@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 07:00:45 -0400
Message-ID: <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com> 
	<m3ab1wnsie.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 13:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdiuo-0005TR-Sj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 13:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbZHSLBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 07:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZHSLBF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 07:01:05 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:54898 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZHSLBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 07:01:04 -0400
Received: by yxe5 with SMTP id 5so5294235yxe.33
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1l2dPXagb0liCIfAd2kqhxoN6uhE0q8XhMa5GPO1tLU=;
        b=wqzVVOXEBojneqBqhUwtYhEWDDeawu1XyPntIKa4aVFLvOLvwS2Ua03Jp46IuCVxP7
         6EhL6k+YkNhym3+Mt19CQEySDJqF6RiMqu9w15tH/zNPZWTpKCGmhJty4z3WFOgn4UH8
         DhC+tcSHImspAQ3n+fCQC1jsFh4guZb+tbOOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hv8TmmW7RiI8iTOdMwTKugEPkua4TQe+UczH4oo1k0oRgn4pawNgFo6gK9LWJLf72u
         GGGSufoUNNkd3Ova4mthG7wetSjBRmM/3Hh029bTitx+ZlN/zumO6OdfbJpNJmrAzhCy
         yP7qy+20qZhyoEy3h7sFHGD0kVOHBkbT9DEgg=
Received: by 10.151.20.15 with SMTP id x15mr10176267ybi.24.1250679665080; Wed, 
	19 Aug 2009 04:01:05 -0700 (PDT)
In-Reply-To: <m3ab1wnsie.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126535>

Thanks all for all the answers :)

One last question based on the multiple projects issue:
Is there a command that lists all your projects ?

My initial thought is that there probably isn't, as there is no
relation between the project except the userID ?

Thanks again,
Rob.

On Wed, Aug 19, 2009 at 3:59 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> "Rob (gmail)" <robvanb@gmail.com> writes:
>
>> I'm new to git and have some (I think) basic questions that I have
>> not been able to find answers to in the documentation. =A0It's very
>> possible that these are the result of my lack in understanding git /
>> version control, so feel free to point me to documentation that
>> might contain the answers.
>
> Documentation you might want to read:
>
> * "Git User's Manual", distributed with Git (installed at least on
> =A0Linux at $sharedir/doc/git-$version/user-manual.html), also at
> =A0http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
>
> * "The Git Community Book", available at
> =A0http://book.git-scm.com/
>
> * "Pro Git. =A0Professional version control", available at
> =A0http://progit.org/book/
>
>> Q1:
>> Can I create a single repository (project?) for all my code, knowing
>> that there are multiple small, unrelated projects. Or should I creat=
e
>> a new repository for each project ?
>
> You should create a new repository for each project. =A0In git each
> commit is about state of whole repository.
>
>
> If you have single unrelated files, you might want to consider using
> Zit tool (see http://git.or.cz/gitwiki/InterfacesFrontendsAndTools fo=
r
> details), but beware that it is in early stages of development.
>
> (Although if you choose one big repository, you can split it later
> with some effort using git-filter-branch (or git-split somewhere in
> mailing list archives) if you didn't publish your repositories).
>
>> Q2:
>> After initalizing my repository, and comitting the 1st batch of code=
:
>> When further working on the code, will the command "git add ." add a=
ll
>> changed and new files ? Or do I specifically need to list the new
>> files ?
>
> "git add ." would add _all_ new not ignored files, and would stage al=
l
> changed files. =A0But you would have to be sure that all files you do=
n't
> want to be comitted, like generated files (*.o, *.log,...) and backup
> files of your editor (*~ or *.bak), are ignored using .gitignore
> (usually for generated files) and .git/info/excludes or
> core.excludesFile (usually for specific patterns like backup files).
>
>> Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
>> if from the root of the project ?
>
> Most git commands take subdirectory they are in into consideration
> when acting. =A0"git add <filename>" in subdirectory works as expecte=
d.
>
> Note that some commands need to have '.' as filename / pattern to be
> limited to current subdirectory / act on current directory.
>
>> --
>> When in trouble or in doubt, run in circles, scream and shout
>
> :-)
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



--=20
When in trouble or in doubt, run in circles, scream and shout
