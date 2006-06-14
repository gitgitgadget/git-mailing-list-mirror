From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix git alias
Date: Wed, 14 Jun 2006 15:38:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606141536320.17539@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vu06nevse.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606141507420.16802@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 15:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqVZY-00013v-2g
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 15:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWFNNiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 09:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFNNiN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 09:38:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7122 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964924AbWFNNiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 09:38:12 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 52CD02104;
	Wed, 14 Jun 2006 15:38:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 46F4D20AA;
	Wed, 14 Jun 2006 15:38:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2AB421ECE;
	Wed, 14 Jun 2006 15:38:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0606141507420.16802@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21846>

Hi,

On Wed, 14 Jun 2006, Johannes Schindelin wrote:

> >    There is another more grave problem I seem to be hitting but
> >    haven't figured out (and will probably not figure out while
> >    away); I'd appreciate if you can track it down.  With
> >    "alias.wh = whatchanged --patch-with-stat", "git wh HEAD --
> >    mailinfo.c" segfaults at fclose() in git_config_from_file()
> >    when it reads the configuration for the second time (the
> >    first time being getting the alias).  The second call comes
> >    via init_revisions() calling setup_git_directory().  Oddly
> >    I do not seem to be able to reproduce this segfault on amd64.
> 
> I will do that.

I cannot reproduce, sorry. Valgrind says some objects are not released, 
but I cannot find another error. That's with 'next'.

Ciao,
Dscho
