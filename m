From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't fetch objects that exist in the local repository
Date: Sat, 8 Oct 2005 01:25:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510080125210.21577@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051007220151.GB4989@reactrix.com>
 <Pine.LNX.4.63.0510080047500.20922@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051007230856.GC4989@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 01:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1bZ-0004h7-IG
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVJGX0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVJGX0E
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:26:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28070 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964801AbVJGX0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 19:26:03 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F052513EE87; Sat,  8 Oct 2005 01:26:01 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D713587FF4; Sat,  8 Oct 2005 01:26:01 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BFDCF9DD32; Sat,  8 Oct 2005 01:25:54 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5BF4013EE46; Sat,  8 Oct 2005 01:25:54 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051007230856.GC4989@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9826>

Hi,

On Fri, 7 Oct 2005, Nick Hengeveld wrote:

> On Sat, Oct 08, 2005 at 12:50:53AM +0200, Johannes Schindelin wrote:
> 
> > > Be sure not to fetch objects that already exist in the local repository.
> > 
> > Really? I seem to recall a dispute I had with Linus that this is 
> > unacceptable. He seems worried about incomplete fetches.
> 
> This patch just moved an existing check from the process queue loop to the
> appropriate places in transport-specific code to prevent the transport
> from transferring an object that appeared in the local repository after
> it was prefetched (eg. via a pack), and to make sure that all objects that
> were prefetched are subsequently fetched so the transport can perform the
> appropriate cleanup.

Ah! Okay, now I understand.

Thanks,
Dscho
