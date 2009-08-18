From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Tue, 18 Aug 2009 13:54:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181353410.4680@intel-tinevez-2-302>
References: <op.uys3qwlmtdk399@sirnot.private> <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Edelen <sirnot@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 13:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdNGi-0007uf-Hr
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679AbZHRLyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZHRLyP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:54:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:58857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754834AbZHRLyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 07:54:15 -0400
Received: (qmail invoked by alias); 18 Aug 2009 11:54:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 18 Aug 2009 13:54:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19B5ZZ7/WVBkX9aiYn33I8/lZfGkLMbM75RFPLm7C
	JiP5zxm/A7dcu/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126384>

Hi,

On Mon, 17 Aug 2009, Nicolas Pitre wrote:

> |$ ls -ld .git/rev-cache/
> |drw-rw-r-- 2 nico nico 4096 2009-08-17 22:47 .git/rev-cache/
> 
> There is no directory execute permission at all.  Indeed, looking at 
> rev-cache.c line 2314, the mode passed to mkdir() is 0x666.  This should 
> rather be 0777.  Which brings the question: how could this ever work for 
> you?  Are you testing your code as root?

No: Nick is on Windows.

Ciao,
Dscho
