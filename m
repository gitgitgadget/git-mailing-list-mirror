From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 21:04:37 +0100
Message-ID: <20080115200437.GB3213@steel.home>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com> <20080114202932.GA25130@steel.home> <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com> <20080115054807.GA3694@steel.home> <a5eb9c330801150721t5da85295heacae2c5a5aad47e@mail.gmail.com> <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEs2W-000824-HY
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYAOUEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYAOUEl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:04:41 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61037 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYAOUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:04:40 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolErE4=
Received: from tigra.home (Faa76.f.strato-dslnet.de [195.4.170.118])
	by post.webmailer.de (fruni mo34) (RZmta 15.4)
	with ESMTP id j03ffbk0FGlHrT ; Tue, 15 Jan 2008 21:04:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0BBD3277AE;
	Tue, 15 Jan 2008 21:04:38 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AEEB056D22; Tue, 15 Jan 2008 21:04:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801150721t5da85295heacae2c5a5aad47e@mail.gmail.com> <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70546>

Paul Umbers, Tue, Jan 15, 2008 16:21:15 +0100:
> I've just completely uninstalled (ie: deleted) and re-installed
> cygwin, ensuring that bin mode was selected for the install (I'm sure
> it was before, that's the default). "mount" confirms that everything
> is mounted in binmode.

Ok, so it is a bit more complicated...

Paul Umbers, Mon, Jan 14, 2008 18:21:44 +0100:
> Trying to create a repository under the cygwin install of git, windows
> XP Pro. I can create the initial repository OK using "git init" and
> add files using "git add .", but when I come to commit I get the
> messages:
> 
> error: invalid object d9b06fceac52f6c24357e6a7f85c601088381152
> fatal: git-write-tree: error building trees

Does the object exists at all? Try

    ls -l .git/d9/b06fceac52f6c24357e6a7f85c601088381152

Is it possible to get a hold of this repo (just the .git directly
after "git add .")? It would be interesting to see the nature of the
corruption.
