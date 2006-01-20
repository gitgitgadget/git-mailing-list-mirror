From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.1.4
Date: Fri, 20 Jan 2006 10:54:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601201053120.15554@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wz31e9t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 10:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzsyJ-0006ag-Dw
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 10:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWATJyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWATJyQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 04:54:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42113 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750774AbWATJyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 04:54:16 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8E24146175; Fri, 20 Jan 2006 10:54:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id B9C5F9E9;
	Fri, 20 Jan 2006 10:54:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 9FD138F5;
	Fri, 20 Jan 2006 10:54:12 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8B46F146175; Fri, 20 Jan 2006 10:54:12 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wz31e9t.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14957>

Hi,

On Fri, 20 Jan 2006, Junio C Hamano wrote:

>       git-fetch-pack: really do not ask for funny refs
> 
>       * This fixes a case where "git-fetch-pack" is asked to
>         fetch all the refs; git barebone Porcelain never
>         triggers it and that is one reason why it was never
>         noticed so far.

Not really true. I did "git fetch some_url:git/", and it triggered. Bug?

Ciao,
Dscho
