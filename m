From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] repo-config: support --get-regexp and fix crash
Date: Wed, 3 May 2006 13:55:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605031353300.4017@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmze0j97u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 13:56:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFxd-000353-Dm
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWECLz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWECLz5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:55:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32176 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965158AbWECLz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 07:55:56 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1CB891D70;
	Wed,  3 May 2006 13:55:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 112271D48;
	Wed,  3 May 2006 13:55:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DA2CD118C;
	Wed,  3 May 2006 13:55:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmze0j97u.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19474>

Hi,

On Tue, 2 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Junio made me aware of a crash, a fix for which was too easy to
> > 	merit a separate patch.
> 
> Not really.

Right. I was just too lazy.

> > 	Strange thing I realized: A value is white-space-trimmed at the end
> > 	only if the line does not end with a comment. This fact is accounted
> > 	for in the new tests.
> 
> Thanks - a note like this helps me quite a bit, because I
> usually apply e-mailed patches with --whitespace=strip, which
> would have destroyed the test, leaving me scratching my head
> without such a notice.

Apparently, I hid that note well: somebody complained privately that my 
patch is not white-space clean.

As for the --get-regexp part: just take your time. It was easy enough, and 
I think it is quite cool, but I have to see an application for it yet.

Ciao,
Dscho
