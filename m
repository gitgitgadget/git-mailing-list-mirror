From: fork0@t-online.de (Alex Riesen)
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 15:31:46 +0200
Message-ID: <20060615133146.GA5794@steel.home>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 15:32:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqrxA-0000Zm-9h
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 15:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWFONcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWFONcF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 09:32:05 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:5570 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030408AbWFONcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 09:32:04 -0400
Received: from fwd34.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1Fqrx0-0003DP-00; Thu, 15 Jun 2006 15:31:58 +0200
Received: from tigra.home (GvrsLGZTre0YLZ6ZZIpuif47j2r7j-Jof8JKmusw2uMRJSLyYcgm8N@[84.160.85.252]) by fwd34.sul.t-online.de
	with esmtp id 1Fqrwp-1NH5LE0; Thu, 15 Jun 2006 15:31:47 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7A0E6277B5;
	Thu, 15 Jun 2006 15:31:46 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fqrwo-00023c-88; Thu, 15 Jun 2006 15:31:46 +0200
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060615072450.GF7766@nowhere.earth>
User-Agent: Mutt/1.5.6i
X-ID: GvrsLGZTre0YLZ6ZZIpuif47j2r7j-Jof8JKmusw2uMRJSLyYcgm8N
X-TOI-MSGID: ab250695-8b05-44cf-9bd1-f7aa7f8aa52a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21893>

Yann Dirson, Thu, Jun 15, 2006 09:24:50 +0200:
> > Is there any interest in converting the build system used by git to
> > Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
> > too big.  As for nice features like remembering $prefix, wouldn't it be
> > better to add them to Automake instead of limiting them to just one
> > project?
> 
> Since there are many people objecting to autotools, what about using
> Jam instead ?  It has the advantage of being designed to be
> cross-platform, and should have all the features we would need for *git.

Except that it is not readily available everywhere, has unreadable
and illogical syntax, and lots of unknown assumptions built in.
We are forced to use that thing at work, and it is mostly hated.

Git already has enough external dependencies (crypto, Python, Perl,
bash, gmake), why create another one?

If we are about to need a configuration system (and I doubt it), may
be we should at least select a system small enough to have it always
in git repo? (yes, as linux kernel configuration system is)
