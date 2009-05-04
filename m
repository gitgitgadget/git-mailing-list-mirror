From: elupus <elupus@ecce.se>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Mon, 4 May 2009 19:54:25 +0200
Message-ID: <yj2z78echiy8$.1mp64tzd3njkz.dlg@40tude.net>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net> <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net> <49FF2507.6070602@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 19:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M12NX-0006Cw-E1
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 19:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbZEDRye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 13:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758608AbZEDRye
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 13:54:34 -0400
Received: from main.gmane.org ([80.91.229.2]:41174 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758331AbZEDRyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 13:54:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M12N4-0000De-JB
	for git@vger.kernel.org; Mon, 04 May 2009 17:54:30 +0000
Received: from ua-83-227-158-203.cust.bredbandsbolaget.se ([83.227.158.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 May 2009 17:54:30 +0000
Received: from elupus by ua-83-227-158-203.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 May 2009 17:54:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ua-83-227-158-203.cust.bredbandsbolaget.se
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118253>

On Mon, 04 May 2009 19:25:27 +0200, Johannes Sixt wrote:

> elupus schrieb:
>> [26 quoted lines suppressed]
> 
> Right.
> 
> It's a know issue. But it was nobody's itch, yet, perhaps because too few 
> people use grafts. There is a topic, cc/replace, in Junio's pu branch that 
> introduces "replacement objects"; these are a generalization of grafts. If 
> effort is invested, then it's best to nurse this topic.
> 
> -- Hannes

Ah okey. Atleast then i know to thread carfully. 

The ugglies thing about this was that git gc had actually pruned a commit
from my repo due to an invalid graft's file. That push/pull didn't work
wasn't soo bad, but that my repo got corrupted due to an invalid graft file
is abit scary. 

Luckily in my case it was a git svn repo, and I even think i found a way to
just rebuild that branch where it occured.

It's quite probable that the problem's I had with the push/pull was due to
this missing commit. Since all my grafts (part from the wrong one) are only
additions of parents to commits. A cloned repo should still be okey even if
it does honor the grafts file (i think without knowning too much about the
inards of git).

Joakim
