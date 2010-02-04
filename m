From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack.packSizeLimit, safety checks
Date: Wed, 03 Feb 2010 21:31:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002032130270.1681@xanadu.home>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002011240510.1681@xanadu.home>
 <7v1vh1zr10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:31:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrV3-0004es-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0BDCbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:31:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18522 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab0BDCbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:31:15 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA00IFNPO3GF52@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 21:31:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v1vh1zr10.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138938>

On Wed, 3 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Thing is... I don't know if the --max-pack-size argument is really that 
> > used.  I'd expect people relying on that feature to use the config 
> > variable instead,...
> 
> I suspect one of us need to be careful not to forget this thing...

Please hold on.  I think I have a better patch.


Nicolas
