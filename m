From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 15:23:57 -0800
Organization: Vyatta
Message-ID: <20080219152357.5ab397cf@extreme>
References: <20080219140604.04afc91f@extreme>
	<20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: skimo@kotnet.org, Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Feb 20 00:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRbpL-00052P-QL
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYBSXYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYBSXYG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:24:06 -0500
Received: from mail.vyatta.com ([216.93.170.194]:44816 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbYBSXYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:24:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id C7CFD4F8054;
	Tue, 19 Feb 2008 15:24:02 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.325
X-Spam-Level: 
X-Spam-Status: No, score=-2.325 tagged_above=-10 required=5 tests=[AWL=0.174,
	BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uX5dVysIaOHb; Tue, 19 Feb 2008 15:23:59 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id 096684F804D;
	Tue, 19 Feb 2008 15:23:58 -0800 (PST)
In-Reply-To: <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74474>

On Tue, 19 Feb 2008 23:32:01 +0100
Sven Verdoolaege <skimo@kotnet.org> wrote:

> On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> > Because of a bone headed merge, I had to rewind one project back
> > to a known good state, but the sub module stuff is now wedged and
> > brain stuck on the old commit id.
> > 
> > Isn't there some simple way to do 'git sub-module remove' followed
> > by 'git sub-module add' to reset the internal index?
> 
> Why doesn't "git submodule update" work for you?
> 

It didn't fix it, but recloning did.
