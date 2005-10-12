From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-index-pack utility
Date: Wed, 12 Oct 2005 16:33:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121632040.6307@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051012173426.56fd5c1c.vsu@altlinux.ru>
 <20051012135405.CDE55E005E3@center4.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 16:33:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPhfc-00062b-T5
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVJLOdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVJLOdS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:33:18 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21440 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964793AbVJLOdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 10:33:18 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5869313EE76; Wed, 12 Oct 2005 16:33:17 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F6F49ECB6; Wed, 12 Oct 2005 16:33:17 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29E7A9ECB2; Wed, 12 Oct 2005 16:33:17 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F69C13EE76; Wed, 12 Oct 2005 16:33:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051012135405.CDE55E005E3@center4.mivlgu.local>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10030>

Hi,

you cheated! You use mmap(), not lseek()! Note that mmap() is more 
efficient only if the platform provides mmap()...

Ciao,
Dscho
