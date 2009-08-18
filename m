From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 16:49:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181646241.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
 <7vpratdpc8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181411320.6044@xanadu.home>
 <7vprasc1vu.fsf@alter.siamese.dyndns.org>
 <7v7hx0c1at.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:50:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVcz-0006TM-1X
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbZHRUts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbZHRUts
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:49:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14279 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZHRUts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:49:48 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL005SEB6V4G00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 16:49:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7hx0c1at.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126455>

On Tue, 18 Aug 2009, Junio C Hamano wrote:

> Meh, our mails crossed.  I'll chuck this one and use your
> 
>     [PATCH] make sure byte swapping is optimal for git
> 
> patch.  Do you want default_swab32 be mmoved inside the
> 
>     #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
> 
> block?

Not necessarily.  It is generic code that other compilers/architectures 
might use as well.


Nicolas
