From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 12:18:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901091215590.30769@pacific.mpi-cbg.de>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <20090109095300.GA4099@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 12:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLFOa-0003Fa-Rp
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 12:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbZAILR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 06:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbZAILR5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 06:17:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:55714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752101AbZAILR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 06:17:57 -0500
Received: (qmail invoked by alias); 09 Jan 2009 11:17:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 09 Jan 2009 12:17:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SlMBd3ntScJ0XkvTFsPC/ZNU40yh+dHtV78aLCl
	z5i5DBMAaaQHLW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090109095300.GA4099@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105006>

Hi,

On Fri, 9 Jan 2009, Jeff King wrote:

> On Fri, Jan 09, 2009 at 01:05:05AM +0100, Thomas Rast wrote:
> 
> > Apart from possible bugs, the main issue is: where should I put the 
> > configuration for this?
> 
> It's a per-file thing, so probably in the diff driver that is triggered 
> via attributes. See userdiff.[ch]; you'll need to add an entry to the 
> userdiff_driver struct. You can look at the funcname pattern stuff as a 
> template, as this is very similar.

I am not sure I would want that in the config or the attributes.  For me, 
it always has been a question of "oh, that LaTeX diff looks ugly, let's 
see what words actually changed".

Only rarely did I wish for a different word boundary detection algorithm.

So I'd rather have an alias than a config/attribute setting.

Ciao,
Dscho
