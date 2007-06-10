From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 14:10:17 +0200
Message-ID: <200706101410.17771.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0706101103160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 14:11:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMGx-0007Ba-1N
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbXFJMKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbXFJMKr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:10:47 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58433 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850AbXFJMKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:10:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00D195TWX400@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 14:10:44 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF005SG5T64Y30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 14:10:18 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00D6Z5T60280@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 14:10:18 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706101103160.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49717>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> As for the general direction of implementing notes as tags: If you want to 
> make them fetchable, you have to deal with conflicts. If you want to be 
> able to amend notes, _especially_ when they should be fetchable, you want 
> a history on them.

I'm not sure what kind of notes you're talking about here. If you're talking 
about my git-note concept, I designed notes to be immutable (thus not 
amendable) and there is therefore _no_ merging or potential for conflicts 
between notes. The only resolution needed is to figure out which order the 
notes for a given object should be presented. The default here is 
chronological sorting.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
