From: Andreas Ericsson <ae@op5.se>
Subject: Re: git.kernel.org not putting out or git-daemon bug?
Date: Wed, 06 Sep 2006 15:15:02 +0200
Message-ID: <44FEC9D6.3030105@op5.se>
References: <44FEC6BE.5060301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 15:15:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKxFJ-0007PG-4Y
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWIFNPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWIFNPK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:15:10 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:389 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750781AbWIFNPH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:15:07 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id B8F496BCEB; Wed,  6 Sep 2006 15:15:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E407D6BCFB
	for <git@vger.kernel.org>; Wed,  6 Sep 2006 15:15:02 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <44FEC6BE.5060301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26530>

Andreas Ericsson wrote:
> Is it just me, or is anyone else having problems 'git fetch'-ing from 
> git.kernel.org? I've been trying on and off for two hours now, but keep 
> getting
> 
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> 
> Around 10 o'clock GMT I got a couple of timeouts, but I haven't seen one 
> of those for several hours now.
> 
> Using git version 1.4.2.ga444 to do the fetching, and trying to pull 
> things on to a clone of that revision of the git repo.
> 

Fetch over rsync seems to work fine, but git version 1.4.2.g8f5d has no 
better luck fetching over the git-protocol.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
