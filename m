From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 20:01:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704161958470.6021@reaper.quantumfyre.co.uk>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <20070416181352.GB29569@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Peter Baumann <peter.baumann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 21:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdWSG-0008Pi-0i
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 21:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXDPTBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbXDPTBc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 15:01:32 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38553 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221AbXDPTBb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 15:01:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 625B8C62A6
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 20:01:30 +0100 (BST)
Received: (qmail 31625 invoked by uid 103); 16 Apr 2007 20:00:51 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.035173 secs); 16 Apr 2007 19:00:51 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Apr 2007 20:00:51 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070416181352.GB29569@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44688>

On Mon, 16 Apr 2007, Peter Baumann wrote:

>
> master
> | next			commit comment for next
> o  |		commit comment for master~1
> |  o			commit comment for next~1
> o  |	[ ... guess whats next :-)		you get the idea ...]
> |  o
> |  |
> o /
> |
>
> tig comes near it, but it only linerarises the branches, so you can't see
> where there was a mergepoint/fork. I'd really like these visuallization of
> the commit graph in some of the text viewers. I normally don't care about
> the _full_ commit text, only if I visually understand what's happening I'm
> looking at the individual commits and the patches.

If you turn on the revision graph visualisation (press 'g' whil in main 
view) then tig will show merges and forks ... looks a little like your 
diagram above in fact.

-- 
Julian

  ---
The climate of Bombay is such that its inhabitants have to live elsewhere.
