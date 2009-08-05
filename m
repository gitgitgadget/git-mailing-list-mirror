From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
 foreign vcs
Date: Thu, 6 Aug 2009 00:04:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>  <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>  <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>  <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de> <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:05:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoc7-0006RY-Ad
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbZHEWE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbZHEWEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:04:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:44189 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752916AbZHEWEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:04:24 -0400
Received: (qmail invoked by alias); 05 Aug 2009 22:04:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 06 Aug 2009 00:04:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1945hwjMiR4VmS0IfB0J5ErfddABPTpK+xrtcwcLh
	2yKejhh286PXfl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125006>

Hi,

On Wed, 5 Aug 2009, Sverre Rabbelier wrote:

> On Wed, Aug 5, 2009 at 14:50, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Problem: on Windows, we cannot name the helper git-remote-http+svn: "+" is
> > not an allowed character in a filename.
> 
> Then do a s/+/-/ before calling the helper; no-one said the
> translation between protocol name and helper name had to be 1:1, as
> long as we document it there is no reason not to? Then again, maybe
> it's more better to use 'svn-http" or 'svn:http' to make it obvious
> that it's a special feature thingy.

Yes, I agree: svn:http:// is much better.

Ciao,
Dscho
