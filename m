From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 07:42:27 -0700
Message-ID: <20090903144227.GH1033@spearce.org>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> <20090903012207.GF1033@spearce.org> <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 16:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjDWw-0001tJ-32
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 16:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbZICOmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbZICOmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 10:42:25 -0400
Received: from george.spearce.org ([209.20.77.23]:50890 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbZICOmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 10:42:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A2A7B381FD; Thu,  3 Sep 2009 14:42:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127656>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> BTW, what is your opinion of making it a bit easier to import and use
> the Maven configuration by putting a pom.xml in the top-level
> directory? The actual pom.xml file responsible for building the jgit
> library can still live on in jgit-maven/ if that is preferable.
> 
> I am also thinking about "mavenizing" the .pgm subproject to make it
> easier to browse and search the code from within NetBeans.

Actually, now that we have forked out of the egit.git repository,
I want to refactor the layout of the JGit project to be more maven
like, and have a proper top-level pom to build things.

Unfortunately it seems that nobody can program a proper Maven pom
for a multi-project project unless they are one of the authors
of Maven itself.  I watched the Apache MINA team struggle with it
until the Maven guys wanted to use their code, and fixed their build.

So, this refactoring is waiting for a Maven guru to contribute
an improvement.  Unfortunately they are all busy...

So, to answer your original question, yes, we should make this
better, and patches are welcome.  My own Maven-fu is just not up
to the task.

-- 
Shawn.
