From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Re: Re: Re: Updating a submodule with a compatible version from
 another submodule version using the parent meta-repository
Date: Sun, 13 Feb 2011 13:59:09 -0500
Message-ID: <AANLkTikHS95BVV4FUjR6TjZxHOGXsje2iDxEwbt9zckh@mail.gmail.com>
References: <4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
	<AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
	<7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
	<20110129110807.GA21864@book.hvoigt.net>
	<AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
	<AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
	<20110209193610.GA67890@book.hvoigt.net>
	<AANLkTimist_GXgRGdUW1PpxpRO=poYgD4HkDC5CsyLra@mail.gmail.com>
	<20110213133019.GB31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 19:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PohAE-0007s7-6n
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 19:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab1BMS7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 13:59:13 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51327 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab1BMS7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 13:59:12 -0500
Received: by iwn9 with SMTP id 9so4118457iwn.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nfSjv8SPStz/0ulZvjFSqjmg2c3t5PmqWatd4ZnAqbA=;
        b=rqZCQMLMy15fVaLsMwJZFut3ZEuKQCthWWywW8u+ScDUzKeAaCR0J5kH+NuvFmpDRc
         KAxbRjYRQo0wlEa56PM+WV82IRYxIqm9dpSEkGyCkjd/ayoStpPKBr7kYj8zQRjgWjfo
         3g44md4nQI2vA36HDp0V39ARCV/tNB1Bkjxww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mcZ4KNuQA3sveqEnjTD6BG5cWJuQ5ellCp0VGq2mgngctSkQMwzY9rbQ4y8W9zYwJx
         PqwHOQTtfsZ2AVAaNw1qLytbzGIhCT9LlXbOL122UYL2j6GyXFZqOstARcO37TaZYfM6
         88BpV4/z8XTk2sBeiqNY5dlMX6GCtrX8HC4uU=
Received: by 10.42.175.4 with SMTP id ay4mr1221589icb.155.1297623550022; Sun,
 13 Feb 2011 10:59:10 -0800 (PST)
Received: by 10.42.222.10 with HTTP; Sun, 13 Feb 2011 10:59:09 -0800 (PST)
In-Reply-To: <20110213133019.GB31986@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166674>

On Sun, Feb 13, 2011 at 8:30 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi Julian,
>
> On Sat, Feb 12, 2011 at 03:32:43PM -0500, Julian Ibarz wrote:
>> Thanks for all your feedbacks. Before your first mail I had already
>> implemented command 1 you are talking about and almost finished
>> command 2. Today I could spend some time again on this side project
>> and I have finished command 2. Here is what you do:
>>
>> git submodulecheckout --find-versions <submodule> > <some_temp_file>
>> cd <submodule>
>> git submodulecheckout --find-closest < <some_temp_file>
>
> I do not quite understand how this is used. I just tried it on the
> msysgit repository. Which is a good candidate for testing since you can
> easily verify the results because for each git version there is a
> corresponding tag in the superproject.
>
> You can find it on repo: http://repo.or.cz/w/msysgit.git
>
> As far as I understand the sha1 you are searching for is determined by
> the currently checked out revision. So here we go:
>
> cd msysgit/git
> git checkout v1.7.2.3.msysgit.0~3
> cd ..
> git submodulecheckout --find-versions git > git-versions.txt
> cd git
> git submodulecheckout --find-closest < ../git-versions.txt
>> submodulecheckout: no commit found

There was multiple bugs in the version you tried and I just pushed the
fix. It is working on my repository at work but on msysgit, just
forget it, it is too slow. I still need to optimize it, it doesn't
scale at all lol. But it shouldn't be a problem. The two optimizations
I want to do:
* use a real hash map to know if I already visited a commit
* go through the history only once and finding the closest commit in a
list instead of going through the entire history for each commit of
the least

I also need to send the list of possible commits in the
meta-repository instead of the first one. For msysgit sometime some
solutions have more than 20 possible solutions!

> Ok lets not be so hard:
>
> git checkout v1.7.2.3.msysgit.0
> cd ..
> git submodulecheckout --find-versions git > git-versions.txt
> cd git
> git submodulecheckout --find-closest < ../git-versions.txt
>> 820fd48475eb72cdd4f2
>
> Close but not quite the right commit. See the output of git log:
> 820fd48 Chomp CRLF before feeding to tar when building netinstaller.
> 83e164c Avoid quoting environment variable values.
> daafc61 (tag: Git-1.7.2.3-preview20100911) Updated git and git documents and ReleaseNotes to v1.7.2.3
>
> Whats strange is that this commit did not even change the submodule.

Well because it is _exactly_ the commit that point to the current
submodule version you have checked out :) So it _is_ the good version.
Which version were you thinking was good?

> I think currently it does not make sense to implement the scripting
> since the interface is not yet cleaned up enough. It should be possible
> to specify a commit as parameter and the path should probably go after
> that like the other commands do as well.
>
> The other issue is that we need to change the working directory. IMO,
> everything should be possible to do from superproject. Have a look at
> add_submodule_odb() in submodule.c it lets you load the database of a
> submodule. This way you can run the --find-closest from the superproject.

I don't think we want to do that. The usual scenario is:

* you are in a submodule
* you checkout a specific version
* you want the meta-repo and side submodules to be updated accordingly

And in this scenario at the beginning you are at the submodule
directory, not the meta repository so... What do you think? Also even
if in these low-level commands you need to change directory, if it is
hided in an integration in the sh submodule script, it doesn't matter
right?

> So what I would be looking for is something like this:
>
> # This looks up all commits of <submodule> ever registered in this
> # project
> git submodulecheckout --find-versions <submodule> > out.tmp
>
> # This reads the previous list and outputs a list of of all the commits
> # that contain <treeish>. Function in_merge_bases(treeish, i&commit, 1)
> # can be of help here. Afterwards you have to prune all later commits
> # that contain earlier ones. I did this in find_first_merges(). I
> # suggest to refactor that code into a function so that you can use it.
> git submodulecheckout --find-closest <treeish> -- <submodule> < out.tmp > out2.tmp
>
> # And now we can search for the commit in the other submodule C
> git submodulecheckout --list-commits <other submodule> < out2.tmp > out3.tmp
>
> And if out3.tmp just contained one line we could checkout that one. I am
> still not sure in which command these options could go. Junio do you
> maybe have a suggestion? Since its all about submodules it would make
> sense to put it in 'git submodule' but thats already the script.
>
> Maybe a new 'git-submodule-tool' ?

Before I wanted to name it submodule-checkout but I think I hade a
naming conflict issue with submodule... not sure if submodule-tool
will work...

> I suggest that you start implementing some basic tests if you found the
> right commits using the testsuite. Basically you build up a sample
> repository where you know which commits of the submodules are tied
> together with a sequence of commands. Then you check whether your
> commands find the correct one. Maybe have a look at the submodule
> tests Jens is implementing on his branch:
>
> https://github.com/jlehmann/git-submod-enhancements

I will take a look into this.

Thanks,
Julian

> Hope that helps.
>
> Cheers Heiko
>
