From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 11:47:02 +0100
Message-ID: <43786B26.703@op5.se>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de> <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net> <437858A1.9010007@op5.se> <200511141136.19192.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 11:47:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebbrg-0004q3-LJ
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 11:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKNKrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 05:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVKNKrE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 05:47:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63424 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751073AbVKNKrE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 05:47:04 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id CAF506BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 11:47:02 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <200511141136.19192.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11786>

Josef Weidendorfer wrote:
> On Monday 14 November 2005 10:28, Andreas Ericsson wrote:
> 
>>But we name them differently, as hpa pointed out some week ago.
>>
>>When I see "usage: <prog> <command>" I expect to find the info in "man 
>><prog>". Soon, this will work to get the right page
>>
>>	git --help <command>
> 
> 
> This is a nice feature, but still needs educating the user.

This feature goes away with the huge man-page.

> I think that the idea of a huge git man page is not that bad; for sure,
> it can be created automatically.
> 
> A huge man page helps searching a command name (Ah, what was the
> command to see commit logs per file?  What is the counterpart of
> "cvs update" called?).
> 

This is already implemented (sort of), but perhaps have both? Or 
pointers to the other man-pages from the "git" one (as is already sort 
of done).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
