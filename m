From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration
 file.
Date: Mon, 5 Dec 2005 21:25:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net> <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
 <4394255D.1030009@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 21:26:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjMuG-0007kG-8Z
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVLEUZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVLEUZt
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:25:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45003 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751431AbVLEUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:25:48 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 77D8A13FAA2; Mon,  5 Dec 2005 21:25:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 59CB69F557; Mon,  5 Dec 2005 21:25:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 43F089DBC8; Mon,  5 Dec 2005 21:25:45 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1A31B13FAA2; Mon,  5 Dec 2005 21:25:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4394255D.1030009@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13225>

Hi,

On Mon, 5 Dec 2005, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > Junio C Hamano <junkio@cox.net> writes:
> > 
> > 
> > > It is just silly to start the file called "config" with a
> > > comment that says "This is the config file."
> > 
> > 
> > Any likes or dislikes?
> > 
> 
> I believe we all agree in silent consensus.

I don't really care, since I know very well that it is a config file... 
However, you should also remove the header which is generated in init-db.c 
when it is determined that the file system does not respect the executable 
flag.

Ciao,
Dscho
