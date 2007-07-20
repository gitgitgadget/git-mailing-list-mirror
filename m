From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Fri, 20 Jul 2007 08:09:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
 <20070719014852.4573.65336.julian@quantumfyre.co.uk> <7v3azj1rva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:10:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmcm-0000yj-34
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 09:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbXGTHJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 03:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbXGTHJv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 03:09:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43265 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754518AbXGTHJu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 03:09:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DAA71D75E1
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 08:09:49 +0100 (BST)
Received: (qmail 28952 invoked by uid 103); 20 Jul 2007 08:09:49 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031122 secs); 20 Jul 2007 07:09:49 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 08:09:49 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7v3azj1rva.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53065>

On Fri, 20 Jul 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> In order for these roff commands to get through to the manpage they
>> have to be element encoded to prevent quoting.  In particular with
>> docbook xsl 1.72.0 and newer we have to use U+2302 instead of . to
>> prevent the roff command being escaped.  We also add a small perl
>> script for docbook < 1.72.0.
>
> This does not work at all for docbook 1.71.  I get "^<TAB>ft C"
> as output from xmlto.

Oh, well ... that's handy? :S

I've just checked, and I do have a machine with docbook < 1.72, so I'll 
see if I can get something working on both.  Probably early next week 
since I'm away this weekend.

-- 
Julian

  ---
Words are the voice of the heart.
