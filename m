From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Fri, 30 Nov 2007 08:16:34 +0100
Message-ID: <20071130071634.GA2975@steel.home>
References: <200711282339.59938.jnareb@gmail.com> <200711290326.13822.jnareb@gmail.com> <20071129200710.GA3314@steel.home> <200711300118.28145.jnareb@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 08:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy07N-00071c-Ck
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 08:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbXK3HQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 02:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbXK3HQi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 02:16:38 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:22567 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbXK3HQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 02:16:37 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTub
Received: from tigra.home (Fca01.f.strato-dslnet.de [195.4.202.1])
	by post.webmailer.de (fruni mo31) (RZmta 14.3)
	with ESMTP id e002e8jAU1pRKF ; Fri, 30 Nov 2007 08:16:35 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 46BA7277AE;
	Fri, 30 Nov 2007 08:16:35 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9C1FF56D22; Fri, 30 Nov 2007 08:16:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711300118.28145.jnareb@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66620>

Jakub Narebski, Fri, Nov 30, 2007 01:18:27 +0100:
> >>                  <s id="mercurial">
> >>                      Excellent.  Uses HTTP or ssh.  Remote access also
> >>                      works safely without locks over read-only network
> 
> By the way, can Git be used with repository on lockless network
> filesystem? (Although with distributed SCM it perhaps be better
> to just use many distributed repositories...). How does it work
> with repository available via SMBFS / CIFS or NFS?

Works fine. CIFS/SMBFS is slow as hell when hosted on windows, but I
figure it is not problem of Git.
