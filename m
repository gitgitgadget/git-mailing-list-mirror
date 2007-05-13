From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 13 May 2007 23:58:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705132348290.4791@beast.quantumfyre.co.uk>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 00:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnN19-0006aR-03
	for gcvg-git@gmane.org; Mon, 14 May 2007 00:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbXEMW6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXEMW6N
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 18:58:13 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39021 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755186AbXEMW6N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 18:58:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 9AFEFC6087
	for <git@vger.kernel.org>; Sun, 13 May 2007 23:58:11 +0100 (BST)
Received: (qmail 10457 invoked by uid 103); 13 May 2007 23:56:23 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3233. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.036478 secs); 13 May 2007 22:56:23 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 13 May 2007 23:56:23 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47188>

On Sun, 13 May 2007, Junio C Hamano wrote:

> * db/remote (Sat May 12 11:46:03 2007 -0400) 3 commits
> - Add handlers for fetch-side configuration of remotes.
> - Move refspec parser from connect.c and cache.h to remote.{c,h}
> - Move remote parsing into a library file out of builtin-push.
>
> Hopefully be in 'next' after v1.5.2; I haven't really played
> with it.  The next step would probably be to add some stuff that
> use this series in fetch--tool, to further rewrite git-fetch
> itself in C, or maybe wholesale rewrite of git-fetch in C.

FWIW, I've got a largely functional C version of git-fetch ... the main 
functionality is there - but it's not complete yet.  In 
addition to some of the non-core functionality being missing 
(e.g. --tags or --no-tags in tagopt), I haven't been keeping 
up with recent updates to fetch/fetch-tool.  I was hoping to 
have it ready for post-1.5.2 - unfortunately I've been rather busy the 
last couple of weeks, and haven't managed to get as far as I'd hoped.

-- 
Julian

  ---
byob, v:
 	Believing Your Own Bull
