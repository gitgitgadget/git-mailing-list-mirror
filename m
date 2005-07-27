From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 11:32:12 -0400
Message-ID: <42E7A8FC.3080904@gmail.com>
References: <20050727083910.GG19290@mythryan2.michonline.com> <42E79946.2020309@gmail.com> <20050727143720.GG7410@birddog.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 17:39:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxnzJ-0002BU-1d
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 17:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVG0PhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 11:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVG0Pee
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 11:34:34 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:6153 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262333AbVG0PcW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 11:32:22 -0400
Received: by wproxy.gmail.com with SMTP id i35so177231wra
        for <git@vger.kernel.org>; Wed, 27 Jul 2005 08:32:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GryBr+J0h5t6XIpg3IP4VyPPmeHZ/hMmoBJiKWWQxVjLlJR/CxZ/Brne0tu465DiYBUCu8zFoPfUZDmqXgsK+x7R8XPgBHx7bVJnM1X2wIsdloG8dPc58txnRonB/m/oeuHG1cHZoGtcpX0fuz3h0qN+zRzXe/M0pDNd40tUuAM=
Received: by 10.54.68.4 with SMTP id q4mr384347wra;
        Wed, 27 Jul 2005 08:32:15 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id d8sm650846wra.2005.07.27.08.32.15;
        Wed, 27 Jul 2005 08:32:15 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: "Kirby C. Bohling" <kbohling@birddog.com>
In-Reply-To: <20050727143720.GG7410@birddog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kirby C. Bohling wrote:
> On Wed, Jul 27, 2005 at 10:25:10AM -0400, A Large Angry SCM wrote:
>>Ryan Anderson wrote:
>>>Convert build process from recurse Make to a single Make
>>>
>>Please explain the rational for this.
> 
> I'm new to the list, but given the subject, I'm fairly confident
> it's this.
> 
> http://www.canb.auug.org.au/~millerp/rmch/recu-make-cons-harm.html
> 
...
> 
> He used the exact wording just about everyone dones when referring
> to it conceptually.  It's easy to google for support and rebuttal:
> 
> http://www.google.com/search?hl=en&q=Recursive+Make+considered+harmful&btnG=Google+Search

Thanks for the references.

A quick read of the paper and some of the rebuttals make me think that 
either way (recursive/non-recursive):
	* require about the same amount of makefile/dependency maintenance work 
from developers.
	* allow developers to be lazy in different ways with 
makefiles/dependencies.
	* achieves the same end.

The non-recursive make method may have a small advantage for developers 
using Git for their SCM because the Git operations are also performed at 
the top level due to Git's design.
