From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack
 extension
Date: Wed, 26 Oct 2005 10:41:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261041100.7424@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
  <20051025204754.GA8030@steel.home>  <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0510252346t3806892dx71f9c0dc1efe4073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 10:42:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUgr5-0002fn-MY
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVJZIlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVJZIlv
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:41:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21979 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932595AbVJZIlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 04:41:50 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C9DE713F2ED; Wed, 26 Oct 2005 10:41:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9F179ABB3; Wed, 26 Oct 2005 10:41:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EAE8F9ABC1; Wed, 26 Oct 2005 10:41:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C399613EBAE; Wed, 26 Oct 2005 10:41:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510252346t3806892dx71f9c0dc1efe4073@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10654>

Hi,

On Wed, 26 Oct 2005, Alex Riesen wrote:

> > Could you please try the patch I sent with the subject "[PATCH]
> > fetch/upload: Fix corner case with few revs"? Your output looks exactly
> > like what I fixed with that patch.
> >
> 
> I couldn't at the moment. Do you still need a test?

If you have time and can test it, yes, please.

Ciao,
Dscho
