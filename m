From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch + git-applymbox small issue
Date: Wed, 17 Aug 2005 21:53:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508172151390.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050817175452.84541.qmail@web26306.mail.ukl.yahoo.com>
 <7vll30wejs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 21:54:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5TyS-00007S-7F
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 21:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVHQTxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVHQTxR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 15:53:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2786 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751230AbVHQTxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 15:53:16 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 17A56E266F; Wed, 17 Aug 2005 21:53:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED1ECAD8FD; Wed, 17 Aug 2005 21:53:15 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A775FAD7EC; Wed, 17 Aug 2005 21:53:15 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 77A53E266F; Wed, 17 Aug 2005 21:53:15 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll30wejs.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 17 Aug 2005, Junio C Hamano wrote:

> Marco Costalba <mcostalba@yahoo.it> writes:
> 
> > So 'revision' is the struct and 'commit object' the pointer ;-)
> 
> It would be more like "revision" is a concept represented (not
> "referenced") by a commit object.

Actually, I think it is "referenced", because the commit object contains a 
little metadata, and then only refs (pointers).

> Agreed.  I personally think the word "archive" on this list came
> from people who have some degree of tla background.  CVS and SVN
> people would have said repository.

I'll add it anyway.

Ciao,
Dscho
