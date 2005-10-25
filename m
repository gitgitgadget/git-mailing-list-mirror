From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to clone faster via ssh ?
Date: Tue, 25 Oct 2005 11:04:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200510251449.15302.lan@ac-sw.com> <200510251454.35202.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 11:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EULAV-0000Vc-TA
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVJYJcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVJYJcR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:32:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8359 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932110AbVJYJcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 05:32:17 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 01EF313F39D; Tue, 25 Oct 2005 11:32:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C205D9EFC8; Tue, 25 Oct 2005 11:32:15 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 827BB9F0B0; Tue, 25 Oct 2005 11:04:35 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 18BBF13F25D; Tue, 25 Oct 2005 11:04:33 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200510251454.35202.lan@ac-sw.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10577>

Hi,

On Tue, 25 Oct 2005, Alexander Litvinov wrote:

> Forgot to tell:
> clone via ssh was made using this command:
> time git-clone -n ssh://lan@lan/home/lan/tmp/git/billing/repo r3

If you have a working git on the other side, you could do

	time git-clone lan@lan:/home/lan/tmp/git/billing/repo r3

which would utilize git-clone-pack. Way faster.

Ciao,
Dscho
