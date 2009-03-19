From: Marcus Better <marcus@better.se>
Subject: Re: [EGIT] assertion failure when renaming file
Date: Thu, 19 Mar 2009 20:45:42 +0100
Message-ID: <gpu8hc$v9n$1@ger.gmane.org>
References: <gpnrcv$mla$1@ger.gmane.org> <200903171940.21617.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 21:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOVz-00019D-VS
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbZCSUFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbZCSUFX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:05:23 -0400
Received: from main.gmane.org ([80.91.229.2]:44520 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755644AbZCSUFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:05:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkOUR-00028w-27
	for git@vger.kernel.org; Thu, 19 Mar 2009 20:05:19 +0000
Received: from 80.251.192.2 ([80.251.192.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 20:05:19 +0000
Received: from marcus by 80.251.192.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 20:05:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.251.192.2
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113820>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robin Rosenberg wrote:
> There  are some ways of corrupting a repo, i.e. the association between
> the Git provider and the project that results in wierd behaviours. The
> ones I know of are related to renaming and moving projects tracked by
> EGit, which works minus-well.

Yes, I think I moved the project once.

I also get a message about a NPE "when scanning the repository for changes" shortly after starting Eclipse:

!ENTRY org.spearce.egit.core 4 0 2009-03-19 20:22:12.776
!MESSAGE Git team provider configuration has gone missing.
!STACK 0
java.io.FileNotFoundException: /home/marcus/.workspace/.metadata/.plugins/org.eclipse.core.resources/.projects/wrt-
widget/org.spearce.egit.core/GitProjectData.properties (Filen eller katalogen finns inte)
	at java.io.FileInputStream.open(Native Method)
	at java.io.FileInputStream.<init>(FileInputStream.java:137)
	at org.spearce.egit.core.project.GitProjectData.load(GitProjectData.java:398)
	at org.spearce.egit.core.project.GitProjectData.get(GitProjectData.java:162)
	at org.spearce.egit.core.GitProvider.getData(GitProvider.java:66)
	at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
	at org.spearce.egit.ui.internal.decorators.GitLightweightDecorator.decorate(GitLightweightDecorator.java:161)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorDefinition.decorate(LightweightDecoratorDefinition.java:263)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager$LightweightRunnable.run(LightweightDecoratorManager.java:72)
	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.decorate(LightweightDecoratorManager.java:356)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.getDecorations(LightweightDecoratorManager.java:338)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.ensureResultCached(DecorationScheduler.java:374)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.run(DecorationScheduler.java:334)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

!ENTRY org.eclipse.ui.workbench 4 2 2009-03-19 20:22:12.777
!MESSAGE Problems occurred when invoking code from plug-in: "org.eclipse.ui.workbench".
!STACK 0
java.lang.NullPointerException
	at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
	at org.spearce.egit.ui.internal.decorators.GitLightweightDecorator.decorate(GitLightweightDecorator.java:161)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorDefinition.decorate(LightweightDecoratorDefinition.java:263)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager$LightweightRunnable.run(LightweightDecoratorManager.java:72)
	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.decorate(LightweightDecoratorManager.java:356)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.getDecorations(LightweightDecoratorManager.java:338)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.ensureResultCached(DecorationScheduler.java:374)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.run(DecorationScheduler.java:334)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

!ENTRY org.eclipse.ui 4 4 2009-03-19 20:22:12.777
!MESSAGE Exception in Decorator

!ENTRY org.eclipse.ui 4 4 2009-03-19 20:22:12.778
!MESSAGE java.lang.NullPointerException
!STACK 0
java.lang.NullPointerException
	at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
	at org.spearce.egit.ui.internal.decorators.GitLightweightDecorator.decorate(GitLightweightDecorator.java:161)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorDefinition.decorate(LightweightDecoratorDefinition.java:263)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager$LightweightRunnable.run(LightweightDecoratorManager.java:72)
	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.decorate(LightweightDecoratorManager.java:356)
	at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.getDecorations(LightweightDecoratorManager.java:338)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.ensureResultCached(DecorationScheduler.java:374)
	at org.eclipse.ui.internal.decorators.DecorationScheduler$1.run(DecorationScheduler.java:334)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

!ENTRY org.spearce.egit.core 4 0 2009-03-19 20:22:23.667
!MESSAGE Git team provider configuration has gone missing.
!STACK 0
java.io.FileNotFoundException: /home/marcus/.workspace/.metadata/.plugins/org.eclipse.core.resources/.projects/wrt-
widget/org.spearce.egit.core/GitProjectData.properties (Filen eller katalogen finns inte)
	at java.io.FileInputStream.open(Native Method)
	at java.io.FileInputStream.<init>(FileInputStream.java:137)
	at org.spearce.egit.core.project.GitProjectData.load(GitProjectData.java:398)
	at org.spearce.egit.core.project.GitProjectData.get(GitProjectData.java:162)
	at org.spearce.egit.core.GitProvider.getData(GitProvider.java:66)
	at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
	at org.spearce.egit.ui.Activator$RCS.run(Activator.java:321)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

!ENTRY org.spearce.egit.ui 4 0 2009-03-19 20:22:23.710
!MESSAGE An error occurred while scanning for changes. Scanning aborted
!STACK 0
java.lang.NullPointerException
	at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
	at org.spearce.egit.ui.Activator$RCS.run(Activator.java:321)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

> Could you try with a fresh workspace (you can keep the workdir as-is)?

Yes, that fixes it.

Cheers,

Marcus

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknCoOYACgkQXjXn6TzcAQkbsgCfbRnEwiSjIo9yu9ipk9Tps6cn
Y70An2sxhtz+xtd0wTP2PODAR7jxj4Qc
=taeS
-----END PGP SIGNATURE-----
