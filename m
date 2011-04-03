From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git exhausts memory.
Date: Sun, 03 Apr 2011 11:18:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_iJbYdLtP50DKoSQqWRwfug)"
Cc: git@vger.kernel.org
To: Alif Wahid <alif.wahid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 17:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6P50-0005U7-3P
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 17:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1DCPSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 11:18:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64847 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1DCPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 11:18:48 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ3001FL14UEC20@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 03 Apr 2011 11:17:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170697>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_iJbYdLtP50DKoSQqWRwfug)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 3 Apr 2011, Alif Wahid wrote:

> Hi Nicolas,
> 
> On 3 April 2011 02:05, Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > Don't use --max-pack-size.  That won't help here.
> 
> I've tried only --window-memory with different values and they all
> failed. It seems to me as though this option is simply ignored or
> non-existent.

It is not ignored, but there are situations where there are problem 
making it effective, especially if a few files are very large.

> > How large are those tar files?
> 
> The tar files aggregate to just under 2 GB and my complete working
> tree is around 3 GB.

What about the individual size for those files?

Something you can try is to simply tell Git not to attempt any delta 
compression on those tar files using gitattributes (see the man page of 
the same name).


Nicolas

--Boundary_(ID_iJbYdLtP50DKoSQqWRwfug)--
