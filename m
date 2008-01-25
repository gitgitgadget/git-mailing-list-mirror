From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 18:24:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251822530.23841@racer.site>
References: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org> <87fxwmv5tf.fsf@jbms.ath.cx> <alpine.LSU.1.00.0801251250120.5731@racer.site> <87abmtvkd8.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JITF5-00072k-Mc
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 19:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbYAYSY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 13:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbYAYSY7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 13:24:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:34342 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753659AbYAYSY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 13:24:58 -0500
Received: (qmail invoked by alias); 25 Jan 2008 18:24:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 25 Jan 2008 19:24:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P5WMBt5kPvd4Jl8D37jwEHxtmY7QqdXllEAcNij
	Ya/HEHGcTZtdln
X-X-Sender: gene099@racer.site
In-Reply-To: <87abmtvkd8.fsf@jbms.ath.cx>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71723>

Hi,

On Fri, 25 Jan 2008, Jeremy Maitin-Shepard wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The upside of such a hash function: less code to maintain.
> 
> A simple hash function that doesn't try to do anything regarding 
> case-insensitivity is extremely short and simple and therefore is hardly 
> a maintenance burden.

You misunderstand me.  If the complicated hash function is the one that is 
less exercised, you _will_ face problems.

OTOH if you _already_ need the "complicated" hash function, there is 
_little_ point not to use it, and be consistent between platforms, 
_especially_ since now all people eat the same dog food.

So I never thought about the simple hash function as being a burden.

Hth,
Dscho
