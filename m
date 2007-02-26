From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Unresolved issues
Date: Mon, 26 Feb 2007 01:33:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 02:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLUkb-0003q7-9x
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 02:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933738AbXBZBdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 20:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933742AbXBZBdu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 20:33:50 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:50707 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738AbXBZBdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 20:33:49 -0500
Received: (qmail 28362 invoked by uid 103); 26 Feb 2007 01:33:48 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2647. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.043672 secs); 26 Feb 2007 01:33:48 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 26 Feb 2007 01:33:48 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40601>

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> * "git fetch" between repositories with hundreds of refs.
>
> 	$gmane/39330
>
>  There are partial rewrite of the most expensive parts of git-fetch in
>  C parked in 'pu'.  It might be good enough for public consumption
>  without going the whole nine yards.  I dunno.  I am not very keen on
>  rewriting all of "git fetch" in C right now, as people seem to be
>  still interested in touching it (including "git bundle" topic).

The current changes in jc/fetch take things from "unusable" to "a bit 
slow", which I think could quite easily be considered a separate task from 
"a bit slow" to "something that even Linus would consider reasonable".  So 
my opinion would be to get the current improvements in so that they can be 
combined with the other good work happening in this area, and wait for 
things to settle before going the last mile (after all anyone converting 
from Subversion or CVS probably won't find 30s to be slow anyway ... ;)).

I would be happy to work on this if you would rather spend your time on 
more generally useful things ...

-- 
Julian

  ---
Stewie Griffin:  [thinks] How wonderful it will be to have mother back!
Brian Griffin:  [thinks] I heard that.
Stewie Griffin:  [thinks] Damn!
