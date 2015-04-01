From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: git-completion.tcsh
Date: Wed, 01 Apr 2015 11:55:19 +0200
Message-ID: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Khouzam <marc.khouzam@gmail.com>
To: Perry Rajnovic <perry.rajnovic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 11:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdFN6-0000mn-OE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 11:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbDAJzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2015 05:55:31 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46335 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167AbbDAJz1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2015 05:55:27 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YdFMq-0002Ek-Um; Wed, 01 Apr 2015 11:55:24 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YdFMl-0005hV-C4; Wed, 01 Apr 2015 11:55:19 +0200
Received: from x590c2fb5.dyn.telefonica.de (x590c2fb5.dyn.telefonica.de
 [89.12.47.181]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 01 Apr 2015 11:55:19 +0200
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427882124.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266597>


Quoting Perry Rajnovic <perry.rajnovic@gmail.com>:

> When using the auto-completion included with git for tcsh, several
> commands do directly completion with an additional space appended to
> the end, which defeats the ability to complete to a deeper
> sub-directory.
>
> For example, if I have a git repository including the following:
> basedir/foo/bar/somefile.c
>
> (works as expected, git add)
> $ cd basedir
> $ git add f<tab>
> $ git add foo/
> $ git add foo/b<tab>
> $ git add foo/bar/
> $ git add foo/bar/s<tab>
> $ git add foo/bar/somefile.c
>
> (works not as expected, git rm)
> $ cd basedir
> $ git rm f<tab>
> $ git rm foo
> $ git rm foo<backspace>/b<tab>
> $ git rm foo/bar
> there=E2=80=99s a trailing space after foo and bar in the above lines=
, which
> means it=E2=80=99s not possible to initiate completion or immediately=
 start
> typing, i must back-space before continuing.
>
> I=E2=80=99m fairly certain i=E2=80=99ve seen this for other commands =
as  well, but
> i=E2=80=99m not sure to what extent this occurs throughout the comman=
ds.
>
> Environment info:
> OS: Darwin 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:47
> PST  2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64 (OSX 10.10.2)
> Apple Terminal Version 2.5.1 (343.6)
> git version 2.3.2 (via MacPorts)
> tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options
> wide,nls,dl,al,kan,sm,rh,color,filec

The tcsh completion script is just a wrapper, it relies on the bash =20
completion script to do the heavy lifting and tunnels its output int =20
tcsh's completion infrastructure.
Could you try bash completion in your environment first to see, =20
whether it's a bash completion issue that I can't reproduce or an =20
issue with the tcsh wrapper?

Cc'ing Marc, author of the tcsh wrapper.


G=C3=A1bor
