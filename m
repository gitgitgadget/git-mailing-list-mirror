From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Wed, 1 Feb 2006 15:47:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602011545390.28923@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vr76oun9o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 15:48:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4JGb-0002U0-49
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 15:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWBAOr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 09:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWBAOr0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 09:47:26 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15026 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161066AbWBAOrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 09:47:25 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ECF6E1467FC; Wed,  1 Feb 2006 15:47:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DE4D59FE;
	Wed,  1 Feb 2006 15:47:24 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AD3FE1467FC; Wed,  1 Feb 2006 15:47:24 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr76oun9o.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15415>

Hi,

On Tue, 31 Jan 2006, Junio C Hamano wrote:

> This is whacky, but another completely different strategy is to
> introduce remote alternates.

I'd rather go with the original plan. After all, you do not really need 
the cut-off commit objects. All needed objects are available on the server 
side: it just has to have a way to know which ones to send.

Ciao,
Dscho
