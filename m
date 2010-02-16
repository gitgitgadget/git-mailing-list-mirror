From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 21:19:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002162118060.8642@intel-tinevez-2-302>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <20100216180209.GA1532@book.hvoigt.net> <7vocjpng1w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:20:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTtq-0005ST-Dy
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab0BPUT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:19:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756767Ab0BPUTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:19:55 -0500
Received: (qmail invoked by alias); 16 Feb 2010 20:19:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 16 Feb 2010 21:19:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bpFsBy50bPEo1IU3egfri2P8jb4cKVRY0AY547X
	TNiBtPBqlGwQz+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140153>

Hi,

On Tue, 16 Feb 2010, Nicolas Pitre wrote:

> On Tue, 16 Feb 2010, Junio C Hamano wrote:
> 
> [...]
> > Notice how your version (xyzzy) broke the cascade of if..elseif..else.
> > 
> > Don't they teach this in schools anymore?
> 
> What do you expect from academia?  School and real life are still too 
> often disconnected.

Actually, you know, I am quite happy that they do not teach _that_ 
particular code template. It is enough that I have to suffer this ugliness 
from oldtimers, no need for newtimers piling onto this particular pile.

Ciao,
Dscho
