From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 12:51:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251250120.5731@racer.site>
References: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org> <87fxwmv5tf.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIO2j-0007xd-7j
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbYAYMvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 07:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYAYMvz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:51:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:58805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754782AbYAYMvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:51:54 -0500
Received: (qmail invoked by alias); 25 Jan 2008 12:51:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 25 Jan 2008 13:51:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0Dc98Z6i0ZTh+hTb8mH/BiO/0YL/hYEw+sC9ZSF
	vMI8TXWzBTLYk5
X-X-Sender: gene099@racer.site
In-Reply-To: <87fxwmv5tf.fsf@jbms.ath.cx>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71704>

Hi,

On Fri, 25 Jan 2008, Jeremy Maitin-Shepard wrote:

> But since multiple hash functions will be needed anyway to support 
> different notions of case-insensitivity, if the warning is not enabled, 
> there is no reason to use a case-insensitive hash function with a 
> byte-exact comparison.

No, only multiple compare functions will be needed.  The hash function can 
be built in such a manner that it guarantees that file names being equal 
with _any_ of the compare functions fall into the same bucket.

The upside of such a hash function: less code to maintain.

Hth,
Dscho
