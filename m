From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] how to know if a cherry-picked patch has been applied
 already?
Date: Fri, 11 Jan 2008 12:12:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801111211260.31053@racer.site>
References: <20080111104737.GA7332@mageo.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIlD-0005fu-CY
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 13:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758505AbYAKMMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 07:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757195AbYAKMMu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 07:12:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:60100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751779AbYAKMMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 07:12:50 -0500
Received: (qmail invoked by alias); 11 Jan 2008 12:12:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 11 Jan 2008 13:12:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1905ssoHxZ0KoMDOQ71/t9n/OG5CivG7sDMPK19T9
	pXoEEXgmSyWsgA
X-X-Sender: gene099@racer.site
In-Reply-To: <20080111104737.GA7332@mageo.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70151>

Hi,

On Fri, 11 Jan 2008, Michal Vitecek wrote:

> Is there any easy way to tell which patches have and have not been 
> applied?

If the patches are not too different, "git log --cherry-pick a...b" (note 
the three dots instead of two) shows only those patches in b that are not 
yet in a.

Hth,
Dscho
