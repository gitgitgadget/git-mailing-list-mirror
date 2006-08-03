From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: What's in git.git
Date: Thu, 3 Aug 2006 01:50:02 -0700
Message-ID: <20060803085002.GA14400@prophet.net-ronin.org>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net> <20060802192922.GA30539@prophet.net-ronin.org> <7virlas9ol.fsf@assigned-by-dhcp.cox.net> <20060803053004.GA10413@prophet.net-ronin.org> <20060803054831.GB10413@prophet.net-ronin.org> <20060803073636.GA12755@prophet.net-ronin.org> <7vvepaqkki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 10:51:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8YuF-0002tL-BS
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 10:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHCIuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWHCIuH
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 04:50:07 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:59596 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S932401AbWHCIuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 04:50:06 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1G8Yu2-0003lD-00; Thu, 03 Aug 2006 01:50:02 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvepaqkki.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24714>

On Thu, Aug 03, 2006 at 01:39:57AM -0700, Junio C Hamano wrote:
> Did your ~/.gitk change after exiting your gitk session?  I
> somehow doubt it.
> 
> The following _might_ have a better chance of success...

Whups -- you're right.  It wasn't creating ~/.gitk at all, so it was in
as you said -- just like rm'ing it every time.

I tried your patch, and I still get the same result, though it creates a
~/.gitk.  "set geometry(ctexth)" appears in the ~/.gitk file properly now,
though.

I'll keep digging, and sorry for the noise.

-- DN
Daniel
