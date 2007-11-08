From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] rebase: operate on a detached HEAD
Date: Thu, 08 Nov 2007 13:28:55 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711081328060.21255@xanadu.home>
References: <Pine.LNX.4.64.0711081818330.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCHD-0008Kt-3E
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760820AbXKHSiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761393AbXKHSiC
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:38:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11692 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762042AbXKHSiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 13:38:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR7008UEA081D70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Nov 2007 13:28:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711081818330.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64060>

On Thu, 8 Nov 2007, Johannes Schindelin wrote:

> 
> The interactive version of rebase does all the operations on a detached
> HEAD, so that after a successful rebase, <branch>@{1} is the pre-rebase
> state.  The reflogs of "HEAD" still show all the actions in detail.
> 
> This teaches the non-interactive version to do the same.

I like this.


Nicolas
