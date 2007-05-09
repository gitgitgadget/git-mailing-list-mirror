From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only
 once instead of once per changed file.
Date: Wed, 9 May 2007 13:04:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091303280.4167@racer.site>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed May 09 13:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hljz3-0005nr-0x
	for gcvg-git@gmane.org; Wed, 09 May 2007 13:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258AbXEILEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 07:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbXEILEm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 07:04:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756936AbXEILEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 07:04:41 -0400
Received: (qmail invoked by alias); 09 May 2007 11:04:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 09 May 2007 13:04:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JSyty3U2J7y7W/nr58pKZrb6J77pHuCxtGaylgB
	p2frEb2yqEcrY7
X-X-Sender: gene099@racer.site
In-Reply-To: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46696>

Hi,

On Wed, 9 May 2007, Steffen Prohaska wrote:

> The old implementation executed 'cvs status' for each file touched by 
> the patch to be applied.

I did not follow development of that script closely, but could it be that 
this is a safety valve, to make it unlikely to commit something which was 
changed by somebody else in the meantime?

Ciao,
Dscho
