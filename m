From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: rerere with modified/deleted conflicts
Date: Mon, 26 Sep 2011 19:23:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1109261920000.2718@xanadu.home>
References: <alpine.LFD.2.00.1109261904340.2718@xanadu.home>
 <7v62ke293f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KWP-0003Yy-2H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab1IZXXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:23:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49969 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1IZXXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:23:32 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LS50006ZKPE3G20@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Sep 2011 19:17:38 -0400 (EDT)
In-reply-to: <7v62ke293f.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182187>

On Mon, 26 Sep 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Is this supported already?
> 
> I do not think so, as rerere is about applying previous change using 3-way
> merge. A modify/delete conflict would mean you have only two stages, and
> while I can see somebody might want to say "I want to ignore further
> modifications to this dead path ignored and resolve in favor of deletion",
> it felt a bit too aggressive to my taste when I last worked on rerere.

Well, that's exactly the use case we have here this would be nice for.  
But I wouldn't design it as "ignore any further changes" but rather 
"ignore _this_ particular change to the file I want you to delete".


Nicolas
