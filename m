From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: diff-core segfault
Date: Mon, 12 Dec 2005 17:56:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512121754340.6749@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1134404990.5928.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 17:59:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elqym-0000W3-1q
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 17:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVLLQ4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVLLQ4j
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 11:56:39 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15834 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751272AbVLLQ4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 11:56:38 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 47A5B13FAEB; Mon, 12 Dec 2005 17:56:37 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 224F39DD92; Mon, 12 Dec 2005 17:56:37 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 05F569DD64; Mon, 12 Dec 2005 17:56:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C194F13FAE9; Mon, 12 Dec 2005 17:56:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1134404990.5928.4.camel@localhost.localdomain>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13525>

Hi,

On Mon, 12 Dec 2005, Darrin Thompson wrote:

> $ git-diff-files -B
> Segmentation fault

This looks exactly like the problem on cygwin which is fixed by using 
NO_MMAP=YesPlease.

How about enabling NO_MMAP=YesPlease on cygwin per default? I think there 
are enough cases where it helps. If it is too slow *and* the user knows 
what she's doing, she can recompile NO_MMAP=NoNoNo.

Opinions, please?

Ciao,
Dscho
