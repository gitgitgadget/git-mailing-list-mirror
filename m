From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rev-list: fix --header
Date: Mon, 17 Apr 2006 22:24:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604172222390.19593@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604171443300.18017@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtdom1t9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 22:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVaGV-0006M2-Hy
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 22:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDQUYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWDQUYE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 16:24:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28615 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750877AbWDQUYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 16:24:03 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 126A11AC7;
	Mon, 17 Apr 2006 22:24:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 066AD1A74;
	Mon, 17 Apr 2006 22:24:02 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DA2C11293;
	Mon, 17 Apr 2006 22:24:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtdom1t9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18834>

Hi,

On Mon, 17 Apr 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > gitk expects raw verbose headers limited by \0. Meet these expectations.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Thanks.
> 
> Wouldn't this be simpler and do the same thing, I wonder?  The
> point being that "--pretty --header" and "--header --pretty"
> traditionally did not make --header to override --pretty.

I thought, why not fix that bug, too? After all, it is counterintuitive 
what "--header --pretty" does, and it was easy to fix.

Ciao,
Dscho
