From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add scripts to generate projects for other buildsystems (MSVC 
 vcproj, QMake)
Date: Wed, 23 Sep 2009 22:37:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909232236490.4985@pacific.mpi-cbg.de>
References: <cover.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <72888219-5bab-4964-9faf-0d40b4770e2c@o35g2000vbi.googlegroups.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-93504439-1253738255=:4985"
Cc: msysGit <msysgit@googlegroups.com>,
	Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYYw-0008H0-0q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbZIWUfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbZIWUfc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:35:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:38217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbZIWUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:35:31 -0400
Received: (qmail invoked by alias); 23 Sep 2009 20:35:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 23 Sep 2009 22:35:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5/hhH7Xf5LkzalktIOQVqCXk2Pjj5ZjBNJ5J2sl
	MhIiubhQuWJXBY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <72888219-5bab-4964-9faf-0d40b4770e2c@o35g2000vbi.googlegroups.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128998>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-93504439-1253738255=:4985
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Sep 2009, Sebastian Schuberth wrote:

> On Sep 16, 10:20 am, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> 
> > These scripts generate projects for the MSVC IDE (.vcproj files) or
> > QMake (.pro files), based on the output of a 'make -n MSVC=1 V=1' run.
> >
> > This enables us to simply do the necesarry changes in the Makefile, and you
> > can update the other buildsystems by regenerating the files. Keeping the
> > other buildsystems up-to-date with main development.
> 
> I know I'm a little late with my comments as this patch set has
> already been merged to master. However, for future reference I'd like
> to point out that something similar could be archived by using e.g.
> CMake, and only maintaining the CMake project file. I'm not suggesting
> to actually switch to CMake at this time, but I wanted to point out
> that a guy called Pau Garcia i Quiles already seems to have created a
> preliminary CMakeLists.txt file for Git [1], and also tried to build
> Git for Windows using his CMake-generated MSVC project files.
> 
> [1] "CMake-ifying git", http://www.elpauer.org/?p=324

We actually discussed this, and I challenged Pau to provide a recipe (a la 
/src/openssl/release.sh) that builds, installs and commits CMake.

There was no response after that challenge.

Ciao,
Dscho

--8323328-93504439-1253738255=:4985--
