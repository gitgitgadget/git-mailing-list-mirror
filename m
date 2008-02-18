From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] Export some email and pretty-printing functions
Date: Mon, 18 Feb 2008 17:24:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181704240.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335460.5816@iabervon.org> <alpine.LSU.1.00.0802181241440.30505@racer.site> <alpine.LNX.1.00.0802181245580.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JREQD-0001pF-VJ
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 23:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYBRWYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYBRWYh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 17:24:37 -0500
Received: from iabervon.org ([66.92.72.58]:44104 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbYBRWYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 17:24:37 -0500
Received: (qmail 6559 invoked by uid 1000); 18 Feb 2008 22:24:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 22:24:35 -0000
In-Reply-To: <alpine.LNX.1.00.0802181245580.5816@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74356>

On Mon, 18 Feb 2008, Daniel Barkalow wrote:

> On Mon, 18 Feb 2008, Johannes Schindelin wrote:
> 
> > In addition to Junio's concern that add_user_info() really wants to be 
> > called pp_add_user_info(), I cannot help myself but suspect that 
> > pp_write_email_headers() -- which called for a new name, too -- also wants 
> > to live in pretty.c.
> 
> Good idea, although I think "pp" is a verb about putting the result in the 
> provided strbuf, so "pp_user_info()" and "pp_email_headers()".
> 
> It's different, currently, in that it actually outputs the headers, rather 
> than putting them in a buffer and uses struct rev_info. I'll need to work 
> on this some more.

It's pretty firmly tied to a different style from the pp_* functions, so I 
think I'll make it log_write_email_headers() for this series.

	-Daniel
*This .sig left intentionally blank*
