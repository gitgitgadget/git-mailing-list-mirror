From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Manpage rendering faults
Date: Wed, 18 Jul 2007 20:29:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707182024440.734@reaper.quantumfyre.co.uk>
References: <m3odi9im5y.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 21:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBFDd-00061O-Eb
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 21:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237AbXGRT3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 15:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbXGRT3u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 15:29:50 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41032 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758181AbXGRT3u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 15:29:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 02C9FB9A39
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 20:29:48 +0100 (BST)
Received: (qmail 23146 invoked by uid 103); 18 Jul 2007 20:29:48 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030859 secs); 18 Jul 2007 19:29:48 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Jul 2007 20:29:48 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <m3odi9im5y.fsf@pc7.dolda2000.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52893>

On Wed, 18 Jul 2007, Fredrik Tolf wrote:

> I often read manpages using a `man -t whatever | ggv -' command, since
> I like how it is rendered in PostScript. However, it turns out that
> some things in the Git manpages don't really render very well using
> that method. For example, in the git-rebase manpage, there are two
> history graphs that look like this when reading the manpages normally
> in a terminal:

It's a proportional font issue ...

Running "groff -Tps -f C -man $(man -w git-rebase) | ggv -" should display 
it correctly.  (The "-f C" being the part the man doesn't do)

No idea how to make it use that font by default though ... not even sure 
if you can put that kind of information into a man page?

-- 
Julian

  ---
Dinner suggestion #302 (Hacker's De-lite):
 	1 tin imported Brisling sardines in tomato sauce
 	1 pouch Chocolate Malt Carnation Instant Breakfast
 	1 carton milk
