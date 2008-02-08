From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 19:04:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081903510.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <20080208184902.GA19404@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNYXu-0002fY-Tg
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 20:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbYBHTEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 14:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbYBHTEp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 14:04:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:44264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964861AbYBHTEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 14:04:42 -0500
Received: (qmail invoked by alias); 08 Feb 2008 19:04:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 08 Feb 2008 20:04:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1ryxFR6j1CxPv8Nx3N5UETQb5Rp0zFaN63i5I5Q
	C03gdb20kh1zRa
X-X-Sender: gene099@racer.site
In-Reply-To: <20080208184902.GA19404@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73125>

Hi,

On Fri, 8 Feb 2008, Mike Hommey wrote:

> - There are tricks to do roughly what you want without modifying git. 
> For example, you can prepare several "shared" clones of your repo (git 
> clone -s) and leave in each only a few branches. Cloning from these will 
> only pull the needed data.

The problem is, of course, that the shared clones are not updated 
automatically, whenever the big repository is updated.

Ciao,
Dscho
