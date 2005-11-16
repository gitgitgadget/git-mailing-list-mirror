From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_config_set() for mean cases
Date: Thu, 17 Nov 2005 00:19:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511170013470.9284@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhdac738c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:20:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWYm-0007Yj-Sr
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVKPXTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbVKPXTX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:19:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40919 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030564AbVKPXTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:19:22 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8B963E3302; Thu, 17 Nov 2005 00:19:21 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 707249F324; Thu, 17 Nov 2005 00:19:21 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 524C17E7A6; Thu, 17 Nov 2005 00:19:21 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 17882E3302; Thu, 17 Nov 2005 00:19:21 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdac738c.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12067>

Hi,

On Wed, 16 Nov 2005, Junio C Hamano wrote:

> Why do you spell apostrophe with 0xb4 not ASCII 0x27?  Not that
> it matters because I'll apply it with -u flag to git-am to
> convert it to UTF-8 in the log message, but I am just curious.

Efficiency. I often do the patches on my iBook w/ German keyboard. The 
apostrophe 0xb4 (upward accent) is just beside my back space key, i.e. in 
a favorite location for my right little finger.

OTOH, 0x27 (the real apostrophe) is just beside the Enter key, which is 
the only key Apple made too small. Way too small. So I try to avoid that 
key, since I hit it by accident already too often. Furthermore, on the 
German keyboard you have to hold Shift down for the apostrophe, while you 
do not for 0xb4.

Besides, the character is there, so why not use it? ;-)

Ciao,
Dscho
