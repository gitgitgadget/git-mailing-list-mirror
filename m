From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 12:25:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231224300.5731@racer.site>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <7vprvtngxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHegR-0007cj-BN
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 13:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYAWMZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 07:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYAWMZu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 07:25:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:48871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753386AbYAWMZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 07:25:48 -0500
Received: (qmail invoked by alias); 23 Jan 2008 12:25:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 23 Jan 2008 13:25:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/70/8+MQ772xfZ9fBAlRkOxuEj+W/rCmpnlITwvh
	0YJ3lEyv9ucxVi
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprvtngxk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71534>

Hi,

On Tue, 22 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Basically, I dislike having two copies of the same data. If something 
> > can be computed from something else, then only the original data 
> > should exist, and the other thing should be recomputed.
> 
> Yes, I agree with that in principle. Storing computable values makes 
> sense only when it is expensive to recompute.  We did not have 
> cache-tree for quite a long time until you noticed that it was rather 
> expensive and wasteful to recompute tree objects from unchanged parts of 
> the index every time.
> 
> It's the same argument; when the hashing performance starts to become 
> noticeable, we can think about storing and reusing it, not before.

I fully expect it to be noticable with that UTF-8 "normalisation".  But 
then, the infrastructure is there, and whoever has an itch to scratch...

Ciao,
Dscho
