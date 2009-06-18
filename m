From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix big left-shifts of unsigned char
Date: Thu, 18 Jun 2009 18:45:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain> <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302> <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHKkK-0003ZL-OZ
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZFRQpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZFRQpn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:45:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:55439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751069AbZFRQpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 12:45:42 -0400
Received: (qmail invoked by alias); 18 Jun 2009 16:45:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 18 Jun 2009 18:45:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cIe5Ewi3c2Qd2JHSHxnSNdhLcdETApFuOZoTMuj
	ZdyYThUrPphXKX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121856>

Hi,

On Thu, 18 Jun 2009, Linus Torvalds wrote:

> On Thu, 18 Jun 2009, Johannes Schindelin wrote:
> 
> > I wonder if there is a mode of 'sparse' which could spot these 
> > buggers.
> 
> Hmm. A very quick hack gets me (this is _after_ my patch):
>
> [snip thorough analysis]

Nice.

The quick hack is not going to be part of sparse.git, I take it?

Ciao,
Dscho
