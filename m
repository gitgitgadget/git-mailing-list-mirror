From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git exhausts memory.
Date: Tue, 05 Apr 2011 20:34:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104052032290.28032@xanadu.home>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
 <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
 <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com>
 <7vzko4mw44.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1104051655310.28032@xanadu.home>
 <7vmxk4l4yb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 02:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Gha-0007oG-W8
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 02:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1DFAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 20:34:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20713 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1DFAeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 20:34:17 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ700IYNG95TFC0@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Apr 2011 20:34:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vmxk4l4yb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170945>

On Tue, 5 Apr 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> > This is only implemented inside of fast-import. pack-objects does not
> >> > honor this variable.
> >> 
> >> Do you mean perhaps we should?
> >
> > Yes.
> >
> > Acked-by: Nicolas Pitre <nico@fluxnic.net>
> 
> I actually was somewhat unhappy to use uintmax_t type in the public header
> for some reason I cannot quite explain (perhaps religious), and was hoping
> somebody with more sanity than myself would stop me or show me a better
> way.

Just use unsigned long.  Everywhere we have object size, it is stored as 
unsigned long.


Nicolas
