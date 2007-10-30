From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: broken strings in localization (was: How to run git-gui always
 in English?)
Date: Tue, 30 Oct 2007 10:45:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301040490.4362@racer.site>
References: <20071030111626.0mbeh417tw4wos0s@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, prohaska@tib.de, spearce@spearce.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImocZ-0007M7-1r
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbXJ3Kqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXJ3Kqj
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:46:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:44672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbXJ3Kqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:46:38 -0400
Received: (qmail invoked by alias); 30 Oct 2007 10:46:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 30 Oct 2007 11:46:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192qck22yF2RSdcJPC9VH19Hwpo/mmve4lCPKFwvj
	HSH0X6l2i9ZFQ7
X-X-Sender: gene099@racer.site
In-Reply-To: <20071030111626.0mbeh417tw4wos0s@webmail.tu-harburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 30 Oct 2007, Christian Stimming wrote:

> Note that the msgstr-translation has not been changed yet - this can 
> only be done by a human. For that reason, the update inserted the 
> "fuzzy" marker. Here's where the error came in: All strings marked as 
> "fuzzy" MUST NOT BE USED by msgfmt! And git-gui's script po2msg.sh 
> doesn't adhere to this rule. Boo, that's why such erroneous translations 
> made it into the msgcat catalog.

My bad.  I thought I handled that, but obviously I did not.  Will fix.

Ciao,
Dscho
