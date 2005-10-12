From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 17:08:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121707510.6666@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051012173426.56fd5c1c.vsu@altlinux.ru>
 <Pine.LNX.4.63.0510121612340.6307@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051012145548.GA2539@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 12 17:12:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPiDs-0002Fx-Oy
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVJLPIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVJLPIt
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:08:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1482 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964810AbVJLPIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 11:08:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C182513EBD7; Wed, 12 Oct 2005 17:08:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A67109ECB5; Wed, 12 Oct 2005 17:08:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8D264929A2; Wed, 12 Oct 2005 17:08:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D3A813EBD7; Wed, 12 Oct 2005 17:08:47 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051012145548.GA2539@master.mivlgu.local>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10035>

Hi,

On Wed, 12 Oct 2005, Sergey Vlasov wrote:

> Hmm, pack-objects.c:write_one() does exactly the opposite - it writes
> the base object _after_ writing out the delta (but it does not ensure
> that ordering completely, so references to base objects can be
> pointing in both directions).  Why?

Okay, I did not read that far. However, having quite a few packs out there 
in this format, there is no option to change the format now.

Ciao,
Dscho
