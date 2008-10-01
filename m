From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 15:15:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20080930231619.GR21310@spearce.org> <20080930234157.GA1453@rdrz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Raphael Zimmerer <killekulla@rdrz.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 15:10:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl1TL-0004Xm-AO
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 15:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYJANJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYJANJU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 09:09:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:53363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753101AbYJANJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 09:09:19 -0400
Received: (qmail invoked by alias); 01 Oct 2008 13:09:17 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 01 Oct 2008 15:09:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jIR4KQLrjlRHWqikctPItxT8PE0nSgMj8EkOCE6
	m1654TMbgBsEgF
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080930234157.GA1453@rdrz.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97220>

Hi,

On Wed, 1 Oct 2008, Raphael Zimmerer wrote:

> On Tue, Sep 30, 2008 at 04:16:19PM -0700, Shawn O. Pearce wrote:
> > Elsewhere in Git we call this "-z", like "git ls-tree -z", "git log 
> > -z".  Should we match grep or git convention here?
> 
> I'd tend to grep's convention, as most options of git-grep mimic those 
> of grep. grep uses "-z" for \0 on _input_, so that would be very 
> confusing for grep users...

I tend to disagree.  Git is _already_ perceived as too heterogenous, and 
we should not add to that pile.

Ciao,
Dscho
