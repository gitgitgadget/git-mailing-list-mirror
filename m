From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 09:20:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610130912500.2435@xanadu.home>
References: <11607177011745-git-send-email-junkio@cox.net>
 <11607177024171-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 15:20:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMxY-0000gP-8R
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJMNUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJMNUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:20:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37157 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750699AbWJMNUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 09:20:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J72009RKT1QUD70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Oct 2006 09:20:14 -0400 (EDT)
In-reply-to: <11607177024171-git-send-email-junkio@cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28843>

On Thu, 12 Oct 2006, Junio C Hamano wrote:

> This new option makes the resulting pack express the delta base
> with more compact "offset" format.

Actually I thought about making it the default whenever git-pack-objects 
supported it, and use a negative option with git-repack to disable it 
instead.

The fact is that there is little reason for not using delta base offsets 
in most cases and specifying -b all the time would become more of an 
annoyance.

What do you think?


Nicolas
