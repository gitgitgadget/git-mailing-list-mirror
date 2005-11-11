From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: lock
Date: Fri, 11 Nov 2005 17:38:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111737590.17831@wbgn013.biozentrum.uni-wuerzburg.de>
References: <34a7ae040511110831y3e896738o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 17:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EabvY-0000Z5-1l
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVKKQiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVKKQiz
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:38:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20929 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750855AbVKKQiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 11:38:54 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B324C13F2E6; Fri, 11 Nov 2005 17:38:53 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8F2F8B514F; Fri, 11 Nov 2005 17:38:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 70468B35C8; Fri, 11 Nov 2005 17:38:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 43B3713F2E6; Fri, 11 Nov 2005 17:38:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Paolo Teti <paolo.teti@gmail.com>
In-Reply-To: <34a7ae040511110831y3e896738o@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11615>

Hi,

On Fri, 11 Nov 2005, Paolo Teti wrote:

> Is possible to apply a lock (as in ClearCase) on a given file etc in 
> order to prevent accidental check-out or any other tool operation?

You should be able to do that with a hook (see Documentation/hooks.txt).

Hth,
Dscho
