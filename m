From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added git-p4 package to the list of git RPMs.
Date: Wed, 04 Apr 2007 11:30:55 -0700
Message-ID: <7v3b3g3sbk.fsf@assigned-by-dhcp.cox.net>
References: <20070321144008.GE14837@codelabs.ru>
	<Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321160126.GH14837@codelabs.ru>
	<7v1wji371q.fsf@assigned-by-dhcp.cox.net>
	<20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<7v1wjcz9x1.fsf@assigned-by-dhcp.cox.net>
	<20070327102601.GN14837@codelabs.ru>
	<7vps6vnehz.fsf@assigned-by-dhcp.cox.net>
	<20070327112202.GB14837@codelabs.ru>
	<20070327112514.GC14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZAKA-0000Jo-8h
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 20:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXDDSbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbXDDSby
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 14:31:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45839 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbXDDSbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 14:31:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404183056.WZBJ1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 14:30:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id j6Ww1W00B1kojtg0000000; Wed, 04 Apr 2007 14:30:56 -0400
In-Reply-To: <20070327112514.GC14837@codelabs.ru> (Eygene Ryabinkin's message
	of "Tue, 27 Mar 2007 15:25:15 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43764>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> diff --git a/git.spec.in b/git.spec.in
> index 46aee88..8c79a79 100644
> --- a/git.spec.in
> +++ b/git.spec.in
> @@ -50,6 +50,13 @@ Requires:       git-core = %{version}-%{release}, tla
>  %description arch
>  Git tools for importing Arch repositories.
>  
> +%package p4
> +Summary:        Git tools for importing Perforce repositories
> +Group:          Development/Tools
> +Requires:       git-core = %{version}-%{release}, python
> +%description p4
> +Git tools for importing Perforce repositories.
> +
>...

Thanks. I'll also add git-p4 here.

diff --git a/git.spec.in b/git.spec.in
index 1d3934b..f0746ed 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -12,7 +12,7 @@ URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, perl-Git
+Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, git-p4, perl-Git
 
 %description
 Git is a fast, scalable, distributed revision control system with an
