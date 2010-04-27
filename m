From: Chris Packham <judge.packham@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Mon, 26 Apr 2010 17:58:59 -0700
Message-ID: <k2ga038bef51004261758gb75415aq9abe4564b67c25f3@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
	 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	 <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	 <4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	 <4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
	 <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	 <m2u86ecb3c71004261646zd17cafdcy85cd2ce522a771d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 02:59:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Z8n-00035o-EF
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 02:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0D0A7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 20:59:02 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37167 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0D0A7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 20:59:01 -0400
Received: by vws13 with SMTP id 13so392996vws.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IFQKMFbsm7R/hcLPhL0DjDwyTlnO1Kxh9b1MIZKObyg=;
        b=OQjsDrDd/Uf38frk5OuvDVXw1cVWncnq5aNsOWJEUeOwU6j48J5Kwm7cQDsbe+vnoS
         GmNcvolrNTP0Cp58kqcl1ucIdpGgg1sulSdzxIlS/oToe7ltErnJSh6U6fbUDLc9wf2H
         7j1ea/egFH8DFXWg4LCEmbqgcFSOYCX7VxG3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c0Jz+aSIaqKwxbCBJm5DVOJUgxlPdVWHoGJSNAYba9Ln8fsZ1jonF1f7K+81v6tVdM
         C0kBeJ5eOuOEdAXEUMHmdiTo74PImdrc/YpG7hqp+GTP/W+F0aKfqp+WbJYGCngmbDEL
         XJXfAHAnCXtHU4GVy70m+TtljU7Z884J2492U=
Received: by 10.220.126.151 with SMTP id c23mr3361948vcs.4.1272329940011; Mon, 
	26 Apr 2010 17:59:00 -0700 (PDT)
Received: by 10.220.99.203 with HTTP; Mon, 26 Apr 2010 17:58:59 -0700 (PDT)
In-Reply-To: <m2u86ecb3c71004261646zd17cafdcy85cd2ce522a771d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145867>

On Mon, Apr 26, 2010 at 4:46 PM, Dmitrijs Ledkovs
<dmitrij.ledkov@ubuntu.com> wrote:
> On 26 April 2010 22:41, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi,
>>
>> How far did git-bzr or git-remote-bzr get?
>>
>
> Don't know, never used.
>
> As far as I know bzr-git can fetch, clone, commit and push to/from
> bzr/git repos. Not sure why you would want git-bzr

Because I searched the git list and thats what I found. Also because
I'm familiar with what I want to do using git.

>> I've tried git-bzr from the repo and I seem to be stumbling on bzr not
>> having the fast-export command after I install the fast-import plugin
>> as per [1]. So I think its a bazzar problem not a git-bzr one. Has
>> anyone got a fully worked example including the installation of the
>> required bits and pieces.
>>
>
> fast-export would loose information AFAIK use bzr-git with dalwich.
>

I'm not really worried about information loss. As long as I can still
get at the tags I'm happy. I'm not really planning on keeping this
repository after migrating the patches (well may be I'll keep it
around to submit the changes but I don't think the upstream project
would find them interesting anyway).

>> Alternatively what I'm really trying to do is update a series of
>> patches for an upstream project that is managed with bazzar. We have
>> 30 or so patches with our customizations so I'd like to get git (or
>> bzr) to do the heavy lifting for me. In git I'd do something like this
>>
>> git clone <upstream>
> bzr branch <upstream>
>> git checkout <tag that corresponds to the version of the tarball we use>
> bzr checkout -rtag:<tagname> tag-branch
>> git checkout -b our-patches
> cd tag-branch
>> git am <patches>
> bzr patch patch1 patch2 patch2
>> git rebase <tag that corresponds to the new version we want to use>
> bzr rebase ../<upstream>
>> git format-patch ...
>>
> bzr log -p; or bazaar send -p or create bundle depends on what you want.
>

OK heres where I run into problems which I think may be due to
openSUSE 11.2s really old version of bzr (1.17). I was missing a 'cd'
in my example so I'm not sure if there is an implied one in the bzr
example. Either way its barfing on 'bzr checkout -rtag:<tagname>
tag-branch' and either refuses to work saying that tag-branch is not a
branch or crashes with I omit tag-branch.

>> Anybody got a similar recipe for bzr? (yes I'll go ask on the bzr list too)
>>

except the list is subscriber only :( .

> Although I think you really want
> http://wiki.bazaar.canonical.com/BzrPipeline which helps you import
> patches ontop of a branch, update upstream, update (merge) patches,
> and export them again. It's something like quilt, topgit but
> bzr-styled ;-)

I'll give it a whirl when I've installed a newer version.

> Thanks. Me will shut up about bzr now =)
>

Yeah me too. I should probably bite the bullet and subscribe or import
the old and new tarballs and see what git can do with limited
information.
