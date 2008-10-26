From: Warren Harris <warrensomebody@gmail.com>
Subject: Re: git export to svn
Date: Sun, 26 Oct 2008 09:24:07 -0700
Message-ID: <8ED0030A-E55E-4082-87C9-53B11F763E1B@gmail.com>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain> <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com> <1224965564.2874.49.camel@localhost.localdomain> <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com> <20081026091554.GC3612@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 26 17:26:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku8RY-0003Up-0A
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 17:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbYJZQYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 12:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYJZQYp
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 12:24:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:54343 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYJZQYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2008 12:24:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1725815rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ccoOAfpkz3q2VCXdXgkHQ0P3Jz4tOZQgwpj0vgqcRvM=;
        b=Mo/Czm/Ysm20SZdp3mK0pohOgp8Gs9Gz4zZPI2geBYIIcK6Wkt3mPzr5lM29i06H/t
         DpsjiGlKaHqys2FplJyoMY2JHHfbH/YB88nYa+5lBHPsZSRqUeZCrf0mqABotz/wc2Vt
         HDnbfjWvstow4MncqABl16CtcBXDi2XeaIXSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=F3UyAkx4qAvtQ1ZsMCLzJzCs1iPQOa0c0b1m/6TWdWRhsxqoM8+TKDCZRKmVm2oL04
         IdW+CDr8luIU3soAPY1ElQ3LMWh1FqSxVOma/qgGMTlo325IbSJrfKvGqrcuAzpv0Cyn
         oWdJkYuzR7lpMFaDQya41Lit9g5izYEZdqEeQ=
Received: by 10.140.166.21 with SMTP id o21mr2634625rve.254.1225038283258;
        Sun, 26 Oct 2008 09:24:43 -0700 (PDT)
Received: from ?192.168.0.31? (c-76-102-237-126.hsd1.ca.comcast.net [76.102.237.126])
        by mx.google.com with ESMTPS id f21sm8121751rvb.5.2008.10.26.09.24.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 09:24:41 -0700 (PDT)
In-Reply-To: <20081026091554.GC3612@atjola.homenet>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99172>


On Oct 26, 2008, at 2:15 AM, Bj=F6rn Steinbrink wrote:

> On 2008.10.25 13:29:50 -0700, Warren Harris wrote:
>> I tried a fetch, but still no luck:
>>
>> $ git svn fetch
>> W: Ignoring error from SVN, path probably does not exist: (175002): =
=20
>> RA
>> layer request failed: REPORT of '/svn/!svn/bc/100': Could not read =20
>> chunk
>> size: Secure connection truncated (https://svn)
>> W: Do not be alarmed at the above message git-svn is just searching
>> aggressively for old history.
>> This may take a while on large repositories
>> r58084 =3D c01dadf89b552077da132273485e7569d8694518 (trunk)
>> 	A	...
>> r58088 =3D 7916f3a02ad6c759985bd9fb886423c373a72125 (trunk)
>>
>> $ git svn rebase
>> Unable to determine upstream SVN information from working tree =20
>> history
>
> Means that your current branch is not based on what git-svn has =20
> fetched,
> which is expected when you use "svn init" + "svn fetch" after you
> already started working.
>
> What's the actual relationship between your local history and the
> history you fetched from svn?

Since I'm trying to export my git repo to svn, the svn repo is =20
completely empty.

>
>
> If your local stuff started from revision X, which you manually =20
> imported
> from svn, you can just rebase it:
>
> git rebase --onto <svn-revision-X> <your-revision-X>

When I try this, I keep getting:

fatal: Needed a single revision
invalid upstream

>
>
>
> If you have a bunch of merges in your local history, you might want t=
o
> merge your stuff into the svn-based branch instead. When you dcommit,
> the svn repo will only see one big "do it all" commit though.
>
> For that, you would create a graft, so that your first "real" local
> commit gets the svn revision X commit as its parent. That is, from:
>
> S---S---SX---S---S---S (svn)
>
> LX--------L---L---L---L (local)
>
> You want to go to:
>
> S---S---SX---S---S---S (svn)
>         \
> LX        L---L---L---L (local)
>
>
> Where 'S' means that the commit came from SVN, and L means that it =20
> is a
> "local" commit. SX and LX are the commits that have the same tree
> attached (same directories/files), but have a different hash due to =20
> how
> they were created. The graft overrides the parent-child relation for =
=20
> the
> first "L" commit, so that it actually appears as being branched off =20
> of SX.
>
> And then, you'd merge local into svn, so you get:
>
> S---S---SX---S---S---S--M (svn)
>         \             /
> LX        L---L---L---L (local)
>
>
>
> If possible, go with the rebase though. That at least gives a somewha=
t
> reasonable history in the svn repo as well. Also note that when you g=
o
> with the merge way, make sure that the svn branch is totally uptodate
> before you merge and that the merge commit is the only one to be
> dcommitted. Otherwise, funny stuff might happen, and rebase might kic=
k
> in anyway, I don't exactly remember what git-svn does, but it wasn't
> pleasant :-)


I may not have been clear about what I'm trying to do: I have a git =20
repository, and I'd like to put it (either the head of the master, or =20
the entire revision history if possible) into svn. From then on, I =20
would like to be able to use 'git svn' commands to manage the two =20
repos. (Initially I don't expect anyone else to be committing to svn =20
-- it's just an archive and something for others to pull from.)

Here's a complete transcript of how I tried to do this, which seems to =
=20
be missing some crucial step:

$ mkdir test2-git-clone
$ git clone ../test2/   # clone my working repo which is unrelated to =20
svn at this point
$ cd test2-git-clone/test2
$ svn mkdir https://svn/svn/SANDBOX/warren/test2 -m "test2"
$ svn mkdir https://svn/svn/SANDBOX/warren/test2/trunk -m "test2"
$ svn mkdir https://svn/svn/SANDBOX/warren/test2/branches -m "test2"
$ svn mkdir https://svn/svn/SANDBOX/warren/test2/tags -m "test2"
$ git svn init https://svn/svn/SANDBOX/warren/test2 -T trunk -t tags -=20
b branches
Initialized empty Git repository in /Users/warren/projects/tmp/test2-=20
git-clone/test2/.git/
Using higher level of URL: https://svn/svn/SANDBOX/warren/test2 =3D> ht=
tps://svn/svn
$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/=20
libexec/git-core/git-svn line 425.
$ git merge --no-ff master
Already up-to-date.
$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/=20
libexec/git-core/git-svn line 425.
$ git svn fetch
$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/=20
libexec/git-core/git-svn line 425.


Thanks for your help,

Warren