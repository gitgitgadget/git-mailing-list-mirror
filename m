From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 14:20:34 +0100 (CET)
Message-ID: <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 14:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ3Qe-0006T6-Hi
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 14:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbZBPNUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757184AbZBPNUi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:20:38 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:49125 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757139AbZBPNUh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 08:20:37 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id CD92858BDCE; Mon, 16 Feb 2009 14:20:34 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 16 Feb 2009 14:20:34 +0100 (CET)
In-Reply-To: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110176>

I solved it:

it has to do with the
core.autocrlf=input
core.safecrlf=true

settings I had in my global config.
Maybe the manual page should warn against having these defined?

Ferry


On Mon, February 16, 2009 10:17, Ferry Huberts (Pelagic) wrote:
> Hi list,
>
> when I try to import a CVS repo with:
>
> git cvsimport -v -i \
>   -d :pserver:anonymous@javagroups.cvs.sourceforge.net:/cvsroot/javagroups \
>   JGroups
>
> I'm getting the errors:
>
> New tests/other/org/jgroups/tests/adapttcp/Test.java: 5914 bytes
> Use of uninitialized value in concatenation (.) or string at /usr/bin/git-cvsimport line 674, <CVS> line 652.
> Use of uninitialized value in concatenation (.) or string at /usr/bin/git-cvsimport line 674, <CVS> line 652.
> fatal: malformed index info 100666 	src/org/jgroups/util/RWLock.java
> unable to write to git-update-index:  at /usr/bin/git-cvsimport line 679, <CVS> line 652.
>
>
> I've seen this before when trying to import other repositories.
> And since I'm not good with Perl I was wondering whether this sounds familiar
> and if there's a fix for it.
>
> I'm on Fedora 10 with the following packages:
> git.x86_64                                                      1.6.0.6-1.fc10
> git-all.x86_64                                                  1.6.0.6-1.fc10
> git-arch.x86_64                                                 1.6.0.6-1.fc10
> git-cvs.x86_64                                                  1.6.0.6-1.fc10
> git-daemon.x86_64                                               1.6.0.6-1.fc10
> git-email.x86_64                                                1.6.0.6-1.fc10
> git-gui.x86_64                                                  1.6.0.6-1.fc10
> git-svn.x86_64                                                  1.6.0.6-1.fc10
> gitk.x86_64                                                     1.6.0.6-1.fc10
> gitosis.noarch                                                  0.2-6.20080825git.fc10
> gitweb.x86_64                                                   1.6.0.6-1.fc10
>
>
>
> Ferry
>
