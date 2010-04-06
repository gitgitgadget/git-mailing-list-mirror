From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:05:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004061702340.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Vitaly <vitaly.berov@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzFxr-00085p-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab0DFVFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:05:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50409 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab0DFVFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:05:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0H00ED73X4C6C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Apr 2010 17:05:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBB53F5.9010106@op5.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144169>

On Tue, 6 Apr 2010, Andreas Ericsson wrote:

> On 04/06/2010 05:29 PM, Vitaly wrote:
> > I didn't try this, but I'll give it a try, thanks.
> > 
> > And what does this stage mean?
> > 
> 
> It means the server is busy creating a packfile to send
> over the wire.

No.

The "Resolving deltas" is performed locally, when Git is actually 
expanding all the deltas in the received pack to find the actual SHA1 of 
the resulting object in order to create the pack index.


Nicolas
