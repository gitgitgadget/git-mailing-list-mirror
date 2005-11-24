From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support username and password inside URL
Date: Thu, 24 Nov 2005 23:24:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511242321500.26651@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87u0e71zpx.fsf@litku.valo.iki.fi> <873blriqh0.fsf@litku.valo.iki.fi>
 <7vwtj3xe72.fsf@assigned-by-dhcp.cox.net> <87d5kraxsr.fsf@litku.valo.iki.fi>
 <7vbr09n16w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kalle Valo <Kalle.Valo@iki.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 23:25:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfPVw-0007j4-MR
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 23:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVKXWYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVKXWYK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 17:24:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38560 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161061AbVKXWYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 17:24:08 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 711A713FD57; Thu, 24 Nov 2005 23:24:06 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4C3F4B5309; Thu, 24 Nov 2005 23:24:06 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2953CB52F8; Thu, 24 Nov 2005 23:24:06 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 05B2513FD5B; Thu, 24 Nov 2005 23:24:06 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr09n16w.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12719>

Hi,

even if HTTP authentication is not really strong, we could permit at least 
the username to be specified. The password could come from .netrc. In this 
manner, it would be possible to use different user names on the same 
server.

I don't have a need for this, though.

Ciao,
Dscho
