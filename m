From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC] sideband: remove line padding (was: Re: [PATCH]
 progress: use \r as EOL only if isatty(stderr) is true)
Date: Thu, 30 Jun 2011 23:46:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106302331050.1371@xanadu.home>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
 <20110629174220.GA36658@sherwood.local>
 <alpine.LFD.2.00.1106291414140.2142@xanadu.home>
 <20110630211329.GC63317@sherwood.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 05:47:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcUh8-0002Hu-LI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 05:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1GADrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 23:47:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32808 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab1GADq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 23:46:59 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LNM00BMWYGXCP00@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2011 23:46:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110630211329.GC63317@sherwood.local>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176513>

On Thu, 30 Jun 2011, Steffen Daode Nurpmeso wrote:

> @ Nicolas Pitre <nico@fluxnic.net> wrote (2011-06-29 20:15+0200):
> > Why?
> 
> Ok, they don't.  (Your initial patch was from 2008, and since
> git(1) is evolving very fast, it might have been that padding is
> no longer of any use at all.)

But they absolutely still are.  What makes you think they aren't 
anymore?

> So, then, i'm the right person to turn the big wheel:

I'm afraid you'll have to understand _why_ that padding is still needed 
first.  Luckily the various commit messages for sideband.c are well 
detailed on the reasons for the current code.


Nicolas
