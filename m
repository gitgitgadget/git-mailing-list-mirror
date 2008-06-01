From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git-fetch vs ipv6 routing issues
Date: Sun, 1 Jun 2008 09:25:30 +0200 (CEST)
Message-ID: <alpine.LRH.1.10.0806010924340.27605@yvahk3.pbagnpgbe.fr>
References: <m38wxq1hou.fsf@eagle.jhcloos.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 09:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2iBQ-0006u1-Sr
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 09:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbYFAHjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 03:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYFAHjf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 03:39:35 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:40639 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYFAHjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 03:39:35 -0400
X-Greylist: delayed 835 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Jun 2008 03:39:34 EDT
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m517PUvc004235;
	Sun, 1 Jun 2008 09:25:30 +0200
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <m38wxq1hou.fsf@eagle.jhcloos.com>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83435>

On Sat, 31 May 2008, James Cloos wrote:

> I just noticed that, given a remote URL with a hostname which has both A and 
> AAAA RRs in the DNS, git-fetch will retry a git-protocol fetch using the v4 
> address if the v6 address is unreachable, but will not do so when the remote 
> is an http URL.

Isn't this simply because libcurl (used for http) has no retry functionality 
on this scenario while git itself has that for the git protocol?

-- 

  / daniel.haxx.se
