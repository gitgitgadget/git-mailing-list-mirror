From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 11:32:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
 <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 17:32:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR9zf-0000BR-1O
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 17:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWDEPcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 11:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWDEPcX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 11:32:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50238 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750977AbWDEPcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 11:32:22 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX900N3Q9TX2YG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 11:32:22 -0400 (EDT)
In-reply-to: <e10mn9$cjs$1@sea.gmane.org>
X-X-Sender: nico@localhost.localdomain
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18438>

On Wed, 5 Apr 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > It _might_ make sense to adopt a well-defined binary patch
> > format (or if there is no prior art, introduce our own) and
> > support that format with both git-diff-* brothers and git-apply,
> > but that would be a bit longer term project.
> 
> bsdiff? http://www.daemonology.net/bsdiff/
> EDelta? http://www.diku.dk/~jacobg/edelta/
> Xdelta? http://xdelta.blogspot.com/
> 
> IIRC bsdiff is used by Firefox to distribute binary software updates.
> Xdelta is generic (not optimized for binaries like bsdiff and edelta), but
> supposedly offers worse compression (bigger diffs).

We already have our own delta code for pack storage.


Nicolas
