From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Thu, 19 Jul 2007 02:21:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com> <20070718213725.31383.50523.julian@quantumfyre.co.uk>
 <7vr6n55krx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 03:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBKiL-00087h-6g
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 03:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934389AbXGSBVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 21:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934215AbXGSBVw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 21:21:52 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58839 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763692AbXGSBVv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 21:21:51 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id CC90BB98BD
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 02:21:49 +0100 (BST)
Received: (qmail 3126 invoked by uid 103); 19 Jul 2007 02:21:49 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031193 secs); 19 Jul 2007 01:21:49 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Jul 2007 02:21:49 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vr6n55krx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52921>

On Wed, 18 Jul 2007, Junio C Hamano wrote:

> I tried with your patch, both with asciidoc7 and asciidoc8.  Did
> you really mean "&#x2302;" above?  Replacing them with "."  gave
> me a series of these changes (diff between output before and
> after your patch with the "s/\&#x2302;/./g" fixup):

I did mean it.  I originally just had .ft, but I was getting \&.ft in the 
manpage, which then just came out as .ft in the console.

I got the &#x2302; from 
http://docbook.sourceforge.net/release/xsl/current/manpages/utility.xsl, 
so I assumed it was the "correct" thing to use ...

This was with asciidoc 7 and docbook xsl stylesheet 1.72.0.


> whatever that 2302 is...

&#x2302; (or U+2302) seems to be a character from the unicode "Misc. 
Technical" section ... looks a bit like a house.

See sixth bullet from 
http://docbook.sourceforge.net/release/xsl/current/RELEASE-NOTES.html#V1.72.0_Manpages

looks like it may need to depend on which docbook xsl version you are 
using ...

-- 
Julian

  ---
The only way to amuse some people is to slip and fall on an icy pavement.
