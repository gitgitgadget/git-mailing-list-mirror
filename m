From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the
 repository
Date: Wed, 13 Feb 2008 12:01:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131200410.30505@racer.site>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
 <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org> <20080213081128.GA27730@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 13 13:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPGJl-0003Dc-SC
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 13:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbYBMMBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759634AbYBMMBi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 07:01:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:55113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756158AbYBMMBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 07:01:37 -0500
Received: (qmail invoked by alias); 13 Feb 2008 12:01:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 13 Feb 2008 13:01:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DBTlTyo1DrXM42fEGEMLcaDyqMMxYFH5xP8TucA
	y6fqH/4vPcH/8h
X-X-Sender: gene099@racer.site
In-Reply-To: <20080213081128.GA27730@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73779>

Hi,

On Wed, 13 Feb 2008, Martin Koegler wrote:

> This would mean, that we must make git-rev-list and git-pack-objects not 
> segfault on incorrect links between objects.

We should do that anyway.  It may error out, but segfaulting is no option.

So if you have a test case, please make it public so we can fix the 
breakage.

Ciao,
Dscho
