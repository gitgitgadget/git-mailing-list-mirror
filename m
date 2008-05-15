From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Provide git_config with a callback-data parameter
Date: Thu, 15 May 2008 02:02:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805150156230.30431@racer>
References: <alpine.DEB.1.00.0805141844580.30431@racer> <alpine.DEB.1.00.0805141846370.30431@racer> <7vk5hwn0tp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 03:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwRsg-0001LG-Et
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYEOBCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYEOBCq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:02:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbYEOBCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:02:45 -0400
Received: (qmail invoked by alias); 15 May 2008 01:02:43 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp047) with SMTP; 15 May 2008 03:02:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MItRobmHMXv2n7WoWlSCbl1EDo0tZ0QO5Bk8xYk
	oWulPxFJMtCckn
X-X-Sender: gene099@racer
In-Reply-To: <7vk5hwn0tp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82162>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > git_config() only had a function parameter, but no callback data
> > parameter.  This assumes that all callback functions only modify
> > global variables.
> >
> > With this patch, every callback gets a void * parameter, and it is hoped
> > that this will help the libification effort.
> 
> Great, as this has also been a pet-peeve of mine for quite some time.
> 
> Except the patch has quite a many rejects X-<.

Did you try to apply it to "next"?  I thought I based it on "next"...  I 
will prepare three patches tomorrow: for "next", "master" and "maint" 
respectively (even if I think that "maint" should not take it; it is no 
real fix).

Ciao,
Dscho
