From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Thu, 20 Oct 2005 16:32:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510201630000.25300@iabervon.org>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 22:36:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESh5o-0006H7-NU
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 22:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVJTUct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVJTUct
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 16:32:49 -0400
Received: from iabervon.org ([66.92.72.58]:36622 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932525AbVJTUct (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 16:32:49 -0400
Received: (qmail 14916 invoked by uid 1000); 20 Oct 2005 16:32:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Oct 2005 16:32:08 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10378>

On Thu, 20 Oct 2005, Johannes Schindelin wrote:

> Hi,
> 
> > > +		    ((o = parse_object(remote)) != NULL) &&
> > > +		    (o->flags & COMPLETE) &&
> 
> I just realized that parse_object() always reads the file, then does a 
> lookup (which makes the above code work), and then parses the file. It 
> always does all of these steps, even if the object was already parsed. Any 
> reason for this?

I'm lazy and haven't sent in a patch to clean that up. There's no reason 
it couldn't check whether the value it gets is already parsed.

	-Daniel
*This .sig left intentionally blank*
