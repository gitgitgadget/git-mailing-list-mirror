From: Warren Harris <warrensomebody@gmail.com>
Subject: Re: git export to svn
Date: Tue, 28 Oct 2008 20:40:21 -0700
Message-ID: <9CE5F946-B783-4D0F-993B-C0187E2E2DAF@gmail.com>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain> <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com> <1224965564.2874.49.camel@localhost.localdomain> <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com> <20081026091554.GC3612@atjola.homenet> <8ED0030A-E55E-4082-87C9-53B11F763E1B@gmail.com> <20081026171519.GD3612@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 04:45:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv1zh-00051F-Fp
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 04:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYJ2Dk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2008 23:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYJ2Dk2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 23:40:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:1299 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYJ2Dk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 23:40:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2991113wfd.4
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=Gly2FI2JenxDliFINCqK3GJmNv1sdVHSTB/wc9SAYHU=;
        b=XF5j9/dmh0eUd8aJlJm59SKU6V0bUluZn0Nov0dWDXDDIgojIgjKAK+BgMIwG546Wm
         z8Ujq2XcIsmLq2CIs2osg5vEId+Vl/ZNLXpDqk3xWCkWjSx1TIuN2lUvyLF4hcXyjjod
         50QXR0blBnp9bSES/Xv6b6fj7KtCJ/HfPFEOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=XxGrAmkWVoVdmoeqihh4Zs7yUDP6BNQHLV8g2wwUp1nmOhCmlxiSKNLb7Edlbdb42B
         LlXQbbs+faMPYSmoSMiXMlnJbzDHEgeAhiGOG1pAkoP+Ljr0KVLLQoKF3A7jVys5f5Ad
         T80nn4wHFx0zjITUwraalfJzB0SCCVHUdQ9j0=
Received: by 10.142.211.7 with SMTP id j7mr975806wfg.252.1225251624948;
        Tue, 28 Oct 2008 20:40:24 -0700 (PDT)
Received: from timesink.local (c-76-102-237-126.hsd1.ca.comcast.net [76.102.237.126])
        by mx.google.com with ESMTPS id 30sm5455193wfd.1.2008.10.28.20.40.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Oct 2008 20:40:23 -0700 (PDT)
In-Reply-To: <20081026171519.GD3612@atjola.homenet>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99347>

Bj=F6rn - Thanks again for your help...

On Oct 26, 2008, at 10:15 AM, Bj=F6rn Steinbrink wrote:

>>
>> Since I'm trying to export my git repo to svn, the svn repo is
>> completely empty.
>
> OK, the "r58084" made me think that your code is based on something =20
> that
> is already in the SVN repo. But apperently, that's just a shared svn
> repo, right?

Right

>
> This should do and uses a graft to simplify the process a bit:
>
> Initialize git-svn:
> git svn init -s --prefix=3Dsvn/ https://svn/svn/SANDBOX/warren/test2
>
> The --prefix gives you remote tracking branches like "svn/trunk" whic=
h
> is nice because you don't get ambiguous names if you call your local
> branch just "trunk" then. And -s is a shortcut for the standard
> trunk/tags/branches layout.
>
>
> Fetch the initial stuff from svn:
> git svn fetch
>
> Now look up the hash of your root commit (should show a single =20
> commit):
> git rev-list --parents master | grep '^.\{40\}$'
>
> Then get the hash of the empty trunk commit:
> git rev-parse svn/trunk
>
> Create the graft:
> echo <root-commit-hash> <svn-trunk-commit-hash> >> .git/info/grafts
>
> Now, "gitk" should show svn/trunk as the first commit on which your
> master branch is based.
>
> Make the graft permanent:
> git filter-branch -- ^svn/trunk --all
>
> Drop the graft:
> rm .git/info/grafts
>
> gitk should still show svn/trunk in the ancestry of master
>
> Linearize your history on top of trunk:
> git svn rebase
>
> And now "git svn dcommit -n" should tell you that it is going to =20
> commit
> to trunk.

This worked. The only downside was that all of our svn users =20
subscribed to the checkins mailing list got a flood of messages from =20
me, but otherwise it worked like a charm. (I see that the original git =
=20
commit dates were not preserved in svn, but that doesn't matter too =20
much...)

>
>
>
> Alternatively, if rebase gives just too many conflicts, you can do:
>
> git svn init -s --prefix=3Dsvn/ https://svn/svn/SANDBOX/warren/test2
> git svn fetch
> git checkout -b trunk svn/trunk
> git merge master
> git svn dcommit
>
> That will just create a single huge commit in svn. But the history =20
> will
> be retained in git. You can then work on the new "trunk" branch or =20
> move
> your master branch, so it points to the same commit as trunk and then
> drop the "trunk" branch or whatever. It just matters that your new =20
> work
> is based upon the dcommited merge commit, so "svn/trunk" is in your
> branch's history.

This didn't work for me. (I had tried the first procedure on a test =20
tree, then this one on a different test tree, and ultimately went back =
=20
to the first procedure for my real git repo.) I ended up with an empty =
=20
svn tree. For the record, here's what happened:

$ git svn fetch
W: Ignoring error from SVN, path probably does not exist: (175002): RA =
=20
layer request failed: REPORT of '/svn/!svn/bc/100': Could not read =20
chunk size: Secure connection truncated (https://svn)
W: Do not be alarmed at the above message git-svn is just searching =20
aggressively for old history.
This may take a while on large repositories
r58382 =3D 9b9d5f01e4a3aca714eb5f61a9f05ab657cc7bc5 (svn/trunk)
Checked out HEAD:
   https://svn/svn/test3/trunk r58382

$ git checkout -b trunk svn/trunk
Switched to a new branch "trunk"

$ git merge master
Already up-to-date.

$ git svn dcommit
Committing to https://svn/svn/test3/trunk ...

$ cd tmp/svn-test3/

$ svn co https://svn/svn/test3/trunk
Checked out revision 58385.

$ ls -al trunk/
total 88
drwxr-xr-x  11 warren  staff    374 Oct 28 18:15 .
drwxr-xr-x   3 warren  staff    102 Oct 28 18:15 ..
drwxr-xr-x   9 warren  staff    306 Oct 28 18:15 .svn


Now one thing that might be different than what you prescribed is that =
=20
our svn repo uses different conventions for branches and tags, so I =20
didn't use 'git svn init -s', although I doubt that matters.

Anyway, I'm up and running in svn with your first procedure, so my =20
problem is solved. Thanks.

Warren