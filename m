From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 29 Oct 2008 18:06:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>  <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:00:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEOv-0004ta-55
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 18:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbYJ2Q64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbYJ2Q6z
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:58:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:46709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbYJ2Q6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:58:55 -0400
Received: (qmail invoked by alias); 29 Oct 2008 16:58:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 29 Oct 2008 17:58:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PGBYwUPgPfHwT3hmlylMFca3h0vouBLBQyC6h4x
	EA0mATJP2Pi6Dj
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99382>

Hi,

On Wed, 29 Oct 2008, David Symonds wrote:

> On Wed, Oct 29, 2008 at 9:42 AM, Jeff King <peff@peff.net> wrote:
> 
> > Hmm. I wonder if it would make it more sense to make the "official" 
> > name --staged, and leave --cached forever as a synonym. If the goal is 
> > giving sane names to end users, then we should probably advertise the 
> > sane ones.
> 
> I agree. If there's some consensus, I can make that shift, keeping 
> --cached as a backward-compatibility synonym.

Yes, I would like that, too.

However, note that we have to hash out what to do about the convention 
that --cached traditionally means that only the staging area (formerly 
known as "the index") is affected, while --index means that the command 
touches the working directory, too.

Ciao,
Dscho
