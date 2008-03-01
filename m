From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git diff-index --raw HEAD and git diff --raw HEAD output the
 same thing?
Date: Sat, 1 Mar 2008 13:21:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011320100.22527@racer.site>
References: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:22:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRfP-0000Vj-LH
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbYCANVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756141AbYCANVn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:21:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:44625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756131AbYCANVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:21:43 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:21:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp037) with SMTP; 01 Mar 2008 14:21:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aInpMSNOa7ogBkMFqutiBBEKmZDoSBETy20APuu
	6h/r8SgY5iMrHx
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75674>

Hi,

On Sat, 1 Mar 2008, Ping Yin wrote:

> Strange things is this line
> :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
> 0000000000000000000000000000000000000000 M      commonmake
> 
> why mod is 160000 while sha1 is 0000...

This indicates that a submodule (160000) was deleted (00000).  It is 
easier not to handle a deletion as mode change...

Ciao,
Dscho

