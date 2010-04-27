From: Marin Atanasov <dnaeon@gmail.com>
Subject: Re: Git and cvsimport
Date: Tue, 27 Apr 2010 13:41:31 +0300
Message-ID: <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
	 <4BD69450.8040608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 27 12:42:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6iEp-0006vl-2w
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 12:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab0D0Klr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 06:41:47 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39628 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab0D0Kld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 06:41:33 -0400
Received: by wwb22 with SMTP id 22so1153852wwb.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4VFHK+JFjjCQbMznFrn9pc6Yw4MXjVEdQQ7DVVc/rQo=;
        b=MidNda0EQOy94CPDuRGQarhj9Z9yrdnLfl4XEfOAdLJWc71YcVKkPz/0/D7lOABt4p
         4SWYqx6KaeS1R5vU02dg9nErvFLbLMvFV4e8NuNynzh+EOoHx4tEfNVcMLmnuzTT+rJv
         5dnALf6UA9KzQ4hHK3E/JF9M2fGPAtFrx54zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xLxfO26vRy4ZsdA/sKDLqM5Mtra5k5etNu5w1JDL9NbpuqMi/fLcKvVyAZbop94pMP
         iQsxkW0q1Xbel0fowXZJhnyAAVHJ32ajrHkjgiCsZ7KwCOnClCRu28ZkeXc7cg6w4Q/y
         1mbeFjwPX7kiuLujPuzbheBlGvsiY9evzj5Yo=
Received: by 10.216.90.21 with SMTP id d21mr1872398wef.159.1272364891480; Tue, 
	27 Apr 2010 03:41:31 -0700 (PDT)
Received: by 10.216.19.10 with HTTP; Tue, 27 Apr 2010 03:41:31 -0700 (PDT)
In-Reply-To: <4BD69450.8040608@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145894>

On Tue, Apr 27, 2010 at 10:37 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Marin Atanasov venit, vidit, dixit 26.04.2010 16:27:
>> Hello,
>>
>> I need to import an existing CVS repo to Git. Using git-cvsimport
>> works well for me when importing from the CVS server itself, but I
>> need to do something different.
>>
>> Here's a little info about what I'm doing.
>>
>> $ pwd
>> /home/<user>/test
>>
>> $ git --version
>> git version 1.5.6.5
>>
>> $ git cvsimport -v -d :pserver:<user>@<server>:/var/
>> cvsroot -C test.git test-repo
>> Initialized empty Git repository in /home/<user>/test/test.git/.git/
>> Running cvsps...
>> connect error: Network is unreachable
>> cvs rlog: Logging test-repo
>> Fetching file1 =A0 v 1.1
>> New file1: 14 bytes
>> Fetching file2 =A0 v 1.1
>> New file2: 14 bytes
>> Fetching file3 =A0 v 1.1
>> New file3: 14 bytes
>> Tree ID bf675ce25c8ca3fd1f4a120ea933510c90ccda16
>> Parent ID (empty)
>> Committed patch 1 (origin +0000 2010-04-26 09:40:58)
>> Commit ID 377641eae81975e214a579da9e6c0c5afd819b17
>> Created tag 'SOMETAG' on 'origin'
>> Fetching file1 =A0 v 1.2
>> Update file1: 47 bytes
>> Fetching file3 =A0 v 1.2
>> Update file3: 47 bytes
>> Tree ID 10ab70cdcc53bb94684d09e60817bb62cb8c3d98
>> Parent ID 377641eae81975e214a579da9e6c0c5afd819b17
>> Committed patch 2 (origin +0000 2010-04-26 09:44:22)
>> Commit ID fea2a99c906e57df5c4735ba3f9627cbb8fba295
>> DONE; creating master branch
>>
>> The above commands works fine, when I directly get the files from th=
e
>> CVS server, but I want to do the following.
>>
>> =A0- checkout files from CVS, which are already tagged with certain
>> names to a local folder
>> =A0- then import those files to Git with git-cvsimport
>> =A0- fetch those imports later by a shared bare repo into different
>> branches, so at the end each branch will contain the files with the
>> certain tag.
>>
>> So, If i do the following, then git-cvsimport fails:
>>
>> $ pwd
>> /home/<user>/test
>>
>> $ cvs -d :pserver:<user>@<server>:/var/cvsroot co -r SOMETAG test-re=
po
>> cvs checkout: Updating test-repo
>> U test-repo/file1
>> U test-repo/file2
>> U test-repo/file3
>>
>> $ git cvsimport -v -d /home/<user>/test -C test.git test-repo
>> Expected Valid-requests from server, but got: E Cannot access
>> /home/<user>/test/CVSROOT
>>
>> Can you give me some hints how to do this? Seems that I can import C=
VS
>> repos from remote server, but cannot do this from a local folder..
>
> ... because a folder is not a server, and a cvs checkout is not a cvs=
 repo.
>
> It's not completely clear to me what you want and why, but the simple=
st
> way seems to be to checkout each cvs tag using cvs, and (add &) commi=
t
> the result to the git branch of your choice using git. You don't seem=
 to
> want to convert the cvs repo, so don't use git cvs-import.
>
> But, really, I don't know what you want - history-less git branches f=
rom
> cvs tags?
>
> Michael
>

Hello Michael,

Perhaps I didn't explain better what I want to accomplish :)

I want to convert CVS repo to a Git one.

But checking  out from CVS and then converting to Git, checks out HEAD
from CVS, thus the latest revisions.

What I want to do is to checkout from CVS the files which are tagged
RELEASE_1_0 for example, and then import the files to a Git repo.
=46iles tagged as RELEASE_1_0 differ from HEAD files, so I want only
those files with that tag for example.

Is this possible to do with git-cvsimport, to specify the tag you want
to checkout from CVS?

I went through the documentation, but didn't see something like that.

If I checkout the files from CVS with that tag and then add, commit to
a git repo, then I'll lose the CVS history, and this is most important
for me keep.

Regards,
Marin

--
Marin Atanasov Nikolov
dnaeon AT gmail DOT com
daemon AT unix-heaven DOT org
