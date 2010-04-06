From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:01:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004061701250.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Vitaly Berov <vitaly.berov@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzFu9-0006RZ-8f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab0DFVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:01:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23522 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438Ab0DFVBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:01:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0H001V13QS36B0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Apr 2010 17:01:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqljd062xb.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144168>

On Tue, 6 Apr 2010, Matthieu Moy wrote:

> Vitaly Berov <vitaly.berov@gmail.com> writes:
> 
> > We have quite a large repository and "git clone" takes about 6 hours. Herewith 
> > "resolving deltas" takes most of the time.
> > What git does at this stage and how can we optimize it?
> 
> Does running "git gc" (long, but done once and for all) on the server
> help?

No, that won't help.


Nicolas
