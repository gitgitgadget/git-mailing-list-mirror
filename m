From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 21 Nov 2005 17:34:47 +0100
Message-ID: <4381F727.2090005@op5.se>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <200511211644.16789.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 17:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEd2-0007bX-TC
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKUQet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVKUQet
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:34:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57730 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932368AbVKUQet
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 11:34:49 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 191C06BD01
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 17:34:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12456>

Johannes Schindelin wrote:
> 
> What do people say? Is it useless to move that information into the 
> config, where it can be queried/replaced/set/removed by the config "API", 

You're thinking the wrong way around. "Is it useless so we should 
refrain?" is not the same as "is it useful enough to do?".


> or should we continue with two incompatible ad-hoc formats? (If that 
> sounds biased, it was not meant to be.)
> 

I don't use Cogito myself so I'm not aware of what incompatibilities 
there are. However, it's a user-friendliness layer, so it can choose to 
do things differently if it wants to, but changing how the plumbing 
works to match the porcelain seems wrong to me.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
