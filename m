From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH 0/4] Add git-pack-intersect
Date: Thu, 10 Nov 2005 00:24:19 +0100
Message-ID: <43728523.1040209@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se> <20051109111917.GB30496@pasky.or.cz> <4371E472.4030902@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 10 00:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzIX-0006qp-KU
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKIXX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVKIXX5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:23:57 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:23504 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750884AbVKIXX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:23:57 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 436F401B000DE074; Thu, 10 Nov 2005 00:23:56 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <4371E472.4030902@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11437>

Andreas Ericsson wrote:
> It would be better if it was in git-prune or a default action for
> git-repack. I can't imagine a scenario where keeping redundant packfiles
> is useful.
> 

Perhaps if git-daemon ever does caching of packfiles, removing the smaller
packfiles might not be optimal.

Integrating it with git-prune sounds like a good idea though, I'll look 
in to it.

/Lukas 
