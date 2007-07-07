From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] revision: allow selection of commits that do not match a
 pattern
Date: Sat, 07 Jul 2007 18:52:08 +0200
Message-ID: <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 18:52:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7DW2-0000kq-Tb
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 18:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXGGQwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXGGQwL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 12:52:11 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:48414 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337AbXGGQwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 12:52:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKT00C3VIUWID@smtp18.wxs.nl> for git@vger.kernel.org; Sat,
 07 Jul 2007 18:52:09 +0200 (CEST)
Received: (qmail 18627 invoked by uid 500); Sat, 07 Jul 2007 16:52:08 +0000
In-reply-to: <Pine.LNX.4.64.0707071724410.4093@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51823>

On Sat, Jul 07, 2007 at 05:27:23PM +0100, Johannes Schindelin wrote:
> I suspect that with this patch,
> 
> 	git rev-list --not --grep bugfix HEAD
> 
> does not work as expected. Why?

Well... I guess that depends on what you expect...

> Why not make "git rev-list --grep '!bugfix' HEAD" work?
> 
> Yes, you would have to have a special exception that the prefix "!!" 
> actually matches an exclamation mark, but I'd be willing to live with 
> that.

Hmm... what if you want to (not) match anything starting with
one or more '!' ?
How about I add a '--invert-match' option that would
apply to all following match options?
Or we could escape the '!' with backslash.

skimo
