From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Tue, 7 Oct 2008 05:53:36 +0400
Message-ID: <20081007015336.GU21650@dpotapov.dyndns.org>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain> <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 03:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn1mo-0007Ax-7F
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 03:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbYJGBxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 21:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbYJGBxn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 21:53:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8787 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbYJGBxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 21:53:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2151376fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 18:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mKIfvuK7PDcDDVL1r3TI2sCxYCxHrWK3zGVgPCLz2pE=;
        b=DRfzrgD7SkVHAv84iTpvVcBBzCYszDIDRbMCzLAVI9UP7hDxbMuLxSlICHDVAKWBIe
         mgsXBUCoMjuJZjmDssLS7j31erXn48cV52KNo+lSc+zY9ZdmVIAwegwsf9uR4Skmx6Cr
         a7j19RvS72eGyD74Nd1bssUwB4IueDrqj23fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KSo/g0/yXkE/SBIe3/CII6EsmzKrQskFRQLhKXFle+mCHxfPcfDcx8yE7OwfLuyoNu
         1twgtfoJ2dLb1IBjbfe6WKDj06T3Uqcs2FTKJDzfmoejnbeXdjjNfvIUWFvtVW/Ub2o4
         Jer4/3R2RIeolcVuYYYNZ5BjXYcid0tudPFdw=
Received: by 10.86.93.19 with SMTP id q19mr5271884fgb.4.1223344420340;
        Mon, 06 Oct 2008 18:53:40 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id e20sm12433853fga.1.2008.10.06.18.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 18:53:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97651>

On Mon, Oct 06, 2008 at 12:47:16PM -0700, Linus Torvalds wrote:
> 
> On Mon, 6 Oct 2008, Johannes Schindelin wrote:
> >
> > It is not a bug.
> 
> If it's unwanted functionality, that's a bug. That's kind of the whole 
> (and only) difference between "bug" and "feature". Do people want it?

It looks like you have changed your opinion since what you wrote half
a year ago.

Back then you said:
> Yeah. Why not just rather than the whole ok/cancel discussion, go with a 
> single button saying "good for me!" and be done with it.
> 
> IOW, the license thing should be considered *informational* rather than a 
> choice. Because to a user, that's exactly what the GPL is.

http://article.gmane.org/gmane.comp.version-control.msysgit/1677

Also, please, re-read what Junio said in this thread:

"I think removing the license dialog is a bad idea.  You need to
tell the end-user about his rights, and one of the things is
that he can get source to git under the terms of GPLv2.  The bug
is not about showing the license, but is about refusing to
install unless the end user agrees with it."

I think such a step as removing the license should be approved by
Junio and not be taken behind his back as it's happening now.


Dmitry
