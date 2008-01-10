From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 17:18:40 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801101717080.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
 <e5bfff550801101351w257975b1q9391d556c7af22a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5jz-0001Sm-Md
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYAJWSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYAJWSm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:18:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37456 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYAJWSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:18:41 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUG009TX8N4G910@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jan 2008 17:18:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e5bfff550801101351w257975b1q9391d556c7af22a0@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70104>

On Thu, 10 Jan 2008, Marco Costalba wrote:

> On Jan 10, 2008 9:39 PM, Nicolas Pitre <nico@cam.org> wrote:
> >
> > Right.  Abstracting the zlib code and having different compression
> > algorithms tested in the Git context is the only way to do meaningful
> > comparisons.
> >
> 
> The first thing I would like to test when zlib abstraction is ready is
> to test with NULL compressor, i.e. not compression/decompression at
> all and see if 'git log' and friends are happy.

Easy: git config core.compression 0


Nicolas
