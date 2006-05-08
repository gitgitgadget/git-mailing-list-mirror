From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Release config lock if the regex is invalid
Date: Mon, 8 May 2006 13:28:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605081327350.28989@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060507213612.27887.28600.stgit@dv.roinet.com>
 <Pine.LNX.4.63.0605080229220.32508@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7j4xi6lo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 13:28:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd3um-0006dk-7m
	for gcvg-git@gmane.org; Mon, 08 May 2006 13:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWEHL2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 07:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEHL2d
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 07:28:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64467 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751257AbWEHL2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 07:28:32 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C5727DB8;
	Mon,  8 May 2006 13:28:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B91BCDB1;
	Mon,  8 May 2006 13:28:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 98BD0AEF;
	Mon,  8 May 2006 13:28:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j4xi6lo.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19763>

Hi,

On Sun, 7 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This is not enough. There are quite a few exit paths. Notice the "goto 
> > out_free"? That is where this must go.
> >
> > This patch is totally untested but obviously correct:
> 
> except that many places you already close(fd) and
> unlink(lock_file).

Yes, my bad. I forgot to look for (and remove) them. Your patch looks fine 
to me.

Ciao,
Dscho
