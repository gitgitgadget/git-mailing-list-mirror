From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Git 1.0 Synopis (Draft v3
Date: Sun, 31 Jul 2005 18:15:40 -0400
Message-ID: <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
References: <ryan@michonline.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 14:56:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzZq6-00037u-C8
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 14:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVHAM4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVHAM4J
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 08:56:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46240 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261844AbVHAM4H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 08:56:07 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j71CsTT4011646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Aug 2005 08:55:03 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j6VMFeqn030963;
	Sun, 31 Jul 2005 18:15:41 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: Message from Ryan Anderson <ryan@michonline.com> 
   of "Fri, 29 Jul 2005 04:29:41 -0400." <20050729082941.GD32263@mythryan2.michonline.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 01 Aug 2005 08:55:03 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> wrote:
> Source Code Management with Git

More bugging...

- Either stay with your idea of "Git is the idea, git the implementation"
  (iff blessed by the Git Powers That Be) and be consistent about it, or
  just use "git" throughout.

- Attribute the meaning appropiately, say by:

In Linus' own words as the inventor of git:

> "git" can mean anything, depending on your mood.
> 
>  - random three-letter combination that is pronounceable, and not
>    actually used by any common UNIX command.  The fact that it is a
>    mispronunciation of "get" may or may not be relevant.
>  - stupid. contemptible and despicable. simple. Take your pick from the
>    dictionary of slang.
>  - "global information tracker": you're in a good mood, and it actually
>    works for you. Angels sing, and a light suddenly fills the room. 
>  - "goddamn idiotic truckload of sh*t": when it breaks
[...]

> To get a copy of Git:
> 	Daily snapshots are available at:
> 	http://www.codemonkey.org.uk/projects/git-snapshots/git/
> 	(Thanks to Dave Jones)
> 
> 	Source tarballs and RPMs at:
> 	http://www.kernel.org/pub/software/scm/git/
> 
> 	Deb packages at:
> 	<insert url here>
> 
> 	Or via Git itself:
> 	git clone http://www.kernel.org/pub/scm/git/git.git/ <local directory>
> 	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ <local directory>
> 
> 	(rsync is generally faster for an initial clone, you can switch later
> 	by editing .git/branches/origin and changing the url)
> 
> To get the 'Porcelain' tools mentioned above:
> 	SCM Interface layers:
> 	cogito - http://www.kernel.org/pub/software/scm/cogito/
> 	StGIT - http://www.procode.org/stgit/

At least cogito includes a (slightly old) version of git. Dunno about
StGIT. And git and cogito have a gitk inside too. This should be mentioned,
i.e., look at the package(s) you are interested and see what else they
carry or require and keep in mind that (for now?) getting git as part of
one package is /not/ guaranteed to be compatible with another or standard
git.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
