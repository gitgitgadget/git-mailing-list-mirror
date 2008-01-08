From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Tue, 08 Jan 2008 15:44:49 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801081526230.3054@xanadu.home>
References: <4783A3B2.3060801@viscovery.net>
 <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801081444360.3054@xanadu.home>
 <7v7iikrs86.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLKa-0004vY-UZ
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYAHUpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYAHUpY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:45:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43523 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYAHUpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:45:23 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUC003IHEYP6PL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 Jan 2008 15:44:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7iikrs86.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69919>

On Tue, 8 Jan 2008, Junio C Hamano wrote:

> How about using a constant large enough slop?  It is not like
> PREFIX and SUFFIX are different vastly between calls.

The size of the buffer is certainly bounded since the prefix length is 
constant, the buffer size is constant, and both possible suffixes are 
also constants.


Nicolas
