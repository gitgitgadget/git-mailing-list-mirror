From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 00:49:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160044490.25894@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 00:50:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4nly-0006U5-8L
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 00:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVHOWtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVHOWtf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 18:49:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35807 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750812AbVHOWtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 18:49:35 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1E65FE27F0; Tue, 16 Aug 2005 00:49:34 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F361CB088E; Tue, 16 Aug 2005 00:49:33 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CDBD2B088C; Tue, 16 Aug 2005 00:49:33 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 09207E27F0; Tue, 16 Aug 2005 00:49:33 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, Carl Baldwin wrote:

> Somewhere in the thread something was mentioned about maintaining
> <local branch>:<remote branch> pairs in the git repository when pushes
> and pulls are performed.  I think the argument was actually against
> keeping this information and ultimately against allowing pushes to a
> branch of a different name.

I think the loudest voice was mine :-)

Actually, I was not against *keeping* the information, but against 
*pulling* in such strange ways. If "cross-pulling" is allowed, I am all 
for keeping track of that.

In the meantime, I did not think about the issue at all :-) However, as is 
often the case in an open discussion, I think I was wrong after all. There 
may be cases you want that, and in the end, nobody forces me to use that 
feature.

Anyway, Junio decided to enhance the fetch mechanism to support the 
cross-pulling (and also multi-pulling).

Ciao,
Dscho
