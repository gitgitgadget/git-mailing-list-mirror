From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Thu, 29 Nov 2007 21:07:10 +0100
Message-ID: <20071129200710.GA3314@steel.home>
References: <200711282339.59938.jnareb@gmail.com> <200711290326.13822.jnareb@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 21:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxpgT-0003BP-IK
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 21:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbXK2UHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762894AbXK2UHU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 15:07:20 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:33235 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762849AbXK2UHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 15:07:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTub
Received: from tigra.home (Fca01.f.strato-dslnet.de [195.4.202.1])
	by post.webmailer.de (klopstock mo32) (RZmta 14.3)
	with ESMTP id V00249jATI2iNR ; Thu, 29 Nov 2007 21:07:11 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EB7C1277AE;
	Thu, 29 Nov 2007 21:07:10 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B0ABB56D22; Thu, 29 Nov 2007 21:07:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711290326.13822.jnareb@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66559>

Jakub Narebski, Thu, Nov 29, 2007 03:26:12 +0100:
> +                <s id="git">
> +                    Medium. There's Git User's Manual, manpages, some
> +                    technical documentation and some howtos.  All
> +                    documentation is also available online in HTML format;
> +                    there is additional information (including beginnings
> +                    of FAQ) on git wiki.
> +                    Nevertheles one of complaints in surveys is insufficient

"Nevertheless" (two "s").

BTW, I wouldn't call the level of documentation "Medium" when compared
to any commercial SCM. How can they earn more than "a little", when
compared to any opensource program?

> @@ -894,6 +938,14 @@ TODO:
>                      to install the subversion perl bindings and a few modules
>                      from CPAN.
>                  </s>
> +                <s id="git">
> +                    TO DO. RPMs and deb packages for Linux. msysGit and
> +                    Cygwin for Win32 - Git requires POSIX shell, Perl,
> +                    and POSIX utilities for some commands (builtin).

I read this as: "Git requires all these programs for builtin
commands". Which is a bit confusing. Just drop "(builtin)"?

> +                    Autoconf to generate Makefile configuration; ready
> +                    generic configuration for many OS. Compiling docs
> +                    requires asciidoc and xmlto toolchain, but prebuild.

"prebuilt" (with "t"). Maybe remove ", but prebuilt" completely?

> @@ -1106,6 +1165,10 @@ TODO:
>                      There exists some HTTP-functionality, but it is quite
>                      limited.
>                  </s>
> +                <s id="git">
> +                    Good.  Uses HTTPS (with WebDAV) or ssh for push,
> +                    HTTP, FTP, ssh or custom protocol for fetch.
> +                </s>

You forgot bundles (aka SneakerNet).
Again, compared to everyone else it is "vastly superior" :)

>                  <s id="mercurial">
>                      Excellent.  Uses HTTP or ssh.  Remote access also
>                      works safely without locks over read-only network
> @@ -1203,6 +1266,10 @@ TODO:
>                      Very good. Supports many UNIXes, Mac OS X, and Windows,
>                      and is written in a portable language.
>                  </s>
> +                <s id="git">TO DO.
> +                    Good.  Portable across all POSIX systems.
> +                    There exists Win32 binary using MinGW.
> +                </s>

"binaries": MinGW and Cygwin. And it is definitely "excellent" by the
standards of the site.
