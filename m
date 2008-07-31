From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 17:24:40 +0200
Message-ID: <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
References: <20080730230336.GA6481@Hermes>
	 <20080731092104.1a6ce8bd@pc09.procura.nl>
	 <20080731143955.034f0577@pc09.procura.nl>
	 <20080731130626.GQ32184@machine.or.cz>
	 <20080731170123.79e0d3e9@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 17:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOa2C-0004Ty-9O
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 17:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYGaPYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYGaPYm
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 11:24:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:53352 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYGaPYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 11:24:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so365552ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FJwrw/WF7WZFNQ20BBxsnVMvbSzr1w3MsRYUpcdan0k=;
        b=o4qvWXi1O2LCWrekXdMp4RVUF5XyOhZRoSrKGRXtGhg8vmjo2JjF/nqMABs92Gx2T6
         3jz8vcxLCCXNpOdsqHq6yYEBAE3aM1N0afDhBa5vM54s4eZRDYDmCfkF6sFF81OrriJx
         hn82HIHwRiKHl7K5PlWbiXZ83AgAOQ3uCrrmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uVC88bjMoZRp297UzOgn5aqpL+h7LkARk+T0Gg9LmrLbGrbPoE2+NAjbeQRsCq9m/r
         yPeevklMDw262pdr5E3u7SEQJfKhTe8KzJQY2L6rAQJblXgP29KVsBx+vNMT4uD1jqQ3
         BiOFCNQSxq2iPDvgzigm1zGDWyMgMBF0Pl3Zk=
Received: by 10.150.154.6 with SMTP id b6mr1408746ybe.92.1217517880762;
        Thu, 31 Jul 2008 08:24:40 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Thu, 31 Jul 2008 08:24:40 -0700 (PDT)
In-Reply-To: <20080731170123.79e0d3e9@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90953>

On Thu, Jul 31, 2008 at 17:01, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> On Thu, 31 Jul 2008 15:06:26 +0200, Petr Baudis <pasky@suse.cz> wrote:
>
>> On Thu, Jul 31, 2008 at 02:39:55PM +0200, H.Merijn Brand wrote:
>> >
>> > There is a slight problem with this merging approach. The path names
>> > are as they are/were in the submodules. In module_a, foo.pl was without
>> > a leading module_a/ path, and now after integration, it still is. Is it
>> > possible to rethink this whole process that integrates/merges the
>> > several git repo's in subfolders into the current folder, as-if they
>> > would have been in this folder in the first place?
>>
>> I would suggest re-reading Santi's suggestions:
>>
>> > You have, basically, two possibilities:
>> >
>> > 1) Add the module_# as submodules:
>> >   http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
>> >   http://git.or.cz/gitwiki/GitSubmoduleTutorial
>> > 2) Add the submodules as subtrees (as gitk and git-gui in git.git)
>> >   http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
>>
>> I think the latter is specifically what you want.
>
> I got stuck in that process, as the new repo thinks all the files from
> the sub-folders belong to the top-folder: After this process, there are
> a lot of files from subfolder include in the "new" top-level folder.
>

I see all OK. Can you provide a self consistent simple testcase that
shows what is wrong?

# prepare the project and the modules
mkdir project
cd project
git init
...
mkdir module_a
cd module_a
git init
...
# your script
# show what you get and what you expect, for example:

$ git show HEAD:   # or something equivalent
$ ls
$ git status
...

> --8<--- git-join.sh
> #!/bin/sh
>
> export MODS
> MODS="include fnc"
> MODS="$MODS i00f000 i99f000"
> MODS="$MODS l00m000 l01f000 l02f000 l03f000 l06f000 l90z000"
> MODS="$MODS rpt"
> MODS="$MODS leerpl mutbev prtabel tabellen zoomen"
>
> echo "Creating merge environment"
> rm -rf new
> mkdir new
> cd new
>
> echo "Recovering original repo's"
> tbz -s -x ../lep4gl-git
>
> echo "Initializing new repo"
> git init
>
> for mod in $MODS ; do
>    echo "Merging $mod ..."
>    git remote add -f B$mod $mod
>    git merge -s ours --no-commit B$mod/master
>    git read-tree --prefix=$mod/ -u B$mod/master
>    git commit -m "Merge $mod as our subdirectory"


>    git pull -s subtree B$mod master

This is only needed when updating the subtree if the module has been
updated (but it should do nothing in you case).

>    done
>
> echo Done
> -->8---

Santi
