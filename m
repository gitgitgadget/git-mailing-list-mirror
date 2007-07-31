From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui i18n / 0.9.x plans
Date: Tue, 31 Jul 2007 11:47:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707311136540.14781@racer.site>
References: <20070731012804.GZ20052@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 12:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFpGd-0003BY-U5
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 12:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbXGaKrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 06:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbXGaKrw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 06:47:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754875AbXGaKrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 06:47:52 -0400
Received: (qmail invoked by alias); 31 Jul 2007 10:47:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 31 Jul 2007 12:47:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/94z4vrfv9o3I4fNTWa9kVO1lEGJtpN6q0vL8s1D
	yNET9yB+6n3U40
X-X-Sender: gene099@racer.site
In-Reply-To: <20070731012804.GZ20052@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54332>

Hi,

On Mon, 30 Jul 2007, Shawn O. Pearce wrote:

> Regarding future development for the off-in-the-future 0.9.0 release I'd 
> like to see the i18n work merge in before we do anything else major to 
> git-gui.

Very good!  As it happens, I pushed an update this morning.  
temp-rebase-to-shawns-master is the branch which forward-ported all 
patches to the current master of git-gui.git.

As I understand, Christian will find and mark all strings lacking [mc ...] 
and update the .pot file.  Then we'll kindly ask the good translators 
(thanks everyone!) to review the changes, and after that I'll prepare some 
submittable patch series (no need to have several patches per language).

>  - Hunk splitting/selection

Yeah, I am personally interested in this, so time permitting I will 
continue on that part.  Regarding your idea from another post of yours: 
IMHO selections are only meaningful if they take whole lines.  But that's 
almost like hunk splitting, so it should be easy to support with the code 
I wrote and will have written.

Ciao,
Dscho
