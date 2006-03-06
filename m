From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Mon, 6 Mar 2006 10:15:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603061012120.1422@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:15:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBoc-00032y-AI
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbWCFJPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbWCFJPi
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:15:38 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:11214 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752320AbWCFJPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 04:15:37 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 6B4E617E8;
	Mon,  6 Mar 2006 10:15:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 5E77D5DD9;
	Mon,  6 Mar 2006 10:15:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 41A88905;
	Mon,  6 Mar 2006 10:15:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17287>

Hi,

On Sun, 5 Mar 2006, Junio C Hamano wrote:

> Another thing I have started in "pu" branch is to stop placing
> an object we decided to delta that is already max-depth deep
> back in the delta-base window, because such a thing only wastes
> the delta base slot.  The changed pack-objects does pick up more
> delta, but the resulting pack seems bigger and I am puzzled why.

Not that I know much about the pack format, but is it possible that the 
deltas are deflated? In that case, a possible explanation is that a better 
delta is less compressible (and taken together, this could amount to more 
bytes).

Ciao,
Dscho
