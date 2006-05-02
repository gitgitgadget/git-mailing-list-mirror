From: Matthias Kestenholz <lists@irregular.ch>
Subject: Re: Bug in git log
Date: Tue, 2 May 2006 15:41:58 +0200
Message-ID: <20060502134158.GC4592@spinlock.ch>
References: <20060502075122.GA8203@spinlock.ch> <7virooomve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 15:44:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FavAw-0007dF-VS
	for gcvg-git@gmane.org; Tue, 02 May 2006 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWEBNoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 09:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWEBNoQ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 09:44:16 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6867 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S964817AbWEBNoP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 09:44:15 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Tue, 2 May 2006 15:44:14 +0200
Received: from spinlock.ch ([129.132.210.115]) by xfe0.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Tue, 2 May 2006 15:44:14 +0200
Received: (nullmailer pid 10658 invoked by uid 1000);
	Tue, 02 May 2006 13:41:58 -0000
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7virooomve.fsf@assigned-by-dhcp.cox.net>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 02 May 2006 13:44:14.0112 (UTC) FILETIME=[7FD7A200:01C66DEE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19420>

* Junio C Hamano (junkio@cox.net) wrote:
> [...]
> We used to have a build problem where we forgot to remove
> libgit.a and an old object from the archive was used by
> mistake.  Could you try rm -f libgit.a and rebuild your git to
> see if it helps?
> 

Ok I did that. I also removed all files which were installed by
'make install' and did a complete rebuild and install of the current
master branch. My git version is now 1.3.1.g7464

The "double dash" problem is not a big deal since it only happens
with the deprecated shellscript-version of whatchanged.

Does anyone get some output with the following command? That was the
bug I tried to report (sorry for my bad/convoluted english)

$ git log -- unresolve.c

-- 
:wq
