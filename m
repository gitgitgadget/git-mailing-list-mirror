From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 15:00:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <20100216180209.GA1532@book.hvoigt.net>
 <7vocjpng1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTf4-0003wg-RT
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab0BPUEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:04:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43223 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933131Ab0BPUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:04:40 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXY00K4LA9B9CA0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Feb 2010 15:00:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vocjpng1w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140152>

On Tue, 16 Feb 2010, Junio C Hamano wrote:

[...]
> Notice how your version (xyzzy) broke the cascade of if..elseif..else.
> 
> Don't they teach this in schools anymore?

What do you expect from academia?  School and real life are still too 
often disconnected.


Nicolas
