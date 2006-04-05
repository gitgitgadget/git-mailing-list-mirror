From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 09:06:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604050855080.2550@localhost.localdomain>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
 <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: moreau francis <francis_moreau2000@yahoo.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 15:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR7iq-0005K9-TT
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 15:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDENGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 09:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDENGw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 09:06:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63269 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751103AbWDENGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 09:06:51 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX900LNM33CTA80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 09:06:49 -0400 (EDT)
In-reply-to: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18428>

On Wed, 5 Apr 2006, Junio C Hamano wrote:

> It _might_ make sense to adopt a well-defined binary patch
> format (or if there is no prior art, introduce our own) and
> support that format with both git-diff-* brothers and git-apply,
> but that would be a bit longer term project.

What about simply using diff-delta and encoding its output with base64?


Nicolas
