From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 14:58:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCVr-0006dO-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 20:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579Ab0BRT6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 14:58:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57778 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517Ab0BRT6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 14:58:07 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY1002AJZGUBA00@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Feb 2010 14:58:06 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vtytee7ff.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140366>

On Thu, 18 Feb 2010, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > This makes it sound as if the user is to blame, but IMHO we're just
> > not checking the input well enough.
> 
> Honesty is very good.  An alternative implementation that does not hurt
> performance as much as the "paranoia" would, and checks "the input well
> enough" would be very welcome.

Can't we rely on the mtime of the source file?  Sample it before 
starting hashing it, then make sure it didn't change when done.


Nicolas
