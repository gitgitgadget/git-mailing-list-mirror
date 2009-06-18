From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix big left-shifts of unsigned char
Date: Thu, 18 Jun 2009 10:12:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCjn-0007bI-6c
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZFRIMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbZFRIMh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:12:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:47670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754965AbZFRIMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:12:36 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:12:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 18 Jun 2009 10:12:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/87KQmGK/8yByBZpGsu9ItCorK9FN+kc7bPPG3F2
	z5PPNF974pkWoq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121808>

Hi,

On Wed, 17 Jun 2009, Linus Torvalds wrote:

> This is _not_ tested in any way. And I got bored with getting rid of 
> 'unsigned char' variables, so I by no means did all of them, just the 
> first few that caugth my grepping eye.

I wonder if there is a mode of 'sparse' which could spot these buggers.

Ciao,
Dscho
