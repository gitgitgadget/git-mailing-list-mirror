From: Matthias Kleine <matthias_kleine@gmx.de>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Wed, 08 Aug 2007 20:51:55 +0200
Message-ID: <f9d3ce$1lo$1@sea.gmane.org>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>	<f9c0d1$7md$1@sea.gmane.org> <7vy7gm4cdv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 20:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIqdr-0004hc-4H
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 20:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935897AbXHHSwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935711AbXHHSwS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 14:52:18 -0400
Received: from main.gmane.org ([80.91.229.2]:43714 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935479AbXHHSwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 14:52:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIqdj-0002lQ-Fi
	for git@vger.kernel.org; Wed, 08 Aug 2007 20:52:15 +0200
Received: from e178106053.adsl.alicedsl.de ([85.178.106.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 20:52:15 +0200
Received: from matthias_kleine by e178106053.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 20:52:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e178106053.adsl.alicedsl.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vy7gm4cdv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55335>

Junio C Hamano wrote:
> Parents' order and which branch you are on may not have anything
> to do with each other.  Somebody else may have pulled a while on
> b, and you might have pulled from him the merge he created by
> doing so while you are on branch a.
> 

You're right, I didn't think of that. While pondering this I came up 
with another problem: git-svn currently remembers which svn-branch a 
commit belongs to by including this information in the git commit log 
message.
This way it is not possible to have one git-commit appear in more than 
one svn branch. Maybe it's better to store this git-commit->svn-branch 
mapping somewhere else. Although it's probably even better to completely 
switch to git :)

Matthias
