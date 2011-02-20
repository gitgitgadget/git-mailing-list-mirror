From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Re: Re: Re: Re: Updating a submodule with a compatible version
 from another submodule version using the parent meta-repository
Date: Sat, 19 Feb 2011 20:15:08 -0500
Message-ID: <AANLkTimbzVd-fs=7KMHMVypb8=RJYah8BTGKQa4Yge1=@mail.gmail.com>
References: <7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
	<AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
	<7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
	<20110129110807.GA21864@book.hvoigt.net>
	<AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
	<AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
	<20110209193610.GA67890@book.hvoigt.net>
	<AANLkTimist_GXgRGdUW1PpxpRO=poYgD4HkDC5CsyLra@mail.gmail.com>
	<20110213133019.GB31986@book.hvoigt.net>
	<AANLkTikHS95BVV4FUjR6TjZxHOGXsje2iDxEwbt9zckh@mail.gmail.com>
	<20110214211317.GA50815@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Feb 20 02:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqxtS-0004ZU-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 02:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab1BTBPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 20:15:10 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47190 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab1BTBPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 20:15:09 -0500
Received: by iwn8 with SMTP id 8so712556iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UQF/Bjr4hU/dpFIXITJzLAvBd9cWrIaW55H76hw6bNc=;
        b=E/iW+5flXjPUYTJGYc042SDQiXJZ/+Wlg7dFaD4XnmEflUbEpEHYgDos5HODNhCsf6
         TYrK0Oer9aVcRHAmsIFKLh/ERQ+xkDY0icP6KNoNarTujUziQDFW8xqY+n4Lf69N2GVe
         bGSs9pB62oWLJHr7Vn4AetFPwxbXDfcNC3Kbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZJ5m/6Papeso/fFIYp0OLuE95tCfeD4adIGVOii3HACrJpUaSHgs8KU+m2kUDNM+wW
         xFFpU3jqlWRVt8fA5jOQt6VKLhCCqi4O0PgwQehO1Q7RUVXz7BgBl+u+dSeJahWfTG/O
         yo/eKjNwv7VOU4jioIVHs7ZzzrRds0plPNAo8=
Received: by 10.42.166.136 with SMTP id o8mr3040033icy.234.1298164508654; Sat,
 19 Feb 2011 17:15:08 -0800 (PST)
Received: by 10.42.221.7 with HTTP; Sat, 19 Feb 2011 17:15:08 -0800 (PST)
In-Reply-To: <20110214211317.GA50815@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167386>

On Mon, Feb 14, 2011 at 4:13 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Sun, Feb 13, 2011 at 01:59:09PM -0500, Julian Ibarz wrote:
>> On Sun, Feb 13, 2011 at 8:30 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > Ok lets not be so hard:
>> >
>> > git checkout v1.7.2.3.msysgit.0
>> > cd ..
>> > git submodulecheckout --find-versions git > git-versions.txt
>> > cd git
>> > git submodulecheckout --find-closest < ../git-versions.txt
>> >> 820fd48475eb72cdd4f2
>> >
>> > Close but not quite the right commit. See the output of git log:
>> > 820fd48 Chomp CRLF before feeding to tar when building netinstaller.
>> > 83e164c Avoid quoting environment variable values.
>> > daafc61 (tag: Git-1.7.2.3-preview20100911) Updated git and git documents and ReleaseNotes to v1.7.2.3
>> >
>> > Whats strange is that this commit did not even change the submodule.
>>
>> Well because it is _exactly_ the commit that point to the current
>> submodule version you have checked out :) So it _is_ the good version.
>> Which version were you thinking was good?
>
> Well I think the interface was/is still confusing me. Once you change to
> one where I can specify the hash I want to search for I will give it
> another try.
>> > I think currently it does not make sense to implement the scripting
>> > since the interface is not yet cleaned up enough. It should be possible
>> > to specify a commit as parameter and the path should probably go after
>> > that like the other commands do as well.
>> >
>> > The other issue is that we need to change the working directory. IMO,
>> > everything should be possible to do from superproject. Have a look at
>> > add_submodule_odb() in submodule.c it lets you load the database of a
>> > submodule. This way you can run the --find-closest from the superproject.
>>
>> I don't think we want to do that. The usual scenario is:
>>
>> * you are in a submodule
>> * you checkout a specific version
>> * you want the meta-repo and side submodules to be updated accordingly
>>
>> And in this scenario at the beginning you are at the submodule
>> directory, not the meta repository so... What do you think? Also even
>> if in these low-level commands you need to change directory, if it is
>> hided in an integration in the sh submodule script, it doesn't matter
>> right?
>
> Well I think the interface should be useable by hand also. Lots of tools
> in git were invented by plugging the tools together differently than the
> original developer even had in his mind. So a nice "do only one thing
> but that very good" kind of interface makes sense.
>
> I think a nice thing would be if you could stay in one directory and it
> should not be too hard since we have add_submodule_odb(). Implementation
> would be easier if we started this command from the supermodule since
> searching for a supermodule from a submodule is still missing.
>
>> > So what I would be looking for is something like this:
>> >
>> > # This looks up all commits of <submodule> ever registered in this
>> > # project
>> > git submodulecheckout --find-versions <submodule> > out.tmp
>> >
>> > # This reads the previous list and outputs a list of of all the commits
>> > # that contain <treeish>. Function in_merge_bases(treeish, i&commit, 1)
>> > # can be of help here. Afterwards you have to prune all later commits
>> > # that contain earlier ones. I did this in find_first_merges(). I
>> > # suggest to refactor that code into a function so that you can use it.
>> > git submodulecheckout --find-closest <treeish> -- <submodule> < out.tmp > out2.tmp
>> >
>> > # And now we can search for the commit in the other submodule C
>> > git submodulecheckout --list-commits <other submodule> < out2.tmp > out3.tmp
>> >
>> > And if out3.tmp just contained one line we could checkout that one. I am
>> > still not sure in which command these options could go. Junio do you
>> > maybe have a suggestion? Since its all about submodules it would make
>> > sense to put it in 'git submodule' but thats already the script.
>> >
>> > Maybe a new 'git-submodule-tool' ?
>>
>> Before I wanted to name it submodule-checkout but I think I hade a
>> naming conflict issue with submodule... not sure if submodule-tool
>> will work...
>
> Since the submodule script might be obsoleted partly and get rewritten
> in C at some point I was thinking of this as a kind of intermediate
> internal submodule helper tool.
>
> Cheers Heiko
>

Today I have added the possibility to provide a hash to find-closest
feature. I have also implemented the two optimizations I was talking
about and now it is pretty fast. By the way I am using the binary tree
from string-list.h. An example of execution:

git submodulecheckout --find-closest v1.7.3.1.msysgit.0 < ../git-versions.txt
279f4c28cad4bd97dc06129118314b0a36f193db

468fabbff85c10e5e226a2ea22699cd4186536f7
fe61e4c51c9f3577fcb85951f72d3c65afce251d

The first commit is the closest referenced commit found starting from
v1.7.3.1.msysgit.0 and then the last two are the commits in the parent
repository that reference this commit. If we integrate this in
git-submodule.sh, the script could take those hash and instead display
them + first line of commit message and the tags if there is one.

As for your third command --list-commits I don't think it matters. As
soon as the user has decided which commit in the parent repository he
wants to checkout, then we just need to git submodule update
everything except the submodule that helped us find it. Basically from
the example above. if we say that
468fabbff85c10e5e226a2ea22699cd4186536f7 is the commit we were looking
for for msysgit then we can do git submodule update on everything
except submodule git.

Next on my TODO list:
* Optimize find-versions using string-list
* Run find-closest in the meta-repository instead
* Implement a test example

Let me know if I am missing something.

Best regards,
Julian
