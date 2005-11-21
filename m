From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvsimport and RTAI repository
Date: Mon, 21 Nov 2005 16:27:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211625300.23247@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4381E565.4020108@dave-tech.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 16:31:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeDZt-0006LL-9N
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 16:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVKUP1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 10:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVKUP1X
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 10:27:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38327 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750866AbVKUP1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 10:27:22 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CF7F414054F; Mon, 21 Nov 2005 16:27:21 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B73AA9F3AC; Mon, 21 Nov 2005 16:27:21 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A27089F3AA; Mon, 21 Nov 2005 16:27:21 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 52B6E140563; Mon, 21 Nov 2005 16:27:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: llandre <r&d2@dave-tech.it>
In-Reply-To: <4381E565.4020108@dave-tech.it>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12448>

Hi,

On Mon, 21 Nov 2005, llandre wrote:

> cvs [rlog aborted]: received abort signal
> [...]

Maybe rlog does not work here... Have you tried

	git-cvsimport -p --no-rlog ...

? This passes the option --no-rlog to cvsps which helped me once.

Hth,
Dscho
