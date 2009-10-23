From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] describe: when failing,
 tell the user about options that  work
Date: Thu, 22 Oct 2009 20:13:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910222011200.21460@xanadu.home>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch>
 <81b0412b0910220940n78ddb774i30338147327b198a@mail.gmail.com>
 <7v63a7f4ka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 02:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N17mX-00028c-BI
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 02:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbZJWANO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 20:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbZJWANO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 20:13:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28878 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZJWANN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 20:13:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRX00A0XXY25X70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Oct 2009 20:13:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v63a7f4ka.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131077>

On Thu, 22 Oct 2009, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > These are quite verbose. Could they be conditional on something like
> > advice.describeHints?
> 
> Concurred.  Please make it so.

I don't have a strong opinion either ways, but is having a less verbose 
message in the _error_ path really a big issue?


Nicolas
