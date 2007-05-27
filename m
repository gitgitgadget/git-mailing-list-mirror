From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 04:02:22 -0300
Message-ID: <46592CFE.40303@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl> <f3agkk$bhn$1@sea.gmane.org> <4659259D.4000803@xs4all.nl> <20070527063902.GB28023@spearce.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 09:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsCp1-0001Nt-Rg
	for gcvg-git@gmane.org; Sun, 27 May 2007 09:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXE0HFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 03:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXE0HFc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 03:05:32 -0400
Received: from main.gmane.org ([80.91.229.2]:50894 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbXE0HFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 03:05:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsCoL-0002ta-Qi
	for git@vger.kernel.org; Sun, 27 May 2007 09:05:05 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 09:05:05 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 09:05:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <20070527063902.GB28023@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48523>

Shawn O. Pearce escreveu:
> 
> On systems like Cygwin the fork+exec overheads are very high;
> running a "simple" configure script can take longer than it
> takes me to compile Git from scratch.  Editing config.mak is
> quite easy; so is passing your choices on the command line to
> `make install`.
> 
> Personally I find:
> 
> 	make NO_CURL=1 install
> 
> easier than:
> 
> 	./configure --without-curl && make install

NO_CURL is a nonstandard option. Every package does it
differently, so this requires users to delve through either
INSTALL or Makefile. 

A well written configure script is able to detect presence
of a linkable libcurl. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
