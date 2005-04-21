From: "John Stoffel" <john@stoffel.org>
Subject: Re: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 17:15:54 -0400
Message-ID: <17000.6154.748117.967898@smtp.charter.net>
References: <1114100518.17551.31.camel@nosferatu.lan>
	<20050421202928.GH7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOixT-0005WE-2o
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVDUVQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVDUVQD
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:16:03 -0400
Received: from mxsf39.cluster1.charter.net ([209.225.28.166]:52935 "EHLO
	mxsf39.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261882AbVDUVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 17:15:56 -0400
Received: from mxip08.cluster1.charter.net (mxip08a.cluster1.charter.net [209.225.28.138])
	by mxsf39.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id j3LLFtVh022843
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 17:15:55 -0400
Received: from 24-107-225-41.dhcp.oxfr.ma.charter.com (HELO jfsnew) (24.107.225.41)
  by mxip08.cluster1.charter.net with ESMTP; 21 Apr 2005 17:15:55 -0400
X-Ironport-AV: i="3.92,121,1112587200"; 
   d="scan'208"; a="870450690:sNHT13114620"
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421202928.GH7443@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Petr" == Petr Baudis <pasky@ucw.cz> writes:

Petr> Perhaps it would be useful to have some "command classes" (with at least
Petr> cg-*-(add|ls|rm)), like:

Petr> 	cg-branch-ls
Petr> 	cg-remote-rm
Petr> 	cg-tag-add

Just speaking of consistency, can we make it so that all the commands
are just variations with out the damm dashes in them?  Something like:

  git lsbranch
  git lstag
  ...

Or something mildly along those lines.  I don't even care what ORDER
they are, whether the 'ls' comes before or after the object type it
works on.  But make it the same every where, so that ls, rm, add,
check, foo, barzle, ... all use the same format. 

Makes it much much easier to extrapolate what command syntax to use
when new objects to be acted upon are added.

Does a standard like:

  git <objecttype> <command> <args> [<obj> ...]

make sense?  Easy to script, easy to remember.  Even munging
<objtype><command> into a single word is ok.

John
