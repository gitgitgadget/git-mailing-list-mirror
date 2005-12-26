From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] avoid asking ?alloc() for zero bytes.
Date: Mon, 26 Dec 2005 23:18:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512262316150.32161@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net>
 <7v3bkis631.fsf@assigned-by-dhcp.cox.net> <20051224211546.GG3963@mail.yhbt.net>
 <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslsfikii.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 23:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er0fo-0006Rd-Oc
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 23:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVLZWSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVLZWSI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 17:18:08 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25512 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750711AbVLZWSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 17:18:07 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2642A14157D; Mon, 26 Dec 2005 23:18:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 176522B95;
	Mon, 26 Dec 2005 23:18:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id F04DF8FA;
	Mon, 26 Dec 2005 23:18:03 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D4C6D14157D; Mon, 26 Dec 2005 23:18:03 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslsfikii.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14062>

Hi,

On Mon, 26 Dec 2005, Junio C Hamano wrote:

> Avoid asking for zero bytes when that change simplifies overall
> logic.  Later we would change the wrapper to ask for 1 byte on
> platforms that return NULL for zero byte request.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * Here is what I have now that roughly corresponds to your
>    patch, which has been somewhat tested.

Thanks.

>    The final phase of making sure we return something from
>    x*alloc() is not done yet.

Tomorrow I'll compare the two patches and find out what, if anything, is 
needed.

Ciao,
Dscho
