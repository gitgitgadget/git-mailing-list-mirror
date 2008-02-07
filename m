From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make git prune remove temporary packs that look like
 write failures
Date: Thu, 7 Feb 2008 01:25:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802070123480.8543@racer.site>
References: <Pine.GSO.4.63.0802062342020.7187@suma3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, nico@cam.org, casey@nrlssc.navy.mil
To: David Steven Tweed <d.s.tweed@reading.ac.uk>
X-From: git-owner@vger.kernel.org Thu Feb 07 02:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMvXJ-0003tz-Uj
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 02:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbYBGB0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 20:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbYBGB0H
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 20:26:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:38296 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758730AbYBGB0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 20:26:06 -0500
Received: (qmail invoked by alias); 07 Feb 2008 01:26:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 07 Feb 2008 02:26:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18d7zRk+wwda3BpdoxLC/MDpKh4zZwq/I82z9sAiH
	FVBTxMQkyBAi6U
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.GSO.4.63.0802062342020.7187@suma3>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72883>

Hi,

On Wed, 6 Feb 2008, David Steven Tweed wrote:

> This version incorporates all the agreed with changes from the previous 
> version, and since I was modifying the relevant context lines it 
> includes Johannes' code honouring --expire (but not the test he wrote 
> which is presumably best sent as a separate patch from him).

No, I don't want the tests as a separate patch.  They are intrinsic to 
your patch, since they show that your patch does what it's supposed to do 
(at least in an empirical way).

Ciao,
Dscho
