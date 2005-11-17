From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 16:38:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171634460.17319@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
 <Pine.LNX.4.63.0511171436170.13358@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051117151653.GB3626@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 16:44:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EclrJ-0000oP-Kv
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVKQPid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKQPi1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:38:27 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59062 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751135AbVKQPiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:38:18 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DF65313F7B3; Thu, 17 Nov 2005 16:38:17 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BDFCFB5231; Thu, 17 Nov 2005 16:38:17 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A095DB521E; Thu, 17 Nov 2005 16:38:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8C51A13F7B3; Thu, 17 Nov 2005 16:38:17 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <20051117151653.GB3626@igloo.ds.co.ug>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12119>

Hi,

On Thu, 17 Nov 2005, Martin Atukunda wrote:

> On Thu, Nov 17, 2005 at 02:39:21PM +0100, Johannes Schindelin wrote:
> > 
> > I think you are more interested in knowing which version the tools are at.
> 
> Actually this patch series is more a response to the thread
> "Re: [PATCH] Disable USE_SYMLINK_HEAD by default" in  particular see
> this message 200511160205.43443.Josef.Weidendorfer@gmx.de by Josef
> Weidendorfer.

When we disable USE_SYMLINK_HEAD by default, tools are expected to work 
with USE_SYMLINK_HEAD enabled, too, so .git/version is not needed for 
that.

But yes, it might be handy to know at some time. But I think it would make 
sense to add .git/version *then*, because you can distinguish repositories 
before/after the change by testing for .git/version.

Ciao,
Dscho
